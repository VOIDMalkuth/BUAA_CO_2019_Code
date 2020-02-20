.data
.space 4

.text
lui $t0, 0x1234
lui $t0, 0x5678
sw $t0, 0
lw $s0, 0
ori $s1, $s0, 0xabcd
