`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:28:40 12/01/2019
// Design Name:   MDU_DelayFSM
// Module Name:   F:/tmpSpace/P6/CPU_Pipelined_Plus/tb_MDU_DelayFSM.v
// Project Name:  CPU_Pipelined_Plus
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MDU_DelayFSM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_MDU_DelayFSM;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] MDU_DelayFSM_i_Mode;

	// Outputs
	wire MDU_DelayFSM_o_Busy;
	wire MDU_DelayFSM_o_dataReady;

	// Instantiate the Unit Under Test (UUT)
	MDU_DelayFSM uut (
		.clk(clk), 
		.reset(reset), 
		.MDU_DelayFSM_i_Mode(MDU_DelayFSM_i_Mode), 
		.MDU_DelayFSM_o_Busy(MDU_DelayFSM_o_Busy),
		.MDU_DelayFSM_o_dataReady(MDU_DelayFSM_o_dataReady)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		MDU_DelayFSM_i_Mode = 0;

		// Wait 100 ns for global reset to finish
		#100;

		#5
		MDU_DelayFSM_i_Mode = 1;
		#10 MDU_DelayFSM_i_Mode = 0;
		#100;

		MDU_DelayFSM_i_Mode = 2;
		#10 MDU_DelayFSM_i_Mode = 0;
		#100;

		MDU_DelayFSM_i_Mode = 3;
		#10 MDU_DelayFSM_i_Mode = 0;
		#100;

		MDU_DelayFSM_i_Mode = 4;
		#10 MDU_DelayFSM_i_Mode = 0;
		#20 reset = 1;
		#10 reset = 0;
        
		// Add stimulus here

	end

	always #5 clk =~clk;
      
endmodule

