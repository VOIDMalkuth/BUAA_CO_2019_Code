`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:28 11/16/2019 
// Design Name: 
// Module Name:    CPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CPU(
    input clk,
    input reset
    );

    // IFU Inputs
	wire [1:0] IFU_Control = IFUCG_Output;	// control
	wire [15:0] IFU_Offset = Instr[15:0];	// immediate
	wire [25:0] IFU_JAddr = Instr[25:0];	// jal/j 
	wire [31:0] IFU_RegAddr = GRF_RData1;	// jr used value in rs
	// IFUCG Inputs
	wire IFUCG_Condition = ALU_isZero;	//check if is zero
	// GRF Inputs
	wire [4:0] GRF_RAddr1 = Instr[25:21];	// rs
	wire [4:0] GRF_RAddr2 = Instr[20:16];	// rt
	wire [4:0] GRF_WAddr = MUX_RegWAddr_Output; // mux in
	wire [31:0] GRF_WData = MUX_RegWData_Output;
	// EXT Inputs
	wire [15:0] EXT_Input = Instr[15:0];	// Immediate
	// ALU Inputs
	wire [31:0] ALU_Operand1 = GRF_RData1;	// alu op1 is always rs
	wire [31:0] ALU_Operand2 = MUX_ALUOp2_Output;
	// DM Inputs
	wire [31:0] DM_Addr = ALU_Result;		// dm addr
	wire [31:0] DM_WData = GRF_RData2;		// data input
	// MUX_ALUOp2 Inputs
	wire [31:0] MUX_ALUOp2_RegIn = GRF_RData2;	// rt
	wire [31:0] MUX_ALUOp2_EXTIn = EXT_Output;	// EXT
	// MUX_RegWAddr Inputs
	wire [4:0] MUX_RegWAddr_rdIn = Instr[15:11];// rd
	wire [4:0] MUX_RegWAddr_rtIn = Instr[20:16];// rt
	// MUX_RegWData Inputs
	wire [31:0] MUX_RegWData_ALUIn = ALU_Result;
	wire [31:0] MUX_RegWData_memIn = DM_RData;
	wire [31:0] MUX_RegWData_linkIn = IFU_PC_plus_4;

	
	// IFU Outputs
	wire [31:0] Instr;		// controller input
	wire [31:0] IFU_PC_plus_4;		// regwdata mux input
	// Controller Outputs
	wire [1:0] IFUCG_Mode;			// ifucg input
	wire IFUCG_isConditional;	// ifucg input
	wire GRF_WEnable;				// GRF input
	wire [1:0] EXT_Mode;			// EXT input
	wire [3:0] ALU_Operation;		// ALU input
	wire DM_WEnable;				// DM input
	wire [1:0] DM_Mode;				// DM input
	wire [1:0] MUX_ALUOp2_Sel;		// MUX_ALUOp2 input
	wire [1:0] MUX_RegWAddr_Sel;	// MUX_RegWAddr input
	wire [1:0] MUX_RegWData_Sel;	// MUX_RegWData input
	// IFUCG Outputs
	wire [1:0] IFUCG_Output;	// IFU input
	// GRF Outputs
	wire [31:0] GRF_RData1;		// ALU input
	wire [31:0] GRF_RData2;		// aluop2 mux input
	// EXT Outputs
	wire [31:0] EXT_Output;		// aluop2 mux input
	// ALU Outputs
	wire [31:0] ALU_Result;		// mux, dm input
	wire ALU_isZero;			// ifucg condition
	wire ALU_Overflow;//NOTHING SO FAR
	// DM Outputs
	wire [31:0] DM_RData;	// mux_regwdata input
	// MUX_ALUOp2 Outputs
	wire [31:0] MUX_ALUOp2_Output;		// ALU input
	// MUX_RegWAddr Outputs
	wire [4:0] MUX_RegWAddr_Output;		// GRF input
	// MUX_RegWData Outputs
	wire [31:0] MUX_RegWData_Output;	// GRF input



    IFU ifu (
		.clk(clk), 
		.reset(reset), 
		.IFU_Control(IFU_Control), 
		.IFU_Offset(IFU_Offset), 
		.IFU_JAddr(IFU_JAddr), 
		.IFU_RegAddr(IFU_RegAddr), 
		.Instr(Instr), 
		.IFU_PC_plus_4(IFU_PC_plus_4)
	);

	Controller controller (
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
	
	IFUCG ifucg (
		.IFUCG_Mode(IFUCG_Mode), 
		.IFUCG_isConditional(IFUCG_isConditional), 
		.IFUCG_Condition(IFUCG_Condition), 
		.IFUCG_Output(IFUCG_Output)
	);

	GRF grf (
		.clk(clk), 
		.reset(reset), 
		.GRF_WEnable(GRF_WEnable), 
		.GRF_RAddr1(GRF_RAddr1), 
		.GRF_RAddr2(GRF_RAddr2), 
		.GRF_WAddr(GRF_WAddr), 
		.GRF_WData(GRF_WData), 
		.GRF_RData1(GRF_RData1), 
		.GRF_RData2(GRF_RData2)
	);

	EXT ext (
		.EXT_Input(EXT_Input), 
		.EXT_Mode(EXT_Mode), 
		.EXT_Output(EXT_Output)
	);

	ALU alu (
		.ALU_Operand1(ALU_Operand1), 
		.ALU_Operand2(ALU_Operand2), 
		.ALU_Operation(ALU_Operation), 
		.ALU_Result(ALU_Result), 
		.ALU_isZero(ALU_isZero), 
		.ALU_Overflow(ALU_Overflow)
	);

	MUX_ALUOp2 mux_aluop2 (
		.MUX_ALUOp2_Sel(MUX_ALUOp2_Sel), 
		.MUX_ALUOp2_RegIn(MUX_ALUOp2_RegIn), 
		.MUX_ALUOp2_EXTIn(MUX_ALUOp2_EXTIn), 
		.MUX_ALUOp2_Output(MUX_ALUOp2_Output)
	);

	MUX_RegWAddr mux_regwaddr (
		.MUX_RegWAddr_Sel(MUX_RegWAddr_Sel), 
		.MUX_RegWAddr_rdIn(MUX_RegWAddr_rdIn), 
		.MUX_RegWAddr_rtIn(MUX_RegWAddr_rtIn), 
		.MUX_RegWAddr_Output(MUX_RegWAddr_Output)
	);

	MUX_RegWData mux_regwdata (
		.MUX_RegWData_Sel(MUX_RegWData_Sel), 
		.MUX_RegWData_ALUIn(MUX_RegWData_ALUIn), 
		.MUX_RegWData_memIn(MUX_RegWData_memIn), 
		.MUX_RegWData_linkIn(MUX_RegWData_linkIn), 
		.MUX_RegWData_Output(MUX_RegWData_Output)
	);

    DM dm (
		.clk(clk), 
		.reset(reset), 
		.DM_WEnable(DM_WEnable), 
		.DM_Mode(DM_Mode), 
		.DM_Addr(DM_Addr), 
		.DM_WData(DM_WData), 
		.DM_RData(DM_RData)
	);

	// display
	always @(posedge clk) begin
		if(GRF_WEnable && reset != 1'b1)
			$display("@%h: $%d <= %h", IFU_PC_plus_4 - 4, GRF_WAddr, GRF_WData);
		if(DM_WEnable && reset != 1'b1)
			$display("@%h: *%h <= %h", IFU_PC_plus_4 - 4, DM_Addr, DM_WData);
	end


endmodule
