`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:18:06 11/14/2019
// Design Name:   ALU
// Module Name:   F:/tmpSpace/P4/CPU/tb_ALU.v
// Project Name:  CPU
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
`include "macro.v"

module tb_ALU;

	// Inputs
	reg [31:0] ALU_Operand1;
	reg [31:0] ALU_Operand2;
	reg [3:0] ALU_Operation;

	// Outputs
	wire [31:0] ALU_Result;
	wire ALU_isZero;
	wire ALU_Overflow;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.ALU_Operand1(ALU_Operand1), 
		.ALU_Operand2(ALU_Operand2), 
		.ALU_Operation(ALU_Operation), 
		.ALU_Result(ALU_Result), 
		.ALU_isZero(ALU_isZero), 
		.ALU_Overflow(ALU_Overflow)
	);

	initial begin
		// Initialize Inputs
		#100;
		ALU_Operand1 = 32'hffffffff;
		ALU_Operand2 = 32'hffffffff;
		ALU_Operation = `ALU_ADD;
		#50 ALU_Operation = `ALU_SUB;
		#50 ALU_Operation = `ALU_OR;

		#50 ALU_Operand1 = 32'h00000011;
		ALU_Operand2 = 32'hffffff00;
		ALU_Operation = `ALU_ADD;
		#50 ALU_Operation = `ALU_SUB;
		#50 ALU_Operation = `ALU_OR;

		#50 ALU_Operand1 = 32'h0fffffff;
		ALU_Operand2 = 32'h0fffffff;
		ALU_Operation = `ALU_ADD;
		#50 ALU_Operation = `ALU_SUB;
		#50 ALU_Operation = `ALU_OR;

		repeat(30) begin
			#50 ALU_Operand1 = $random;
			ALU_Operand2 = $random;
			ALU_Operation = `ALU_ADD;
			#50 ALU_Operation = `ALU_SUB;
			#50 ALU_Operation = `ALU_OR;
		end
        
		// Add stimulus here

	end
      
endmodule

