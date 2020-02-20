.data
.align 2
stack_start: .space 0x2000
stack: 
symbol: .space 8
array:.space 8
space: .asciiz " "
newline: .asciiz "\n"

.text
la $sp, stack
la $s1, array
la $s2, symbol

li $v0, 5
syscall
move $s0, $v0

li $a0, 0
jal fullArray

li $v0, 10
syscall

#sub-routines
fullArray:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	addi $sp, $sp, -4
	sw $a0, ($sp)
	addi $sp, $sp, -4
	sw $t0, ($sp)
	addi $sp, $sp, -4
	sw $t1, ($sp)
	addi $sp, $sp, -4
	sw $t2, ($sp)
	addi $sp, $sp, -4
	sw $t3, ($sp)
	
	
	print:
	blt $a0, $s0, recurse
	li $t0, 0
	loop_print:	# not save a0 for return immediately
		add $t1, $t0, $s1
		lb $a0, ($t1)
		li $v0, 1
		syscall
		la $a0, space
		li $v0, 4
		syscall
		
		addi $t0, $t0, 1
		blt $t0, $s0, loop_print
	la $a0, newline
	li $v0, 4
	syscall
	lw $t3, ($sp)
	addi $sp, $sp, 4
	lw $t2, ($sp)
	addi $sp, $sp, 4
	lw $t1, ($sp)
	addi $sp, $sp, 4
	lw $t0, ($sp)
	addi $sp, $sp, 4
	lw $a0, ($sp)
	addi $sp, $sp, 4
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
	
	
	recurse:
	li $t0, 0
		recurse_loop:
		add $t1, $t0, $s2	# t1: symbol[i]
		lb $t2, ($t1)
		bne $t2, 0, recurse_loop_finish
		
		li $t3, 1
		sb $t3, ($t1)	#symbol[i] = 1
				
		addi $t3, $t0, 1 	# i + 1
		add $t2, $a0, $s1	# array index
		sb $t3, ($t2)	#array[index] = i + 1
		
		addi $a0, $a0, 1
		jal fullArray
		addi $a0, $a0, -1
		
		sb $zero, ($t1)	#symbol[i] = 0
		
		recurse_loop_finish:
		addi $t0, $t0, 1
		blt $t0, $s0, recurse_loop

lw $t3, ($sp)
addi $sp, $sp, 4
lw $t2, ($sp)
addi $sp, $sp, 4
lw $t1, ($sp)
addi $sp, $sp, 4
lw $t0, ($sp)
addi $sp, $sp, 4
lw $a0, ($sp)
addi $sp, $sp, 4
lw $ra, ($sp)
addi $sp, $sp, 4
jr $ra
		
		
	