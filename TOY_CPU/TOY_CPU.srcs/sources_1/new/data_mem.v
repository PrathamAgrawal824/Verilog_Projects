`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 22:57:15
// Design Name: 
// Module Name: data_mem
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


module data_mem(
input clk,
input rst_mem,          //we need rst to reset the whole memory if required
input mem_write,
input [2:0] mem_addr,
input [7:0] write_mem,
output [7:0] read_mem
    );
    
    reg [7:0] mem [7:0];
    
    //reading the memory
    assign read_mem = mem[mem_addr];
    
    //write into the memory
    integer i;
    always@(posedge clk) begin
        if(rst_mem) begin
            for(i=0 ; i < 8 ; i=i+1) begin
            mem[i]<=0;
            end 
        end
        else if(mem_write) begin
        mem[mem_addr] <= write_mem;
        end
    end 
endmodule
