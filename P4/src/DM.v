`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:03:11 11/13/2019 
// Design Name: 
// Module Name:    DM 
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

module DM(
    input clk,
    input reset,
    input DM_WEnable,
    input [1:0] DM_Mode,
    input [31:0] DM_Addr,
    input [31:0] DM_WData,
    output wire [31:0] DM_RData
    );

    parameter DM_SIZE = 32'd4096;

    reg [7:0] D_Memory[DM_SIZE - 1:0];
    reg [31:0] DM_RData_TMP;

    integer i;
    initial begin
        for (i = 0; i < DM_SIZE; i = i + 1)
            D_Memory[i] = 0;
    end

    wire [31:0] alignedAddr = (DM_Mode == `DM_WORD)? {DM_Addr[31:2], 2'b00} :
                        ((DM_Mode == `DM_HALF)? {DM_Addr[31:1], 1'b0} : DM_Addr);
    always@(*) begin
        case(DM_Mode)
            `DM_WORD: DM_RData_TMP = {D_Memory[alignedAddr+32'd3], D_Memory[alignedAddr+32'd2], D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]};
            `DM_HALF: DM_RData_TMP = {{16{D_Memory[alignedAddr+32'd1][7]}},D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]};
            `DM_BYTE: DM_RData_TMP = {{24{D_Memory[alignedAddr][7]}},D_Memory[alignedAddr]};

            default: DM_RData_TMP = 32'bx;
        endcase
    end

    always @(posedge clk ) begin
        if(reset) begin
            for (i = 0; i < DM_SIZE; i = i + 1)
                D_Memory[i] <= 0;
        end
        else if(DM_WEnable) begin
            case(DM_Mode)
                `DM_WORD: {D_Memory[alignedAddr+32'd3], D_Memory[alignedAddr+32'd2], D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]} <= DM_WData[31:0];
                `DM_HALF: {D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]} <= DM_WData[15:0];
                `DM_BYTE: D_Memory[alignedAddr] <= DM_WData[7:0];
                // no default
            endcase
        end
    end

    assign DM_RData = DM_RData_TMP;


endmodule
