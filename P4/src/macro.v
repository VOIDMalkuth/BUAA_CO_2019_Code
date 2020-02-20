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
// IFU Control
`define IFU_NORMAL 2'b00
`define IFU_BRANCH 2'b01
`define IFU_JUMP 2'b10
`define IFU_JREG 2'b11

// DM bits
`define DM_WORD 2'b00
`define DM_HALF 2'b01
`define DM_BYTE 2'b10

// ALU Operations
`define ALU_ADD 4'd0
`define ALU_SUB 4'd1
`define ALU_OR 4'd2

// EXT Operations
`define EXT_UNSIGNED 2'd0
`define EXT_SIGNED 2'd1
`define EXT_SHIFT 2'd2

// MUX_ALUOp2
`define MUX_ALUOP2_REGSEL 2'd0
`define MUX_ALUOP2_EXTSEL 2'd1

// MUX_RegWAddr
`define MUX_REGWADDR_RDSEL 2'd0
`define MUX_REGWADDR_RTSEL 2'd1
`define MUX_REGWADDR_LINKSEL 2'd2

// MUX_RegWData
`define MUX_REGWDATA_ALUSEL 2'd0
`define MUX_REGWDATA_MEMSEL 2'd1
`define MUX_REGWDATA_LINKSEL 2'd2

// Instruction
`define INSTR_NOP 32'b0
`define INSTR_ADDU 32'b1
`define INSTR_SUBU 32'b10
`define INSTR_ORI 32'b100
`define INSTR_LW 32'b1000
`define INSTR_SW 32'b10000
`define INSTR_BEQ 32'b100000
`define INSTR_LUI 32'b1000000
`define INSTR_JAL 32'b10000000
`define INSTR_JR 32'b100000000

`endif
