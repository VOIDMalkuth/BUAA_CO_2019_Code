.macro addr(%dst, %base, %i, %j, %length)
mul %dst, %i, %length
add %dst, %dst, %j
add %dst, %dst, %base
.end_macro

.macro push(%reg)
addi $sp, $sp, -4
sw %reg, ($sp)
.end_macro 

.macro pop(%reg)
lw %reg, ($sp)
addi $sp, $sp, 4
.end_macro

.data
maze: .space 100

.text
la $s0, maze

li $v0, 5
syscall
move $s1, $v0	# n
li $v0, 5
syscall
move $s2, $v0	# m

mul $t8, $s1, $s2
add $t8, $t8, $s0
move $t0, $s0
read_in_loop:
	li $v0, 5
	syscall
	sb $v0, ($t0)
	
	addi $t0, $t0, 1
	blt $t0, $t8, read_in_loop

li $v0, 5
syscall
addi $s3, $v0, -1	# dest_y
li $v0, 5
syscall
addi $s4, $v0, -1	# dest_x
li $v0, 5
syscall
addi $a0, $v0, -1	# start_y
li $v0, 5
syscall
addi $a1, $v0, -1	# start_x
li $s7, 0		# total

jal dfs

move $a0, $s7
li $v0, 1
syscall

li $v0, 10
syscall



# Begin SubRoutine: dfs
# $a0 --- start_y, $a1 --- start_x
dfs:
bne $a0, $s3, next
bne $a1, $s4, next
addi $s7, $s7, 1
jr $ra

next:
addr($t8, $s0, $a0, $a1, $s2)
li $t9, 1
sb $t9, ($t8)

down:
addi $t9, $a0, -1
blt $t9, $zero, left
addr($t8, $s0, $t9, $a1, $s2)
lb $t7, ($t8)
bne $t7, $zero, left

push($a0)
push($a1)
push($ra)
move $a0, $t9
move $a1, $a1
jal dfs
pop($ra)
pop($a1)
pop($a0)

left:
addi $t9, $a1, -1
blt $t9, $zero, up
addr($t8, $s0, $a0, $t9, $s2)
lb $t7, ($t8)
bne $t7, $zero, up

push($a0)
push($a1)
push($ra)
move $a0, $a0
move $a1, $t9
jal dfs
pop($ra)
pop($a1)
pop($a0)

up:
addi $t9, $a0, 1
bge $t9, $s1, right
addr($t8, $s0, $t9, $a1, $s2)
lb $t7, ($t8)
bne $t7, $zero, right

push($a0)
push($a1)
push($ra)
move $a0, $t9
move $a1, $a1
jal dfs
pop($ra)
pop($a1)
pop($a0)

right:
addi $t9, $a1, 1
bge $t9, $s2, fin
addr($t8, $s0, $a0, $t9, $s2)
lb $t7, ($t8)
bne $t7, $zero, fin

push($a0)
push($a1)
push($ra)
move $a0, $a0
move $a1, $t9
jal dfs
pop($ra)
pop($a1)
pop($a0)

fin:
addr($t8, $s0, $a0, $a1, $s2)
sb $zero, ($t8)
jr $ra
