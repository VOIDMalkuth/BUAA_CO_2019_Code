.data
str: .space 500

.text
li $v0, 5
syscall 
move $s0, $v0 	# s0: total

la $t1, str
li $t0, 0
read_loop:
	add $t2, $t1, $t0
	
	li $v0, 12
	syscall
	sb $v0, ($t2)
	
	addi $t0, $t0, 1
	blt $t0, $s0, read_loop
	
la $t0, str
add $t1, $t0, $s0
addi $t1, $t1, -1
check_loop:
	lb $t2, ($t0)
	lb $t3, ($t1) 
	
	bne $t2, $t3, fail
	addi $t0, $t0, 1
	addi $t1, $t1, -1
	blt $t0, $t1, check_loop
li $s1, 1
j output 

fail:
li $s1, 0
j output
	
output:
move $a0, $s1
li $v0, 1
syscall

li $v0,10
syscall