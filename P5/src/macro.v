`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:05:23 11/12/2019 
// Design Name: 
// Module Name:    macro 
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

`ifndef _MACRO
`define _MACRO
// NPC Control
`define NPC_NORMAL 3'b00
`define NPC_BRANCH 3'b01
`define NPC_JUMP 3'b10
`define NPC_JREG 3'b11

// DM bits
`define DM_WORD 2'b00
`define DM_HALF 2'b01
`define DM_BYTE 2'b10

// ALU Operations
`define ALU_ADD 4'd0
`define ALU_SUB 4'd1
`define ALU_OR 4'd2
`define ALU_LUI 4'd3

// EXT Operations
`define EXT_UNSIGNED 2'd0
`define EXT_SIGNED 2'd1


// MUX_ALUOp2
`define MUX_ALUOP2_REGSEL 3'd0
`define MUX_ALUOP2_EXTSEL 3'd1

// MUX_RegWAddr
`define MUX_REGWADDR_RDSEL 3'd0
`define MUX_REGWADDR_RTSEL 3'd1
`define MUX_REGWADDR_LINKSEL 3'd2

// MUX_RegWData
`define MUX_REGWDATA_ALUSEL 3'd0
`define MUX_REGWDATA_MEMSEL 3'd1
`define MUX_REGWDATA_LINKSEL 3'd2

// Instruction
`define INSTR_NOP 32'd0
`define INSTR_ADDU 32'd1
`define INSTR_SUBU 32'd2
`define INSTR_ORI 32'd3
`define INSTR_LW 32'd4
`define INSTR_SW 32'd5
`define INSTR_BEQ 32'd6
`define INSTR_LUI 32'd7
`define INSTR_JAL 32'd8
`define INSTR_JR 32'd9
`define INSTR_J 32'd10

// HID
`define T_USE_AT_D 4'd0
`define T_USE_AT_E 4'd1
`define T_USE_AT_M 4'd2
`define T_USE_NEVER_READ 4'd5

`define T_NEW_NO_NEW 4'd0   // for instruction
`define T_NEW_READY 4'd0    // same as no new, for clearity in coding
`define T_NEW_AT_ID_EX 4'd1
`define T_NEW_AT_EX_MEM 4'd2
`define T_NEW_AT_MEM_WB 4'd3

// Forward Ctrl
`define FWD_DONT_FWD 2'd0

`define FWD_EREG_TO_D 2'd1
`define FWD_MREG_TO_D 2'd2

`define FWD_MREG_TO_E 2'd1
`define FWD_WREG_TO_E 2'd2

`define FWD_WREG_TO_M 2'd1

`endif
