`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:44 11/23/2019 
// Design Name: 
// Module Name:    IFU 
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

module IFU(
    input clk,
    input reset,
    input IFU_i_En,
    input IFU_i_IntReq,
    input [31:0] IFU_i_nPC,
    output [31:0] IFU_o_PC,
    output [31:0] IFU_o_Instr,
    output [4:0] IFU_o_excCode
    );

    parameter SIZE = 32'd4096,
              OFFSET = 32'h3000;
    parameter EXCEPTION_HANDLER = 32'h00004180;

    reg [31:0] I_Memory [(SIZE - 1):0];
    
    reg [31:0] PC = 32'h3000;
    
    wire [31:0] offsetedAddress;

    integer i;
    initial begin
        for (i = 0; i < SIZE; i = i + 1)
            I_Memory[i] = 32'b0;

        $readmemh("code.txt", I_Memory);
        $readmemh("code_handler.txt", I_Memory, 1120, 2047);     

        PC = OFFSET;
    end

    always @(posedge clk) begin
        if(reset) begin
            PC <= OFFSET;
        end
        else if(IFU_i_IntReq) begin
            PC <= EXCEPTION_HANDLER;
        end
        else if (IFU_i_En) begin
            PC <= IFU_i_nPC;
        end
    end

    assign IFU_o_PC = PC;
    assign offsetedAddress = (IFU_o_PC - OFFSET) >> 2;
    assign IFU_o_Instr = (IFU_o_excCode != `EXC_ADEL) ? I_Memory[offsetedAddress] : 32'b0;
    assign IFU_o_excCode = ((IFU_o_PC < 32'h3000) || (IFU_o_PC > 32'h4ffc) || (IFU_o_PC[1:0] != 2'b0)) ? `EXC_ADEL : 5'b0;


endmodule
