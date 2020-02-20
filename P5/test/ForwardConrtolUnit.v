`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:00 11/23/2019 
// Design Name: 
// Module Name:    ForwardConrtolUnit 
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
`include "macro.v"

module ForwardConrtolUnit(
    input [4:0] FCU_i_D_Rs,
    input [4:0] FCU_i_D_Rt,
    input [4:0] FCU_i_E_Rs,
    input [4:0] FCU_i_E_Rt,
    input [4:0] FCU_i_M_Rs,
    input [4:0] FCU_i_M_Rt,
    input [4:0] FCU_i_E_WAddr,
    input [4:0] FCU_i_M_WAddr,
    input [4:0] FCU_i_W_WAddr,
    input FCU_i_E_WEnable,
    input FCU_i_M_WEnable,
    input FCU_i_W_WEnable,
    input [3:0] FCU_i_E_Tnew,
    input [3:0] FCU_i_M_Tnew,
    output reg [1:0] FCU_o_FwdD_Rs,
    output reg [1:0] FCU_o_FwdD_Rt,
    output reg [1:0] FCU_o_FwdE_Rs,
    output reg [1:0] FCU_o_FwdE_Rt,
    output reg [1:0] FCU_o_FwdM_Rs,
    output reg [1:0] FCU_o_FwdM_Rt
    );

    // no W_Tnew because at WB all is ready
    wire [3:0] FCU_i_W_Tnew = `T_NEW_READY;

    // control FwdD_Rs
    always@(*) begin
        FCU_o_FwdD_Rs = `FWD_DONT_FWD;  // default not to forward, prevents latch
        FCU_o_FwdD_Rt = `FWD_DONT_FWD;  // default not to forward, prevents latch
        FCU_o_FwdE_Rs = `FWD_DONT_FWD;  // default not to forward, prevents latch
        FCU_o_FwdE_Rt = `FWD_DONT_FWD;  // default not to forward, prevents latch
        FCU_o_FwdM_Rs = `FWD_DONT_FWD;  // default not to forward, prevents latch
        FCU_o_FwdM_Rt = `FWD_DONT_FWD;  // default not to forward, prevents latch

        // Forward to D_Rs
        if(FCU_i_D_Rs == FCU_i_E_WAddr && FCU_i_D_Rs != 5'b0 && FCU_i_E_WEnable & FCU_i_E_Tnew == `T_NEW_READY)
            FCU_o_FwdD_Rs = `FWD_EREG_TO_D;
        else if(FCU_i_D_Rs == FCU_i_M_WAddr && FCU_i_D_Rs != 5'b0 && FCU_i_M_WEnable & FCU_i_M_Tnew == `T_NEW_READY)
            FCU_o_FwdD_Rs = `FWD_MREG_TO_D;
        else
            FCU_o_FwdD_Rs = `FWD_DONT_FWD;

        // Forward to D_Rt
        if(FCU_i_D_Rt == FCU_i_E_WAddr && FCU_i_D_Rt != 5'b0 && FCU_i_E_WEnable & FCU_i_E_Tnew == `T_NEW_READY)
            FCU_o_FwdD_Rt = `FWD_EREG_TO_D;
        else if(FCU_i_D_Rt == FCU_i_M_WAddr && FCU_i_D_Rt != 5'b0 && FCU_i_M_WEnable & FCU_i_M_Tnew == `T_NEW_READY)
            FCU_o_FwdD_Rt = `FWD_MREG_TO_D;
        else
            FCU_o_FwdD_Rt = `FWD_DONT_FWD;


        // Forward to E_Rs
        if(FCU_i_E_Rs == FCU_i_M_WAddr && FCU_i_E_Rs != 5'b0 && FCU_i_M_WEnable & FCU_i_M_Tnew == `T_NEW_READY)
            FCU_o_FwdE_Rs = `FWD_MREG_TO_E;
        else if(FCU_i_E_Rs == FCU_i_W_WAddr && FCU_i_E_Rs != 5'b0 && FCU_i_W_WEnable)   // WB is always ready
            FCU_o_FwdE_Rs = `FWD_WREG_TO_E;
        else
            FCU_o_FwdE_Rs = `FWD_DONT_FWD;

        // Forward to E_Rt
        if(FCU_i_E_Rt == FCU_i_M_WAddr && FCU_i_E_Rt != 5'b0 && FCU_i_M_WEnable & FCU_i_M_Tnew == `T_NEW_READY)
            FCU_o_FwdE_Rt = `FWD_MREG_TO_E;
        else if(FCU_i_E_Rt == FCU_i_W_WAddr && FCU_i_E_Rt != 5'b0 && FCU_i_W_WEnable)   // WB is always ready
            FCU_o_FwdE_Rt = `FWD_WREG_TO_E;
        else
            FCU_o_FwdE_Rt = `FWD_DONT_FWD;


        // Forward to M_Rs
        if(FCU_i_M_Rs == FCU_i_W_WAddr && FCU_i_M_Rs != 5'b0 && FCU_i_W_WEnable)   // WB is always ready
            FCU_o_FwdM_Rs = `FWD_WREG_TO_M;
        else
            FCU_o_FwdM_Rs = `FWD_DONT_FWD;

        // Forward to M_Rt
        if(FCU_i_M_Rt == FCU_i_W_WAddr && FCU_i_M_Rt != 5'b0 && FCU_i_W_WEnable)   // WB is always ready
            FCU_o_FwdM_Rt = `FWD_WREG_TO_M;
        else
            FCU_o_FwdM_Rt = `FWD_DONT_FWD;
    end


endmodule
