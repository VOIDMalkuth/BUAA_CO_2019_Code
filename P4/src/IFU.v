`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:10:23 11/13/2019 
// Design Name: 
// Module Name:    IFU 
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

module nPC(
    input [31:0] nPC_pc,
    input [15:0] nPC_offset,
    input [25:0] nPC_addr_j,
    input [31:0] nPC_addr_reg,
    input [1:0] nPC_control,
    output reg [31:0] nPC_npc,
    output [31:0] nPC_pc_plus_4
    );

    assign nPC_pc_plus_4 = nPC_pc + 32'd4;

    always@(*) begin
        case (nPC_control)
            `IFU_NORMAL: nPC_npc = nPC_pc_plus_4;
            `IFU_BRANCH: nPC_npc = nPC_pc_plus_4 + {{14{nPC_offset[15]}}, nPC_offset[15:0], 2'b0};
            `IFU_JUMP: nPC_npc = {nPC_pc_plus_4[31:28], nPC_addr_j[25:0], 2'b0};
            `IFU_JREG: nPC_npc = nPC_addr_reg;
            default: nPC_npc = 32'bz;
        endcase
    end


endmodule


module IM(
    input [31:0] PC,
    output [31:0] Instr
    );

    parameter offset = 32'h00003000;
    parameter IM_SIZE = 32'd1024;

    wire [31:0] offsetedAddress;
    reg [31:0] I_Memory[IM_SIZE - 1:0];
    
    integer i;  // varible for initial 
    initial begin
        for (i = 0; i < IM_SIZE; i = i + 1)
            I_Memory[i] = 0;

        $readmemh("code.txt", I_Memory, 0, IM_SIZE - 1);
    end

    assign offsetedAddress = (PC - offset) >> 2;
    
    assign Instr = I_Memory[offsetedAddress];

endmodule


module IFU(
    input clk,
    input reset,
    input [1:0] IFU_Control,
    input [15:0] IFU_Offset,
    input [25:0] IFU_JAddr,
    input [31:0] IFU_RegAddr,
    output [31:0] Instr,
    output [31:0] IFU_PC_plus_4
    );

    parameter initialAddress = 32'h00003000;

    reg [31:0] pc = initialAddress;
    
    wire [31:0] nPC_npc;

    nPC IFU_nPC (
		.nPC_pc(pc), 
		.nPC_offset(IFU_Offset), 
		.nPC_addr_j(IFU_JAddr), 
		.nPC_addr_reg(IFU_RegAddr), 
		.nPC_control(IFU_Control), 
		.nPC_npc(nPC_npc),
        .nPC_pc_plus_4(IFU_PC_plus_4)
	);

    IM IFU_IM (
        .PC(pc),
        .Instr(Instr)
    );

    always @(posedge clk ) begin
        if(reset)
            pc <= initialAddress;
        else
            pc <= nPC_npc;
    end


endmodule

module IFUCG(
    input [1:0] IFUCG_Mode ,
    input IFUCG_isConditional,
    input IFUCG_Condition,
    output [1:0] IFUCG_Output
    );

    assign IFUCG_Output = IFUCG_isConditional?(IFUCG_Condition == 1?IFUCG_Mode:`IFU_NORMAL):IFUCG_Mode;

endmodule