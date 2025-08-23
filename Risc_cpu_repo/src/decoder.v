`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2025 16:58:24
// Design Name: 
// Module Name: decoder
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


// decoder.v - Instruction Decoder
module decoder (
    input [7:0] instr,
    output [2:0] opcode,
    output [1:0] rd,
    output [2:0] src,
    output [7:0] imm 
);
    assign opcode = instr[7:5];  // 3-bit operation code
    assign rd     = instr[4:3];  // 2-bit destination register
    assign src    = instr[2:0];  // 3-bit source register or immediate
    assign imm = {5'b0, instr[2:0]};

endmodule

