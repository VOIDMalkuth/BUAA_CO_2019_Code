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
    output reg [4:0] HID_o_RegWAddr
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

        case(HID_i_Instr_Type)
            `INSTR_NOP: begin
                HID_o_TuseRs = `T_USE_NEVER_READ;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end

            `INSTR_ADDU: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_AT_E;
                HID_o_TnewD = `T_NEW_AT_EX_MEM; // first pipeline register addu result in is M
            end

            `INSTR_SUBU: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_AT_E;
                HID_o_TnewD = `T_NEW_AT_EX_MEM;
            end

            `INSTR_ORI: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_AT_EX_MEM;
            end

            `INSTR_LW: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_AT_MEM_WB;
            end

            `INSTR_SW: begin
                HID_o_TuseRs = `T_USE_AT_E;
                HID_o_TuseRt = `T_USE_AT_M;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end

            `INSTR_BEQ: begin
                HID_o_TuseRs = `T_USE_AT_D;
                HID_o_TuseRt = `T_USE_AT_D;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end

            `INSTR_LUI: begin
                HID_o_TuseRs = `T_USE_NEVER_READ;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_AT_EX_MEM;
            end

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

            `INSTR_JR: begin
                HID_o_TuseRs = `T_USE_AT_D;
                HID_o_TuseRt = `T_USE_NEVER_READ;
                HID_o_TnewD = `T_NEW_NO_NEW;
            end

        endcase
    end


endmodule
