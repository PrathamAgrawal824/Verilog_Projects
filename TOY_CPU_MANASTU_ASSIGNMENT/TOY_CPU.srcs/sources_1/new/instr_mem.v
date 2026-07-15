`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 16:14:43
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


module instr_mem(
    input [7:0] addr,
    output reg [9:0] instruction
    );
        
    always @(*) begin
        case (addr)
            8'd0: instruction = 10'b000_01_00_000; // ADD R1 = R1 + R0
            8'd1: instruction = 10'b001_10_01_000; // SUB R2 = R2 - R1
            8'd2: instruction = 10'b010_11_10_000; // AND R3 = R3 & R2
            8'd3: instruction = 10'b110_01_00_100; // STORE Mem[4] = R1
            8'd4: instruction = 10'b101_01_00_100; // LOAD R1 = Mem[4]
            8'd5: instruction = 10'b011_00_11_000; // OR R0 = R0 | R3
            8'd6: instruction = 10'b100_11_00_000; // MOVI R3 = 0
            8'd7: instruction = 10'b111_11_00_010; // BEQ rd=R3, offset=2
            default: instruction = 10'b111_00_00_000; // NOP 
        endcase
    end
endmodule