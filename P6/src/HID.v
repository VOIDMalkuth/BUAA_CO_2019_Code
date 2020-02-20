`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:40 11/23/2019 
// Design Name: 
// Module Name:    HID 
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

module HID(
    input [31:0] HID_i_Instr,
    input [31:0] HID_i_Instr_Type,
    input [2:0] HID_i_RegWAddrSel,
    output [4:0] HID_o_Rs,
    output [4:0] HID_o_Rt,
    output reg [3:0] HID_o_TuseRs,
    output reg [3:0] HID_o_TuseRt,
    output reg [3:0] HID_o_TnewD,
    output reg [4:0] HID_o_RegWAddr,
    output reg [3:0] HID_o_MDU_Usage
    );

    // Hazard Instruction Decoder
    // Decodes what's necessary in hazard handling
    // Tuse/Tnew are all values at ID stage
    // When use Tnew, check current stage, possibly substract them
    // Time is 4 bit, when at D how many cycles will pass before use/generate
    // Tnew is the cycle number after which result appears in an pipline Register

    assign HID_o_Rs = HID_i_Instr[25:21];
    assign HID_o_Rt = HID_i_Instr[20:16];

    always @(*) begin
        case(HID_i_RegWAddrSel)
            `MUX_REGWADDR_RDSEL: HID_o_RegWAddr = HID_i_Instr[15:11];
            `MUX_REGWADDR_RTSEL: HID_o_RegWAddr = HID_i_Instr[20:16];
            `MUX_REGWADDR_LINKSEL: HID_o_RegWAddr = 5'b11111;

            default: HID_o_RegWAddr = 5'bx;
        endcase
    end

    always @(*) begin
        HID_o_TuseRs = `T_USE_NEVER_READ;
        HID_o_TuseRt = `T_USE_NEVER_READ;
        HID_o_TnewD = `T_NEW_NO_NEW;
        // Only set only modules with MDU
        HID_o_MDU_Usage = `SCU_MDU_USAGE_NOMDU;

        case(HID_i_Instr_Type)
            `INSTR_NOP: begin
                HID_o_TuseRs = `T_USE_NEVER_READ;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end


            // R-Type Cal
            `INSTR_ADD, `INSTR_ADDU, `INSTR_SUB, `INSTR_SUBU, `INSTR_SLLV, `INSTR_SRLV,
            `INSTR_SRAV, `INSTR_AND, `INSTR_OR, `INSTR_XOR, `INSTR_NOR, `INSTR_SLT,
            `INSTR_SLTU: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_AT_E;
                HID_o_TnewD = `T_NEW_AT_EX_MEM;
            end

            `INSTR_SLL, `INSTR_SRL, `INSTR_SRA: begin
                HID_o_TuseRs = `T_USE_NEVER_READ;   // use Shamt as ALUinput1
                HID_o_TuseRt = `T_USE_AT_E;
                HID_o_TnewD = `T_NEW_AT_EX_MEM;
            end

            `INSTR_MULT, `INSTR_MULTU, `INSTR_DIV, `INSTR_DIVU: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_AT_E;
                HID_o_TnewD = `T_NEW_NO_NEW;    // do not generate result directly
                // When these Instrs are in E, Instrs at D will stall
                HID_o_MDU_Usage = `SCU_MDU_USAGE_STALL;
            end




            // I-Type Cal
            `INSTR_ADDI, `INSTR_ADDIU, `INSTR_ANDI, `INSTR_ORI, `INSTR_XORI,
            `INSTR_SLTI, `INSTR_SLTIU: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_AT_EX_MEM;
            end

            `INSTR_LUI: begin
                HID_o_TuseRs = `T_USE_NEVER_READ;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_AT_EX_MEM;
            end



            // MemRead
            `INSTR_LB, `INSTR_LBU, `INSTR_LH, `INSTR_LHU, `INSTR_LW: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_AT_MEM_WB;
            end



            // MemWrite
            `INSTR_SB, `INSTR_SH, `INSTR_SW: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_AT_M;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end



            // Branch
            `INSTR_BEQ, `INSTR_BNE: begin
                HID_o_TuseRs = `T_USE_AT_D;
                HID_o_TuseRt = `T_USE_AT_D;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end

            `INSTR_BLEZ, `INSTR_BGTZ, `INSTR_BLTZ, `INSTR_BGEZ: begin
                HID_o_TuseRs = `T_USE_AT_D;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end




            // J type
            `INSTR_J: begin
                HID_o_TuseRs = `T_USE_NEVER_READ;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end

            `INSTR_JAL: begin
                HID_o_TuseRs = `T_USE_NEVER_READ;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_AT_ID_EX;
            end

            `INSTR_JALR: begin
                HID_o_TuseRs = `T_USE_AT_D;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_AT_ID_EX;
            end

            `INSTR_JR: begin
                HID_o_TuseRs = `T_USE_AT_D;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end



            // MDU related load/save
            `INSTR_MFHI, `INSTR_MFLO: begin
                HID_o_TuseRs = `T_USE_NEVER_READ;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_AT_EX_MEM;
                HID_o_MDU_Usage = `SCU_MDU_USAGE_NOSTALL;
            end

            `INSTR_MTHI, `INSTR_MTLO: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_NO_NEW;
                HID_o_MDU_Usage = `SCU_MDU_USAGE_NOSTALL;
            end

        endcase
    end


endmodule
