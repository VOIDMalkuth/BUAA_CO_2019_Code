ori $1, 125
ori $2, 131
jal label1
addu $1, $31, $2
jal end:
addu $1, $2, $31
label1: 
addu $2, $31, $1
addu $31, $31, $1
nop
nop
nop
nop
nop
subu $31, $31, $1
jr $ra
nop
end:
nop