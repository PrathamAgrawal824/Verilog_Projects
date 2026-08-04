`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 15:08:23
// Design Name: 
// Module Name: Zybo_wrapper
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


module Zybo_wrapper(
    input clk,
    input rst,
    output [3:0] led
);
    
    wire [9:0] instruction;
    wire [7:0] alu_result;
    wire [7:0] pc_value;
    
    // Clock divider: 125MHz -> ~1Hz
    reg [26:0] counter = 0;
    wire slow_clk;
    always @(posedge clk) begin
        counter <= counter + 1;
    end
    assign slow_clk = counter[26];
    
    CPU_top uut(
        .clk(slow_clk),          // <-- now uses the divided clock
        .rst(rst),
        .instruction(instruction),
        .alu_result(alu_result),
        .pc_value(pc_value)
    );
        
    assign led = pc_value[3:0];  // <-- now shows PC, not ALU result
        
endmodule