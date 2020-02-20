`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:07:52 12/11/2019
// Design Name:   ExcChecker
// Module Name:   F:/tmpSpace/P7/Mips/tb_ExcChecker.v
// Project Name:  Mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ExcChecker
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "macro.v"

module tb_ExcChecker;

	// Inputs
	reg [4:0] EC_i_E_ExcCode;
	reg EC_i_DM_WEnable;
	reg EC_i_DM_REnable;
	reg [31:0] EC_i_Addr;
	reg [3:0] EC_i_DM_Mode;
	reg EC_i_Unaligned;

	// Outputs
	wire [4:0] EC_o_ExcCode;

	// Instantiate the Unit Under Test (UUT)
	ExcChecker uut (
		.EC_i_E_ExcCode(EC_i_E_ExcCode), 
		.EC_i_DM_WEnable(EC_i_DM_WEnable), 
		.EC_i_DM_REnable(EC_i_DM_REnable), 
		.EC_i_Addr(EC_i_Addr), 
		.EC_i_DM_Mode(EC_i_DM_Mode), 
		.EC_i_Unaligned(EC_i_Unaligned), 
		.EC_o_ExcCode(EC_o_ExcCode)
	);

	initial begin
		// Initialize Inputs
		EC_i_E_ExcCode = 0;
		EC_i_DM_WEnable = 1;
		EC_i_DM_REnable = 0;
		EC_i_Addr = 1533;
		EC_i_DM_Mode = `DM_BYTE;
		EC_i_Unaligned = 0;

		// Wait 100 ns for global reset to finish
		#5;
        EC_i_E_ExcCode = 0;
		EC_i_DM_WEnable = 0;
		EC_i_DM_REnable = 1;
		EC_i_Addr = 32'h7f04;
		EC_i_DM_Mode = 2;
		EC_i_Unaligned = 0;
		// Add stimulus here
		#5;
        EC_i_E_ExcCode = 0;
		EC_i_DM_WEnable = 1;
		EC_i_DM_REnable = 0;
		EC_i_Addr = 32'h7f04;
		EC_i_DM_Mode = 2;
		EC_i_Unaligned = 0;
		#5;
        EC_i_E_ExcCode = `EXC_OV;
		EC_i_DM_WEnable = 0;
		EC_i_DM_REnable = 1;
		EC_i_Addr = 32'h3204;
		EC_i_DM_Mode = 2;
		EC_i_Unaligned = 0;
		#5;
        EC_i_E_ExcCode = 0;
		EC_i_DM_WEnable = 0;
		EC_i_DM_REnable = 1;
		EC_i_Addr = 32'h7f03;
		EC_i_DM_Mode = 0;
		EC_i_Unaligned = 1;
		#5;
        EC_i_E_ExcCode = 0;
		EC_i_DM_WEnable = 0;
		EC_i_DM_REnable = 1;
		EC_i_Addr = 32'h15152;
		EC_i_DM_Mode = 2;
		EC_i_Unaligned = 0;

	end
      
endmodule

