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

// CMP Modes
// 0 for noting
`define CMP_NOOP 4'd0
`define CMP_EQ 4'd1
`define CMP_NEQ 4'd2
`define CMP_LEZ 4'd3
`define CMP_GEZ 4'd4
`define CMP_LZ 4'd5
`define CMP_GZ 4'd6

// DM bits
`define DM_WORD 4'd0
`define DM_HALF 4'd1
`define DM_BYTE 4'd2
`define DM_HALF_UNSIGNED 4'd3
`define DM_BYTE_UNSIGNED 4'd4

// ALU Operations
`define ALU_ADDU 8'd0
`define ALU_ADD 8'd1
`define ALU_SUBU 8'd2
`define ALU_SUB 8'd3
`define ALU_AND 8'd4
`define ALU_OR 8'd5
`define ALU_XOR 8'd6
`define ALU_NOR 8'd7
`define ALU_SLL 8'd8
`define ALU_SRL 8'd9
`define ALU_SRA 8'd10
`define ALU_SLT 8'd11
`define ALU_SLTU 8'd12
`define ALU_LUI 8'd13

// EXT Operations
`define EXT_UNSIGNED 2'd0
`define EXT_SIGNED 2'd1


// MUX_ALUOp1
`define MUX_ALUOP1_RSSEL 3'd0
`define MUX_ALUOP1_SHAMTSEL 3'd1

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

// MUX_EALUOutData
`define MUX_EALU_ODATA_ALUSEL 3'd0
`define MUX_EALU_ODATA_HISEL 3'd1
`define MUX_EALU_ODATA_LOSEL 3'd2

// Instruction
`define INSTR_NOP   32'd0
`define INSTR_LB    32'd1
`define INSTR_LBU   32'd2
`define INSTR_LH    32'd3
`define INSTR_LHU   32'd4
`define INSTR_LW    32'd5

`define INSTR_SB    32'd6
`define INSTR_SH    32'd7
`define INSTR_SW    32'd8

`define INSTR_ADD   32'd9
`define INSTR_ADDU  32'd10
`define INSTR_SUB   32'd11
`define INSTR_SUBU  32'd12
`define INSTR_MULT  32'd13
`define INSTR_MULTU 32'd14
`define INSTR_DIV   32'd15
`define INSTR_DIVU  32'd16
`define INSTR_SLL   32'd17
`define INSTR_SRL   32'd18
`define INSTR_SRA   32'd19
`define INSTR_SLLV  32'd20
`define INSTR_SRLV  32'd21
`define INSTR_SRAV  32'd22
`define INSTR_AND   32'd23
`define INSTR_OR    32'd24
`define INSTR_XOR   32'd25
`define INSTR_NOR   32'd26
`define INSTR_SLT   32'd27
`define INSTR_SLTU  32'd28

`define INSTR_ADDI  32'd29
`define INSTR_ADDIU 32'd30
`define INSTR_ANDI  32'd31
`define INSTR_ORI   32'd32
`define INSTR_XORI  32'd33
`define INSTR_LUI   32'd34
`define INSTR_SLTI  32'd35
`define INSTR_SLTIU 32'd36

`define INSTR_BEQ   32'd37
`define INSTR_BNE   32'd38
`define INSTR_BLEZ  32'd39
`define INSTR_BGTZ  32'd40
`define INSTR_BLTZ  32'd41
`define INSTR_BGEZ  32'd42

`define INSTR_J     32'd43
`define INSTR_JAL   32'd44
`define INSTR_JALR  32'd45
`define INSTR_JR    32'd46

`define INSTR_MFHI  32'd47
`define INSTR_MFLO  32'd48
`define INSTR_MTHI  32'd49
`define INSTR_MTLO  32'd50

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

// Multiply Divide Unit
// Busy Signal, delay time
`define MDU_NOOP 4'd0
`define MDU_MULT 4'd1
`define MDU_MULTU 4'd2
`define MDU_DIV 4'd3
`define MDU_DIVU 4'd4
`define MDU_MTHI 4'd5
`define MDU_MTLO 4'd6
// for convenience in stall
`define MDU_READ 4'd7

// MDU in Hazard
`define SCU_MDU_USAGE_NOMDU 4'd0
`define SCU_MDU_USAGE_NOSTALL 4'd1
`define SCU_MDU_USAGE_STALL 4'd2



`endif
