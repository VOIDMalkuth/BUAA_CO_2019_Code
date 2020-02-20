`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:55:34 11/14/2019 
// Design Name: 
// Module Name:    EXT 
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

module EXT(
    input [15:0] EXT_i_Input,
    input [1:0] EXT_i_Mode,
    output reg [31:0] EXT_o_Output
    );

    always@(*) begin
        case(EXT_i_Mode)
            `EXT_UNSIGNED: EXT_o_Output = {16'b0, EXT_i_Input};
            `EXT_SIGNED: EXT_o_Output = {{16{EXT_i_Input[15]}}, EXT_i_Input};

            default: EXT_o_Output = 32'bx;
        endcase
    end


endmodule
