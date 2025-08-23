`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2025 19:40:13
// Design Name: 
// Module Name: Datapath
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


module Datapath(gt,lt,eq,ldA,ldB,sel1,sel2,sel_in,data_in,clk);
input ldA,ldB,sel1,sel2,sel_in,clk;
input[15:0]data_in;
output gt,lt,eq;
wire [15:0]Aout,Bout,x,y,bus,subout;

PIPO A(Aout,bus,ldA,clk);
PIPO B(Bout,bus,ldB,clk);
MUX MUX_in1(x,Aout,Bout,sel1);
MUX MUX_in2(y,Aout,Bout,sel2);
MUX MUX_load(bus,subout,data_in,sel_in);
SUB SB(subout,x,y);
COMPARE CMP(lt,gt,eq,Aout,Bout);
endmodule

module PIPO(data_out,data_in,load,clk);
input[15:0]data_in;
input load,clk;
output reg[15:0]data_out;
always@(posedge clk)
if(load) data_out<=data_in;
endmodule

module MUX(out,in0,in1,sel);
input[15:0]in0,in1;
input sel;
output wire [15:0] out;

assign out=sel?in1:in0;
endmodule

module SUB(out,in1,in2);
input[15:0]in1,in2;

output wire [15:0] out;
assign out = in1 - in2;

endmodule

module COMPARE(lt,gt,eq,data1,data2);
input [15:0]data1,data2;
output lt,eq,gt;
assign lt=data1<data2;
assign gt=data1>data2;
assign eq=data1==data2;
endmodule