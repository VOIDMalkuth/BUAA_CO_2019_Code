`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:50 10/18/2019 
// Design Name: 
// Module Name:    string 
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
module string(
    input clk,
    input clr,
    input [7:0] in,
    output reg out
    );

    parameter state_waitForNum = 3'b001,
          state_numEncountered = 3'b010,
          state_Failed = 3'b100;

    reg [2:0] state;

    initial begin
        state = state_waitForNum;
        out = 0;
    end

    always @(posedge clk or posedge clr) begin
        if(clr) begin
            state <= state_waitForNum;
            out <= 0;
        end
        else begin
            case(state)
                3'b001: begin
                    state <= ("0" <= in && in <= "9")?state_numEncountered:state_Failed;
                    out <= ("0" <= in && in <= "9")?1'b1:1'b0;
                end
                3'b010: begin
                    state <= ("+" == in || in == "*")?state_waitForNum:state_Failed;
                    out <= 1'b0;
                end
                3'b100: begin
                    state <= state_Failed;
                    out <= 1'b0;
                end
            endcase
        end
    end



endmodule
