`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:36:47 11/15/2019
// Design Name:   GRF
// Module Name:   F:/tmpSpace/P4/CPU/tb_GRF.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: GRF
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_GRF;

	// Inputs
	reg clk;
	reg reset;
	reg GRF_WEnable;
	reg [4:0] GRF_RAddr1;
	reg [4:0] GRF_RAddr2;
	reg [4:0] GRF_WAddr;
	reg [31:0] GRF_WData;

	// Outputs
	wire [31:0] GRF_RData1;
	wire [31:0] GRF_RData2;

	// Instantiate the Unit Under Test (UUT)
	GRF uut (
		.clk(clk), 
		.reset(reset), 
		.GRF_WEnable(GRF_WEnable), 
		.GRF_RAddr1(GRF_RAddr1), 
		.GRF_RAddr2(GRF_RAddr2), 
		.GRF_WAddr(GRF_WAddr), 
		.GRF_WData(GRF_WData), 
		.GRF_RData1(GRF_RData1), 
		.GRF_RData2(GRF_RData2)
	);

	integer i;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		GRF_WEnable = 0;
		GRF_RAddr1 = 0;
		GRF_RAddr2 = 0;
		GRF_WAddr = 0;
		GRF_WData = 0;

		// Wait 100 ns for global reset to finish
		#100;

		GRF_WEnable = 1;
		GRF_RAddr1 = 15;
		GRF_RAddr2 = 0;
		GRF_WAddr = 0;
		GRF_WData = 1234;
		#50;
		GRF_WEnable = 0;
		GRF_RAddr1 = 15;
		GRF_RAddr2 = 0;
		GRF_WAddr = 15;
		GRF_WData = 1234;
		#50;
		GRF_WEnable = 1;
		GRF_RAddr1 = 16;
		GRF_RAddr2 = 0;
		GRF_WAddr = 16;
		GRF_WData = 3411;
		#50;
		GRF_WEnable = 0;
		GRF_RAddr1 = 16;
		GRF_RAddr2 = 0;
		GRF_WAddr = 15;
		GRF_WData = 1234;
		#50 reset= 1;
		#10 reset = 0;
		GRF_WEnable = 0;
		GRF_RAddr1 = 16;
		GRF_RAddr2 = 0;
		GRF_WAddr = 15;
		GRF_WData = 1234;
        
		// Add stimulus here

	end

	always #5 clk = ~clk;

endmodule

