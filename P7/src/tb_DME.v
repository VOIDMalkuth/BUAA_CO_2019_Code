`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:00:22 12/07/2019
// Design Name:   DM_Extender
// Module Name:   F:/tmpSpace/P7/Mips/tb_DME.v
// Project Name:  Mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DM_Extender
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_DME;

	// Inputs
	reg [1:0] DME_i_Addr;
	reg [31:0] DME_i_Data;
	reg [3:0] DME_i_Mode;

	// Outputs
	wire [31:0] DME_o_Output;

	// Instantiate the Unit Under Test (UUT)
	DM_Extender uut (
		.DME_i_Addr(DME_i_Addr), 
		.DME_i_Data(DME_i_Data), 
		.DME_i_Mode(DME_i_Mode), 
		.DME_o_Output(DME_o_Output)
	);

	initial begin
		// Initialize Inputs
		DME_i_Addr = 0;
		DME_i_Data = 0;
		DME_i_Mode = 0;

		// Wait 100 ns for global reset to finish
		#100;

		DME_i_Addr = 2'b10;
		DME_i_Data = 32'hf2345678;
		DME_i_Mode = 0;
		#5 DME_i_Mode = 1;
		#5 DME_i_Mode = 2;
		#5 DME_i_Mode = 3;
		#5 DME_i_Mode = 4;
		#5 DME_i_Mode = 5;
        
		// Add stimulus here

	end
      
endmodule

