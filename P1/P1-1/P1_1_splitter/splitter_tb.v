`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:28:42 10/18/2019
// Design Name:   splitter
// Module Name:   F:/tmpSpace/P1_1_splitter/splitter_tb.v
// Project Name:  P1_1_splitter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: splitter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module splitter_tb;

	// Inputs
	reg [31:0] A;

	// Outputs
	wire [7:0] O1;
	wire [7:0] O2;
	wire [7:0] O3;
	wire [7:0] O4;

	wire mis1,mis2,mis3,mis4;

	// Instantiate the Unit Under Test (UUT)
	splitter uut (
		.A(A), 
		.O1(O1), 
		.O2(O2), 
		.O3(O3), 
		.O4(O4)
	);

	reg clk = 0;

	assign mis1 = (A[7:0] != O4);
	assign mis2 = (A[15:8] != O3);
	assign mis3 = (A[23:16] != O2);
	assign mis4 = (A[31:24] != O1);
	assign mismatch = mis1 || mis2 || mis3 || mis4;

	initial begin
		// Initialize Inputs
		A = 0;

		// Wait 100 ns for global reset to finish
		repeat(40)
			#5 A = $random;
        
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
endmodule

