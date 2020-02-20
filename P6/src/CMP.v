`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:18 12/02/2019 
// Design Name: 
// Module Name:    CMP 
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

module CMP(
    input [31:0] CMP_i_RsIn,
    input [31:0] CMP_i_RtIn,
    input [3:0] CMP_i_Mode,
    output reg CMP_o_Output
    );

    always @(*) begin
        case(CMP_i_Mode)
            `CMP_EQ: CMP_o_Output = (CMP_i_RsIn == CMP_i_RtIn)?1'b1:1'b0;
            `CMP_NEQ: CMP_o_Output = (CMP_i_RsIn != CMP_i_RtIn)?1'b1:1'b0;
            `CMP_LEZ: CMP_o_Output = ($signed(CMP_i_RsIn) <= $signed(0))?1'b1:1'b0;
            `CMP_GEZ: CMP_o_Output = ($signed(CMP_i_RsIn) >= $signed(0))?1'b1:1'b0;
            `CMP_LZ: CMP_o_Output = ($signed(CMP_i_RsIn) < $signed(0))?1'b1:1'b0;
            `CMP_GZ: CMP_o_Output = ($signed(CMP_i_RsIn) > $signed(0))?1'b1:1'b0;

            default: CMP_o_Output = 1'b0;
        endcase
    end


endmodule
