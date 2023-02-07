		.data
x:		.word 5
y:		.word 10
z:		.word 15

		.text
MAIN:	la $t0, x
		lw $s0, 0($t0)		# s0 = x
		la $t0, y
		lw $s1, 0($t0)		# s1 = y
		la $t0, z
		lw $s2, 0($t0)		# s2 = z
		
		
		# Prepare to call sum(x)
		add $a0, $zero, $s0	# Set a0 as input argument for FOO
		add $a1, $zero, $s1
		add $a2, $zero, $s2
		
		jal FOO
		
		add $t0, $s1, $s0 	# t0 = x+y
		add $t0, $t0, $s2	#$t0 = x + y + z
		add $a0, $s3, $t0 	#$a0 = #s3 + $t0	 Load total
		
		li $v0, 1		 
		syscall	
		j END
		
BAR: 	addi $sp, $sp, -20 
		sw $v0, 0($sp) # return value
		sw $a0, 4($sp) # a
		sw $a1, 8($sp) # b
		sw $a2, 12($sp) # c
		sw $ra, 16($sp)

		sub $t7, $a2, $a0 #c-a
		sllv  $v0, $t7, $a1  #(c-a)^b

		lw $t1, 0($sp) # return value
		lw $a0, 4($sp) # a
		lw $a1, 8($sp) # b
		lw $a2, 12($sp) # c
		lw $ra, 16($sp)

		addi $sp, $sp 20
   		jr $ra
   	
FOO:	addi $sp, $sp -24
		sw $v0, 0($sp)	# return value
		sw $a0, 4($sp)	# a m
		sw $a1, 8($sp)	# b n
		sw $a2, 12($sp)	# c o
		sw $s0, 16($sp)
		sw $ra, 20($sp)
		
		#int p = bar(m + n, n + o, o + m);
		#int q = bar(m - o, n - m, 2 * n);

		add $t0, $a0, $a1 # m + n
		add $t1, $a1, $a2 # n + o
		add $t2, $a0, $a2 # o + m

		sub $t3, $a0, $a2 	# m - o
		sub $t4, $a1, $a0 	# n - m
		mul $t5, $a1, 2  	# 2 * n

		move $a0, $t0 
		move $a1, $t1
		move $a2, $t2

		jal BAR

		move $t0, $v0
		move $a0, $t3 
		move $a1, $t4
		move $a2, $t5

		jal BAR

		lw $s3, 0($sp) # return value
		lw $a0, 4($sp) # a
		lw $a1, 8($sp) # b
		lw $a2 12($sp) # c	
		lw $s0 16($sp) # p
		lw $ra 20($sp)
		
		add $s3, $t0, $v0

		addi $sp, $sp, 24
		
		jr $ra
		
END:
