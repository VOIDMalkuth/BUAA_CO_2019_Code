`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
//
//
//
//
//////////////////////////////////////////////////////////////////////////
`include "macro.v"

module CPU(
    input clk,
    input reset,
	input [7:2] HWInt,
	input [31:0] PrRD,
	output [31:0] PrAddr,
	output [3:0] PrBE,
	output [31:0] PrWD,
	output PrWE,
	output [31:0] addr
    );

	assign addr = PReg_M_o_PC;

	// stageF start
	// ================================================
    // IFU Inputs
    wire IFU_i_En = HU_o_F_IFUEnable;
	wire [31:0] IFU_i_nPC = NPC_o_nPC;
	// ================================================

	// stage D start
	// ================================================
	// CMP Inputs
	wire [31:0] CMP_i_RsIn = FMUX_D_rs_o_correctedVal;
	wire [31:0] CMP_i_RtIn = FMUX_D_rt_o_correctedVal;
	wire [3:0] CMP_i_Mode = D_CMP_Mode;
    // NPC Inputs
	wire [31:0] NPC_i_PC = IFU_o_PC;					// DIRECT CONNECT!
	wire [25:0] NPC_i_Immediate = PReg_D_o_Instr[25:0]; //NPC use D PReg!
	wire [31:0] NPC_i_RegAddr = FMUX_D_rs_o_correctedVal;
	
	// !!!!! Forward !!!!!
	wire [31:0] NPC_i_EPCAddr = (E_instr_type == `INSTR_MTC0 && E_Instr[15:11] == 5'd14) ? FMUX_E_rt_o_correctedVal : CP0_o_EPC;
	// !!!!! Forward !!!!!

	wire [2:0] NPC_i_Mode = D_NPC_Mode;
	wire NPC_i_Condition = CMP_o_Output;
    // PReg_D inputs
	wire PReg_D_i_isInserted = 1'b0;
	wire PReg_D_i_Enable = HU_o_D_PRegEnable;
	wire [31:0] PReg_D_i_Instr = IFU_o_Instr;

	// ! Cleared Bubble after eret will have a PC of return address
	// ! in case of [mult - eret - mult] kinds of sequence
	wire [31:0] PReg_D_i_PC = (D_NPC_Mode == `NPC_ERET) ? NPC_o_nPC : IFU_o_PC;
	
	wire [4:0] PReg_D_i_excCode = IFU_o_excCode;
    // D_Controller Inputs
	wire [31:0] D_Instr = PReg_D_o_Instr;
	// GRF Inputs
	wire GRF_i_WEnable = W_GRF_WEnable;					// W stage control
	wire [4:0] GRF_i_RAddr1 = PReg_D_o_Instr[25:21];	// rs
	wire [4:0] GRF_i_RAddr2 = PReg_D_o_Instr[20:16];	// rt
	wire [4:0] GRF_i_WAddr = W_MUX_RegWAddr_o_Output;	// connects using data in wb
	wire [31:0] GRF_i_WData = W_MUX_RegWData_Output;	// connects using data in wb
	wire [31:0] GRF_i_PC = PReg_W_o_PC;					// connects using data in wb
	// EXT Inputs
	wire [15:0] EXT_i_Input = PReg_D_o_Instr[15:0];
	wire [1:0] EXT_i_Mode = D_EXT_Mode;
	// all MUX inputs are in mux, including forward MUX
	// ID/EX PReg inputs
	wire PReg_E_i_clear = HU_o_E_PRegClear;	//  in HU
	wire PReg_E_i_isInserted = PReg_D_o_isInserted;
	wire [31:0] PReg_E_i_Instr = PReg_D_o_Instr;
	wire [31:0] PReg_E_i_PC = PReg_D_o_PC;
	wire [31:0] PReg_E_i_rsData = FMUX_D_rs_o_correctedVal;
	wire [31:0] PReg_E_i_rtData = FMUX_D_rt_o_correctedVal;
	wire [31:0] PReg_E_i_extData = EXT_o_Output;
	wire [31:0] PReg_E_i_RegWData = D_MUX_RegWData_Output;
	wire [4:0]  PReg_E_i_excCode = (D_instr_type == `INSTR_ILLEGAL) ? `EXC_RI : PReg_D_o_excCode;
	// ================================================

	// stage E start
	// ================================================
	// stageE Controller Inputs
	wire [31:0] E_Instr = PReg_E_o_Instr;
	// ALU Inputs
	wire [31:0] E_ALU_i_Operand1 = E_MUX_ALUOp1_o_Output;
	wire [31:0] E_ALU_i_Operand2 = E_MUX_ALUOp2_o_Output;
	wire [7:0] E_ALU_i_Operation = E_ALU_Operation;
	// MDU Inputs
	wire [31:0] E_MDU_i_Operand1 = FMUX_E_rs_o_correctedVal;
	wire [31:0] E_MDU_i_Operand2 = FMUX_E_rt_o_correctedVal;
	wire [3:0] E_MDU_i_Operation = (CP0_o_IntReq == 1'b1) ? `MDU_NOOP : E_MDU_Operation;
	// EX/MEM PReg Inputs
	wire PReg_M_i_isInserted = PReg_E_o_isInserted;
	wire [31:0] PReg_M_i_Instr = PReg_E_o_Instr;
	wire [31:0] PReg_M_i_PC = PReg_E_o_PC;
	wire [31:0] PReg_M_i_rsData = FMUX_E_rs_o_correctedVal;
	wire [31:0] PReg_M_i_rtData = FMUX_E_rt_o_correctedVal;
	wire [31:0] PReg_M_i_extData = PReg_E_o_extData;
	wire [31:0] PReg_M_i_ALUResult = E_MUX_EALU_OData_o_Output;
	wire [31:0] PReg_M_i_RegWData = E_MUX_RegWData_Output;
	wire [4:0]  PReg_M_i_excCode = (E_ALU_o_isOverflown == 1'b1) ? `EXC_OV : PReg_E_o_excCode;
	// ================================================

	// stage M start
	// ================================================
	// stage M Controller Inputs
	wire [31:0] M_Instr = PReg_M_o_Instr;
	
	// M_DM Inputs
	// DM will write !only when in dm range!
	wire M_DM_i_WEnable = M_DM_WEnable && (CP0_o_IntReq != 1'b1);
	wire [3:0] M_DM_i_Mode = M_DM_Mode;
	wire [31:0] M_DM_i_Addr = PReg_M_o_ALUResult;
	wire [31:0] M_DM_i_WData = FMUX_M_rt_o_correctedVal;
	wire [31:0] M_DM_i_PC = PReg_M_o_PC;
	// M ExcChecker Inputs
	wire [4:0] EC_i_E_ExcCode = PReg_M_o_excCode;
	wire EC_i_DM_WEnable = M_DM_WEnable;
	wire EC_i_DM_REnable = M_DM_REnable;
	wire [31:0] EC_i_Addr = PReg_M_o_ALUResult;
	wire [3:0] EC_i_DM_Mode = M_DM_Mode;
	wire EC_i_Unaligned = M_DM_o_Unaligned;
	// CP0 Inputs
	wire [4:0] CP0_i_Addr = M_Instr[15:11];
	wire [31:0] CP0_i_WData = FMUX_M_rt_o_correctedVal;
	wire [31:0] CP0_i_PCAtM = PReg_M_o_PC;
	wire [6:2] CP0_i_ExcCode = EC_o_ExcCode;
	wire [5:0] CP0_i_HWInt = HWInt[7:2];
	wire CP0_i_isInsertedNop = PReg_M_o_isInserted;
	wire CP0_i_isBranch = (M_NPC_Mode != `NPC_NORMAL && M_NPC_Mode != `NPC_ERET) ? 1'b1 : 1'b0;
	wire CP0_i_WEnable = M_CP0_WEnable;
	wire CP0_i_EXLClr = M_CP0_EXLClr;
	// MEM/WB PReg Inputs
	wire PReg_W_i_isInserted = PReg_M_o_isInserted;
	wire [31:0] PReg_W_i_Instr = PReg_M_o_Instr;
	wire [31:0] PReg_W_i_PC = PReg_M_o_PC;
	wire [31:0] PReg_W_i_rsData = FMUX_M_rs_o_correctedVal;
	wire [31:0] PReg_W_i_rtData = FMUX_M_rt_o_correctedVal;
	wire [31:0] PReg_W_i_extData = PReg_M_o_extData;
	wire [31:0] PReg_W_i_ALUResult = PReg_M_o_ALUResult;
	wire [31:0] PReg_W_i_memData = M_OutDataFinal;
	wire [31:0] PReg_W_i_RegWData = M_MUX_RegWData_Output;
	wire [4:0] PReg_W_i_excCode = EC_o_ExcCode;
	// ================================================

	// stage W start
	// ================================================
	// stage W Controller Inputs
	wire [31:0] W_Instr = PReg_W_o_Instr;
	// Hazard Unit Inputs
	wire [31:0] HU_i_D_Instr = PReg_D_o_Instr;
	wire [31:0] HU_i_D_Instr_Type = D_instr_type;
	wire [2:0] HU_i_D_RegWAddrSel = D_MUX_RegWAddr_Sel;
	wire HU_i_D_GRFWEnable = D_GRF_WEnable;
	wire [31:0] HU_i_E_Instr = PReg_E_o_Instr;
	wire [31:0] HU_i_E_Instr_Type = E_instr_type;
	wire [2:0] HU_i_E_RegWAddrSel = E_MUX_RegWAddr_Sel;
	wire HU_i_E_GRFWEnable = E_GRF_WEnable;
	wire HU_i_E_MDUBusy = E_MDU_o_Busy;
	wire [31:0] HU_i_M_Instr = PReg_M_o_Instr;
	wire [31:0] HU_i_M_Instr_Type = M_instr_type;
	wire [2:0] HU_i_M_RegWAddrSel = M_MUX_RegWAddr_Sel;
	wire HU_i_M_GRFWEnable = M_GRF_WEnable;
	wire [31:0] HU_i_W_Instr = PReg_W_o_Instr;
	wire [31:0] HU_i_W_Instr_Type = W_instr_type;
	wire [2:0] HU_i_W_RegWAddrSel = W_MUX_RegWAddr_Sel;
	wire HU_i_W_GRFWEnable = W_GRF_WEnable;


    // IFU Outputs
	wire [31:0] IFU_o_PC;       // npc_i_pc & PReg_D_i_PC input
	wire [31:0] IFU_o_Instr;    // PReg_D_i_Instr input
	wire [4:0] IFU_o_excCode;
	// CMP Outputs
	wire CMP_o_Output;
    // NPC Outputs
	wire [31:0] NPC_o_nPC;      // ifu_i_pc input
    // PReg Outputs
	wire PReg_D_o_isInserted;
	wire [31:0] PReg_D_o_Instr; // npc/controller/ext inputs
	wire [31:0] PReg_D_o_PC;	// D_mux input
	wire [4:0] PReg_D_o_excCode;
    // stageD Controller Outputs
	wire [31:0] D_instr_type;
	wire [3:0] D_CMP_Mode;
	wire [2:0] D_NPC_Mode;		// NPC input
	wire D_GRF_WEnable;			// GRF
	wire [1:0] D_EXT_Mode;		// ext input
	wire [2:0] D_MUX_RegWAddr_Sel;
	wire [2:0] D_MUX_RegWData_Sel;	// result MUX sel
	// GRF Outputs
	wire [31:0] GRF_o_RData1;
	wire [31:0] GRF_o_RData2;
	// stageD MUX out -- for forward
	wire [31:0] D_MUX_RegWData_Output;
	// EXT Outputs
	wire [31:0] EXT_o_Output;
	// FMUX_D Outputs
	wire [31:0] FMUX_D_rs_o_correctedVal;
	wire [31:0] FMUX_D_rt_o_correctedVal;
	// ID/EX PReg Output
	wire PReg_E_o_isInserted;
	wire [31:0] PReg_E_o_Instr;
	wire [31:0] PReg_E_o_PC;
	wire [31:0] PReg_E_o_rsData;
	wire [31:0] PReg_E_o_rtData;
	wire [31:0] PReg_E_o_extData;
	wire [31:0] PReg_E_o_RegWData;
	wire [4:0] PReg_E_o_excCode;
	// FMUX Outputs
	wire [31:0] FMUX_E_rs_o_correctedVal;
	wire [31:0] FMUX_E_rt_o_correctedVal;
	// stageE Controller Outputs
	wire [31:0] E_instr_type;
	wire E_GRF_WEnable;
	wire [7:0] E_ALU_Operation;
	wire [3:0] E_MDU_Operation;
	wire [2:0] E_MUX_ALUOp1_Sel;
	wire [2:0] E_MUX_ALUOp2_Sel;
	wire [2:0] E_MUX_RegWAddr_Sel;
	wire [2:0] E_MUX_RegWData_Sel;
	wire [2:0] E_MUX_EALU_OData_Sel; // !
	// E_MUX_ALUOp1/2 Outputs
	wire [31:0] E_MUX_ALUOp1_o_Output;
	wire [31:0] E_MUX_ALUOp2_o_Output;
	// ALU Outputs
	wire [31:0] E_ALU_o_Result;
	wire E_ALU_o_isOverflown;
	// MDU Outputs
	wire E_MDU_o_Busy;
	wire [31:0] E_MDU_o_Hi;
	wire [31:0] E_MDU_o_Lo;
	// MUX alu result choose
	// ! Use this mux to support mfhi/mflo, alu result in RegWData input
	// !  is determined by this mux (realALU/Hi/Lo)
	wire [31:0] E_MUX_EALU_OData_o_Output;
	// stageE MUX out -- for forward
	wire [31:0] E_MUX_RegWData_Output;
	// EX/MEM PReg Outputs
	wire PReg_M_o_isInserted;
	wire [31:0] PReg_M_o_Instr;
	wire [31:0] PReg_M_o_PC;
	wire [31:0] PReg_M_o_rsData;
	wire [31:0] PReg_M_o_rtData;
	wire [31:0] PReg_M_o_extData;
	wire [31:0] PReg_M_o_ALUResult;
	wire [31:0] PReg_M_o_RegWData;
	wire [4:0] PReg_M_o_excCode;
	// stageM FMUX Outputs
	wire [31:0] FMUX_M_rs_o_correctedVal;
	wire [31:0] FMUX_M_rt_o_correctedVal;
	// stageM Controller Outputs
	wire [31:0] M_instr_type;
	wire [2:0] M_NPC_Mode;
	wire M_GRF_WEnable;
	wire M_DM_WEnable;
	wire [3:0] M_DM_Mode;
	wire M_CP0_WEnable;
	wire M_CP0_EXLClr;
	wire [2:0] M_MUX_RegWAddr_Sel;
	wire [2:0] M_MUX_RegWData_Sel;
	wire M_DM_REnable;
	wire [2:0] M_MUX_stageMOutData_Sel;
	// M_DM Outputs
	wire [31:0] M_DM_o_RData;
	wire M_DM_o_Unaligned;
	// stageM MUX out -- for forward
	wire [31:0] M_MUX_RegWData_Output;
	// EC Outputs
	wire [4:0] EC_o_ExcCode;
	// CP0 Outputs
	wire CP0_o_IntReq;
	wire [31:0] CP0_o_EPC;
	wire [31:0] CP0_o_RData;
	// MEM/WB PReg Outputs
	wire PReg_W_o_isInserted;
	wire [31:0] PReg_W_o_Instr;
	wire [31:0] PReg_W_o_PC;
	wire [31:0] PReg_W_o_rsData;
	wire [31:0] PReg_W_o_rtData;
	wire [31:0] PReg_W_o_extData;
	wire [31:0] PReg_W_o_ALUResult;
	wire [31:0] PReg_W_o_memData;
	wire [31:0] PReg_W_o_RegWData;
	wire [4:0] PReg_W_o_excCode;
	// stageW Controller Outputs
	wire [31:0] W_instr_type;
	wire W_GRF_WEnable;
	wire [2:0] W_MUX_RegWAddr_Sel;
	wire [2:0] W_MUX_RegWData_Sel;
	// stageW MUX out -- for write
	wire [31:0] W_MUX_RegWData_Output;
	// RegWAddr MUX Outputs
	wire [4:0] W_MUX_RegWAddr_o_Output;
	// === Hazard Unit Outputs ===
	wire HU_o_F_IFUEnable;
	wire HU_o_D_PRegEnable;
	wire HU_o_E_PRegClear;
	wire [1:0] HU_o_FwdD_Rs;
	wire [1:0] HU_o_FwdD_Rt;
	wire [1:0] HU_o_FwdE_Rs;
	wire [1:0] HU_o_FwdE_Rt;
	wire [1:0] HU_o_FwdM_Rs;
	wire [1:0] HU_o_FwdM_Rt;

	// ============= stage F starts ===============
    IFU stageF_ifu (
		.clk(clk), 
		.reset(reset), 
		.IFU_i_En(IFU_i_En), 
		.IFU_i_IntReq(CP0_o_IntReq),
		.IFU_i_nPC(IFU_i_nPC), 
		.IFU_o_PC(IFU_o_PC), 
		.IFU_o_Instr(IFU_o_Instr),
		.IFU_o_excCode(IFU_o_excCode)
	);

	PReg stageD_PReg (
		.clk(clk), 
		.reset(reset || CP0_o_IntReq), 
		.PReg_i_clear((D_instr_type == `INSTR_ERET)), 
		.PReg_i_Enable(PReg_D_i_Enable), 
		.PReg_i_isInserted(PReg_D_i_isInserted),
		.PReg_i_Instr(PReg_D_i_Instr), 
		.PReg_i_PC(PReg_D_i_PC), 
		.PReg_i_rsData(0), 
		.PReg_i_rtData(0), 
		.PReg_i_extData(0), 
		.PReg_i_ALUResult(0), 
		.PReg_i_memData(0), 
		.PReg_i_RegWData(0),
		.PReg_i_excCode(PReg_D_i_excCode), 
		.PReg_o_isInserted(PReg_D_o_isInserted),
		.PReg_o_Instr(PReg_D_o_Instr), 
		.PReg_o_PC(PReg_D_o_PC),
		// USELESS ... Still will warning... and only warns first line
		// .PReg_o_rsData(pc1),
		// .PReg_o_rtData(0), 
		// .PReg_o_extData(0), 
		// .PReg_o_ALUResult(0), 
		// .PReg_o_memData(0), 
		// .PReg_o_RegWData(0),
		.PReg_o_excCode(PReg_D_o_excCode)
	);
	// ============= stage F ends =================

	// ============= stage D starts ===============
	CMP stageD_cmp (
		.CMP_i_RsIn(CMP_i_RsIn), 
		.CMP_i_RtIn(CMP_i_RtIn), 
		.CMP_i_Mode(CMP_i_Mode), 
		.CMP_o_Output(CMP_o_Output)
	);

    NPC stageD_npc (
		.NPC_i_PC(NPC_i_PC), 
		.NPC_i_Immediate(NPC_i_Immediate), 
		.NPC_i_RegAddr(NPC_i_RegAddr), 
		.NPC_i_EPCAddr(NPC_i_EPCAddr),
		.NPC_i_Mode(NPC_i_Mode), 
		.NPC_i_Condition(NPC_i_Condition),
		.NPC_o_nPC(NPC_o_nPC)
	);

	Controller stageD_Controller (
		.Instr(D_Instr), 
		.instr_type(D_instr_type), 
		.NPC_Mode(D_NPC_Mode), 
		.CMP_Mode(D_CMP_Mode),
		.GRF_WEnable(D_GRF_WEnable), 
		.EXT_Mode(D_EXT_Mode), 
        // USELESS FOR D, Still will warning... and only warns first line
		// .ALU_Operation(0), 
		// .MDU_Operation(0),
		// .DM_WEnable(0), 
		// .DM_Mode(0), 
		// .CP0_WEnable(0),
		// .CP0_EXLClr(0),
		// .MUX_ALUOp1_Sel(0),
		// .MUX_ALUOp2_Sel(0), 
		.MUX_RegWAddr_Sel(D_MUX_RegWAddr_Sel), 
		.MUX_RegWData_Sel(D_MUX_RegWData_Sel)
		// .MUX_EALU_OData_Sel(0)
		// .MUX_stageMOutData_Sel(0)
	);

	GRF stageD_GRF (
		.clk(clk), 
		.reset(reset),
		.GRF_i_WEnable(GRF_i_WEnable), 
		.GRF_i_RAddr1(GRF_i_RAddr1), 
		.GRF_i_RAddr2(GRF_i_RAddr2), 
		.GRF_i_WAddr(GRF_i_WAddr), 	// in wb
		.GRF_i_WData(GRF_i_WData), 	// in wb
		.GRF_i_PC(GRF_i_PC),		// in wb
		.GRF_o_RData1(GRF_o_RData1), 
		.GRF_o_RData2(GRF_o_RData2)
	);

	EXT stageD_ext (
		.EXT_i_Input(EXT_i_Input), 
		.EXT_i_Mode(EXT_i_Mode), 
		.EXT_o_Output(EXT_o_Output)
	);

	// MUX to write proper data into PReg_E
    MUX_RegWData stageD_mux_regwdata (
		.MUX_RegWData_i_Sel(D_MUX_RegWData_Sel), 
		.MUX_RegWData_i_ALUIn(32'b0), 
		.MUX_RegWData_i_memIn(32'b0),
		.MUX_RegWData_i_linkIn(PReg_D_o_PC + 32'd8),
		.MUX_RegWData_o_Output(D_MUX_RegWData_Output)
	);

	FMUX_D stageD_FMUX_rs (
		.FMUX_D_i_DIn(GRF_o_RData1),	//FMUX_D_rs_i_DIn 
		.FMUX_D_i_ERegIn(PReg_E_o_RegWData), // FMUX_D_rs_i_ERegIn
		.FMUX_D_i_MRegIn(PReg_M_o_RegWData), // FMUX_D_rs_i_MRegIn
		.FMUX_D_i_FwdCtrl(HU_o_FwdD_Rs), // FMUX_D_rs_i_FwdCtrl
		.FMUX_D_o_correctedVal(FMUX_D_rs_o_correctedVal)
	);

	FMUX_D stageD_FMUX_rt (
		.FMUX_D_i_DIn(GRF_o_RData2),	// FMUX_D_rt_i_DIn
		.FMUX_D_i_ERegIn(PReg_E_o_RegWData), // FMUX_D_rt_i_ERegIn
		.FMUX_D_i_MRegIn(PReg_M_o_RegWData), // FMUX_D_rt_i_MRegIn
		.FMUX_D_i_FwdCtrl(HU_o_FwdD_Rt), // FMUX_D_rt_i_FwdCtrl
		.FMUX_D_o_correctedVal(FMUX_D_rt_o_correctedVal)
	);

	PReg stageE_PReg (
		.clk(clk), 
		.reset(reset || CP0_o_IntReq), 
		.PReg_i_clear(PReg_E_i_clear), 
		.PReg_i_Enable(1'b1), 
		.PReg_i_isInserted(PReg_E_i_isInserted),
		.PReg_i_Instr(PReg_E_i_Instr), 
		.PReg_i_PC(PReg_E_i_PC), 
		.PReg_i_rsData(PReg_E_i_rsData), 
		.PReg_i_rtData(PReg_E_i_rtData), 
		.PReg_i_extData(PReg_E_i_extData), 
		.PReg_i_ALUResult(0), 
		.PReg_i_memData(0), 
		.PReg_i_RegWData(PReg_E_i_RegWData), 
		.PReg_i_excCode(PReg_E_i_excCode),
		.PReg_o_isInserted(PReg_E_o_isInserted),
		.PReg_o_Instr(PReg_E_o_Instr), 
		.PReg_o_PC(PReg_E_o_PC), 
		.PReg_o_rsData(PReg_E_o_rsData), 
		.PReg_o_rtData(PReg_E_o_rtData), 
		.PReg_o_extData(PReg_E_o_extData), 
		// .PReg_o_ALUResult(PReg_E_o_ALUResult), 
		// .PReg_o_memData(PReg_E_o_memData), 
		.PReg_o_RegWData(PReg_E_o_RegWData),
		.PReg_o_excCode(PReg_E_o_excCode)
	);
	// ============= stage D ends =================

	// ============= stage E starts ===============
	FMUX_E stageE_FMUX_rs (
		.FMUX_E_i_EIn(PReg_E_o_rsData), // FMUX_E_rs_i_EIn
		.FMUX_E_i_MRegIn(PReg_M_o_RegWData), // FMUX_E_rs_i_MRegIn
		.FMUX_E_i_WRegIn(PReg_W_o_RegWData), // FMUX_E_rs_i_WRegIn
		.FMUX_E_i_FwdCtrl(HU_o_FwdE_Rs), // FMUX_E_rs_i_FwdCtrl
		.FMUX_E_o_correctedVal(FMUX_E_rs_o_correctedVal)
	);
	FMUX_E stageE_FMUX_rt (
		.FMUX_E_i_EIn(PReg_E_o_rtData), // FMUX_E_rt_i_EIn
		.FMUX_E_i_MRegIn(PReg_M_o_RegWData), // FMUX_E_rt_i_MRegIn
		.FMUX_E_i_WRegIn(PReg_W_o_RegWData), // FMUX_E_rt_i_WRegIn
		.FMUX_E_i_FwdCtrl(HU_o_FwdE_Rt), // FMUX_E_rt_i_FwdCtrl
		.FMUX_E_o_correctedVal(FMUX_E_rt_o_correctedVal)
	);

	Controller stageE_Controller (
		.Instr(E_Instr), 
		.instr_type(E_instr_type), 
		// .NPC_Mode(E_NPC_Mode),
		// .CMP_Mode(E_CMP_Mode), 
		.GRF_WEnable(E_GRF_WEnable), 
		// .EXT_Mode(E_EXT_Mode), 
		.ALU_Operation(E_ALU_Operation),
		.MDU_Operation(E_MDU_Operation), 
		// .DM_WEnable(E_DM_WEnable), 
		// .DM_Mode(E_DM_Mode), 
		// .CP0_WEnable(0),
		// .CP0_EXLClr(0),
		.MUX_ALUOp1_Sel(E_MUX_ALUOp1_Sel),
		.MUX_ALUOp2_Sel(E_MUX_ALUOp2_Sel), 
		.MUX_RegWAddr_Sel(E_MUX_RegWAddr_Sel), 
		.MUX_RegWData_Sel(E_MUX_RegWData_Sel),
		.MUX_EALU_OData_Sel(E_MUX_EALU_OData_Sel)
		// .MUX_stageMOutData_Sel(0)
	);

	MUX_ALUOp1 stageE_mux_aluop1 (
		.MUX_ALUOp1_i_Sel(E_MUX_ALUOp1_Sel), 
		.MUX_ALUOp1_i_RsIn(FMUX_E_rs_o_correctedVal), 
		.MUX_ALUOp1_i_ShamtIn(E_Instr[10:6]), 
		.MUX_ALUOp1_o_Output(E_MUX_ALUOp1_o_Output)
	);

	MUX_ALUOp2 stageE_mux_aluop2 (
		.MUX_ALUOp2_i_Sel(E_MUX_ALUOp2_Sel),
		.MUX_ALUOp2_i_RegIn(FMUX_E_rt_o_correctedVal), //rt:E_MUX_ALUOp2_i_RegIn
		.MUX_ALUOp2_i_EXTIn(PReg_E_o_extData), //E_MUX_ALUOp2_i_EXTIn
		.MUX_ALUOp2_o_Output(E_MUX_ALUOp2_o_Output)
	);

	ALU stageE_ALU (
		.ALU_i_Operand1(E_ALU_i_Operand1), 
		.ALU_i_Operand2(E_ALU_i_Operand2), 
		.ALU_i_Operation(E_ALU_i_Operation), 
		.ALU_o_Result(E_ALU_o_Result), 
		.ALU_o_isOverflown(E_ALU_o_isOverflown)
	);

	MDU stageE_MDU (
		.clk(clk), 
		.reset(reset), 
		.MDU_i_Operand1(E_MDU_i_Operand1), 
		.MDU_i_Operand2(E_MDU_i_Operand2), 
		.MDU_i_Operation(E_MDU_i_Operation), 
		.MDU_o_Busy(E_MDU_o_Busy),
		.MDU_o_Hi(E_MDU_o_Hi),
		.MDU_o_Lo(E_MDU_o_Lo)
	);

	// MUX to write proper data to ALUOut
	MUX_EALU_OData stageE_mux_ealu_odata (
		.MUX_EALU_OData_i_Sel(E_MUX_EALU_OData_Sel), 
		.MUX_EALU_OData_i_ALUIn(E_ALU_o_Result), 
		.MUX_EALU_OData_i_HiIn(E_MDU_o_Hi), 
		.MUX_EALU_OData_i_LoIn(E_MDU_o_Lo), 
		.MUX_EALU_OData_o_Output(E_MUX_EALU_OData_o_Output)
	);

	// MUX to write proper data into PReg_M
    MUX_RegWData stageE_mux_regwdata (
		.MUX_RegWData_i_Sel(E_MUX_RegWData_Sel), 
		.MUX_RegWData_i_ALUIn(E_MUX_EALU_OData_o_Output), 
		.MUX_RegWData_i_memIn(32'b0),
		.MUX_RegWData_i_linkIn(PReg_E_o_PC + 32'd8),
		.MUX_RegWData_o_Output(E_MUX_RegWData_Output)
	);

	PReg stageM_PReg (
		.clk(clk), 
		.reset(reset || CP0_o_IntReq), 
		// .PReg_i_clear(CP0_o_IntReq), 
		.PReg_i_Enable(1'b1), 
		.PReg_i_isInserted(PReg_M_i_isInserted),
		.PReg_i_Instr(PReg_M_i_Instr), 
		.PReg_i_PC(PReg_M_i_PC), 
		.PReg_i_rsData(PReg_M_i_rsData), 
		.PReg_i_rtData(PReg_M_i_rtData), 
		.PReg_i_extData(PReg_M_i_extData), 
		.PReg_i_ALUResult(PReg_M_i_ALUResult), 
		.PReg_i_memData(0), 
		.PReg_i_RegWData(PReg_M_i_RegWData), 
		.PReg_i_excCode(PReg_M_i_excCode),
		.PReg_o_isInserted(PReg_M_o_isInserted),
		.PReg_o_Instr(PReg_M_o_Instr), 
		.PReg_o_PC(PReg_M_o_PC), 
		.PReg_o_rsData(PReg_M_o_rsData), 
		.PReg_o_rtData(PReg_M_o_rtData), 
		.PReg_o_extData(PReg_M_o_extData), 
		.PReg_o_ALUResult(PReg_M_o_ALUResult), 
		//.PReg_o_memData(PReg_M_o_memData), 
		.PReg_o_RegWData(PReg_M_o_RegWData),
		.PReg_o_excCode(PReg_M_o_excCode)
	);

	// ============= stage E ends =================

	// ============= stage M starts ===============
	FMUX_M stageM_FMUX_rs ( // maybe not useful
		.FMUX_M_i_MIn(PReg_M_o_rsData), // FMUX_M_rs_i_MIn
		.FMUX_M_i_WRegIn(PReg_W_o_RegWData), // FMUX_M_rs_i_WRegIn
		.FMUX_M_i_FwdCtrl(HU_o_FwdM_Rs), // FMUX_M_rs_i_FwdCtrl
		.FMUX_M_o_correctedVal(FMUX_M_rs_o_correctedVal)
	);
	FMUX_M stageM_FMUX_rt (
		.FMUX_M_i_MIn(PReg_M_o_rtData), // FMUX_M_rt_i_MIn
		.FMUX_M_i_WRegIn(PReg_W_o_RegWData), // FMUX_M_rt_i_WRegIn
		.FMUX_M_i_FwdCtrl(HU_o_FwdM_Rt), // FMUX_M_rt_i_FwdCtrl
		.FMUX_M_o_correctedVal(FMUX_M_rt_o_correctedVal)
	);

	Controller stageM_Controller (
		.Instr(M_Instr), 
		.instr_type(M_instr_type), 
		.NPC_Mode(M_NPC_Mode), 
		// .CMP_Mode(M_CMP_Mode), 
		.GRF_WEnable(M_GRF_WEnable), 
		// .EXT_Mode(M_EXT_Mode), 
		// .ALU_Operation(M_ALU_Operation),
		// .MDU_Operation(M_MDU_Operation),  
		.DM_WEnable(M_DM_WEnable), 
		.DM_Mode(M_DM_Mode), 
		.CP0_WEnable(M_CP0_WEnable),
		.CP0_EXLClr(M_CP0_EXLClr),
		// .MUX_ALUOp1_Sel(M_MUX_ALUOp1_Sel), 
		// .MUX_ALUOp2_Sel(M_MUX_ALUOp2_Sel), 
		.MUX_RegWAddr_Sel(M_MUX_RegWAddr_Sel), 
		.MUX_RegWData_Sel(M_MUX_RegWData_Sel),
		// .MUX_EALU_OData_Sel(M_MUX_EALU_OData_Sel),
		.DM_REnable(M_DM_REnable),
		.MUX_stageMOutData_Sel(M_MUX_stageMOutData_Sel)
	);

	DM stageM_DM (
		.clk(clk), 
		.reset(reset), 
		.DM_i_WEnable(M_DM_i_WEnable), 
		.DM_i_Mode(M_DM_i_Mode), 
		.DM_i_Addr(M_DM_i_Addr), 
		.DM_i_WData(M_DM_i_WData),
		.DM_i_PC(M_DM_i_PC), 
		.DM_i_PrRD(PrRD),
		.DM_o_RData(M_DM_o_RData),
		.DM_o_Unaligned(M_DM_o_Unaligned),
		.DM_o_PrAddr(PrAddr),
		.DM_o_PrBE(PrBE),
		.DM_o_PrWD(PrWD),
		.DM_o_PrWE(PrWE)
	);

	wire [31:0] M_OutDataFinal = (M_MUX_stageMOutData_Sel == `MUX_MOUT_DMSEL) ? M_DM_o_RData : CP0_o_RData;

	// MUX to write proper data into PReg_W
    MUX_RegWData stageM_mux_regwdata (
		.MUX_RegWData_i_Sel(M_MUX_RegWData_Sel), 
		.MUX_RegWData_i_ALUIn(PReg_M_o_ALUResult), 
		.MUX_RegWData_i_memIn(M_OutDataFinal),
		.MUX_RegWData_i_linkIn(PReg_M_o_PC + 32'd8),
		.MUX_RegWData_o_Output(M_MUX_RegWData_Output)
	);

	ExcChecker stageM_excChecker (
		.EC_i_E_ExcCode(EC_i_E_ExcCode), 
		.EC_i_DM_WEnable(EC_i_DM_WEnable), 
		.EC_i_DM_REnable(EC_i_DM_REnable), 
		.EC_i_Addr(EC_i_Addr), 
		.EC_i_DM_Mode(EC_i_DM_Mode), 
		.EC_i_Unaligned(EC_i_Unaligned), 
		.EC_o_ExcCode(EC_o_ExcCode)
	);

	CoProcessor0 stageM_CP0 (
		.clk(clk), 
		.reset(reset), 
		.CP0_i_Addr(CP0_i_Addr), 
		.CP0_i_WData(CP0_i_WData), 
		.CP0_i_PCAtM(CP0_i_PCAtM), 
		.CP0_i_ExcCode(CP0_i_ExcCode), 
		.CP0_i_HWInt(CP0_i_HWInt), 
		.CP0_i_isInsertedNop(CP0_i_isInsertedNop), 
		.CP0_i_isBranch(CP0_i_isBranch), 
		.CP0_i_WEnable(CP0_i_WEnable), 
		.CP0_i_EXLClr(CP0_i_EXLClr), 
		.CP0_o_IntReq(CP0_o_IntReq), 
		.CP0_o_EPC(CP0_o_EPC), 
		.CP0_o_RData(CP0_o_RData)
	);

	PReg stageW_PReg (
		.clk(clk), 
		.reset(reset || CP0_o_IntReq), 
		// .PReg_i_clear(CP0_o_IntReq), 
		.PReg_i_Enable(1'b1), 
		.PReg_i_isInserted(PReg_W_i_isInserted),
		.PReg_i_Instr(PReg_W_i_Instr), 
		.PReg_i_PC(PReg_W_i_PC), 
		.PReg_i_rsData(PReg_W_i_rsData), 
		.PReg_i_rtData(PReg_W_i_rtData), 
		.PReg_i_extData(PReg_W_i_extData), 
		.PReg_i_ALUResult(PReg_W_i_ALUResult), 
		.PReg_i_memData(PReg_W_i_memData), 
		.PReg_i_RegWData(PReg_W_i_RegWData), 
		.PReg_i_excCode(PReg_W_i_excCode),
		.PReg_o_isInserted(PReg_W_o_isInserted),
		.PReg_o_Instr(PReg_W_o_Instr), 
		.PReg_o_PC(PReg_W_o_PC), 
		.PReg_o_rsData(PReg_W_o_rsData), 
		.PReg_o_rtData(PReg_W_o_rtData), 
		.PReg_o_extData(PReg_W_o_extData), 
		.PReg_o_ALUResult(PReg_W_o_ALUResult), 
		.PReg_o_memData(PReg_W_o_memData), 
		.PReg_o_RegWData(PReg_W_o_RegWData),
		.PReg_o_excCode(PReg_W_o_excCode)
	);

	// ============= stage M ends =================

	// ============= stage W starts ===============
	Controller stageW_Controller (
		.Instr(W_Instr), 
		.instr_type(W_instr_type), 
		// .NPC_Mode(W_NPC_Mode), 
		// .CMP_Mode(W_CMP_Mode), 
		.GRF_WEnable(W_GRF_WEnable), 
		// .EXT_Mode(W_EXT_Mode), 
		// .ALU_Operation(W_ALU_Operation),
		// .MDU_Operation(W_MDU_Operation),   
		// .DM_WEnable(W_DM_WEnable), 
		// .DM_Mode(W_DM_Mode), 
		// .CP0_WEnable(0),
		// .CP0_EXLClr(0),
		// .MUX_ALUOp1_Sel(W_MUX_ALUOp1_Sel), 
		// .MUX_ALUOp2_Sel(W_MUX_ALUOp2_Sel), 
		.MUX_RegWAddr_Sel(W_MUX_RegWAddr_Sel), 
		.MUX_RegWData_Sel(W_MUX_RegWData_Sel)
		// .MUX_EALU_OData_Sel(W_MUX_EALU_OData_Sel)
		// .MUX_stageMOutData_Sel(0)
	);
	// MUX to write proper data into GRF
    MUX_RegWData stageW_mux_regwdata (
		.MUX_RegWData_i_Sel(W_MUX_RegWData_Sel), 
		.MUX_RegWData_i_ALUIn(PReg_W_o_ALUResult), 
		.MUX_RegWData_i_memIn(PReg_W_o_memData),
		.MUX_RegWData_i_linkIn(PReg_W_o_PC + 32'd8),
		.MUX_RegWData_o_Output(W_MUX_RegWData_Output) // GRF Input
	);

	MUX_RegWAddr stageW_mux_regwaddr (
		.MUX_RegWAddr_i_Sel(W_MUX_RegWAddr_Sel), 
		.MUX_RegWAddr_i_rdIn(W_Instr[15:11]), // W_MUX_RegWAddr_i_rdIn
		.MUX_RegWAddr_i_rtIn(W_Instr[20:16]), // W_MUX_RegWAddr_i_rtIn
		.MUX_RegWAddr_o_Output(W_MUX_RegWAddr_o_Output)
	);

	HazardUnit hu (
		.HU_i_D_Instr(HU_i_D_Instr), 
		.HU_i_D_Instr_Type(HU_i_D_Instr_Type), 
		.HU_i_D_RegWAddrSel(HU_i_D_RegWAddrSel), 
		.HU_i_D_GRFWEnable(HU_i_D_GRFWEnable), 
		.HU_i_E_Instr(HU_i_E_Instr), 
		.HU_i_E_Instr_Type(HU_i_E_Instr_Type), 
		.HU_i_E_RegWAddrSel(HU_i_E_RegWAddrSel), 
		.HU_i_E_GRFWEnable(HU_i_E_GRFWEnable), 
		.HU_i_E_MDUBusy(HU_i_E_MDUBusy),
		.HU_i_M_Instr(HU_i_M_Instr), 
		.HU_i_M_Instr_Type(HU_i_M_Instr_Type), 
		.HU_i_M_RegWAddrSel(HU_i_M_RegWAddrSel), 
		.HU_i_M_GRFWEnable(HU_i_M_GRFWEnable), 
		.HU_i_W_Instr(HU_i_W_Instr), 
		.HU_i_W_Instr_Type(HU_i_W_Instr_Type), 
		.HU_i_W_RegWAddrSel(HU_i_W_RegWAddrSel), 
		.HU_i_W_GRFWEnable(HU_i_W_GRFWEnable), 
		.HU_o_F_IFUEnable(HU_o_F_IFUEnable), 
		.HU_o_D_PRegEnable(HU_o_D_PRegEnable), 
		.HU_o_E_PRegClear(HU_o_E_PRegClear), 
		.HU_o_FwdD_Rs(HU_o_FwdD_Rs), 
		.HU_o_FwdD_Rt(HU_o_FwdD_Rt), 
		.HU_o_FwdE_Rs(HU_o_FwdE_Rs), 
		.HU_o_FwdE_Rt(HU_o_FwdE_Rt), 
		.HU_o_FwdM_Rs(HU_o_FwdM_Rs), 
		.HU_o_FwdM_Rt(HU_o_FwdM_Rt)
	);


	//always @(posedge clk ) begin
	//	if(GRF_i_WEnable && !reset)
	//		$display("%d@%h: $%d <= %h", $time, PReg_W_o_PC, W_MUX_RegWAddr_o_Output, PReg_W_o_RegWData);
	//	if(M_DM_i_WEnable && !reset)
	//		$display("%d@%h: *%h <= %h", $time, PReg_M_o_PC, PReg_M_o_ALUResult, FMUX_M_rt_o_correctedVal);
	//end



endmodule
