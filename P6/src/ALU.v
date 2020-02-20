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
    output reg [31:0] ALU_o_Result,
    output ALU_o_isOverflown
    );
    
    reg overflowChk;

    always@(*) begin
        overflowChk = 0;
        case(ALU_i_Operation)
            `ALU_ADDU: ALU_o_Result = ALU_i_Operand1 + ALU_i_Operand2;            
            `ALU_ADD: {overflowChk, ALU_o_Result} = {ALU_i_Operand1[31], ALU_i_Operand1} + {ALU_i_Operand2[31], ALU_i_Operand2};
            `ALU_SUBU: ALU_o_Result = ALU_i_Operand1 - ALU_i_Operand2;
            `ALU_SUB: {overflowChk, ALU_o_Result} = {ALU_i_Operand1[31], ALU_i_Operand1} - {ALU_i_Operand2[31], ALU_i_Operand2};
            `ALU_AND: ALU_o_Result = ALU_i_Operand1 & ALU_i_Operand2;
            `ALU_OR: ALU_o_Result = ALU_i_Operand1 | ALU_i_Operand2;
            `ALU_XOR: ALU_o_Result = ALU_i_Operand1 ^ ALU_i_Operand2;
            `ALU_NOR: ALU_o_Result = ~(ALU_i_Operand1 | ALU_i_Operand2);
            `ALU_SLL: ALU_o_Result = ALU_i_Operand2 << {1'b0, ALU_i_Operand1[4:0]};
            `ALU_SRL: ALU_o_Result = $unsigned($unsigned({1'b0, ALU_i_Operand2}) >> $unsigned({1'b0, ALU_i_Operand1[4:0]}));
            `ALU_SRA: ALU_o_Result = $signed($signed(ALU_i_Operand2) >>> $signed({1'b0, ALU_i_Operand1[4:0]}));
            `ALU_SLT: ALU_o_Result = $signed($signed(ALU_i_Operand1) < $signed(ALU_i_Operand2))?32'd1:32'd0;
            `ALU_SLTU: ALU_o_Result = $unsigned($unsigned(ALU_i_Operand1) < $unsigned(ALU_i_Operand2))?32'd1:32'd0;
            `ALU_LUI: ALU_o_Result = {ALU_i_Operand2[15:0], 16'b0};

            default: ALU_o_Result = 32'bx;
        endcase
    end

    assign ALU_isOverflown = (ALU_i_Operation == `ALU_ADD || ALU_i_Operation == `ALU_SUB)?(overflowChk != ALU_o_Result[31]):1'b0;


endmodule
