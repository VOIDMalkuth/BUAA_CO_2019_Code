`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    12:11:19 10/18/2019
// Design Name:
// Module Name:    gray
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
module gray(input Clk,
            input Reset,
            input En,
            output reg [2:0] Output,
            output reg Overflow);

    initial begin
        Output = 0;
        Overflow = 0;
    end
    
    always @(posedge Clk) begin
        if (Reset == 1) begin
            Output   <= 1'b0;
            Overflow <= 1'b0;
        end
        else begin
            case (Output)
                3'b000 : Output <= En ? 3'b001 : 3'b000;
                3'b001 : Output <= En ? 3'b011 : 3'b001;
                3'b011 : Output <= En ? 3'b010 : 3'b011;
                3'b010 : Output <= En ? 3'b110 : 3'b010;
                3'b110 : Output <= En ? 3'b111 : 3'b110;
                3'b111 : Output <= En ? 3'b101 : 3'b111;
                3'b101 : Output <= En ? 3'b100 : 3'b101;
                3'b100 : begin
                    Output   <= En ? 3'b000 : 3'b100;
                    Overflow <= 1'b1;
                end
                
                default: begin
                    Output   <= 3'bxxx;
                    Overflow <= 1'bx;
                end
            endcase
        end
    end
    
endmodule
