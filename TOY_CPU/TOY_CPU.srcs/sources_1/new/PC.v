`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 00:06:36
// Design Name: 
// Module Name: PC
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


module PC (
    input clk,
    input reset,
    input [7:0] pc_next,
    output reg [7:0] pc_out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 8'd0;
        else
            pc_out <= pc_next;
    end
endmodule