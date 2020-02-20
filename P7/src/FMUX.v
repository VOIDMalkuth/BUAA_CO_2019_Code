`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:55:54 11/23/2019 
// Design Name: 
// Module Name:    FMUX_D 
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

module FMUX_D(
    input [31:0] FMUX_D_i_DIn,
    input [31:0] FMUX_D_i_ERegIn,
    input [31:0] FMUX_D_i_MRegIn,
    input [1:0] FMUX_D_i_FwdCtrl,
    output reg [31:0] FMUX_D_o_correctedVal
    );

    always @(*) begin
        case(FMUX_D_i_FwdCtrl)
            `FWD_DONT_FWD: FMUX_D_o_correctedVal = FMUX_D_i_DIn;
            `FWD_EREG_TO_D: FMUX_D_o_correctedVal = FMUX_D_i_ERegIn;
            `FWD_MREG_TO_D: FMUX_D_o_correctedVal = FMUX_D_i_MRegIn;
            // forward from Wreg is done in GRF
            default: FMUX_D_o_correctedVal = FMUX_D_i_DIn;
        endcase
    end

endmodule

module FMUX_E(
    input [31:0] FMUX_E_i_EIn,
    input [31:0] FMUX_E_i_MRegIn,
    input [31:0] FMUX_E_i_WRegIn,
    input [1:0] FMUX_E_i_FwdCtrl,
    output reg [31:0] FMUX_E_o_correctedVal
    );

    always @(*) begin
        case(FMUX_E_i_FwdCtrl)
            `FWD_DONT_FWD: FMUX_E_o_correctedVal = FMUX_E_i_EIn;
            `FWD_MREG_TO_E: FMUX_E_o_correctedVal = FMUX_E_i_MRegIn;
            `FWD_WREG_TO_E: FMUX_E_o_correctedVal = FMUX_E_i_WRegIn;
            // forward from Wreg is done in GRF
            default: FMUX_E_o_correctedVal = FMUX_E_i_EIn;
        endcase
    end

endmodule

module FMUX_M(
    input [31:0] FMUX_M_i_MIn,
    input [31:0] FMUX_M_i_WRegIn,
    input [1:0] FMUX_M_i_FwdCtrl,
    output reg [31:0] FMUX_M_o_correctedVal
    );

    always @(*) begin
        case(FMUX_M_i_FwdCtrl)
            `FWD_DONT_FWD: FMUX_M_o_correctedVal = FMUX_M_i_MIn;
            `FWD_WREG_TO_M: FMUX_M_o_correctedVal = FMUX_M_i_WRegIn;

            default: FMUX_M_o_correctedVal = FMUX_M_i_MIn;
        endcase
    end

endmodule
