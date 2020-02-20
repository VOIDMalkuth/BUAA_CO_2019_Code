`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:40 12/08/2019 
// Design Name: 
// Module Name:    Bridge 
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
`ifndef _BRG_MACRO
`define _BRG_MACRO

`define HIT_NOHIT 16'd0
`define HIT_DEV0 16'd1
`define HIT_DEV1 16'd2

`endif


module Bridge(
    input [31:0] BRG_i_Addr,
    input [3:0] BRG_i_ByteEnable,
    input [31:0] BRG_i_WData_shifted,
    input BRG_i_WEnable,
    output reg [31:0] BRG_o_RData,
    // Below are for devices
    input [31:0] BRG_i_DEV0_RData,
    input [31:0] BRG_i_DEV1_RData,
    output [31:0] BRG_o_Dev_Addr,
    output BRG_o_Dev0_WEnable,
    output BRG_o_Dev1_WEnable,
    output [31:0] BRG_o_Dev_WData
    );

    // Device Hit Check
    reg [15:0] hit_stat;
    always @(*) begin
        hit_stat = `HIT_NOHIT;
        if(32'h7f00 <= BRG_i_Addr && BRG_i_Addr <= 32'h7f0b)
            hit_stat = `HIT_DEV0;

        if(32'h7f10 <= BRG_i_Addr && BRG_i_Addr <= 32'h7f1b)
            hit_stat = `HIT_DEV1;
    end

    // Device Address
    assign BRG_o_Dev_Addr = BRG_i_Addr;

    // Device Read Data
    always @(*) begin
        case (hit_stat)
            `HIT_DEV0: BRG_o_RData = BRG_i_DEV0_RData;
            `HIT_DEV1: BRG_o_RData = BRG_i_DEV1_RData;

            default: BRG_o_RData = 32'bx; 
        endcase
    end

    // Device Write Data
    assign BRG_o_Dev_WData[7:0] = (BRG_i_ByteEnable[0] == 1'b1) ? BRG_i_WData_shifted[7:0] : BRG_o_RData[7:0];
    assign BRG_o_Dev_WData[15:8] = (BRG_i_ByteEnable[1] == 1'b1) ? BRG_i_WData_shifted[15:8] : BRG_o_RData[15:8];
    assign BRG_o_Dev_WData[23:16] = (BRG_i_ByteEnable[2] == 1'b1) ? BRG_i_WData_shifted[23:16] : BRG_o_RData[23:16];
    assign BRG_o_Dev_WData[31:24] = (BRG_i_ByteEnable[3] == 1'b1) ? BRG_i_WData_shifted[31:24] : BRG_o_RData[31:24];

    // Device Write Enable
    assign BRG_o_Dev0_WEnable = (hit_stat == `HIT_DEV0 && BRG_i_WEnable) ? 1'b1 : 1'b0;
    assign BRG_o_Dev1_WEnable = (hit_stat == `HIT_DEV1 && BRG_i_WEnable) ? 1'b1 : 1'b0;

endmodule
