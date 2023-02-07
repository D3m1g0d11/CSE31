        .data
n:      .word 0

        .text
main: 	add     $t0, $0, $zero
		addi    $t1, $zero, 1
		#la      $t3, n
		#lw      $t3, 0($t3)
		
		li $v0, 5
		syscall
		move $t3, $v0
		
fib: 	beq     $t3, $0, finish #finish if $t3 = 0 while t3 != 0
		add     $t2,$t1,$t0 #t2 = t1 + t0
		move    $t0, $t1 #t0 = t1
		move    $t1, $t2 #t1 = t2 = t1 + t0
		subi    $t3, $t3, 1 # t3 -= 1
		j       fib #jumps to fib
		
finish: addi    $a0, $t0, 0 
		li      $v0, 1		
		syscall			
		li      $v0, 10		
		syscall			

