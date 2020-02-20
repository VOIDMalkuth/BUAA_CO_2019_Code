`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:21:00 11/12/2019
// Design Name:   nPC
// Module Name:   F:/tmpSpace/P4/CPU/tb_nPC.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: nPC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "macro.v"

module tb_nPC;

	// Inputs
	reg [31:0] nPC_pc;
	reg [15:0] nPC_offset;
	reg [25:0] nPC_addr_j;
	reg [31:0] nPC_addr_reg;
	reg [1:0] nPC_control;

	// Outputs
	wire [31:0] nPC_npc, nPC_pc_plus_4;

	// Instantiate the Unit Under Test (UUT)
	nPC uut (
		.nPC_pc(nPC_pc), 
		.nPC_offset(nPC_offset), 
		.nPC_addr_j(nPC_addr_j), 
		.nPC_addr_reg(nPC_addr_reg), 
		.nPC_control(nPC_control), 
		.nPC_npc(nPC_npc),
		.nPC_pc_plus_4(nPC_pc_plus_4)
	);

	initial begin
		// Initialize Inputs
		nPC_pc = 0;
		nPC_offset = 0;
		nPC_addr_j = 0;
		nPC_addr_reg = 0;
		nPC_control = 0;

		// Wait 100 ns for global reset to finish
		#5 nPC_control = `IFU_NORMAL;
		   nPC_pc = 32'h10;
		#5 nPC_control = `IFU_NORMAL;
		   nPC_pc = 32'h3004;
		#5 nPC_control = `IFU_BRANCH;
		   nPC_pc = 32'h3004;     
		   nPC_offset = 16'hffff; 
		#5 nPC_control = `IFU_BRANCH;
		   nPC_pc = 16'h3008;     
		   nPC_offset = 16'hfff0; 
		#5 nPC_control = `IFU_BRANCH;
		   nPC_pc = 32'h3008;     
		   nPC_offset = 16'd2;
		#5 nPC_control = `IFU_JUMP;
		   nPC_pc = 32'hffffff00;
		   nPC_addr_j = 26'h0003000;
		#5 nPC_control = `IFU_JREG;
		   nPC_pc = 32'hffffff00;
		   nPC_addr_reg = 32'h12345678;
		
        
		// Add stimulus here

	end
      
endmodule

