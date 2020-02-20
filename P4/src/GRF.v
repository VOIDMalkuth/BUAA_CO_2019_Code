`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:17:05 11/15/2019 
// Design Name: 
// Module Name:    GRF 
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

module GRF(
    input clk,
    input reset,
    input GRF_WEnable,
    input [4:0] GRF_RAddr1,
    input [4:0] GRF_RAddr2,
    input [4:0] GRF_WAddr,
    input [31:0] GRF_WData,
    output wire [31:0] GRF_RData1,
    output wire [31:0] GRF_RData2
    );

    reg [31:0] registerFile[31:0];

    integer i = 0;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            registerFile[i] = 0;
    end

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                registerFile[i] <= 0;
        end
        else begin 
            if(GRF_WEnable && GRF_WAddr != 5'd0) // WEnable and not writing to 0
                registerFile[GRF_WAddr] <= GRF_WData;
        end
    end

    assign GRF_RData1 = registerFile[GRF_RAddr1];
    assign GRF_RData2 = registerFile[GRF_RAddr2];


endmodule
