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
    input [31:0] ALU_Operand1,
    input [31:0] ALU_Operand2,
    input [3:0] ALU_Operation,
    output reg [31:0] ALU_Result,
    output ALU_isZero,
    output ALU_Overflow
    );
    
    reg overflowChk;

    always@(*) begin
        overflowChk = 0;
        case(ALU_Operation)
            `ALU_ADD: {overflowChk, ALU_Result} = {ALU_Operand1[31], ALU_Operand1} + {ALU_Operand2[31], ALU_Operand2};
            `ALU_SUB: {overflowChk, ALU_Result} = {ALU_Operand1[31], ALU_Operand1} - {ALU_Operand2[31], ALU_Operand2};
            `ALU_OR: ALU_Result = ALU_Operand1 | ALU_Operand2;

            default: ALU_Result = 32'bx;
        endcase
    end

    assign ALU_isZero = (ALU_Result == 32'b0)?1'b1:1'b0;
    assign ALU_Overflow = (ALU_Operation == `ALU_ADD || ALU_Operation == `ALU_SUB)?(overflowChk != ALU_Result[31]):1'b0;


endmodule
