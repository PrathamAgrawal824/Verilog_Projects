`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2025 00:54:13
// Design Name: 
// Module Name: Vending
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


module Vending(
    input clk,
    input rst,
    input [3:0]money,
    input [1:0]in, //01 item1,10 item2, 11 item3
    output reg out,
    output reg insufficient_money,//led for showing less money
    output reg [3:0]change
    );
    
    reg [1:0]PS,NS;
   parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    parameter price1 = 4'b0011, price2 = 4'b0101, price3 = 4'b0111;

    always@(posedge clk)
    if(rst)
        begin PS<=0;
              NS<=0;
              out<=0;
        end
        
    else 
        PS<=NS;          
    
    always@(*)
    begin
    case(PS)
        S0:
           if(in==2'b00)
           begin 
           NS=S0;
           out=0;end
           else if(in==2'b01) begin
           NS=S1;
           out=0; end
           else if(in==2'b10) begin
           NS=S2;
           out=0;end
           else begin
           NS=S3;
           out=0; end
           
       S1:
          if(money>=price1)
          begin
          NS=S0;
          out=1;
          change=money-price1;
          insufficient_money = 0; // Reset LED
          end
          else begin NS=S0;
          out =0;
          insufficient_money=1;
          end
       S2:
            if(money>=price2)
                 begin
                 NS=S0;
                 out=1;
                 change=money-price3;
                 insufficient_money = 0; // Reset LED
                 end
                 else begin NS=S0;
                 out =0;
                 insufficient_money=1;
                 end
           
       S3:if(money>=price3)
              begin
              NS=S0;
              out=1;
              change=money-price2;
              insufficient_money = 0; // Reset LED
              end
              else begin NS=S0;
              out =0;
              insufficient_money=1;
              end     
        default: begin
                  NS = S0;
                  out = 0;
              end

    endcase
    end          
endmodule
