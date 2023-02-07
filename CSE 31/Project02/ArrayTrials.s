.data 

original_list: .space 100 
sorted_list: .space 100

str0: .asciiz "Enter size of list (between 1 and 25): "
str1: .asciiz "Enter one list element: "
str2: .asciiz "Content of original list: "
str3: .asciiz "Enter a key to search for: "
str4: .asciiz "Content of sorted list: "
strYes: .asciiz "Key found!"
strNo: .asciiz "Key not found!"



.text 

# This is the main program.
# It first asks user to enter the size of a list.
# It then asks user to input the elements of the list, one at a time.
# It then calls printList to print out content of the list.
# It then calls inSort to perform insertion sort
# It then asks user to enter a search key and calls bSearch on the sorted list.
# It then prints out search result based on return value of bSearch
main: 
	addi $sp, $sp -8
	sw $ra, 0($sp)
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	# Read size of list from user
	syscall
	move $s0, $v0 #s0 = v0
	move $t0, $0 #t0 = 0
	la $s1, original_list 
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2  # t1 = t0 * 4
	add $t1, $t1, $s1 #t1 = t1 + s1
	li $v0, 5	# Read elements from user
	syscall
	sw $v0, 0($t1) # v0 = address of t1
	addi $t0, $t0, 1 #t0 += 1
	bne $t0, $s0, loop_in #if t0 != s0 Loop_in
	move $a0, $s1  #a0 = s1
	move $a1, $s0  #a1 = s0
	
	jal inSort	# Call inSort to perform insertion sort in original list
	
	sw $v0, 4($sp) #v0 = address of sp +4
	li $v0, 4 
	la $a0, str2 #prints original list
	syscall 
	la $a0, original_list #calls array
	move $a1, $s0 #a1 = s0
	jal printList	# Print original list
	li $v0, 4 
	la $a0, str4 
	syscall #Contents of sorted list string
	lw $a0, 4($sp)
	jal printList	# Print sorted list
	
	li $v0, 4 
	la $a0, str3 
	syscall 
	li $v0, 5	# Read search key from user
	syscall
	move $a3, $v0
	lw $a0, 4($sp) 
	jal bSearch	# Call bSearch to perform binary search
	
	beq $v0, $0, notFound #Value is not there
	li $v0, 4 
	la $a0, strYes 
	syscall 
	j end
	
notFound:
	li $v0, 4 
	la $a0, strNo 
	syscall 
end:
	lw $ra, 0($sp)
	addi $sp, $sp 8
	li $v0, 10 
	syscall
	
	
# printList takes in a list and its size as arguments. 
# It prints all the elements in one line.
printList:
	# Your implementation of printList here	
	#s0 is i in a for loop
	#t1 is the array
	move $t1, $a0
	li $s0, 0
	
forLoop:
	slt $t0, $s0, $a1
	beq $t0, $zero, break
	
	lw $a0, 0($t1)
	li $v0, 1
	syscall
	
	li $a0, 32
	li $v0, 11
	syscall
	
	addi $t1, $t1, 4
	addi $s0, $s0, 1
	j forLoop

break:
	li $v0, 4
	la $a0, original_list
	jr $ra
	
# inSort takes in a list and it size as arguments. 
# It performs INSERTION sort in ascending order and returns a new sorted list
# You may use the pre-defined sorted_list to store the result
inSort:
	# Your implementation of inSort here
	li $t1, 1
	li, $t2, 0
	la $t8, original_list
	la $t9, sorted_list
	
transferLoop:
	bgt $t1, $a1, resett
	lw $t5, ($t8)
	sw $t5, ($t9)
	addi $t8, $t8, 4
	addi $t9, $t9, 4
	addi $t1, $t1, 1
	j transferLoop
	
resett:
	la $t9, sorted_list
	
sortLoop:
	bge $t2, $a1, forEnd
	move $t3, $t2

nestedWhile:
	mul $t5, $t3, 4
	add $t0, $t9, $t5
	
	ble $t3, 0, whileEnd
	
	lw $t7, 0($t0)
	lw $t6, -4($t0)
	
	bge $t7, $t6, whileEnd
	
	lw $t4, 0($t0)
	sw $t6, 0($t0)
	sw $t4, -4($t0)
	
	subi $t3, $t3, 1
	j nestedWhile
	
whileEnd:
	addi $t2, $t2, 1
	j sortLoop
	
forEnd:
	la $v0, sorted_list
	jr $ra
	
	
# bSearch takes in a list, its size, and a search key as arguments.
# It performs binary search RECURSIVELY to look for the search key.
# It will return a 1 if the key is found, or a 0 otherwise.
# Note: you MUST NOT use iterative approach in this function.
bSearch:

	move $s0, $a0 #address of the sorted array
	move $s1, $a1 # right
	move $s2, $a3 # search key
	move $s3, $a2 # left  
	li $s5, 0 # mid

	#Index $s1 is the array size
	subi $s1, $s1, 1

	#if Right >= Left
	blt $s1, $s3, notEquals 

	#mid = Left + (Right -  Left)/2
	sub $t0, $s1, $s3
	sra $t0, $t0, 1
	add $s5, $s5, $s3

	beq $s5, $s2, equals
	exit:
	bne $s5, $s2, notEquals

	checkLeft:
	sub $a1, $s5, $s3
	j bSearch
	
	checkRight:
	addi $a3, $s5, 1
	j bSearch

equals:
	li $v0, 1
	jr $ra
	
notEquals:
	li $v0, 0
	jr $ra
	
