`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:18:30 11/13/2019
// Design Name:   IFU
// Module Name:   F:/tmpSpace/P4/CPU/tb_IFU.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IFU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "macro.v"

module tb_IFU;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] IFU_Control;
	reg [15:0] IFU_Offset;
	reg [25:0] IFU_JAddr;
	reg [31:0] IFU_RegAddr;

	// Outputs
	wire [31:0] Instr;
	wire [31:0] IFU_PC_plus_4;

	// Instantiate the Unit Under Test (UUT)
	IFU uut (
		.clk(clk), 
		.reset(reset), 
		.IFU_Control(IFU_Control), 
		.IFU_Offset(IFU_Offset), 
		.IFU_JAddr(IFU_JAddr), 
		.IFU_RegAddr(IFU_RegAddr), 
		.Instr(Instr), 
		.IFU_PC_plus_4(IFU_PC_plus_4)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		IFU_Control = 0;
		IFU_Offset = 0;
		IFU_JAddr = 0;
		IFU_RegAddr = 0;

		#100
		// Wait 100 ns for global reset to finish
		#10 IFU_Control = `IFU_NORMAL;
			reset = 1;
		#10 reset = 0;
			IFU_Control = `IFU_NORMAL;
		#10 IFU_Control = `IFU_BRANCH;   
		   IFU_Offset = 16'hffff; 
		#10 IFU_Control = `IFU_BRANCH;
		   IFU_Offset = 16'hfff0; 
		#10 IFU_Control = `IFU_BRANCH;
		   IFU_Offset = 16'd2;
		#10 IFU_Control = `IFU_JREG;
		   IFU_RegAddr = 32'hf2345678;
		#10 IFU_Control = `IFU_JUMP;
		   IFU_JAddr = 26'h0003000;
		#10 IFU_Control = `IFU_JREG;
		   IFU_RegAddr = 32'h00003000;
		#10 IFU_Control = `IFU_NORMAL;
        
		// Add stimulus here

	end

	always #5 clk = ~clk;
      
endmodule

