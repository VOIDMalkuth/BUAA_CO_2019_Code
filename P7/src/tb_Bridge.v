`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:38:05 12/08/2019
// Design Name:   Bridge
// Module Name:   F:/tmpSpace/P7/Mips/tb_Bridge.v
// Project Name:  Mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Bridge
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_Bridge;

	// Inputs
	reg [31:0] BRG_i_Addr;
	reg [3:0] BRG_i_ByteEnable;
	reg [31:0] BRG_i_WData_shifted;
	reg BRG_i_WEnable;
	reg [31:0] BRG_i_DEV0_RData;
	reg [31:0] BRG_i_DEV1_RData;

	// Outputs
	wire [31:0] BRG_o_RData;
	wire [31:0] BRG_o_Dev_Addr;
	wire BRG_o_Dev0_WEnable;
	wire BRG_o_Dev1_WEnable;
	wire [31:0] BRG_o_Dev_WData;

	// Instantiate the Unit Under Test (UUT)
	Bridge uut (
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

	initial begin
		// Initialize Inputs
		BRG_i_Addr = 0;
		BRG_i_ByteEnable = 0;
		BRG_i_WData_shifted = 0;
		BRG_i_WEnable = 0;
		BRG_i_DEV0_RData = 0;
		BRG_i_DEV1_RData = 0;

		// Wait 100 ns for global reset to finish
		#100;

		BRG_i_Addr = 32'h7f02;
		BRG_i_ByteEnable = 4'b1010;
		BRG_i_WData_shifted = 32'hdd11aa88;
		BRG_i_WEnable = 0;
		BRG_i_DEV0_RData = 32'h12345670;
		BRG_i_DEV1_RData = 32'h89abcdef;

		#10 		
		BRG_i_WEnable = 1;
		#10
		BRG_i_ByteEnable = 4'b0110;
		#10 
		BRG_i_Addr = 32'h7f12;
		#10 		
		BRG_i_WEnable = 0;
        
		// Add stimulus here

	end
      
endmodule

