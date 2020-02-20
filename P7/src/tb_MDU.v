`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:24:33 12/01/2019
// Design Name:   MDU
// Module Name:   F:/tmpSpace/P6/CPU_Pipelined_Plus/tb_MDU.v
// Project Name:  CPU_Pipelined_Plus
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MDU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_MDU;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] MDU_i_Operand1;
	reg [31:0] MDU_i_Operand2;
	reg [3:0] MDU_i_Operation;

	// Outputs
	wire MDU_o_Busy;
	wire [31:0] MDU_o_Hi;
	wire [31:0] MDU_o_Lo;

	// Instantiate the Unit Under Test (UUT)
	MDU uut (
		.clk(clk), 
		.reset(reset), 
		.MDU_i_Operand1(MDU_i_Operand1), 
		.MDU_i_Operand2(MDU_i_Operand2), 
		.MDU_i_Operation(MDU_i_Operation), 
		.MDU_o_Busy(MDU_o_Busy), 
		.MDU_o_Hi(MDU_o_Hi), 
		.MDU_o_Lo(MDU_o_Lo)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		MDU_i_Operand1 = 0;
		MDU_i_Operand2 = 0;
		MDU_i_Operation = 0;

		// Wait 100 ns for global reset to finish
		#106 reset = 0;
        
		// Add stimulus here
		#10 MDU_i_Operand1 = 32'd12345678;
			MDU_i_Operand2 = 32'd24691356;
			MDU_i_Operation = 1;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#100;

		#10 MDU_i_Operand1 = 32'd12345678;
			MDU_i_Operand2 = 32'd24691356;
			MDU_i_Operation = 2;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#100;

		#10 MDU_i_Operand1 = 32'd12345678;
			MDU_i_Operand2 = 32'd24691356;
			MDU_i_Operation = 3;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = 32'd12345678;
			MDU_i_Operand2 = 32'd24691356;
			MDU_i_Operation = 4;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = 32'd126;
			MDU_i_Operation = 1;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = 32'd126;
			MDU_i_Operation = 2;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = 32'd126;
			MDU_i_Operation = 3;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = 32'd126;
			MDU_i_Operation = 4;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = 32'd126;
			MDU_i_Operation = 5;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = 32'd126;
			MDU_i_Operation = 6;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = 32'd12345678;
			MDU_i_Operand2 = -32'd126;
			MDU_i_Operation = 1;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = 32'd12345678;
			MDU_i_Operand2 = -32'd126;
			MDU_i_Operation = 2;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = 32'd12345678;
			MDU_i_Operand2 = -32'd126;
			MDU_i_Operation = 3;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = 32'd12345678;
			MDU_i_Operand2 = -32'd126;
			MDU_i_Operation = 4;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = -32'd126;
			MDU_i_Operation = 1;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = -32'd126;
			MDU_i_Operation = 2;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = -32'd126;
			MDU_i_Operation = 3;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;

		#10 MDU_i_Operand1 = -32'd12345678;
			MDU_i_Operand2 = -32'd126;
			MDU_i_Operation = 4;
		#10 MDU_i_Operand1 = 32'd0;
			MDU_i_Operand2 = 32'd0;
			MDU_i_Operation = 0;
		#150;


	end

	always #5 clk = ~clk;
      
endmodule

