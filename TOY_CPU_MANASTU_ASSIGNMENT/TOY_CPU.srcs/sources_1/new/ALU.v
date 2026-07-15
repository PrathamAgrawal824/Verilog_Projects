`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 00:34:05
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU (
    input [2:0] opcode,
    input [7:0] operand1,  // from destination register (Rd)
    input [7:0] operand2,  // from source register or immediate
    output reg [7:0] result
);

always @(*) begin
    case (opcode)
        3'b000: result = operand1 + operand2; // ADD
        3'b001: result = operand1 - operand2; // SUB
        3'b010: result = operand1 & operand2; // AND
        3'b011: result = operand1 | operand2; // OR
        3'b100: result = operand2;            // MOV
        default: result = 8'b0;
    endcase
end

endmodule