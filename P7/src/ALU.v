`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:08:04 11/14/2019 
// Design Name: 
// Module Name:    ALU 
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

module ALU(
    input [31:0] ALU_i_Operand1,
    input [31:0] ALU_i_Operand2,
    input [7:0] ALU_i_Operation,
    output [31:0] ALU_o_Result,
    output ALU_o_isOverflown
    );
    
    reg overflowChk;
    reg [31:0] tmpResult;

    always@(*) begin
        overflowChk = 0;
        case(ALU_i_Operation)
            `ALU_ADDU: tmpResult = ALU_i_Operand1 + ALU_i_Operand2;            
            `ALU_ADD: {overflowChk, tmpResult} = {ALU_i_Operand1[31], ALU_i_Operand1} + {ALU_i_Operand2[31], ALU_i_Operand2};
            `ALU_SUBU: tmpResult = ALU_i_Operand1 - ALU_i_Operand2;
            `ALU_SUB: {overflowChk, tmpResult} = {ALU_i_Operand1[31], ALU_i_Operand1} - {ALU_i_Operand2[31], ALU_i_Operand2};
            `ALU_AND: tmpResult = ALU_i_Operand1 & ALU_i_Operand2;
            `ALU_OR: tmpResult = ALU_i_Operand1 | ALU_i_Operand2;
            `ALU_XOR: tmpResult = ALU_i_Operand1 ^ ALU_i_Operand2;
            `ALU_NOR: tmpResult = ~(ALU_i_Operand1 | ALU_i_Operand2);
            `ALU_SLL: tmpResult = ALU_i_Operand2 << {1'b0, ALU_i_Operand1[4:0]};
            `ALU_SRL: tmpResult = $unsigned($unsigned({1'b0, ALU_i_Operand2}) >> $unsigned({1'b0, ALU_i_Operand1[4:0]}));
            `ALU_SRA: tmpResult = $signed($signed(ALU_i_Operand2) >>> $signed({1'b0, ALU_i_Operand1[4:0]}));
            `ALU_SLT: tmpResult = $signed($signed(ALU_i_Operand1) < $signed(ALU_i_Operand2))?32'd1:32'd0;
            `ALU_SLTU: tmpResult = $unsigned($unsigned(ALU_i_Operand1) < $unsigned(ALU_i_Operand2))?32'd1:32'd0;
            `ALU_LUI: tmpResult = {ALU_i_Operand2[15:0], 16'b0};

            default: tmpResult = 32'bx;
        endcase
    end

    assign ALU_o_isOverflown = (ALU_i_Operation == `ALU_ADD || ALU_i_Operation == `ALU_SUB)?(overflowChk != tmpResult[31]):1'b0;

    assign ALU_o_Result = ALU_o_isOverflown ? 32'b0 : tmpResult;

endmodule
