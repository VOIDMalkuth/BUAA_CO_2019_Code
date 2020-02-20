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

module MUX_ALUOp1(
    input [2:0] MUX_ALUOp1_i_Sel,
    input [31:0] MUX_ALUOp1_i_RsIn,
    input [4:0] MUX_ALUOp1_i_ShamtIn,
    output reg [31:0] MUX_ALUOp1_o_Output
    );

    always @(*) begin
        case(MUX_ALUOp1_i_Sel)
            `MUX_ALUOP1_RSSEL: MUX_ALUOp1_o_Output = MUX_ALUOp1_i_RsIn;
            `MUX_ALUOP1_SHAMTSEL: MUX_ALUOp1_o_Output = {27'b0, MUX_ALUOp1_i_ShamtIn};

            default: MUX_ALUOp1_o_Output = 32'bx;
        endcase
    end

endmodule

module MUX_ALUOp2(
    input [2:0] MUX_ALUOp2_i_Sel,
    input [31:0] MUX_ALUOp2_i_RegIn,
    input [31:0] MUX_ALUOp2_i_EXTIn,
    output reg [31:0] MUX_ALUOp2_o_Output
    );

    always @(*) begin
        case(MUX_ALUOp2_i_Sel)
            `MUX_ALUOP2_REGSEL: MUX_ALUOp2_o_Output = MUX_ALUOp2_i_RegIn;
            `MUX_ALUOP2_EXTSEL: MUX_ALUOp2_o_Output = MUX_ALUOp2_i_EXTIn;

            default: MUX_ALUOp2_o_Output = 32'bx;
        endcase
    end

endmodule

module MUX_RegWAddr(
    input [2:0] MUX_RegWAddr_i_Sel,
    input [4:0] MUX_RegWAddr_i_rdIn,
    input [4:0] MUX_RegWAddr_i_rtIn,
    output reg [4:0] MUX_RegWAddr_o_Output
    );

    always @(*) begin
        case (MUX_RegWAddr_i_Sel)
            `MUX_REGWADDR_RDSEL: MUX_RegWAddr_o_Output =  MUX_RegWAddr_i_rdIn;
            `MUX_REGWADDR_RTSEL: MUX_RegWAddr_o_Output =  MUX_RegWAddr_i_rtIn;
            `MUX_REGWADDR_LINKSEL: MUX_RegWAddr_o_Output = 5'b11111; // link: save pc +4 to $ra

            default: MUX_RegWAddr_o_Output = 5'bx;
        endcase
    end

endmodule

module MUX_RegWData(
    input [2:0] MUX_RegWData_i_Sel,
    input [31:0] MUX_RegWData_i_ALUIn,
    input [31:0] MUX_RegWData_i_memIn,
    input [31:0] MUX_RegWData_i_linkIn,   // pc + 4
    output reg [31:0] MUX_RegWData_o_Output
    );

    always @(*) begin
        case(MUX_RegWData_i_Sel)
            `MUX_REGWDATA_ALUSEL: MUX_RegWData_o_Output = MUX_RegWData_i_ALUIn;
            `MUX_REGWDATA_MEMSEL: MUX_RegWData_o_Output = MUX_RegWData_i_memIn;
            `MUX_REGWDATA_LINKSEL: MUX_RegWData_o_Output = MUX_RegWData_i_linkIn;

            default: MUX_RegWData_o_Output = 32'bx;
        endcase
    end

endmodule

module MUX_EALU_OData(
    input [2:0] MUX_EALU_OData_i_Sel,
    input [31:0] MUX_EALU_OData_i_ALUIn,
    input [31:0] MUX_EALU_OData_i_HiIn,
    input [31:0] MUX_EALU_OData_i_LoIn,
    output reg [31:0] MUX_EALU_OData_o_Output
    );

    always @(*) begin
        case(MUX_EALU_OData_i_Sel)
            `MUX_EALU_ODATA_ALUSEL: MUX_EALU_OData_o_Output = MUX_EALU_OData_i_ALUIn;
            `MUX_EALU_ODATA_HISEL: MUX_EALU_OData_o_Output = MUX_EALU_OData_i_HiIn;
            `MUX_EALU_ODATA_LOSEL: MUX_EALU_OData_o_Output = MUX_EALU_OData_i_LoIn;

            default: MUX_EALU_OData_o_Output = 32'bx;
        endcase
    end

endmodule