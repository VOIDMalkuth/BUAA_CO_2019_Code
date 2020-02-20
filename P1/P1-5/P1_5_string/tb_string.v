`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:04:13 10/18/2019
// Design Name:   string
// Module Name:   F:/tmpSpace/P1_5_string/tb_string.v
// Project Name:  P1_5_string
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: string
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_string;

	// Inputs
	reg clk;
	reg clr;
	reg [7:0] in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	string uut (
		.clk(clk), 
		.clr(clr), 
		.in(in), 
		.out(out)
	);

	reg [7:0] ch;
	integer fd;

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;

   		in= "1";
		#10 in= "+";
		#10 in= "2";
		#10 in= "*";
		#10 in= "3";
		clr = 1;
		#10 in= "1";
			clr = 0;
		#10 in= "+";
		#10 in= "2";
		#10 in= "*";
		#10 in= "3";
		#10 in= "3";
			clr = 1;
		#10 in= "1";
			clr = 0;
		#10 in= "+";
		#10 in= "2";
	end

	always #5 clk = ~clk;
      
endmodule

