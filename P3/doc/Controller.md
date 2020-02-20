#### RegWAddrpath

端口定义表

| 信号名                 | 方向 | 描述                                    |
| ---------------------- | ---- | --------------------------------------- |
| RegWAddrpath_sel[1:0]  | I    | 选择信号：0 --- rd， 1 --- rt，其他待定 |
| RegWAddrpath_rdIn[4:0] | I    | rd                                      |
| RegWAddrpath_rtIn[4:0] | I    | rt                                      |
| RegWAddrpath_out[4:0]  | O    | 输出                                    |

功能：根据RegWAddrpath_sel的选择输出对应数据



#### RegWDatapath

端口定义表

| 信号名                   | 方向 | 描述                                              |
| ------------------------ | ---- | ------------------------------------------------- |
| RegWDatapath_sel[1:0]    | I    | 选择信号：0 --- alu结果， 1 --- mem数据，其他待定 |
| RegWDatapath_aluIn[31:0] | I    | ALU结果                                           |
| RegWDatapath_memIn[31:0] | I    | MEM结果                                           |
| RegWDatapath_out[31:0]   | O    | 输出                                              |

功能：根据RegWDatapath_sel的选择输出对应数据



#### ALUOp2Datapath

端口定义表

| 信号名                       | 方向 | 描述                                                         |
| ---------------------------- | ---- | ------------------------------------------------------------ |
| ALUOp2Datapath_sel[1:0]      | I    | 选择信号，0 --- RegData2，1 --- EXTender，2 --- 移位后的immediate(用于lui)，3 --- 待定 |
| ALUOp2Datapath_regIn[31:0]   | I    | reg数据输入                                                  |
| ALUOp2Datapath_extIn[31:0]   | I    | ext数据输入                                                  |
| ALUOp2Datapath_shiftIn[31:0] | I    | 移位后immediate输入                                          |
| ALUOp2Datapath_out[31:0]     | O    | 输出                                                         |

功能：根据ALUOp2Datapath_sel的选择输出对应数据



#### InstructionDecoder

端口定义表 

| 信号名      | 方向 | 描述             |
| ----------- | ---- | ---------------- |
| OpCode[5:0] | I    | 指令的OpCode部分 |
| Funct[5:0]  | I    | 指令的Funct部分  |
| ID_addu     | O    | 指令为addu时为1  |
| ID_subu     | O    | 指令为subu时为1  |
| ID_ori      | O    | 指令为ori时为1   |
| ID_lw       | O    | 指令为lw时为1    |
| ID_sw       | O    | 指令为sw时为1    |
| ID_beq      | O    | 指令为beq时为1   |
| ID_lui      | O    | 指令为lui时为1   |

功能定义表

| 序号 | 功能名称 | 功能描述                       |
| ---- | -------- | ------------------------------ |
| 1    | 译码     | 当检测到某指令时输出其对应信号 |

组合逻辑真值表

| OpCode | Funct  |      | ID_addu | ID_subu | ID_ori | ID_lw | ID_sw | ID_beq | ID_lui |
| ------ | ------ | :--: | ------- | ------- | ------ | ----- | ----- | ------ | ------ |
| 000000 | 100001 |      | 1       | 0       | 0      | 0     | 0     | 0      | 0      |
| 000000 | 100011 |      | 0       | 1       | 0      | 0     | 0     | 0      | 0      |
| 001101 | xxxxxx |      | 0       | 0       | 1      | 0     | 0     | 0      | 0      |
| 100011 | xxxxxx |      | 0       | 0       | 0      | 1     | 0     | 0      | 0      |
| 101011 | xxxxxx |      | 0       | 0       | 0      | 0     | 1     | 0      | 0      |
| 000100 | xxxxxx |      | 0       | 0       | 0      | 0     | 0     | 1      | 0      |
| 001111 | xxxxxx |      | 0       | 0       | 0      | 0     | 0     | 0      | 1      |



