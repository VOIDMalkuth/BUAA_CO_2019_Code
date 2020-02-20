.macro addr(%dst, %base, %i, %j, %length)
mul %dst, %i, %length
add %dst, %dst, %j
sll %dst, %dst, 2
add %dst, %dst, %base
.end_macro 

.macro readNum(%dst)
li $v0, 5
syscall
move %dst, $v0
.end_macro 

.data
matrix: .space 500
kernel: .space 500
res: .space 500
space: .asciiz " "
nl: .asciiz "\n"

.text
la $s0, matrix
la $s1, kernel

readNum($s2)	#m1
readNum($s3)	#n1
readNum($s4)	#m2
readNum($s5)	#n2

la $s6, res

la $t0, matrix
mul $t2, $s2, $s3
sll $t2, $t2, 2
add $t2, $t2, $s0
read_mat_loop:
	li $v0, 5
	syscall
	sw $v0, ($t0)
	
	addi $t0, $t0, 4
	blt $t0, $t2, read_mat_loop
	
la $t0, kernel
mul $t2, $s4, $s5
sll $t2, $t2, 2
add $t2, $t2, $s1
read_ker_loop:
	li $v0, 5
	syscall
	sw $v0, ($t0)
	
	addi $t0, $t0, 4
	blt $t0, $t2, read_ker_loop
	
li $t0, 0
con_row_loop:
	li $t2, 0
	con_col_loop:
		#multiply and place at res[t0][t2]
		li $t9, 0
		li $t3, 0
		mul_row_loop:
			li $t4, 0
			mul_col_loop:
				add $t5, $t3, $t0
				add $t6, $t4, $t2
				addr($t1, $s0, $t5, $t6, $s3)
				lw $t7, ($t1)
				addr($t1, $s1, $t3, $t4, $s5)
				lw $t8, ($t1)
				mul $t7, $t7, $t8
				add $t9, $t9, $t7
				
				addi $t4, $t4, 1
				blt $t4, $s5, mul_col_loop
				
			addi $t3, $t3, 1
			blt $t3, $s4, mul_row_loop
		
		#Output, res in $t9
		move $a0, $t9
		li $v0, 1
		syscall
		la $a0, space
		li $v0, 4
		syscall
		
		addi $t2, $t2, 1
		sub $t1, $s3, $s5
		ble $t2, $t1, con_col_loop
		
	la $a0, nl
	li $v0, 4
	syscall
	addi $t0, $t0, 1
	sub $t1, $s2, $s4
	ble $t0, $t1, con_row_loop
	
li $v0, 10
syscall


