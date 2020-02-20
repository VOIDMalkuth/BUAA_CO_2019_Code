.macro addr(%dst, %base, %i, %j, %len)
mul %dst, %i, %len
add %dst, %dst, %j
sll %dst, %dst, 2
add %dst, %dst, %base
.end_macro

.data
array: .space 600
core: .space 600
res: .space 600
space: .asciiz " "
nl: .asciiz "\n"

.text
la $s4, array
la $s5, core
la $s6, res

li $v0, 5
syscall
move $s0, $v0	# s0 = m1
li $v0, 5
syscall
move $s1, $v0	# s1 = n1
li $v0, 5
syscall
move $s2, $v0	# s2 = m2
li $v0, 5
syscall
move $s3, $v0	# s3 = n2

li $t0, 0
read_array_lp:
	li $t1, 0
	read_array_lp_in:
		li $v0, 5
		syscall
		addr($t8, $s4, $t0, $t1, $s1)
		sw $v0, ($t8)
		
		addi $t1, $t1, 1
		blt $t1, $s1, read_array_lp_in
	addi $t0, $t0, 1
	blt $t0, $s0, read_array_lp
	
li $t0, 0
read_core_lp:
	li $t1, 0
	read_core_lp_in:
		li $v0, 5
		syscall
		addr($t8, $s5, $t0, $t1, $s3)
		sw $v0, ($t8)
		
		addi $t1, $t1, 1
		blt $t1, $s3, read_core_lp_in
	addi $t0, $t0, 1
	blt $t0, $s2, read_core_lp
	
#cal
li $t0, 0
cal_lp_i:
	li $t1, 0
	cal_lp_j:
		li $s7, 0	# s7 = tmp
		move $t2, $t0	# k = i
		cal_lp_k:
			move $t3, $t1	# l = j
			cal_lp_l:
				addr($t7, $s4, $t2, $t3, $s1)
				lw $t8, ($t7)
				subu $t4, $t2, $t0
				subu $t5, $t3, $t1
				addr($t7, $s5, $t4, $t5, $s3)
				lw $t9, ($t7)
				mul $t7, $t8, $t9
				add $s7, $s7, $t7
				
				addi $t3, $t3, 1
				addu $t7, $t1, $s3
				blt $t3, $t7, cal_lp_l
			
			addi $t2, $t2, 1
			addu $t7, $t0, $s2
			blt $t2, $t7, cal_lp_k
		
		subu $t8, $s1, $s3
		addi $t8, $t8, 1
		addr($t7, $s6, $t0, $t1, $t8)
		sw $s7, ($t7)
		
		addi $t1, $t1, 1
		blt $t1, $t8, cal_lp_j
	
	subu $t8, $s0, $s2
	addi $t8, $t8, 1
	addi $t0, $t0, 1
	blt $t0, $t8, cal_lp_i
	
# out
li $t0, 0
out_lp_i:
	li $t1, 0
	out_lp_j:
		subu $t8, $s1, $s3
		addi $t8, $t8, 1
		addr($t7, $s6, $t0, $t1, $t8)
		lw $a0, ($t7)
		li $v0, 1
		syscall
		la $a0, space
		li $v0, 4
		syscall
		
		addi $t1, $t1, 1
		blt $t1, $t8, out_lp_j
		
	la $a0, nl
	li $v0, 4
	syscall
	subu $t8, $s0, $s2
	addi $t8, $t8, 1
	addi $t0, $t0, 1
	blt $t0, $t8, out_lp_i
	
li $v0, 10
syscall
		
		
		
				







