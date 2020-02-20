`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:15:48 12/06/2019
// Design Name:   DM_BE_Decoder
// Module Name:   F:/tmpSpace/P7/Mips/tb_DMBD.v
// Project Name:  Mips
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DM_BE_Decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_DMBD;

	// Inputs
	reg [1:0] DMBD_i_Addr;
	reg [3:0] DMBD_i_Mode;

	// Outputs
	wire [3:0] DMBD_o_ByteEn;
	wire DMBD_o_Unaligned;

	// Instantiate the Unit Under Test (UUT)
	DM_BE_Decoder uut (
		.DMBD_i_Addr(DMBD_i_Addr), 
		.DMBD_i_Mode(DMBD_i_Mode), 
		.DMBD_o_Unaligned(DMBD_o_Unaligned),
		.DMBD_o_ByteEn(DMBD_o_ByteEn)
	);

	reg [3:0] i, j;

	initial begin
		// Initialize Inputs
		DMBD_i_Addr = 0;
		DMBD_i_Mode = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		for(i = 0; i < 4; i = i + 1) begin
			DMBD_i_Addr = i;
			for(j = 0; j < 5; j = j + 1) begin
				#5 DMBD_i_Mode = j;
			end
		end
        
		// Add stimulus here

	end
      
endmodule

