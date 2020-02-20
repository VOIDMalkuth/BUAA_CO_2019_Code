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
    output reg GRF_WEnable,
    output reg [1:0] EXT_Mode,
    output reg [3:0] ALU_Operation,
    output reg DM_WEnable,
    output reg [1:0] DM_Mode,
    output reg [2:0] MUX_ALUOp2_Sel,
    output reg [2:0] MUX_RegWAddr_Sel,
    output reg [2:0] MUX_RegWData_Sel
    );

    wire [5:0] opcode = Instr[31:26];
    wire [5:0] funct = Instr[5:0];

    // instr_type is now a part of output 

    // decide what instruction is this
    always @(*) begin
        instr_type = `INSTR_NOP;
        case(opcode)
            6'b000000: begin
                case(funct)
                    6'b000000: instr_type = `INSTR_NOP; 
                    6'b001000: instr_type = `INSTR_JR;
                    6'b100001: instr_type = `INSTR_ADDU;
                    6'b100011: instr_type = `INSTR_SUBU;

                    default: instr_type = `INSTR_NOP; 
                endcase
            end
            
            6'b000010: instr_type = `INSTR_J;
            6'b000011: instr_type = `INSTR_JAL;
            6'b000100: instr_type = `INSTR_BEQ;
            6'b001101: instr_type = `INSTR_ORI;
            6'b001111: instr_type = `INSTR_LUI;
            6'b100011: instr_type = `INSTR_LW;
            6'b101011: instr_type = `INSTR_SW;

            default: instr_type = `INSTR_NOP;
        endcase
    end

    // decide control signal
    always @(*) begin
        // give a default value
        NPC_Mode = `NPC_NORMAL;
        GRF_WEnable = 1'b0;
        EXT_Mode =  `EXT_UNSIGNED;
        ALU_Operation = `ALU_ADD;
        DM_Mode = `DM_WORD;
        DM_WEnable = 1'b0;
        MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;
        MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
        MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;

        case(instr_type)
            `INSTR_ADDU: begin
                NPC_Mode = `NPC_NORMAL;
                GRF_WEnable = 1'b1;
                EXT_Mode =  `EXT_UNSIGNED;  // useless
                ALU_Operation = `ALU_ADD;
                DM_Mode = `DM_WORD;         // useless
                DM_WEnable = 1'b0;          // useless
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
            end

            `INSTR_SUBU: begin
                NPC_Mode = `NPC_NORMAL;
                GRF_WEnable = 1'b1;
                EXT_Mode = `EXT_UNSIGNED;   // useless
                ALU_Operation = `ALU_SUB;
                DM_Mode = `DM_WORD;         // useless
                DM_WEnable = 1'b0;          // useless
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
            end

            `INSTR_BEQ: begin
                NPC_Mode = `NPC_BRANCH;
                GRF_WEnable = 1'b0;
                EXT_Mode = `EXT_UNSIGNED;  // beq addr is extended in ifu
                ALU_Operation = `ALU_SUB; // sub to check if zero
                DM_Mode = `DM_WORD;         // useless
                DM_WEnable = 1'b0;          // useless
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;     // useless
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;    // useless
            end

            `INSTR_ORI: begin
                NPC_Mode = `NPC_NORMAL;
                GRF_WEnable = 1'b1;
                EXT_Mode = `EXT_UNSIGNED;
                ALU_Operation = `ALU_OR;
                DM_Mode = `DM_WORD;         // useless
                DM_WEnable = 1'b0;          // useless
                MUX_ALUOp2_Sel = `MUX_ALUOP2_EXTSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RTSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
            end

            `INSTR_LUI: begin
                NPC_Mode = `NPC_NORMAL;
                GRF_WEnable = 1'b1;
                EXT_Mode = `EXT_UNSIGNED;
                ALU_Operation = `ALU_LUI;    // IMM << 16 | 0
                DM_Mode = `DM_WORD;         // useless
                DM_WEnable = 1'b0;          // useless
                MUX_ALUOp2_Sel = `MUX_ALUOP2_EXTSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RTSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
            end

            `INSTR_LW: begin
                NPC_Mode = `NPC_NORMAL;
                GRF_WEnable = 1'b1;
                EXT_Mode = `EXT_SIGNED;
                ALU_Operation = `ALU_ADD;    // cal addr
                DM_Mode = `DM_WORD;
                DM_WEnable = 1'b0;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_EXTSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RTSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_MEMSEL;
            end

            `INSTR_SW: begin    // rt output is linked to mem datain
                NPC_Mode = `NPC_NORMAL;
                GRF_WEnable = 1'b0;
                EXT_Mode = `EXT_SIGNED;
                ALU_Operation = `ALU_ADD;    // cal addr
                DM_Mode = `DM_WORD;
                DM_WEnable = 1'b1;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_EXTSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL; // useless
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL; // useless
            end

            `INSTR_J: begin
                NPC_Mode = `NPC_JUMP;
                GRF_WEnable = 1'b0;         // no GRF write
                EXT_Mode = `EXT_UNSIGNED;   // useless
                ALU_Operation = `ALU_ADD;    // useless
                DM_Mode = `DM_WORD;
                DM_WEnable = 1'b0;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;    //useless
                MUX_RegWAddr_Sel = `MUX_REGWADDR_LINKSEL;//useless
                MUX_RegWData_Sel = `MUX_REGWDATA_LINKSEL;//useless
            end

            `INSTR_JAL: begin
                NPC_Mode = `NPC_JUMP;
                GRF_WEnable = 1'b1;
                EXT_Mode = `EXT_UNSIGNED;   // useless
                ALU_Operation = `ALU_ADD;    // useless
                DM_Mode = `DM_WORD;
                DM_WEnable = 1'b0;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;    //useless
                MUX_RegWAddr_Sel = `MUX_REGWADDR_LINKSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_LINKSEL;
            end

            `INSTR_JR: begin
                NPC_Mode = `NPC_JREG;
                GRF_WEnable = 1'b0;
                EXT_Mode = `EXT_UNSIGNED;   // useless
                ALU_Operation = `ALU_ADD;    // useless
                DM_Mode = `DM_WORD; // useless
                DM_WEnable = 1'b0;  //useless
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;    // useless
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL; // useless
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL; // useless
            end

            default: begin
                NPC_Mode = `NPC_NORMAL;
                GRF_WEnable = 1'b0;
                EXT_Mode =  `EXT_UNSIGNED;
                ALU_Operation = `ALU_ADD;
                MUX_ALUOp2_Sel = `MUX_ALUOP2_REGSEL;
                MUX_RegWAddr_Sel = `MUX_REGWADDR_RDSEL;
                MUX_RegWData_Sel = `MUX_REGWDATA_ALUSEL;
            end
        endcase
    end


endmodule
