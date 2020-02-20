`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:13:25 12/01/2019 
// Design Name: 
// Module Name:    MDU 
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

module MDU(
    input clk,
    input reset,
    input [31:0] MDU_i_Operand1,
    input [31:0] MDU_i_Operand2,
    input [3:0] MDU_i_Operation,
    output MDU_o_Busy,
    output reg [31:0] MDU_o_Hi,
    output reg [31:0] MDU_o_Lo
    );

    initial begin
        MDU_o_Hi = 0;
        MDU_o_Lo = 0;
        lastop = 0;
        op1 = 0;
        op2 = 0;
    end

    wire dataReady;
    MDU_DelayFSM delayFSM (
		.clk(clk), 
		.reset(reset), 
		.MDU_DelayFSM_i_Mode(MDU_i_Operation), 
		.MDU_DelayFSM_o_Busy(MDU_o_Busy),
		.MDU_DelayFSM_o_dataReady(MDU_DelayFSM_o_dataReady)
	);
    assign dataReady = MDU_DelayFSM_o_dataReady;



    reg signed [31:0] op1 = 0, op2 = 0;
    reg [3:0] lastop = 0;

    always @(posedge clk) begin
        if(reset) begin
            MDU_o_Hi <= 0;
            MDU_o_Lo <= 0;
            lastop <= 0;
            op1 <= 0;
            op2 <= 0;
        end
        
        else if(MDU_i_Operation == `MDU_MTHI ) begin
            {MDU_o_Hi, MDU_o_Lo} <= {MDU_i_Operand1, MDU_o_Lo};
        end
        else if(MDU_i_Operation == `MDU_MTLO) begin
            {MDU_o_Hi, MDU_o_Lo} <= {MDU_o_Hi, MDU_i_Operand1};
        end
        else if(MDU_i_Operation == `MDU_READ) begin
            // for convenience in Stall Control
            {MDU_o_Hi, MDU_o_Lo} <= {MDU_o_Hi, MDU_o_Lo};
        end // !

        else if(MDU_i_Operation != 4'b0) begin  // saves data, give result only when ready
            lastop <= MDU_i_Operation;
            op1 <= MDU_i_Operand1;
            op2 <= MDU_i_Operand2;
        end
        else if(dataReady && MDU_i_Operation == 4'b0) begin // gives result
            lastop <= 0;
            {MDU_o_Hi, MDU_o_Lo} <= tmpResult;
        end
        
    end



    // use signed to force signed result
    reg signed [63:0] tmpResult;
    always@(*) begin
        // ! tmpResult/op1/op2 are all **signed** !
        case(lastop)
            `MDU_MULT: tmpResult = op1 * op2;
            `MDU_MULTU: tmpResult = {1'b0, op1} * {1'b0, op2};
            `MDU_DIV: tmpResult = {(op1%op2), (op1/op2)};
            `MDU_DIVU: begin
                tmpResult[31:0] = {1'b0, op1} / {1'b0, op2};
                tmpResult[63:32] = {1'b0, op1} % {1'b0, op2};
            end
            
            default: tmpResult = {MDU_o_Hi, MDU_o_Lo};

        endcase
    end


endmodule
