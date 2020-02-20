.data
.space 4

.text
lui $t0, 0x1234
ori $0, 0x5678
sw $t0, 0
lw $zero, 0
ori $s1, $zero, 0xabcd
