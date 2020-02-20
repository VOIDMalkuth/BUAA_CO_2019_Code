`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:59:50 11/14/2019
// Design Name:   EXT
// Module Name:   F:/tmpSpace/P4/CPU/tb_EXT.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: EXT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "macro.v"

module tb_EXT;

	// Inputs
	reg [15:0] EXT_Input;
	reg [1:0] EXT_Mode;

	// Outputs
	wire [31:0] EXT_Output;

	// Instantiate the Unit Under Test (UUT)
	EXT uut (
		.EXT_Input(EXT_Input), 
		.EXT_Mode(EXT_Mode), 
		.EXT_Output(EXT_Output)
	);

	initial begin
		// Initialize Inputs
		EXT_Input = 0;
		EXT_Mode = 0;

		// Wait 100 ns for global reset to finish
		#100;

		#50
		EXT_Input = 16'hf32a;
		EXT_Mode = `EXT_UNSIGNED;
		#50 EXT_Mode = `EXT_SIGNED;
		#50 EXT_Mode = `EXT_SHIFT;

		#50
		EXT_Input = 16'h0df2;
		EXT_Mode = `EXT_UNSIGNED;
		#50 EXT_Mode = `EXT_SIGNED;
		#50 EXT_Mode = `EXT_SHIFT;

		repeat(3) begin
			#50
			EXT_Input = $random;
			EXT_Mode = `EXT_UNSIGNED;
			#50 EXT_Mode = `EXT_SIGNED;
			#50 EXT_Mode = `EXT_SHIFT;
		end
        
		// Add stimulus here

	end
      
endmodule

