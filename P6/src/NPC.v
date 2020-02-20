`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:54 11/23/2019 
// Design Name: 
// Module Name:    NPC 
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

module NPC(
    input [31:0] NPC_i_PC,
    input [25:0] NPC_i_Immediate,
    input [31:0] NPC_i_RegAddr,
    input [2:0] NPC_i_Mode,
    input NPC_i_Condition,
    output reg [31:0] NPC_o_nPC
    );

    // ATTENTION: IMMEDIATE is 26Bit!

    wire [31:0] PC_plus_4;
    assign PC_plus_4 = NPC_i_PC + 32'd4;

    always@(*) begin
        case (NPC_i_Mode)
            `NPC_NORMAL: NPC_o_nPC = PC_plus_4;
            `NPC_BRANCH: NPC_o_nPC = (NPC_i_Condition == 1) ? NPC_i_PC + {{14{NPC_i_Immediate[15]}}, NPC_i_Immediate[15:0], 2'b0}:
                                                              PC_plus_4;
            `NPC_JUMP: NPC_o_nPC = {NPC_i_PC[31:28], NPC_i_Immediate[25:0], 2'b0};
            `NPC_JREG: NPC_o_nPC = NPC_i_RegAddr;
            default: NPC_o_nPC = 32'bz;
        endcase
    end


endmodule