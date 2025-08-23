`timescale 1ns/1ps

module Vending_machine_tb;

    reg clk;
    reg reset;
    reg [1:0] coin;
    wire Z, change_given;

    
    Vending_machine uut (
        .clk(clk),
        .reset(reset),
        .coin(coin),
        .Z(Z),
        .change_given(change_given)
    );

    
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
       
        $dumpfile("vending_machine.vcd");
        $dumpvars(0, Vending_machine_tb);

       
        reset = 1; coin = 2'b00;
        #10;
        reset = 0;

             
        coin = 2'b00; #10; // 10 -> S10
        coin = 2'b01; #10; // 20 -> S30
        coin = 2'b00; #10; // 10 -> S40 (Z=1, change_given=0)
       reset = 1; #10; reset = 0;

      
        
        coin = 2'b10; #10; // 50 -> S50 (Z=1, change_given=1)
        reset = 1; #10; reset = 0;


        coin = 2'b01; #10; // 20 -> S20
        coin = 2'b10; #10; // 50 -> S70 (Z=1, change_given=1)
        reset = 1; #10; reset = 0;

        coin = 2'b00; #10; // 10 -> S10
        coin = 2'b10; #10; // 50 -> S60 (Z=1, change_given=1)
        reset = 1; #10; reset = 0;

        coin = 2'b01; #10; // 20 -> S20
        coin = 2'b10; #10; // 50 -> S70
        coin = 2'b00; #10; // 10 -> S80 (Z=1, change_given=1)

        #20 $finish;
    end

endmodule