#### ControlSignalGenerator

端口定义表 

| 信号名                  | 方向 | 描述               |
| ----------------------- | ---- | ------------------ |
| ID_addu                 | I    | 指令为addu         |
| ID_subu                 | I    | 指令为subu         |
| ID_ori                  | I    | 指令为ori          |
| ID_lw                   | I    | 指令为lw           |
| ID_sw                   | I    | 指令为sw           |
| ID_beq                  | I    | 指令为beq          |
| ID_lui                  | I    | 指令为lui          |
| BranchEqual             | O    | 相等时分支         |
| Jump                    | O    | 跳转指示           |
| RegWEnable              | O    | 寄存器写使能信号   |
| RegWAddrpath_sel[1:0]   | O    | 寄存器写地址选择   |
| RegWDatapath_sel[1:0]   | O    | 寄存器写数据选择   |
| ALUOperation[2:0]       | O    | ALU操作信号        |
| ALUOp2Datapath_sel[1:0] | O    | ALU操作数2选择信号 |
| MemWEnable              | O    | 内存写使能         |
| MemMode[1:0]            | O    | 操作位宽           |
| EXTMode                 | O    | Extender模式       |

功能：根据指令输入输出对应控制信号

组合逻辑真值表

| 指令 | BranchEqual | Jump | RegWEnable | RegWAddrpath_sel | RegWDatapath_sel | ALUOperation[2:0] | ALUOp2Datapath_sel[1:0] | MemWEnable | MemMode[1:0] | EXTMode |
| :--: | ----------- | ---- | ---------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------- | ------------ | ------- |
| addu | 0           | 0    | 1          | 0                | 0                | 0                 | 0                       | 0          | x            | x       |
| subu | 0           | 0    | 1          | 0                | 0                | 1                 | 0                       | 0          | x            | x       |
| ori  | 0           | 0    | 1          | 1                | 0                | 2                 | 1                       | 0          | x            | 0       |
|  lw  | 0           | 0    | 1          | 1                | 1                | 0                 | 1                       | 0          | 00           | 1       |
|  sw  | 0           | 0    | 0          | x                | x                | 0                 | 1                       | 1          | 00           | 1       |
| beq  | 1           | 0    | 0          | x                | x                | 1（相减isZero？） | 0                       | 0          | x            | 1       |
| lui  | 0           | 0    | 1          | 1                | 0                | 2                 | 2                       | 0          | x            | 0       |

| 信号                    | addu | subu    | ori     | lw     | sw     | beq     | lui     |
| ----------------------- | ---- | ------- | ------- | ------ | ------ | ------- | ------- |
| BranchEqual             | 0    | 0       | 0       | 0      | 0      | 1       | 0       |
| Jump                    | 0    | 0       | 0       | 0      | 0      | 0       | 0       |
| RegWEnable              | 1    | 1       | 1       | 1      | 0      | 0       | 1       |
| RegWAddrpath_sel[1:0]   | 0    | 0       | 1(b01)  | 1(b01) | xx     | xx      | 1(b01)  |
| RegWDatapath_sel[1:0]   | 0    | 0       | 0       | 1(b01) | xx     | xx      | 0       |
| ALUOperation[2:0]       | 0    | 1(b001) | 2(b010) | 0      | 0      | 1(b001) | 2(b010) |
| ALUOp2Datapath_sel[1:0] | 0    | 0       | 1(b01)  | 1(b01) | 1(b01) | 0       | 2(b10)  |
| MemWEnable              | 0    | 0       | 0       | 0      | 1      | 0       | 0       |
| MemMode[1:0]            | xx   | xx      | xx      | 0      | 0      | xx      | xx      |
| EXTMode                 | x    | x       | 0       | 1      | 1      | 1       | 0       |



注： lui采用ALU输入2（移位至高16位） | 0的输出作为写寄存器输入

