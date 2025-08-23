`timescale 1ns / 1ps

module datapath_tb;

    reg clk;
    reg rst;

    wire [7:0] instruction;
    wire [7:0] alu_result;
    wire [7:0] pc_value;

    datapath uut (
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .alu_result(alu_result),
        .pc_value(pc_value)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        // Hold reset for some time
        #20;
        rst = 0;

        #100;

        rst = 1;
        #10;
        rst = 0;

        #100;

        $finish;
    end

    initial begin
        $monitor("Time: %0t | PC: %h | Instruction: %h | ALU Result: %h", 
                  $time, pc_value, instruction, alu_result);
    end

endmodule
