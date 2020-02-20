`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:33:41 11/23/2019 
// Design Name: 
// Module Name:    HazardUnit 
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
module HazardUnit(
    input [31:0] HU_i_D_Instr,
    input [31:0] HU_i_D_Instr_Type,
    input [2:0] HU_i_D_RegWAddrSel,
    input HU_i_D_GRFWEnable,
    input [31:0] HU_i_E_Instr,
    input [31:0] HU_i_E_Instr_Type,
    input [2:0] HU_i_E_RegWAddrSel,
    input HU_i_E_GRFWEnable,
	input HU_i_E_MDUBusy,
    input [31:0] HU_i_M_Instr,
    input [31:0] HU_i_M_Instr_Type,
    input [2:0] HU_i_M_RegWAddrSel,
    input HU_i_M_GRFWEnable,
    input [31:0] HU_i_W_Instr,
    input [31:0] HU_i_W_Instr_Type,
    input [2:0] HU_i_W_RegWAddrSel,
    input HU_i_W_GRFWEnable,
    // Stall
    output HU_o_F_IFUEnable,
    output HU_o_D_PRegEnable,
    output HU_o_E_PRegClear,
    // Forward
    output [1:0] HU_o_FwdD_Rs,
	output [1:0] HU_o_FwdD_Rt,
	output [1:0] HU_o_FwdE_Rs,
	output [1:0] HU_o_FwdE_Rt,
	output [1:0] HU_o_FwdM_Rs,
	output [1:0] HU_o_FwdM_Rt
    );

    // stageD_hid Outputs
	wire [4:0] HID_o_D_Rs;
	wire [4:0] HID_o_D_Rt;
	wire [3:0] HID_o_D_TuseRs;
	wire [3:0] HID_o_D_TuseRt;
	wire [3:0] HID_o_D_TnewD;
	wire [4:0] HID_o_D_RegWAddr;
	wire [3:0] HID_o_D_MDU_Usage;
    HID stageD_hid (
		.HID_i_Instr(HU_i_D_Instr), 
		.HID_i_Instr_Type(HU_i_D_Instr_Type), 
		.HID_i_RegWAddrSel(HU_i_D_RegWAddrSel), 
		.HID_o_Rs(HID_o_D_Rs), 
		.HID_o_Rt(HID_o_D_Rt), 
		.HID_o_TuseRs(HID_o_D_TuseRs), 
		.HID_o_TuseRt(HID_o_D_TuseRt), 
		.HID_o_TnewD(HID_o_D_TnewD), 
		.HID_o_RegWAddr(HID_o_D_RegWAddr),
		.HID_o_MDU_Usage(HID_o_D_MDU_Usage)
	);

    // stageE_hid Outputs
	wire [4:0] HID_o_E_Rs;
	wire [4:0] HID_o_E_Rt;
	wire [3:0] HID_o_E_TuseRs;
	wire [3:0] HID_o_E_TuseRt;
	wire [3:0] HID_o_E_TnewD;
	wire [4:0] HID_o_E_RegWAddr;
	wire [3:0] HID_o_E_MDU_Usage;
    HID stageE_hid (
		.HID_i_Instr(HU_i_E_Instr), 
		.HID_i_Instr_Type(HU_i_E_Instr_Type), 
		.HID_i_RegWAddrSel(HU_i_E_RegWAddrSel), 
		.HID_o_Rs(HID_o_E_Rs), 
		.HID_o_Rt(HID_o_E_Rt), 
		.HID_o_TuseRs(HID_o_E_TuseRs), 
		.HID_o_TuseRt(HID_o_E_TuseRt), 
		.HID_o_TnewD(HID_o_E_TnewD), 
		.HID_o_RegWAddr(HID_o_E_RegWAddr),
		.HID_o_MDU_Usage(HID_o_E_MDU_Usage)
	);

    // stageM_hid Outputs
	wire [4:0] HID_o_M_Rs;
	wire [4:0] HID_o_M_Rt;
	wire [3:0] HID_o_M_TuseRs;
	wire [3:0] HID_o_M_TuseRt;
	wire [3:0] HID_o_M_TnewD;
	wire [4:0] HID_o_M_RegWAddr;
    HID stageM_hid (
		.HID_i_Instr(HU_i_M_Instr), 
		.HID_i_Instr_Type(HU_i_M_Instr_Type), 
		.HID_i_RegWAddrSel(HU_i_M_RegWAddrSel), 
		.HID_o_Rs(HID_o_M_Rs), 
		.HID_o_Rt(HID_o_M_Rt), 
		.HID_o_TuseRs(HID_o_M_TuseRs), 
		.HID_o_TuseRt(HID_o_M_TuseRt), 
		.HID_o_TnewD(HID_o_M_TnewD), 
		.HID_o_RegWAddr(HID_o_M_RegWAddr)
		//.HID_o_MDU_Usage()
	);

    // stageW_hid Outputs
	wire [4:0] HID_o_W_Rs;
	wire [4:0] HID_o_W_Rt;
	wire [3:0] HID_o_W_TuseRs;
	wire [3:0] HID_o_W_TuseRt;
	wire [3:0] HID_o_W_TnewD;
	wire [4:0] HID_o_W_RegWAddr;
    HID stageW_hid (
		.HID_i_Instr(HU_i_W_Instr), 
		.HID_i_Instr_Type(HU_i_W_Instr_Type), 
		.HID_i_RegWAddrSel(HU_i_W_RegWAddrSel), 
		.HID_o_Rs(HID_o_W_Rs), 
		.HID_o_Rt(HID_o_W_Rt), 
		.HID_o_TuseRs(HID_o_W_TuseRs), 
		.HID_o_TuseRt(HID_o_W_TuseRt), 
		.HID_o_TnewD(HID_o_W_TnewD), 
		.HID_o_RegWAddr(HID_o_W_RegWAddr)
		//.HID_o_MDU_Usage()
	);

	// == Real Tnew at current stage ==
	wire [3:0] E_Tnew;
	wire [3:0] M_Tnew;
	// ================================


    // Stall Control
    // Stall Control Outputs
    // because any instruction that does not produce a new value has a Tnew
    // of 0, so won't stall, so there is no need to specify WEnable
	wire SCU_o_Stall;
	// == Real Tnew at current stage ==
	assign E_Tnew = (HID_o_E_TnewD > 4'd0) ? (HID_o_E_TnewD - 4'd1) : 4'd0;
	assign M_Tnew = (HID_o_M_TnewD > 4'd1) ? (HID_o_M_TnewD - 4'd2) : 4'd0;
	
	StallControlUnit scu (
		.SCU_i_D_Rs(HID_o_D_Rs), 
		.SCU_i_D_Rt(HID_o_D_Rt), 
		.SCU_i_D_TuseRs(HID_o_D_TuseRs), 
		.SCU_i_D_TuseRt(HID_o_D_TuseRt), 
		.SCU_i_D_MDU_Usage(HID_o_D_MDU_Usage),
		// !! ATTENTION: E_Tnew and M_Tnew should be Tnew on their respective stage !!
		.SCU_i_E_Tnew(E_Tnew), 
		.SCU_i_E_WAddr(HID_o_E_RegWAddr),
		.SCU_i_E_MDU_Usage(HID_o_E_MDU_Usage),
		.SCU_i_E_MDU_Busy(HU_i_E_MDUBusy),
		.SCU_i_M_Tnew(M_Tnew), 
		.SCU_i_M_WAddr(HID_o_M_RegWAddr), 
		.SCU_o_Stall(SCU_o_Stall)
	);
	// === Decleared in I/O Ports ===
    assign HU_o_F_IFUEnable = !SCU_o_Stall;
    assign HU_o_D_PRegEnable = !SCU_o_Stall;
    assign HU_o_E_PRegClear = SCU_o_Stall;


    // Foward Control Unit
    // FCU Outputs
    // Decleared in I/O ports part
    // =========================
	// wire [1:0] FCU_o_FwdD_Rs;
	// wire [1:0] FCU_o_FwdD_Rt;
	// wire [1:0] FCU_o_FwdE_Rs;
	// wire [1:0] FCU_o_FwdE_Rt;
	// wire [1:0] FCU_o_FwdM_Rs;
	// wire [1:0] FCU_o_FwdM_Rt;
    // =========================

	
	ForwardConrtolUnit fcu (
		.FCU_i_D_Rs(HID_o_D_Rs), 
		.FCU_i_D_Rt(HID_o_D_Rt), 
		.FCU_i_E_Rs(HID_o_E_Rs), 
		.FCU_i_E_Rt(HID_o_E_Rt), 
		.FCU_i_M_Rs(HID_o_M_Rs), 
		.FCU_i_M_Rt(HID_o_M_Rt), 
		.FCU_i_E_WAddr(HID_o_E_RegWAddr), 
		.FCU_i_M_WAddr(HID_o_M_RegWAddr), 
		.FCU_i_W_WAddr(HID_o_W_RegWAddr), 
		.FCU_i_E_WEnable(HU_i_E_GRFWEnable), 
		.FCU_i_M_WEnable(HU_i_M_GRFWEnable), 
		.FCU_i_W_WEnable(HU_i_W_GRFWEnable), 
		.FCU_i_E_Tnew(E_Tnew), 
		.FCU_i_M_Tnew(M_Tnew), 
		.FCU_o_FwdD_Rs(HU_o_FwdD_Rs), 
		.FCU_o_FwdD_Rt(HU_o_FwdD_Rt), 
		.FCU_o_FwdE_Rs(HU_o_FwdE_Rs), 
		.FCU_o_FwdE_Rt(HU_o_FwdE_Rt), 
		.FCU_o_FwdM_Rs(HU_o_FwdM_Rs), 
		.FCU_o_FwdM_Rt(HU_o_FwdM_Rt)
	);


endmodule
