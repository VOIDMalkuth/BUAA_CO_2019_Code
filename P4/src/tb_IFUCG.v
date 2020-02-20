`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:39:42 11/16/2019
// Design Name:   IFUCG
// Module Name:   F:/tmpSpace/P4/CPU/tb_IFUCG.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IFUCG
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_IFUCG;

	// Inputs
	reg [1:0] IFUCG_Mode;
	reg IFUCG_isConditional;
	reg IFUCG_Condition;

	// Outputs
	wire [1:0] IFUCG_Output;

	// Instantiate the Unit Under Test (UUT)
	IFUCG uut (
		.IFUCG_Mode(IFUCG_Mode), 
		.IFUCG_isConditional(IFUCG_isConditional), 
		.IFUCG_Condition(IFUCG_Condition), 
		.IFUCG_Output(IFUCG_Output)
	);

	initial begin
		// Initialize Inputs
		IFUCG_Mode = 0;
		IFUCG_isConditional = 0;
		IFUCG_Condition = 0;

		// Wait 100 ns for global reset to finish
		#100;

		#5 IFUCG_Mode = 1;
		#5 IFUCG_Mode = 2;
		#5 IFUCG_Mode = 3;

		#5 IFUCG_Condition = 1;
		#5 IFUCG_Mode = 0;
		#5 IFUCG_Mode = 1;
		#5 IFUCG_Mode = 2;
		#5 IFUCG_Mode = 3;

		#5 IFUCG_isConditional = 1;
		#5 IFUCG_Mode = 0;
		#5 IFUCG_Mode = 1;
		#5 IFUCG_Mode = 2;
		#5 IFUCG_Mode = 3;

		#5 IFUCG_Condition = 0;
		#5 IFUCG_Mode = 0;
		#5 IFUCG_Mode = 1;
		#5 IFUCG_Mode = 2;
		#5 IFUCG_Mode = 3;
        
		// Add stimulus here

	end
      
endmodule

