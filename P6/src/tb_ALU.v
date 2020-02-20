`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:15:33 12/03/2019
// Design Name:   ALU
// Module Name:   F:/tmpSpace/P6/CPU_Pipelined_Plus/tb_ALU.v
// Project Name:  CPU_Pipelined_Plus
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_ALU;

	// Inputs
	reg [31:0] ALU_i_Operand1;
	reg [31:0] ALU_i_Operand2;
	reg [7:0] ALU_i_Operation;

	// Outputs
	wire [31:0] ALU_o_Result;
	wire ALU_o_isOverflown;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.ALU_i_Operand1(ALU_i_Operand1), 
		.ALU_i_Operand2(ALU_i_Operand2), 
		.ALU_i_Operation(ALU_i_Operation), 
		.ALU_o_Result(ALU_o_Result), 
		.ALU_o_isOverflown(ALU_o_isOverflown)
	);

	integer i;
	initial begin
		// Initialize Inputs
		ALU_i_Operand1 = 32'd7;
		ALU_i_Operand2 = 32'd1234567;
		ALU_i_Operation = 0;

		// Wait 100 ns for global reset to finish
		#100;

		for(i=0;i<14;i = i+1)
			#5 ALU_i_Operation = i;
		#5 ;

		ALU_i_Operand1 = 32'd11;
		ALU_i_Operand2 = -32'd1956;

		for(i=0;i<14;i = i+1)
			#5 ALU_i_Operation = i;
		#5 ;
        
		// Add stimulus here

	end
      
endmodule

