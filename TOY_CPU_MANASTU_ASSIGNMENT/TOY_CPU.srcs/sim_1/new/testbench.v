`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 16:53:04
// Design Name: 
// Module Name: testbench
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


module testbench();
reg clk;
reg rst;

wire [9:0] instruction;
wire [7:0] alu_result;
wire [7:0] pc_value;

CPU_top uut(
.clk(clk),
.rst(rst),
.instruction(instruction),
.alu_result(alu_result),
.pc_value(pc_value)
);
    
    always #10 clk = ~clk;
    
    initial begin
    
    clk = 0;
    rst = 1;
    
    #20;
    
    
    rst = 0;
    
    
    #200;
    
    $finish;
    
    end
    
endmodule
