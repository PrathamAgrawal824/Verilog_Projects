`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2025 16:52:27
// Design Name: 
// Module Name: instr_mem
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


// instr_mem.v
module instr_mem (
    input [7:0] addr,
    output reg [7:0] instr
);
    always @(*) begin
        case (addr)
            8'd0: instr = 8'b000_01_00; // ADD R1 = R1 + R0
            8'd1: instr = 8'b001_10_01; // SUB R2 = R2 - R1
            8'd2: instr = 8'b010_11_10; // AND R3 = R3 & R2
            8'd3: instr = 8'b011_00_11; // OR R0 = R0 | R3
            8'd4: instr = 8'b100_01_000; // MOVI R1 = imm (but where is imm from?)
            default: instr = 8'b11100000;  // Opcode 111 = NOP


        endcase
    end
endmodule

