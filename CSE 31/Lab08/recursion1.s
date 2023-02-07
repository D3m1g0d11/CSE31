        .data


userInput: .asciiz "Please enter an integer: "
        .text
main: 		addi $sp, $sp, -4	# Moving stack pointer to make room for storing local variables (push the stack frame)
		
		li $v0, 4
		la $a0, userInput
		syscall
		
		# (read user input)
		li $v0, 5
		syscall		
		
		#User input goes to argument
		move $a0, $v0
		addi $v0, $zero, 0
		
		jal recursion	# Calls recursion
		
		sw $v0, 0($sp)
		lw $a0, 0($sp)
		
		li $v0, 1         # service 1 is print integer
		syscall
		
		j end		# Jump to end of program


# Implementing recursion
recursion:	addi $sp, $sp, -12	# Push stack frame for local storage
		
		sw $ra, 8($sp)	#Saves $ra as a backup
		
		
		addi $t0, $zero, 10
		bne $t0, $a0, not_ten
		
		
		
		#update returned value)
		addi $v0, $v0 2 #return value
		
		j end_recur
			
not_ten:	addi $t0, $zero, 11
		bne $t0, $a0, not_eleven
		
		# TPS 2 #9 (update returned value)
		
		addi $v0, $v0, 1
		
		j end_recur		

not_eleven:	sw $a0, 4($sp) 	
		#Prepare new input argument, i.e. m + 2)
		
		addi $a0, $a0, 2
		
		jal recursion	# Call recursion (m + 2)
		
		lw $a0, 4($sp)
				
		
		# (Prepare new input argument, i.e. m + 1)
		addi $a0, $a0, 1
		
		jal recursion	# Call recursion(m + 1)
		
		
		lw $a0, 4($sp)
		add $v0, $a0, $v0
		
		j end_recur
		

# End of recursion function	
end_recur:	 lw $ra, 8($sp) 		#return value
		
		addi $sp, $sp, 12	# Pop stack frame 
		jr $ra

# Terminating the program
end:	addi $sp, $sp 4	# Moving stack pointer back (pop the stack frame)
		li $v0, 10 
		syscall
