`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:51:51 12/02/2019
// Design Name:   CMP
// Module Name:   F:/tmpSpace/P6/CPU_Pipelined_Plus/tb_CMP.v
// Project Name:  CPU_Pipelined_Plus
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CMP
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_CMP;

	// Inputs
	reg [31:0] CMP_i_RsIn;
	reg [31:0] CMP_i_RtIn;
	reg [3:0] CMP_i_Mode;

	// Outputs
	wire CMP_o_Output;

	// Instantiate the Unit Under Test (UUT)
	CMP uut (
		.CMP_i_RsIn(CMP_i_RsIn), 
		.CMP_i_RtIn(CMP_i_RtIn), 
		.CMP_i_Mode(CMP_i_Mode), 
		.CMP_o_Output(CMP_o_Output)
	);

	integer i = 0;

	initial begin
		// Initialize Inputs
		CMP_i_RsIn = 0;
		CMP_i_RtIn = 0;
		CMP_i_Mode = 0;

		// Wait 100 ns for global reset to finish
		#100;

		for(i = 0; i < 7; i = i + 1)
			#5 CMP_i_Mode = i;

		#10

		CMP_i_RsIn = 32'd10;
		CMP_i_RtIn = 32'd10;

		for(i = 0; i < 7; i = i + 1)
			#5 CMP_i_Mode = i;

		#10
		CMP_i_RsIn = -32'd185;
		CMP_i_RtIn = 32'd32;

		for(i = 0; i < 7; i = i + 1)
			#5 CMP_i_Mode = i;
        
		// Add stimulus here

	end
      
endmodule

