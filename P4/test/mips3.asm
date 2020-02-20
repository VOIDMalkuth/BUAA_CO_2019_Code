lui $gp, 0
lui $sp, 0
start:
lui $3, 0xf568
lui $4, 0x4127
ori $3, 0x0120
addu $5, $4, $0
lui $7, 0
lui $8, 0
lui $9, 0
lui $10, 0
ori $8, 0x0004
ori $9, 0x0002
lui $11, 0
ori $11, 128
loop:
sw $10, ($7)	# WILL FAIL IN MARS
addu $7, $7, $8
addu $10, $10, $9
beq $0, $3, start
beq $7, $11, loop_end
beq $0, $0, loop
loop_end:
