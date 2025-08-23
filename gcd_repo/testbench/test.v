`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2025 22:16:03
// Design Name: 
// Module Name: test
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


`timescale 1ns / 1ps

module GCD_TB;
    
    reg clk, start;
    reg [15:0] data_in;
    
    
    wire ldA, ldB, sel1, sel2, sel_in, done;
    wire gt, lt, eq;

    
    Datapath DP (
        .gt(gt), .lt(lt), .eq(eq),
        .ldA(ldA), .ldB(ldB),
        .sel1(sel1), .sel2(sel2), .sel_in(sel_in),
        .data_in(data_in), .clk(clk)
    );

    controlpath CP (
        .clk(clk), .start(start),
        .lt(lt), .gt(gt), .eq(eq),
        .ldA(ldA), .ldB(ldB),
        .sel1(sel1), .sel2(sel2), .sel_in(sel_in),
        .done(done)
    );

   
    always #5 clk = ~clk;  

    initial begin
       
        clk = 0; start = 0; data_in = 0;

        // Step 1: Load first number into A
        #10 data_in = 16'd36; start = 1;
        #10 start = 0;

        // Step 2: Load second number into B
        #10 data_in = 16'd24;

        
        wait(done);

       
        #10 $display("GCD Computation Done!");

        #10 $finish;  
    end
endmodule
