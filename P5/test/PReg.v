`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:19:43 11/23/2019 
// Design Name: 
// Module Name:    PReg 
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
module PReg(
    input clk,
    input reset,
    input PReg_i_clear,
    input PReg_i_Enable,
    input [31:0] PReg_i_Instr,
    input [31:0] PReg_i_PC,
    input [31:0] PReg_i_rsData,
    input [31:0] PReg_i_rtData,
    input [31:0] PReg_i_extData,
    input [31:0] PReg_i_ALUResult,
    input [31:0] PReg_i_memData,
    input [31:0] PReg_i_RegWData,
    output [31:0] PReg_o_Instr,
    output [31:0] PReg_o_PC,
    output [31:0] PReg_o_rsData,
    output [31:0] PReg_o_rtData,
    output [31:0] PReg_o_extData,
    output [31:0] PReg_o_ALUResult,
    output [31:0] PReg_o_memData,
    output [31:0] PReg_o_RegWData
    );

    reg [31:0] PReg_Instr = 32'b0;
    reg [31:0] PReg_PC = 32'h3000;
    reg [31:0] PReg_rsData = 32'b0;
    reg [31:0] PReg_rtData = 32'b0;
    reg [31:0] PReg_extData = 32'b0;
    reg [31:0] PReg_ALUResult = 32'b0;
    reg [31:0] PReg_memData = 32'b0;
    reg [31:0] PReg_RegWData = 32'b0;

    always @(posedge clk ) begin
        if(reset || PReg_i_clear) begin
            PReg_Instr <= 32'b0;
            PReg_PC <= reset?32'h3000:PReg_PC;  // useless maybe, but can help debug
            PReg_rsData <= 32'b0;
            PReg_rtData <= 32'b0;
            PReg_extData <= 32'b0;
            PReg_ALUResult <= 32'b0;
            PReg_memData <= 32'b0;
            PReg_RegWData <= 32'b0;
        end
        else if(PReg_i_Enable) begin
            PReg_Instr <= PReg_i_Instr;
            PReg_PC <= PReg_i_PC;
            PReg_rsData <= PReg_i_rsData;
            PReg_rtData <= PReg_i_rtData;
            PReg_extData <= PReg_i_extData;
            PReg_ALUResult <= PReg_i_ALUResult;
            PReg_memData <= PReg_i_memData;
            PReg_RegWData <= PReg_i_RegWData;
        end
    end

    assign PReg_o_Instr = PReg_Instr;
    assign PReg_o_PC = PReg_PC;
    assign PReg_o_rsData = PReg_rsData;
    assign PReg_o_rtData = PReg_rtData;
    assign PReg_o_extData = PReg_extData;
    assign PReg_o_ALUResult = PReg_ALUResult;
    assign PReg_o_memData = PReg_memData;
    assign PReg_o_RegWData = PReg_RegWData;


endmodule
