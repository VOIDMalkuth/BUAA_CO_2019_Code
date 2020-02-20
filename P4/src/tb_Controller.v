`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:21:29 11/16/2019
// Design Name:   Controller
// Module Name:   F:/tmpSpace/P4/CPU/tb_Controller.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_Controller;

	// Inputs
	reg [31:0] Instr;

	// Outputs
	wire [1:0] IFUCG_Mode;
	wire IFUCG_isConditional;
	wire GRF_WEnable;
	wire [1:0] EXT_Mode;
	wire [3:0] ALU_Operation;
	wire DM_WEnable;
	wire [1:0] DM_Mode;
	wire [1:0] MUX_ALUOp2_Sel;
	wire [1:0] MUX_RegWAddr_Sel;
	wire [1:0] MUX_RegWData_Sel;

	// Instantiate the Unit Under Test (UUT)
	Controller uut (
		.Instr(Instr), 
		.IFUCG_Mode(IFUCG_Mode), 
		.IFUCG_isConditional(IFUCG_isConditional), 
		.GRF_WEnable(GRF_WEnable), 
		.EXT_Mode(EXT_Mode), 
		.ALU_Operation(ALU_Operation), 
		.DM_WEnable(DM_WEnable), 
		.DM_Mode(DM_Mode), 
		.MUX_ALUOp2_Sel(MUX_ALUOp2_Sel), 
		.MUX_RegWAddr_Sel(MUX_RegWAddr_Sel), 
		.MUX_RegWData_Sel(MUX_RegWData_Sel)
	);

	initial begin
		// Initialize Inputs
		Instr = 0;

		// Wait 100 ns for global reset to finish
		#5 Instr = 32'h341c0000;
		#5 Instr = 32'h341d0000;
		#5 Instr = 32'h34013456;
		#5 Instr = 32'h00210821;
		#5 Instr = 32'h8c010004;
		#5 Instr = 32'hac010004;
		#5 Instr = 32'h3c027878;
		#5 Instr = 32'h00411823;
		#5 Instr = 32'h3c051234;
		#5 Instr = 32'h34040005;
		#5 Instr = 32'h00000000;
		#5 Instr = 32'hac85ffff;
		#5 Instr = 32'h8c83ffff;
		#5 Instr = 32'h10650003;
		#5 Instr = 32'h00000000;
		#5 Instr = 32'h10000011;
		#5 Instr = 32'h00000000;
		#5 Instr = 32'h34670404;
		#5 Instr = 32'h10e3000e;
		#5 Instr = 32'h00000000;
		#5 Instr = 32'h3c087777;
		#5 Instr = 32'h3508ffff;
		#5 Instr = 32'h00080023;
		#5 Instr = 32'h34001100;
		#5 Instr = 32'h00e65021;
		#5 Instr = 32'h34080000;
		#5 Instr = 32'h34090001;
		#5 Instr = 32'h340a0001;
		#5 Instr = 32'h010a4021;
		#5 Instr = 32'h1109fffe;
		#5 Instr = 32'h0c000c22;
		#5 Instr = 32'h00000000;
		#5 Instr = 32'h014a5021;
		#5 Instr = 32'h1000ffff;
		#5 Instr = 32'h014a5021;
		#5 Instr = 32'h03e00008;
		#5 Instr = 32'h00000000;
        
		// Add stimulus here

	end
      
endmodule

