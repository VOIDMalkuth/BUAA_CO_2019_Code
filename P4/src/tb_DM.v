`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:34:27 11/14/2019
// Design Name:   DM
// Module Name:   F:/tmpSpace/P4/CPU/tb_DM.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "macro.v"

module tb_DM;

	// Inputs
	reg clk;
	reg reset;
	reg DM_WEnable;
	reg [1:0] DM_Mode;
	reg [31:0] DM_Addr;
	reg [31:0] DM_WData;

	// Outputs
	wire [31:0] DM_RData;

	// Instantiate the Unit Under Test (UUT)
	DM uut (
		.clk(clk), 
		.reset(reset), 
		.DM_WEnable(DM_WEnable), 
		.DM_Mode(DM_Mode), 
		.DM_Addr(DM_Addr), 
		.DM_WData(DM_WData), 
		.DM_RData(DM_RData)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		DM_WEnable = 0;
		DM_Mode = 0;
		DM_Addr = 0;
		DM_WData = 0;

		// Wait 100 ns for global reset to finish
		
		reset = 1;
		#10
		reset = 0;
		DM_WEnable = 1;
		DM_Mode = `DM_WORD;
		DM_WData = 32'h12345678;
		#10 DM_WData = 32'h21daad23;
		#10
		DM_Mode = `DM_HALF;
		DM_Addr = 32'h0010;
		#10 DM_Addr = 32'h0010 + 1'b1;
		#10 DM_Addr = 32'h0010 + 2'b10;
		#10 DM_Addr = 32'h0010 + 2'b11;
		#10 
		DM_Mode = `DM_WORD;
		DM_WData = 32'h12345678;
		DM_Addr = 32'h0010;
		#10 DM_Addr = 32'h0010 + 1'b1;
		#10 DM_Addr = 32'h0010 + 2'b10;
		#10 DM_Addr = 32'h0010 + 2'b11;
		DM_Mode = `DM_BYTE;
		DM_WData = 32'h123456fa;
		DM_Addr = 32'h0010;
		#10 DM_Addr = 32'h0010 + 1'b1;
		#10 DM_Addr = 32'h0010 + 2'b10;
		#10 DM_Addr = 32'h0010 + 2'b11;
        
		// Add stimulus here

	end

	always #5 clk = ~clk;
      
endmodule

