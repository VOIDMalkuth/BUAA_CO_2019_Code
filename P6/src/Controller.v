`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:40 11/15/2019 
// Design Name: 
// Module Name:    Controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "macro.v"

module Controller(
    input [31:0] Instr,
    output reg [31:0] instr_type,
    output reg [2:0] NPC_Mode,
    output reg [3:0] CMP_Mode,
    output reg GRF_WEnable,
    output reg [1:0] EXT_Mode,
    output reg [7:0] ALU_Operation,
    output reg [3:0] MDU_Operation,
    output reg DM_WEnable,
    output reg [3:0] DM_Mode,
    output reg [2:0] MUX_ALUOp1_Sel,
    output reg [2:0] MUX_ALUOp2_Sel,
    output reg [2:0] MUX_RegWAddr_Sel,
    output reg [2:0] MUX_RegWData_Sel,
    output reg [2:0] MUX_EALU_OData_Sel
    );

    wire [5:0] opcode = Instr[31:26];
    wire [5:0] funct = Instr[5:0];
    wire [4:0] rt = Instr[20:16];

    // instr_type is now a part of output 

    // decide what instruction is this
    always @(*) begin
        instr_type = `INSTR_NOP;
        case(opcode)
            6'b000000: begin
                case(funct)
                    6'b000000: instr_type = `INSTR_SLL; 
                    6'b000010: instr_type = `INSTR_SRL;
                    6'b000011: instr_type = `INSTR_SRA; 
                    6'b000100: instr_type = `INSTR_SLLV;
                    6'b000110: instr_type = `INSTR_SRLV;
                    6'b000111: instr_type = `INSTR_SRAV;

                    6'b001000: instr_type = `INSTR_JR;
                    6'b001001: instr_type = `INSTR_JALR;

                    6'b010000: instr_type = `INSTR_MFHI;
                    6'b010001: instr_type = `INSTR_MTHI;
                    6'b010010: instr_type = `INSTR_MFLO;
                    6'b010011: instr_type = `INSTR_MTLO;

                    6'b011000: instr_type = `INSTR_MULT;
                    6'b011001: instr_type = `INSTR_MULTU;
                    6'b011010: instr_type = `INSTR_DIV;
                    6'b011011: instr_type = `INSTR_DIVU;

                    6'b100000: instr_type = `INSTR_ADD;
                    6'b100001: instr_type = `INSTR_ADDU;
                    6'b100010: instr_type = `INSTR_SUB;
                    6'b100011: instr_type = `INSTR_SUBU;
                    6'b100100: instr_type = `INSTR_AND;
                    6'b100101: instr_type = `INSTR_OR;
                    6'b100110: instr_type = `INSTR_XOR;
                    6'b100111: instr_type = `INSTR_NOR;

                    6'b101010: instr_type = `INSTR_SLT;
                    6'b101011: instr_type = `INSTR_SLTU;

                    default: instr_type = `INSTR_NOP; 
                endcase
            end

            6'b000001: begin
                case(rt)
                    5'b00000: instr_type = `INSTR_BLTZ;
                    5'b00001: instr_type = `INSTR_BGEZ;

                    default: instr_type = `INSTR_NOP;
                endcase
            end
            
            6'b000010: instr_type = `INSTR_J;
            6'b000011: instr_type = `INSTR_JAL;

            6'b000100: instr_type = `INSTR_BEQ;
            6'b000101: instr_type = `INSTR_BNE;
            6'b000110: instr_type = `INSTR_BLEZ;
            6'b000111: instr_type = `INSTR_BGTZ;

            6'b001000: instr_type = `INSTR_ADDI;
            6'b001001: instr_type = `INSTR_ADDIU;
            6'b001010: instr_type = `INSTR_SLTI;
            6'b001011: instr_type = `INSTR_SLTIU;
            6'b001100: instr_type = `INSTR_ANDI;
            6'b001101: instr_type = `INSTR_ORI;
            6'b001110: instr_type = `INSTR_XORI;
            6'b001111: instr_type = `INSTR_LUI;

            6'b100000: instr_type = `INSTR_LB;
            6'b100001: instr_type = `INSTR_LH;
            6'b100011: instr_type = `INSTR_LW;
            6'b100100: instr_type = `INSTR_LBU;
            6'b100101: instr_type = `INSTR_LHU;

            6'b101000: instr_type = `INSTR_SB;
            6'b101001: instr_type = `INSTR_SH;
            6'b101011: instr_type = `INSTR_SW;

            default: instr_type = `INSTR_NOP;
        endcase
    end

    // decide control signal
    always @(*) begin
        // give a default value
        NPC_Mode = `NPC_NORMAL;
        CMP_Mode = `CMP_NOOP;
        GRF_WEnable = 1'b0;
        EXT_Mode =  `EXT_UNSIGNED;
        ALU_Operation = `ALU_ADDU;
        MDU_Operation = `MDU_NOOP;
        DM_Mode = `DM_WORD;
        DM_WEnable = 1'b0;
        MUX_ALUOp1_Sel = `MUX_ALUOP1_RSSEL;
        MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;
        MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
        MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
        MUX_EALU_OData_Sel = `MUX_EALU_ODATA_ALUSEL;

        case(instr_type)

            // MemRead Part
            `INSTR_LB, `INSTR_LBU, `INSTR_LH, `INSTR_LHU, `INSTR_LW: begin
                GRF_WEnable = 1'b1;
                ALU_Operation = `ALU_ADDU;  // unsigned won't overflow
                EXT_Mode = `EXT_SIGNED;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_EXTSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RTSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_MEMSEL;

                case(instr_type)
                    `INSTR_LB: DM_Mode = `DM_BYTE;
                    `INSTR_LBU: DM_Mode = `DM_BYTE_UNSIGNED;
                    `INSTR_LH: DM_Mode = `DM_HALF;
                    `INSTR_LHU: DM_Mode = `DM_HALF_UNSIGNED;
                    `INSTR_LW: DM_Mode = `DM_WORD;

                    default: DM_Mode = `DM_WORD;
                endcase
            end


            // MemWrite Part
            `INSTR_SB, `INSTR_SH, `INSTR_SW: begin
                GRF_WEnable = 1'b0;
                EXT_Mode =  `EXT_SIGNED;
                ALU_Operation = `ALU_ADDU;
                DM_WEnable = 1'b1;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_EXTSEL;
                case(instr_type)
                    `INSTR_SB: DM_Mode = `DM_BYTE;
                    `INSTR_SH: DM_Mode = `DM_HALF;
                    `INSTR_SW: DM_Mode = `DM_WORD;

                    default: DM_Mode = `DM_WORD;
                endcase
            end


            // R-Type normal Cal
            `INSTR_ADD, `INSTR_ADDU, `INSTR_SUB, `INSTR_SUBU, `INSTR_SLLV, `INSTR_SRLV,
            `INSTR_SRAV, `INSTR_AND, `INSTR_OR, `INSTR_XOR, `INSTR_NOR, `INSTR_SLT,
            `INSTR_SLTU : begin
                GRF_WEnable = 1'b1;
                ALU_Operation = `ALU_ADDU;
                MUX_ALUOp1_Sel = `MUX_ALUOP1_RSSEL;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
                MUX_EALU_OData_Sel = `MUX_EALU_ODATA_ALUSEL;

                case(instr_type)
                    `INSTR_ADD: ALU_Operation = `ALU_ADD;
                    `INSTR_ADDU: ALU_Operation = `ALU_ADDU;
                    `INSTR_SUB: ALU_Operation = `ALU_SUB;
                    `INSTR_SUBU: ALU_Operation = `ALU_SUBU;
                    `INSTR_SLLV: ALU_Operation = `ALU_SLL;
                    `INSTR_SRLV: ALU_Operation = `ALU_SRL;
                    `INSTR_SRAV: ALU_Operation = `ALU_SRA;
                    `INSTR_AND: ALU_Operation = `ALU_AND;
                    `INSTR_OR: ALU_Operation = `ALU_OR;
                    `INSTR_XOR: ALU_Operation = `ALU_XOR;
                    `INSTR_NOR: ALU_Operation = `ALU_NOR;
                    `INSTR_SLT: ALU_Operation = `ALU_SLT;
                    `INSTR_SLTU: ALU_Operation = `ALU_SLTU;

                    default: ALU_Operation = `ALU_ADDU;
                endcase
            end


            // R-Type Cal where Shamt as aluop1
            `INSTR_SLL, `INSTR_SRL, `INSTR_SRA: begin
                GRF_WEnable = 1'b1;
                MUX_ALUOp1_Sel = `MUX_ALUOP1_SHAMTSEL;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
                MUX_EALU_OData_Sel = `MUX_EALU_ODATA_ALUSEL;

                case(instr_type) 
                    `INSTR_SLL: ALU_Operation = `ALU_SLL;
                    `INSTR_SRL: ALU_Operation = `ALU_SRL;
                    `INSTR_SRA: ALU_Operation = `ALU_SRA;
                endcase // no default
            end


            // R-Type MDU related calculate
            `INSTR_MULT, `INSTR_MULTU, `INSTR_DIV, `INSTR_DIVU: begin
                GRF_WEnable = 1'b0;

                case(instr_type)
                    `INSTR_MULT: MDU_Operation = `MDU_MULT;
                    `INSTR_MULTU: MDU_Operation = `MDU_MULTU;
                    `INSTR_DIV: MDU_Operation = `MDU_DIV;
                    `INSTR_DIVU: MDU_Operation = `MDU_DIVU;

                    default: MDU_Operation = `MDU_NOOP;
                endcase
            end


            // I-type Cal
            `INSTR_ADDI, `INSTR_ADDIU, `INSTR_ANDI, `INSTR_ORI, `INSTR_XORI, `INSTR_LUI,
            `INSTR_SLTI, `INSTR_SLTIU: begin
                GRF_WEnable = 1'b1;
                MUX_ALUOp1_Sel = `MUX_ALUOP1_RSSEL;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_EXTSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RTSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
                MUX_EALU_OData_Sel = `MUX_EALU_ODATA_ALUSEL;
				// Different extmode and alu operation

                case(instr_type)
                    `INSTR_ADDI, `INSTR_ADDIU, `INSTR_SLTI, `INSTR_SLTIU: 
                        EXT_Mode = `EXT_SIGNED;
                    
                    `INSTR_ANDI, `INSTR_ORI, `INSTR_XORI, `INSTR_LUI: 
                        EXT_Mode = `EXT_UNSIGNED;

                    default: EXT_Mode = `EXT_UNSIGNED;
                endcase

                case(instr_type)
					`INSTR_ADDI: ALU_Operation = `ALU_ADD;
					`INSTR_ADDIU: ALU_Operation = `ALU_ADDU;
                    `INSTR_ANDI: ALU_Operation = `ALU_AND;
                    `INSTR_ORI: ALU_Operation = `ALU_OR;
                    `INSTR_XORI: ALU_Operation = `ALU_XOR;
                    `INSTR_LUI: ALU_Operation = `ALU_LUI;
                    `INSTR_SLTI: ALU_Operation = `ALU_SLT;
                    `INSTR_SLTIU: ALU_Operation = `ALU_SLTU;
                endcase // no default
            end


            // Branch Instructions
            `INSTR_BEQ, `INSTR_BNE, `INSTR_BLEZ, `INSTR_BGTZ, `INSTR_BLTZ, `INSTR_BGEZ: begin
                NPC_Mode = `NPC_BRANCH;

                case(instr_type)
                    `INSTR_BEQ: CMP_Mode = `CMP_EQ;
                    `INSTR_BNE: CMP_Mode = `CMP_NEQ;
                    `INSTR_BLEZ: CMP_Mode = `CMP_LEZ;
                    `INSTR_BGTZ: CMP_Mode = `CMP_GZ;
                    `INSTR_BLTZ: CMP_Mode = `CMP_LZ;
                    `INSTR_BGEZ: CMP_Mode = `CMP_GEZ;

                    default: CMP_Mode = `CMP_NOOP;
                endcase
            end

            // hi/lo op
            `INSTR_MFHI, `INSTR_MFLO: begin
                GRF_WEnable = 1'b1;
                MDU_Operation =  `MDU_READ;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
                case(instr_type)
                    `INSTR_MFHI: MUX_EALU_OData_Sel = `MUX_EALU_ODATA_HISEL;
                    `INSTR_MFLO: MUX_EALU_OData_Sel = `MUX_EALU_ODATA_LOSEL;

                    default: MUX_EALU_OData_Sel = `MUX_EALU_ODATA_ALUSEL; // shouldn't reach
                endcase
            end

            `INSTR_MTHI: MDU_Operation = `MDU_MTHI;
            `INSTR_MTLO: MDU_Operation = `MDU_MTLO;

            // =========================================================

            // All sorts of jumps ...
            `INSTR_J: NPC_Mode = `NPC_JUMP;
            `INSTR_JR: NPC_Mode = `NPC_JREG;
            `INSTR_JAL: begin
                NPC_Mode = `NPC_JUMP;
                GRF_WEnable = 1'b1;
                MUX_RegWData_Sel = `MUX_REGWDATA_LINKSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_LINKSEL;
            end
            `INSTR_JALR: begin
                NPC_Mode = `NPC_JREG;
                GRF_WEnable = 1'b1;
                MUX_RegWData_Sel = `MUX_REGWDATA_LINKSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
            end

        
            default: begin
                NPC_Mode = `NPC_NORMAL;
                CMP_Mode = `CMP_NOOP;
                GRF_WEnable = 1'b0;
                EXT_Mode =  `EXT_UNSIGNED;
                ALU_Operation = `ALU_ADDU;
                MDU_Operation = `MDU_NOOP;
                DM_Mode = `DM_WORD;
                DM_WEnable = 1'b0;
                MUX_ALUOp1_Sel = `MUX_ALUOP1_RSSEL;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
                MUX_EALU_OData_Sel = `MUX_EALU_ODATA_ALUSEL;
            end
        endcase
    end


endmodule
