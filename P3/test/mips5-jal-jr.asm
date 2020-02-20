lb: lui $0,10
lui $1, 0
lui $2, 0
lui $3, 0
lui $4, 0
ori $2, 1
ori $4, 0x7
lui $5, 0
ori $5, 0x20
lui $6, 0
ori $6, 4

jal func
jal end

func:
beq $4, $3, return
addu $3, $3, $2
subu $5, $5, $6
sw $ra, ($5)
jal func
lw $ra, ($5)
addu $5, $5, $6
return:
jr $ra

lui $16, 0x1234	# Shouldn't be executed

end:
lui $15 0x7890
