begin:
ori $t1, $t1, 3
ori $t2, 0x3456
sw $t2, 1($t1) 
ori $t1, 4
lui $t3, 0xaaaa
ori $t3, 0xbbbb
lw $t3, -3($t1)
beq $t3, $t2, jumo
nop
beq $zero, $zero, begin
nop
jumo:
sw $zero, 4($zero) 
