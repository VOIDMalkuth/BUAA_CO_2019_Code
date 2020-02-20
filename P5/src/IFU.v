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
module IFU(
    input clk,
    input reset,
    input IFU_i_En,
    input [31:0] IFU_i_nPC,
    output [31:0] IFU_o_PC,
    output [31:0] IFU_o_Instr
    );

    parameter SIZE = 32'd4096,
              OFFSET = 32'h3000;

    reg [31:0] I_Memory [(SIZE - 1):0];
    
    reg [31:0] PC = 32'h3000;
    
    wire [31:0] offsetedAddress;

    integer i;
    initial begin
        for (i = 0; i < SIZE; i = i + 1)
            I_Memory[i] = 32'b0;

        $readmemh("code.txt", I_Memory, 0, SIZE - 1);     

        PC = OFFSET;
    end

    always @(posedge clk) begin
        if(reset) begin
            PC <= OFFSET;
        end
        else if (IFU_i_En) begin
            PC <= IFU_i_nPC;
        end
    end

    assign offsetedAddress = (PC - OFFSET) >> 2;
    assign IFU_o_Instr = I_Memory[offsetedAddress];
    assign IFU_o_PC = PC;


endmodule
