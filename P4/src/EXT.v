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
    input [15:0] EXT_Input,
    input [1:0] EXT_Mode,
    output reg [31:0] EXT_Output
    );

    always@(*) begin
        case(EXT_Mode)
            `EXT_UNSIGNED: EXT_Output = {16'b0, EXT_Input};
            `EXT_SIGNED: EXT_Output = {{16{EXT_Input[15]}}, EXT_Input};
            `EXT_SHIFT: EXT_Output = {EXT_Input[15:0], 16'b0};

            default: EXT_Output = 32'bx;
        endcase
    end


endmodule
