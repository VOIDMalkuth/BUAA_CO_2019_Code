`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:05:11 10/18/2019
// Design Name:   gray
// Module Name:   F:/tmpSpace/P1_4_gray/tb_gray.v
// Project Name:  P1_4_gray
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: gray
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_gray;

	// Inputs
	reg Clk;
	reg Reset;
	reg En;

	// Outputs
	wire [2:0] Output;
	wire Overflow;

	// Instantiate the Unit Under Test (UUT)
	gray uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.En(En), 
		.Output(Output), 
		.Overflow(Overflow)
	);

	initial begin
		// Initialize Inputs
		Clk = 0;
		Reset = 0;
		En = 0;

		// Wait 100 ns for global reset to finish
		#10

		En = 1;

		#30

		En = 0;

		#20

		En = 1;

		#10

		Reset = 1;
        
		#10
		En = 1;
		Reset = 0;

		#300
		Reset = 1;

		#10
		Reset = 0;

	end

	always #5 Clk = ~Clk;
      
endmodule

