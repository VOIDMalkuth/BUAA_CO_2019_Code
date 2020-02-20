`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:57:32 11/15/2019 
// Design Name: 
// Module Name:    MUX_ALUOp2 
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

module MUX_ALUOp2(
    input [1:0] MUX_ALUOp2_Sel,
    input [31:0] MUX_ALUOp2_RegIn,
    input [31:0] MUX_ALUOp2_EXTIn,
    output reg [31:0] MUX_ALUOp2_Output
    );

    always @(*) begin
        case(MUX_ALUOp2_Sel)
            `MUX_ALUOP2_REGSEL: MUX_ALUOp2_Output = MUX_ALUOp2_RegIn;
            `MUX_ALUOP2_EXTSEL: MUX_ALUOp2_Output = MUX_ALUOp2_EXTIn;

            default: MUX_ALUOp2_Output = 32'bx;
        endcase
    end

endmodule

module MUX_RegWAddr(
    input [1:0] MUX_RegWAddr_Sel,
    input [4:0] MUX_RegWAddr_rdIn,
    input [4:0] MUX_RegWAddr_rtIn,
    output reg [4:0] MUX_RegWAddr_Output
    );

    always @(*) begin
        case (MUX_RegWAddr_Sel)
            `MUX_REGWADDR_RDSEL: MUX_RegWAddr_Output =  MUX_RegWAddr_rdIn;
            `MUX_REGWADDR_RTSEL: MUX_RegWAddr_Output =  MUX_RegWAddr_rtIn;
            `MUX_REGWADDR_LINKSEL: MUX_RegWAddr_Output = 5'b11111; // link: save pc +4 to $ra

            default: MUX_RegWAddr_Output = 5'bx;
        endcase
    end

endmodule

module MUX_RegWData(
    input [1:0] MUX_RegWData_Sel,
    input [31:0] MUX_RegWData_ALUIn,
    input [31:0] MUX_RegWData_memIn,
    input [31:0] MUX_RegWData_linkIn,   // pc + 4
    output reg [31:0] MUX_RegWData_Output
    );

    always @(*) begin
        case(MUX_RegWData_Sel)
            `MUX_REGWDATA_ALUSEL: MUX_RegWData_Output = MUX_RegWData_ALUIn;
            `MUX_REGWDATA_MEMSEL: MUX_RegWData_Output = MUX_RegWData_memIn;
            `MUX_REGWDATA_LINKSEL: MUX_RegWData_Output = MUX_RegWData_linkIn;

            default: MUX_RegWData_Output = 32'bx;
        endcase
    end

endmodule