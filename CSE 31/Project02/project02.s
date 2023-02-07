.data 
# online help and worked with Jovan S.
original_list: .space 100 
sorted_list: .space 100

str0: .asciiz "Enter size of list (between 1 and 25): "
str1: .asciiz "Enter one list element: "
str2: .asciiz "Content of original list: "
str3: .asciiz "Enter a key to search for: "
str4: .asciiz "Content of sorted list: "
strYes: .asciiz "Key found!"
strNo: .asciiz "Key not found!"

space: .asciiz " "
newLine: .asciiz "\n"

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
	#Your implementation of printList here	
	addi $sp, $sp -4
	sw $ra, 0($sp)
	
	#a0 = array address
	#a1 = array size
	move $t0, $a0 
	move $t1, $a1 
	
	printLoop:
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	
	addi $t0, $t0, 4 
	addi $t1, $t1, -1

	beq $t1, $zero, printEnd 

    	li $a0, 32 # space in ASCII
       	li $v0, 11
        syscall #make space
        #bne $t0, $zero, LOOP  #if the decrementation == 0 then end function
    	j printLoop
	
printEnd:
	la $t2, newLine
	move $a0, $t2
	li $v0, 4
	syscall	

	lw $ra, 0($sp) #restore $ra
	addi $sp, $sp 4
	
	jr $ra	

#inSort takes in a list and it size as arguments. 
#It performs INSERTION sort in ascending order and returns a new sorted list
#You may use the pre-defined sorted_list to store the result
inSort:
	#Your implementation of inSort here
	addi $sp, $sp, -32
	sw $ra, 8($sp)
	sw $s0, 12($sp) #address of og array
	sw $s1, 16($sp) #Size 
	sw $s2, 20($sp) #Int i
	sw $s3, 24($sp) #indivdual addressfor index
	sw $s4, 28($sp) #int j
	
	move $s0, $s1 # s0 = address of original array
	move $s1, $a1 # size of array
	addi $s2, $zero, 1 #i = 1
	
	copy:
	la $t0, original_list#load address og list
	la $t1, sorted_list #load address of new sorted list
	addi $t6, $t6, 0 # i, s1 = size

	
	duplicate:
	#duplicates everythingin the og array
	beq $s1, $t6, copyEnd
		
	lw $t2, ($t0)
	sw $t2, ($t1)
		
	#increment pointers
	addi $t0, $t0, 4 
	addi $t1, $t1, 4
	addi $t6, $t6, 1
		
	j duplicate

	copyEnd:
	la $t1, sorted_list
	move $s0, $t1
	#address of sorted array in s0
	
	forLoop:
	beq $s2, $s1, forEnd #i = arraySize go to iEnd
	sll $t2, $s2, 2 # offset = i * 4
	add $t3, $s0, $t2 # t3 = *array + offset
	lw $s3, ($t3) # s3 = value of address t3
	addi $s4, $s2, -1 # j = i--
	
		whileLoop:
		#loops from j to 0
		# branch if less than zero
		bltu $s4, $zero, whileEnd #J >= 0
		move $a0, $s3 # a0 =array[i]
		
		la $t0, ($s0) #address
		sll $t2, $s4, 2 #offset
		add $t3, $t0, $t2 # t3 = array[j]
		lw $a1, ($t3) #offset + address
		
		jal set
		
		move $t0, $v0
		beq $t0, $zero, whileEnd 
		
		la $t0, ($s0) # array[j+1] = array[j], j--
		sll $t2, $s4, 2  #for the offset
		add $t3, $t0, $t2 #addthe offset with the address of s0
		lw $t4, 0($t3) # load the value of address t3

		addi $t2, $s4, 1 # t2 = j++
		sll $t3, $t2, 2 #offset
		add $t1, $t3, $s0 # & array[j+1]
		sw $t4, 0($t1) # incrememnt to next element = array[j]
		addi $s4, $s4, -1 # j--
		
		j whileLoop
		
	whileEnd:
	
	#array[j+1] = key
	move $t0, $s4
	addi $t0, $t0, 1
	sll $t2, $t0, 2
	add $t1, $s0, $t2
	
	sw $s3, ($t1)
		
	addi $s2, $s2, 1 #i++
	j forLoop
	
	forEnd:
	# restore a1
	move $a1, $s1
	
	lw $ra, 8($sp)
	lw $s0, 12($sp)
	lw $s1, 16($sp)
	lw $s2, 20($sp)
	lw $s3, 24($sp)
	lw $s4, 28($sp)
	addi $sp, $sp, 32 #Undo the sp offset
	
	la $v0, sorted_list # returns the address of the sorted array
	jr $ra
	
#  true if less than, false if greater than
set: 

	move $t0, $a0 # t0 = array[i]
	move $t1, $a1 # array [j]
	
	compare:
	
	blt $t0, $t1, L # jumps to less than if t0 < t1
	bge $t0, $t1, G # jumps to greater than if t0 > t1
	
	j compare #set onLess THan
	
	stringEnd:
	beq $t2, $zero, L # if x = 0
	j G # returns false
	
	L: #true
	li $v0, 1
	j insertEnd	
	
	G: #false
	li $v0, 0
	j insertEnd

	insertEnd:
	jr $ra
	
	
# bSearch takes in a list, its size, and a search key as arguments.
# It performs binary search RECURSIVELY to look for the search key.
# It will return a 1 if the key is found, or a 0 otherwise.
# Note: you MUST NOT use iterative approach in this function.
bSearch:
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)

       move $s0, $a0 #array address
       li $s1, 0#Left bound
       move $s2, $a3 #search key
       move $s3, $a1 #right bound
       move $s4, $zero #midpoint
       li $t4, 4 #loads 4 for the offset

       add $t0, $s3, 0 
       beq $a2, $t0, false

       add $t1, $a1, $a2 #l+R
       div $t1, $t1, 2# midpoint = (l + r) / 2; Middle index
       mul $t4, $t4, $t1  #address  = address + mid offset
       add $t3, $a0, $t4
       lw $t2, 0($t3)


       beq $t2, $s2, true
       blt $s2, $t2, lessThan
       bgt $s2, $t2, greaterThan

       lessThan:
       move $a1, $t1 #sets right to mid
       jal bSearch
       j stackReset

       greaterThan:
       add $a2, $t1, 1 #sets left to mid + 1
       jal bSearch
       j stackReset

       true:
       li $v0, 1
       j stackReset

       false:
       li $v0, 0
	

      stackReset:
       lw $ra, 0($sp)
       addi $sp, $sp, 4 #Resets the stack
       jr $ra