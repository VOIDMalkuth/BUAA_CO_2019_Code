`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:51:18 11/23/2019 
// Design Name: 
// Module Name:    StallControl 
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
module StallControlUnit(
    input [4:0] SCU_i_D_Rs,
    input [4:0] SCU_i_D_Rt,
    input [3:0] SCU_i_D_TuseRs,
    input [3:0] SCU_i_D_TuseRt,
    input [3:0] SCU_i_E_Tnew,
    input [4:0] SCU_i_E_WAddr,
    input [3:0] SCU_i_M_Tnew,
    input [4:0] SCU_i_M_WAddr,
    output SCU_o_Stall
    );

    // because any instruction that does not produce a new value has a Tnew
    // of 0, so won't stall

    // Stall condition: (1) read register that are written by E/M stage 
    //                  (2) not reading zero
    //                  (3) can't be forwarded

    // !! ATTENTION: E_Tnew and M_Tnew should be Tnew on their respective stage !!

    wire Stall_DE, Stall_DM;

    assign Stall_DE = (SCU_i_D_Rs == SCU_i_E_WAddr && SCU_i_E_WAddr != 5'b0 && SCU_i_D_TuseRs < SCU_i_E_Tnew)||
                      (SCU_i_D_Rt == SCU_i_E_WAddr && SCU_i_E_WAddr != 5'b0 && SCU_i_D_TuseRt < SCU_i_E_Tnew) ;

    assign Stall_DM = (SCU_i_D_Rs == SCU_i_M_WAddr && SCU_i_M_WAddr != 5'b0 && SCU_i_D_TuseRs < SCU_i_M_Tnew)|| 
                      (SCU_i_D_Rt == SCU_i_M_WAddr && SCU_i_M_WAddr != 5'b0 && SCU_i_D_TuseRt < SCU_i_M_Tnew) ;

    assign SCU_o_Stall = Stall_DE || Stall_DM;

endmodule
