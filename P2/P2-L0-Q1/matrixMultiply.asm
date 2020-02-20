.macro readDigit(%dst) # uses v0
li $v0, 5
syscall
move %dst, $v0
.end_macro

.macro getAddress(%dst, %base, %i, %j, %length)
mul %dst, %i, %length
add %dst, %dst, %j
mul %dst, %dst, 4
add %dst, %dst, %base
.end_macro

.data
m1: .space 300
m2: .space 300
res: .space 300

space: .asciiz " "
newline: .ascii "\n"

.text
readDigit($s0) # s0 contains n

la $t0, m1	# t0: m+i
mul $s3, $s0, $s0
mul $t1, $s3, 4
add $t1, $t1, $t0	# t1:max
loop_read_m1:
	readDigit($t2)
	sw $t2, ($t0)
	addi $t0, $t0, 4
	blt $t0, $t1, loop_read_m1

la $t0, m2	# t0: m+i
mul $t1, $s3, 4
add $t1, $t1, $t0	# t1:max
loop_read_m2:
	readDigit($t2)
	sw $t2, ($t0)
	addi $t0, $t0, 4
	blt $t0, $t1, loop_read_m2
	
# read data finished
# s1:m1, s2:m2 s4:res
la $s1, m1
la $s2, m2
la $s4, res

# loop-var i
# loopvar j
# t2: tmp address
# t3: m1[i][j]
# t4: m2[j][i]
li $t5, 0	# t5: res
# t6: tmp j

li $t0, 0 
loop_multi_m1_row:
	li $t1, 0
	loop_multi_m1_col:
		li $t5, 0
		li $t6, 0
		loop_multi_m2_col:
			getAddress($t2, $s1, $t0, $t6, $s0)
			lw $t3, ($t2)
			getAddress($t2, $s2, $t6, $t1, $s0)
			lw $t4, ($t2)
			mul $t3, $t3, $t4
			add $t5, $t5, $t3
			addi $t6, $t6, 1
			blt $t6, $s0, loop_multi_m2_col
		getAddress($t2, $s4, $t0, $t1, $s0)
		sw $t5, ($t2)
		addi $t1, $t1, 1
		blt $t1, $s0, loop_multi_m1_col
	addi $t0, $t0, 1
	blt $t0, $s0, loop_multi_m1_row

# output
li $t0, 0
loop_output_out:
	li $t1, 0
	loop_output_inner:
		getAddress($t2, $s4, $t0, $t1, $s0)
		lw $a0, ($t2)
		li $v0, 1
		syscall	#output num
		
		la $a0, space
		li $v0, 4
		syscall #output space
		
		addi $t1, $t1, 1
		blt $t1, $s0, loop_output_inner
	
	la $a0, newline
	li $v0, 4
	syscall #output newline
	
	addi $t0, $t0, 1
	blt $t0, $s0, loop_output_out
	
li $v0, 10
syscall
		
		
	
		
		
		
		