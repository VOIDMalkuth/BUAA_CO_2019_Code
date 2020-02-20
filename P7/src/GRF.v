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
module GRF(
    input clk,
    input reset,
    input GRF_i_WEnable,
    input [4:0] GRF_i_RAddr1,
    input [4:0] GRF_i_RAddr2,
    input [4:0] GRF_i_WAddr,
    input [31:0] GRF_i_WData,
    input [31:0] GRF_i_PC,  // for $display
    output wire [31:0] GRF_o_RData1,
    output wire [31:0] GRF_o_RData2
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
            if(GRF_i_WEnable && GRF_i_WAddr != 5'd0) begin// WEnable and not writing to 0
                registerFile[GRF_i_WAddr] <= GRF_i_WData;
                $display("%d@%h: $%d <= %h", $time, GRF_i_PC, GRF_i_WAddr, GRF_i_WData);
            end
        end


    end

    assign GRF_o_RData1 = (GRF_i_RAddr1 == GRF_i_WAddr && GRF_i_RAddr1 != 0 && GRF_i_WEnable)?
                                    GRF_i_WData:registerFile[GRF_i_RAddr1]; // forward

    assign GRF_o_RData2 = (GRF_i_RAddr2 == GRF_i_WAddr && GRF_i_RAddr2 != 0 && GRF_i_WEnable)?
                                    GRF_i_WData:registerFile[GRF_i_RAddr2]; // forward


endmodule