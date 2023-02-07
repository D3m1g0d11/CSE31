		.data
x:		.word 5
y:		.word 10
m:		.word 15
b:		.word 2

		.text
MAIN:	la $t0, x
		lw $s0, 0($t0)		# s0 = x
		la $t0, y
		lw $s1, 0($t0)		# s1 = y
		
		# Prepare to call sum(x)
		add $a0, $zero, $s0	# Set a0 as input argument for SUM
		
		jal SUM
		
		add $t0, $s1, $s0 	# $t0 = $s1 + $s0 (y + x)
		add $s1, $t0, $v0 	# $s1 = $t0 + $v0 (y + x + sum)
		addi $a0, $s1, 0 	# $a0 = #s1 + 0	 Load total
		
		li $v0, 1		
		syscall	
		j END

		
SUM: 	la $t0, m
		addi $sp, $sp, -12 
		sw $a0, 0($sp) 	#Saves $a0 as a backup
		sw $s0, 4($sp)	#Saves $s0 as a backup
		sw $ra, 8($sp)	#Saves $ra as a backup
		lw $s0, 0($t0)		# s0 = m
		
		add $a0, $s0, $a0	# Update a0 as new argument for SUB
		
		jal SUB
		
		lw $a0, 0($sp) #$a0
		lw $s0, 4($sp)	#$s0
		lw $ra, 8($sp)	#$ra
		
		addi $sp, $sp, 12 	#12 = 4 (integer) * 3 
		add $v0, $a0, $v0 	#sets argument as a value
		jr $ra		
		
SUB:	la $t0, b
		addi $sp, $sp -4
		sw $s0, 0($sp)		# Backup s0 from SUM
		lw $s0, 0($t0)		# s0 = b
		
		sub $v0, $a0, $s0	#subtracts 
		
		lw $s0, 0($sp)		# Restore s0 from SUM
		addi $sp, $sp 4		#reverses 4 for space
		jr $ra

		
END:
