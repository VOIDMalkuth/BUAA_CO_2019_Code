`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:13:10 12/11/2019 
// Design Name: 
// Module Name:    ExcChecker 
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

module ExcChecker(
    input [4:0] EC_i_E_ExcCode,
    input EC_i_DM_WEnable,
    input EC_i_DM_REnable,
    input [31:0] EC_i_Addr,
    input [3:0] EC_i_DM_Mode,
    input EC_i_Unaligned,
    output [4:0] EC_o_ExcCode
    );

    wire inTimerRange = (EC_i_Addr >= 32'h7f00 && EC_i_Addr <= 32'h7f0b) ||
                        (EC_i_Addr >= 32'h7f10 && EC_i_Addr <= 32'h7f1b);

    wire inNormalRange = (EC_i_Addr >= 32'h0000 && EC_i_Addr <= 32'h2fff);

    wire haveMemOp = (EC_i_DM_WEnable || EC_i_DM_REnable);

    wire addrUnaligned = haveMemOp && (inNormalRange || inTimerRange) && EC_i_Unaligned;
    wire timerNotWord = haveMemOp && inTimerRange && (EC_i_DM_Mode != `DM_WORD);
    wire notInRange = haveMemOp && (!(inTimerRange || inNormalRange));
    wire addrCalOverflow = haveMemOp && (EC_i_E_ExcCode == `EXC_OV);
    wire writeTimerCnt = haveMemOp && EC_i_DM_WEnable && 
                        ((EC_i_Addr >= 32'h7f08 && EC_i_Addr <= 32'h7f0b) ||
                        (EC_i_Addr >= 32'h7f18 && EC_i_Addr <= 32'h7f1b));

    wire exceptionInM = haveMemOp && (addrUnaligned || timerNotWord || notInRange || addrCalOverflow || writeTimerCnt);

    assign EC_o_ExcCode = (exceptionInM == 1'b1) ? ((EC_i_DM_WEnable == 1'b1) ? `EXC_ADES : `EXC_ADEL) : EC_i_E_ExcCode;

endmodule
