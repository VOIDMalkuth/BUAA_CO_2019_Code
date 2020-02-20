`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:03:11 11/13/2019 
// Design Name: 
// Module Name:    DM 
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

module DM_BE_Decoder(
    input [1:0] DMBD_i_Addr,
    input [3:0] DMBD_i_Mode,
    output DMBD_o_Unaligned,
    output reg [3:0] DMBD_o_ByteEn
    );

    assign DMBD_o_Unaligned = (DMBD_i_Mode == `DM_WORD && DMBD_i_Addr != 2'b0) ||
                              ((DMBD_i_Mode == `DM_HALF || DMBD_i_Mode == `DM_HALF_UNSIGNED) && DMBD_i_Addr[0] != 1'b0);

    always@(*) begin
        case(DMBD_i_Mode)
            `DM_WORD: DMBD_o_ByteEn = 4'b1111;
            `DM_HALF: DMBD_o_ByteEn = { {2{DMBD_i_Addr[1] == 1'b1}} , {2{DMBD_i_Addr[1] == 1'b0}} };
            `DM_BYTE: DMBD_o_ByteEn = {(DMBD_i_Addr == 2'd3), (DMBD_i_Addr == 2'd2),
                                        (DMBD_i_Addr == 2'd1), (DMBD_i_Addr == 2'd0)};

            // be 0 only on byteunsigned/halfunsigned because save ins won't generate
            // such signals
            default: DMBD_o_ByteEn = 4'b0000;
        endcase
    end

endmodule

module DM_Core(
    input reset,
    input clk,
    input [31:0] DMC_i_WordAlignedAddr,
    input [31:0] DMC_i_WData,
    input [3:0] DMC_i_ByteEn,
    input [31:0] DMC_i_PC,
    output [31:0] DMC_o_Data
    );

    parameter SIZE = 32'd4096;

    reg [31:0] D_Memory[SIZE - 1:0];

    integer i;
    initial begin
        for(i = 0; i < SIZE; i = i + 1) begin
            D_Memory[i] = 0;
        end
    end

    wire [31:0] realWData;
    assign realWData[7:0] = (DMC_i_ByteEn[0] == 1'b1) ? DMC_i_WData[7:0] : D_Memory[DMC_i_WordAlignedAddr >> 2][7:0];
    assign realWData[15:8] = (DMC_i_ByteEn[1] == 1'b1) ? DMC_i_WData[15:8] : D_Memory[DMC_i_WordAlignedAddr >> 2][15:8];
    assign realWData[23:16] = (DMC_i_ByteEn[2] == 1'b1) ? DMC_i_WData[23:16] : D_Memory[DMC_i_WordAlignedAddr >> 2][23:16];
    assign realWData[31:24] = (DMC_i_ByteEn[3] == 1'b1) ? DMC_i_WData[31:24] : D_Memory[DMC_i_WordAlignedAddr >> 2][31:24];

    always @(posedge clk) begin
        if(reset) begin
            for(i = 0; i < SIZE; i = i + 1) begin
                D_Memory[i] <= 0;
            end
        end
        else if(DMC_i_ByteEn != 4'b0) begin
            D_Memory[DMC_i_WordAlignedAddr >> 2] <= realWData[31:0];
            $display("%d@%h: *%h <= %h", $time, DMC_i_PC, DMC_i_WordAlignedAddr, realWData[31:0]);
        end
    end

    assign DMC_o_Data = D_Memory[DMC_i_WordAlignedAddr >> 2];

endmodule

module DM_Extender(
    input [1:0] DME_i_Addr,
    input [31:0] DME_i_Data,
    input [3:0] DME_i_Mode,
    output reg [31:0] DME_o_Output
    );

    wire [15:0] tmp_halfword [1:0];
    wire [7:0] tmp_byte[3:0];

    assign {tmp_halfword[1], tmp_halfword[0]} = DME_i_Data;
    assign {tmp_byte[3], tmp_byte[2], tmp_byte[1], tmp_byte[0]} = DME_i_Data;

    always@(*) begin
        case(DME_i_Mode)
            `DM_WORD: DME_o_Output = DME_i_Data;
            `DM_HALF: DME_o_Output = { {16{tmp_halfword[DME_i_Addr[1]][15]}}, tmp_halfword[DME_i_Addr[1]] };
            `DM_HALF_UNSIGNED: DME_o_Output = { 16'b0, tmp_halfword[DME_i_Addr[1]] };
            `DM_BYTE: DME_o_Output = { {24{tmp_byte[DME_i_Addr[1:0]][7]}} , tmp_byte[DME_i_Addr[1:0]] };
            `DM_BYTE_UNSIGNED: DME_o_Output = { 24'b0 , tmp_byte[DME_i_Addr[1:0]] };

            default: DME_o_Output = DME_i_Data;
        endcase
    end
endmodule

module DM(
    input clk,
    input reset,
    input DM_i_WEnable,
    input [3:0] DM_i_Mode,
    input [31:0] DM_i_Addr,
    input [31:0] DM_i_WData,
    input [31:0] DM_i_PC,
    input [31:0] DM_i_PrRD,
    output [31:0] DM_o_RData,
    output DM_o_Unaligned,
    output [31:0] DM_o_PrAddr,
    output [3:0] DM_o_PrBE,
    output [31:0] DM_o_PrWD,
    output DM_o_PrWE
    );

    // DMBD Outputs
	wire [3:0] DMBD_o_ByteEn;
	wire DMBD_o_Unaligned;

    DM_BE_Decoder DM_DMBE (
		.DMBD_i_Addr(DM_i_Addr[1:0]), 
		.DMBD_i_Mode(DM_i_Mode), 
		.DMBD_o_Unaligned(DMBD_o_Unaligned),
		.DMBD_o_ByteEn(DMBD_o_ByteEn)
	);

    // core memory inputs
    wire inDMRange = DM_i_Addr >= 32'h0000 && DM_i_Addr <= 32'h2fff;
    wire inTimerRange = (DM_i_Addr >= 32'h7f00 && DM_i_Addr <= 32'h7f0b) ||
                        (DM_i_Addr >= 32'h7f10 && DM_i_Addr <= 32'h7f1b);
    wire [3:0] DMC_i_ByteEn = (inDMRange && DM_i_WEnable) ? DMBD_o_ByteEn : 4'b0;
    reg [31:0] DMC_i_WData;
    // core memory outputs
    wire [31:0] DMC_o_Data;

    // shiftData:
    always @(*) begin
        case(DM_i_Mode)
            `DM_WORD: DMC_i_WData = DM_i_WData;
            `DM_HALF, `DM_HALF_UNSIGNED: DMC_i_WData = DM_i_WData << (DM_i_Addr[1]*16);
            `DM_BYTE, `DM_BYTE_UNSIGNED: DMC_i_WData = DM_i_WData << (DM_i_Addr[1:0]*8);

            default: DMC_i_WData = DM_i_WData;
        endcase
    end
    DM_Core DM_coreMemory(
        .reset(reset),
        .clk(clk),
        .DMC_i_WordAlignedAddr({DM_i_Addr[31:2], 2'b0}),
        .DMC_i_WData(DMC_i_WData),
        .DMC_i_ByteEn(DMC_i_ByteEn),
        .DMC_i_PC(DM_i_PC),
        .DMC_o_Data(DMC_o_Data)
    );

    // DME Outputs
	wire [31:0] DME_o_Output;
    DM_Extender DM_DME (
		.DME_i_Addr(DM_i_Addr[1:0]), 
		.DME_i_Data(DMC_o_Data), 
		.DME_i_Mode(DM_i_Mode), 
		.DME_o_Output(DME_o_Output)
	);

    // =================== Bridge Part ====================
    assign DM_o_PrAddr = DM_i_Addr;
    assign DM_o_PrBE = (inTimerRange && DM_i_WEnable) ? DMBD_o_ByteEn : 4'b0;
    assign DM_o_PrWD = DMC_i_WData; // shifted
    assign DM_o_PrWE = (inTimerRange && DM_i_WEnable);
    // ====================================================

    assign DM_o_RData = inDMRange ? DME_o_Output : (inTimerRange ? DM_i_PrRD : 32'bx);
    assign DM_o_Unaligned = DMBD_o_Unaligned;

endmodule

// old version 
/*
module DM(
    input clk,
    input reset,
    input DM_i_WEnable,
    input [3:0] DM_i_Mode,
    input [31:0] DM_i_Addr,
    input [31:0] DM_i_WData,
    input [31:0] DM_i_PC,
    output [31:0] DM_o_RData
    );

    parameter DM_SIZE = 32'd16384;

    reg [7:0] D_Memory[DM_SIZE - 1:0];
    reg [31:0] DM_RData_TMP;

    integer i;
    initial begin
        for (i = 0; i < DM_SIZE; i = i + 1)
            D_Memory[i] = 0;
    end

    wire [31:0] alignedAddr = (DM_i_Mode == `DM_WORD)? {DM_i_Addr[31:2], 2'b00} :
                        ((DM_i_Mode == `DM_HALF)? {DM_i_Addr[31:1], 1'b0} : DM_i_Addr);

    wire [31:0] wordAlignedAddr = {DM_i_Addr[31:2],2'b00};

    always@(*) begin
        case(DM_i_Mode)
            `DM_WORD: DM_RData_TMP = {D_Memory[alignedAddr+32'd3], D_Memory[alignedAddr+32'd2], D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]};
            `DM_HALF: DM_RData_TMP = {{16{D_Memory[alignedAddr+32'd1][7]}},D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]};
            `DM_BYTE: DM_RData_TMP = {{24{D_Memory[alignedAddr][7]}},D_Memory[alignedAddr]};
            `DM_HALF_UNSIGNED: DM_RData_TMP = {16'b0, D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]};
            `DM_BYTE_UNSIGNED: DM_RData_TMP = {24'b0,D_Memory[alignedAddr]};

            default: DM_RData_TMP = 32'bx;
        endcase
    end

    always @(posedge clk ) begin
        if(reset) begin
            for (i = 0; i < DM_SIZE; i = i + 1)
                D_Memory[i] <= 0;
        end
        else if(DM_i_WEnable) begin
            case(DM_i_Mode)
                `DM_WORD: begin
                    {D_Memory[alignedAddr+32'd3], D_Memory[alignedAddr+32'd2], D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]} <= DM_i_WData[31:0];
                    $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, DM_i_WData[31:0]);
                end

                `DM_HALF: begin
                    {D_Memory[alignedAddr+32'd1], D_Memory[alignedAddr]} <= DM_i_WData[15:0];
                    case(DM_i_Addr[1])  // ! when Save Half it is addr[1] that matters, addr[0] will always be 0 !
                        1'b0: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {D_Memory[wordAlignedAddr + 3], D_Memory[wordAlignedAddr + 2], DM_i_WData[15:0]});
                        1'b1: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {DM_i_WData[15:0], D_Memory[wordAlignedAddr + 1], D_Memory[wordAlignedAddr]});
                    endcase
                end

                `DM_BYTE: begin
                    D_Memory[alignedAddr] <= DM_i_WData[7:0];
                    case(DM_i_Addr[1:0])
                        2'b00: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {D_Memory[wordAlignedAddr + 3], D_Memory[wordAlignedAddr + 2], D_Memory[wordAlignedAddr + 1], DM_i_WData[7:0]});
                        2'b01: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {D_Memory[wordAlignedAddr + 3], D_Memory[wordAlignedAddr + 2], DM_i_WData[7:0], D_Memory[wordAlignedAddr]});
                        2'b10: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {D_Memory[wordAlignedAddr + 3], DM_i_WData[7:0], D_Memory[wordAlignedAddr + 1], D_Memory[wordAlignedAddr]});
                        2'b11: $display("%d@%h: *%h <= %h", $time, DM_i_PC, wordAlignedAddr, {DM_i_WData[7:0], D_Memory[wordAlignedAddr + 2], D_Memory[wordAlignedAddr + 1], D_Memory[wordAlignedAddr]});
                    endcase
                end
                // no default
            endcase
        end
    end

    assign DM_o_RData = DM_RData_TMP;

endmodule
*/