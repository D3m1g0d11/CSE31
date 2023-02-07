        .data
n:      .word 25
str1: .asciiz "Less than\n"
str2: .asciiz "Less than or equal to\n"
str3: .asciiz "Greater than\n"
str4: .asciiz "Greater than or equal to\n"

        .text

	la $t0, n
	lw $s0, 0($t0)
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	slt $t0, $s1, $s0 #if s1 is less than $s0 $t0  = 1 else $t0 = 0 if s1 == s0 fo to greater than or equal to ($t0 = 1)
	bne $t0, $zero, L #if $t0 != 0 then go to less than function
	beq $t0, $zero, G #if $t0 == 0 then go to greater than function

#	slt $t0, $s0, $s1 #if s0 is less than $s1 then $t0 = 1 else $t0 = 0 if s0 == s1 then go to less than
#	bne $t0, $zero, G
#	beq $t0, $zero, L


L:		li  $v0, 4         # service 1 is print integer
    		la $a0, str1  # load desired value into argument register $a0, using pseudo-op
    		syscall	
    		j END
    		
#L:    		li  $v0, 4         # service 1 is print integer
#    		la $a0, str2  # load desired value into argument register $a0, using pseudo-op
#   		syscall	
#    		j END
    		
#G:    		li  $v0, 4         # service 1 is print integer
#   		la $a0, str3  # load desired value into argument register $a0, using pseudo-op
#  		syscall	
#    		j END
    		
G:    		li  $v0, 4         # service 1 is print integer
    		la $a0, str4  # load desired value into argument register $a0, using pseudo-op
    		syscall		
		j END
		
END:           li $v0, 10
		syscall
