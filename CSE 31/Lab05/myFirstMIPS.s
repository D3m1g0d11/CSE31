        .data
s1:      .word 

        .text
main: 	move    $t0, $s0
		addi    $t1, $t0, -1
		addi    $t2, $t1, -2
		addi    $t3, $t2, -3
		addi    $t4, $t3, -4
		addi    $t5, $t4, -5
		addi    $t6, $t5, -6
		addi    $t7, $t6, -7

		addi    $a0, $t0, 0
		li      $v0, 1
		syscall		
		
		addi    $a0, $t1, 0	
		li      $v1, 1	
		syscall	
		
		addi    $a0, $t2, 0		
		li      $v0, 1	
		syscall	
		
		addi    $a0, $t3, 0	
		li      $v0, 1	
		syscall	
		
		addi    $a0, $t4, 0	
		li      $v0, 1	
		syscall	
		
		addi    $a0, $t5, 0	
		li      $v0, 1	
		syscall	
		
		addi    $a0, $t6, 0	
		li      $v0, 1	
		syscall		
		
		addi    $a0, $t7, 0	
		li      $v0, 10
		syscall	
