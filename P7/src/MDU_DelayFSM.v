`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:39 12/01/2019 
// Design Name: 
// Module Name:    MDU_DelayFSM 
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

module MDU_DelayFSM(
    input clk,
    input reset,
    input [3:0] MDU_DelayFSM_i_Mode,
    output MDU_DelayFSM_o_Busy,
    output MDU_DelayFSM_o_dataReady
    );

    reg [31:0] counter = 0;
    reg [31:0] delay;

    always @(*) begin
        case(MDU_DelayFSM_i_Mode)
            `MDU_MULT, `MDU_MULTU: // multiply operation takes 5 clk
                delay = 32'd5;
            `MDU_DIV, `MDU_DIVU: // divide operation takes 10 clk
                delay = 32'd10;

            `MDU_NOOP: delay = 32'd0;
            default: delay = 32'd0;
        endcase 
    end

    always @(posedge clk) begin
        if(reset) begin
            counter <= 0;
        end
        else if(counter > 0)
            counter <= counter - 1'b1;
        else
            counter <= delay;
    end

    assign MDU_DelayFSM_o_Busy = (counter != 32'b0 || delay != 32'b0)?1'b1:1'b0;
    assign MDU_DelayFSM_o_dataReady = (counter == 32'b1)?1'b1:1'b0;

endmodule
