`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:07 12/10/2019 
// Design Name: 
// Module Name:    CoProcessor0 
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
module CoProcessor0(
    input clk,
    input reset,
    input [4:0] CP0_i_Addr,
    input [31:0] CP0_i_WData,
    input [31:0] CP0_i_PCAtM,
    input [6:2] CP0_i_ExcCode,
    input [5:0] CP0_i_HWInt,
    input CP0_i_isInsertedNop,
    input CP0_i_isBranch,
    input CP0_i_WEnable,
    input CP0_i_EXLClr,
    output CP0_o_IntReq,
    output [31:0] CP0_o_EPC,
    output reg [31:0] CP0_o_RData
    );

    reg [31:0] regSR, regCause, regEPC, regPRId;
    initial begin
        regSR = 0;
        regCause = 0;
        regEPC = 0;
        regPRId = 32'h00000400;
    end

    // Reg output
    always @(*) begin
        case(CP0_i_Addr)
            5'd12: CP0_o_RData = regSR;
            5'd13: CP0_o_RData = regCause;
            5'd14: CP0_o_RData = regEPC;
            5'd15: CP0_o_RData = regPRId;

            default: CP0_o_RData = 32'bx;
        endcase
    end

    parameter regSRWmask = 32'h0000fc03;

    reg inDB = 0;
    // RegUpdate
    always @(posedge clk) begin
        inDB <= (CP0_i_isInsertedNop == 1'b1) ? inDB : CP0_i_isBranch;
        if(reset) begin
            regSR <= 32'h0;
            regCause <= 32'b0;
            regEPC <= 32'b0;
            regPRId <= 32'h00000400;
            inDB <= 1'b0;
        end
        else if(CP0_o_IntReq) begin  // inside interruption or exception
            if(isInterruption) begin
                regCause <= {inDB, 15'b0, finalIntSignal[7:2],3'b0, 5'b0, 2'b0};
            end
            else begin
                regCause <= {inDB, 15'b0, 6'b0, 3'b0, CP0_i_ExcCode[6:2], 2'b0};
            end

            regEPC <= inDB ? ({CP0_i_PCAtM[31:2], 2'b0} - 32'd4) : ({CP0_i_PCAtM[31:2], 2'b0});
            regSR <= regSR | 32'd2;
        end
        else if(CP0_i_EXLClr) begin
            regSR <= regSR & 32'hfffffffd;
        end
        else if(CP0_i_WEnable && (!CP0_o_IntReq)) begin    // not in intreq so that mtc0 at interruption won't write
            case(CP0_i_Addr)
                5'd12: regSR <= CP0_i_WData & regSRWmask;
                5'd14: regEPC <= CP0_i_WData;
                // no default
            endcase
        end
    end

    // some useful part
    wire [7:2] SR_IM = regSR[15:10];
    wire SR_EXL = regSR[1];
    wire SR_IE = regSR[0];

    // handle the IntReq Out
    wire [7:2] finalIEnable = {6{SR_IE}} & {6{~SR_EXL}} & SR_IM[7:2];
    wire [7:2] finalIntSignal = CP0_i_HWInt[5:0] & finalIEnable[7:2];
    wire isInterruption = (|finalIntSignal);
    wire isException = (CP0_i_ExcCode != 5'b0);
    assign CP0_o_IntReq = isInterruption || isException;

    assign CP0_o_EPC = (CP0_i_WEnable && CP0_i_Addr == 5'd14) ? CP0_i_WData : regEPC;

endmodule
