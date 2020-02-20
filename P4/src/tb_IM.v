`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:45:34 11/10/2019
// Design Name:   IM
// Module Name:   F:/tmpSpace/P4/CPU/tb_IM.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_IM;

	// Inputs
	reg [31:0] PC;

	// Outputs
	wire [31:0] Instr;

	// Instantiate the Unit Under Test (UUT)
	IM uut (
		.PC(PC), 
		.Instr(Instr)
	);

	initial begin
		// Initialize Inputs
		PC = 0;
		#5 PC = 32'h00003000;

		// Wait 100 ns for global reset to finish
		repeat(20)
			#5 PC = PC + 4;

        #5 PC = 32'h00003500;
		#5 PC = 32'h00108000;
		// Add stimulus here

	end
      
endmodule

