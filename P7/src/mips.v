`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:05:04 11/24/2019 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset,
    input interrupt,
    output [31:0] addr
    );

    wire [7:2] HWInt = {3'b0, interrupt, TC1_IRQ, TC0_IRQ};
    wire [31:0] PrRD = BRG_o_RData;
    wire [31:0] PrAddr;
    wire [3:0] PrBE;
    wire [31:0] PrWD;
    wire PrWE;

    CPU MIPS_CPU(.clk(clk),
        .reset(reset),
        .HWInt(HWInt), 
        .PrRD(PrRD),
        .PrAddr(PrAddr),
        .PrBE(PrBE),
        .PrWD(PrWD),
        .PrWE(PrWE), 
        .addr(addr)
    );

    // Bridge Inputs
	wire [31:0] BRG_i_Addr = PrAddr;
	wire [3:0] BRG_i_ByteEnable = PrBE;
	wire [31:0] BRG_i_WData_shifted = PrWD;
	wire BRG_i_WEnable = PrWE;
	wire [31:0] BRG_i_DEV0_RData = TC0_Dout;
	wire [31:0] BRG_i_DEV1_RData = TC1_Dout;
    // Bridge Outputs
	wire [31:0] BRG_o_RData;
	wire [31:0] BRG_o_Dev_Addr;
	wire BRG_o_Dev0_WEnable;
	wire BRG_o_Dev1_WEnable;
	wire [31:0] BRG_o_Dev_WData;

    Bridge SystemBridge (
		.BRG_i_Addr(BRG_i_Addr), 
		.BRG_i_ByteEnable(BRG_i_ByteEnable), 
		.BRG_i_WData_shifted(BRG_i_WData_shifted), 
		.BRG_i_WEnable(BRG_i_WEnable), 
		.BRG_o_RData(BRG_o_RData), 
		.BRG_i_DEV0_RData(BRG_i_DEV0_RData), 
		.BRG_i_DEV1_RData(BRG_i_DEV1_RData), 
		.BRG_o_Dev_Addr(BRG_o_Dev_Addr), 
		.BRG_o_Dev0_WEnable(BRG_o_Dev0_WEnable), 
		.BRG_o_Dev1_WEnable(BRG_o_Dev1_WEnable), 
		.BRG_o_Dev_WData(BRG_o_Dev_WData)
	);

    // Timer0 inputs
    wire [31:2] TC0_Addr = BRG_o_Dev_Addr[31:2];
	wire TC0_WE = BRG_o_Dev0_WEnable;
	wire [31:0] TC0_Din = BRG_o_Dev_WData;
    // Timer0 Outputs
	wire [31:0] TC0_Dout;
	wire TC0_IRQ;

    TC Timer0 (
		.clk(clk), 
		.reset(reset), 
		.Addr(TC0_Addr), 
		.WE(TC0_WE), 
		.Din(TC0_Din), 
		.Dout(TC0_Dout), 
		.IRQ(TC0_IRQ)
	);

    // Timer1 inputs
    wire [31:2] TC1_Addr = BRG_o_Dev_Addr[31:2];
	wire TC1_WE = BRG_o_Dev1_WEnable;
	wire [31:0] TC1_Din = BRG_o_Dev_WData;
    // Timer1 Outputs
	wire [31:0] TC1_Dout;
	wire TC1_IRQ;

    TC Timer1 (
		.clk(clk), 
		.reset(reset), 
		.Addr(TC1_Addr), 
		.WE(TC1_WE), 
		.Din(TC1_Din), 
		.Dout(TC1_Dout), 
		.IRQ(TC1_IRQ)
	);


endmodule
