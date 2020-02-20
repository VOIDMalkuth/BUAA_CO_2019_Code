lui $gp, 0
lui $sp, 0
# Used for simulating in MARS
begin:
ori $18, $18, 3
ori $20, 0x3456
sw $20, 1($18) 
ori $18, 4
lui $30, 0xaaaa
ori $30, 0xbbbb
lw $30, -3($18)
beq $20, $20, jumo
nop
beq $zero, $zero, begin
nop
jumo:
sw $zero, 4($zero) 
start:
ori $3, 0x0120
lui $3, 0xf568
lui $4, 0x4127
addu $5, $4, $0
lui $7, 0
lui $8, 0
lui $9, 0
lui $10, 0
ori $8, 0x0004
ori $9, 0x0002
lui $23, 0
ori $23, 0x80
loop:
sw $10, ($7)
addu $7, $7, $8
subu $10, $10, $9
beq $7, $23, end_loop
nop
beq $0, $0, loop
nop
end_loop:
