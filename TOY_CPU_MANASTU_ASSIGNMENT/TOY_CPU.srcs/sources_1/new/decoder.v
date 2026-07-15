`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 19:51:48
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


module decoder(
input [9:0] instruction,
output [2:0] opcode,
output [1:0] rd,
output [1:0] rs,
output [2:0] imm

    );
    
    assign opcode = instruction[9:7];  //3 bit opcode
    assign rd = instruction[6:5];       //2 bit rd(one out of 4 registers)
    assign rs = instruction[4:3];       //2 bit rs(one out of 4 registers)
    assign imm = instruction[2:0];      //3 bit immediate value if required
    
    
endmodule
