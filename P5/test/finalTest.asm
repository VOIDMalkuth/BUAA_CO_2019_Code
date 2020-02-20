lui $28, 0
lui $29, 0
# for simulation in mars, clear $gp and $sp
ori $1, $0, 0x1234
lui $1, 0x1078
# check if lui set lower to 0
ori $1, $1, 0x1234
# function of ori
addu $0, $1, $1
addu $2, $0, $1
addu $2, $1, $1
# check if $0 stays at 0 and addu
subu $2, $2, $1
# func of subu
ori $3, $0, 5
# check if DM is reset to 0
addu $2, $3, $2
lw $4, 4($0)
sw $2, 3($3)
# lw/sw check
# beq/jal/jr check
beq $0, $3, branch
addu $5, $5, $3
addu $5, $5, $3
branch: 
addu $5, $5, $3
beq $0, $0, branch2
addu $7, $5, $3
branch2:
addu $5, $5, $3
jal jump
addu $6, $5, $3
addu $6, $5, $3
jal end
jump:
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
lui $0, 0xdeb
beq $0, $0, loop
lui $0, 0xabc
end_loop:
jr $ra
nop
end:


