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
    input DM_i_WEnable,
    input [3:0] DM_i_Mode,
    input [31:0] DM_i_Addr,
    input [31:0] DM_i_WData,
    input [31:0] DM_i_PC,
    output [31:0] DM_o_RData
    );

    parameter DM_SIZE = 32'd16384;

    reg [7:0] D_Memory[DM_SIZE - 1:0];
    reg [31:0] DM_RData_TMP;

    integer i;
    initial begin
        for (i = 0; i < DM_SIZE; i = i + 1)
            D_Memory[i] = 0;
    end

    wire [31:0] alignedAddr = (DM_i_Mode == `DM_WORD)? {DM_i_Addr[31:2], 2'b00} :
                        ((DM_i_Mode == `DM_HALF)? {DM_i_Addr[31:1], 1'b0} : DM_i_Addr);

    wire [31:0] wordAlignedAddr = {DM_i_Addr[31:2],2'b00};

    always@(*) begin
        case(DM_i_Mode)
            `DM_WORD: DM_RData_TMP = {D_Memory[alignedAddr+32'd3], D_Memory[alignedAddr+32'd2], D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]};
            `DM_HALF: DM_RData_TMP = {{16{D_Memory[alignedAddr+32'd1][7]}},D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]};
            `DM_BYTE: DM_RData_TMP = {{24{D_Memory[alignedAddr][7]}},D_Memory[alignedAddr]};
            `DM_HALF_UNSIGNED: DM_RData_TMP = {16'b0, D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]};
            `DM_BYTE_UNSIGNED: DM_RData_TMP = {24'b0,D_Memory[alignedAddr]};

            default: DM_RData_TMP = 32'bx;
        endcase
    end

    always @(posedge clk ) begin
        if(reset) begin
            for (i = 0; i < DM_SIZE; i = i + 1)
                D_Memory[i] <= 0;
        end
        else if(DM_i_WEnable) begin
            case(DM_i_Mode)
                `DM_WORD: begin
                    {D_Memory[alignedAddr+32'd3], D_Memory[alignedAddr+32'd2], D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]} <= DM_i_WData[31:0];
                    $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, DM_i_WData[31:0]);
                end

                `DM_HALF: begin
                    {D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]} <= DM_i_WData[15:0];
                    case(DM_i_Addr[1])  // ! when Save Half it is addr[1] that matters, addr[0] will always be 0 !
                        1'b0: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {D_Memory[wordAlignedAddr + 3], D_Memory[wordAlignedAddr + 2], DM_i_WData[15:0]});
                        1'b1: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {DM_i_WData[15:0], D_Memory[wordAlignedAddr + 1], D_Memory[wordAlignedAddr]});
                    endcase
                end

                `DM_BYTE: begin
                    D_Memory[alignedAddr] <= DM_i_WData[7:0];
                    case(DM_i_Addr[1:0])
                        2'b00: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {D_Memory[wordAlignedAddr + 3], D_Memory[wordAlignedAddr + 2], D_Memory[wordAlignedAddr + 1], DM_i_WData[7:0]});
                        2'b01: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {D_Memory[wordAlignedAddr + 3], D_Memory[wordAlignedAddr + 2], DM_i_WData[7:0], D_Memory[wordAlignedAddr]});
                        2'b10: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {D_Memory[wordAlignedAddr + 3], DM_i_WData[7:0], D_Memory[wordAlignedAddr + 1], D_Memory[wordAlignedAddr]});
                        2'b11: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {DM_i_WData[7:0], D_Memory[wordAlignedAddr + 2], D_Memory[wordAlignedAddr + 1], D_Memory[wordAlignedAddr]});
                    endcase
                end
                // no default
            endcase
        end
    end

    assign DM_o_RData = DM_RData_TMP;

endmodule
