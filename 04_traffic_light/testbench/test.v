`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2025 17:06:10
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

`timescale 1ns/1ps

module Traffic_sys_tb;

    reg clk;
    reg reset;
    wire [2:0] north_light, south_light, east_light, west_light;

    
    Traffic_sys uut (
        .clk(clk),
        .reset(reset),
        .north_light(north_light),
        .south_light(south_light),
        .east_light(east_light),
        .west_light(west_light)
    );

    
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        
        $dumpfile("traffic_sys.vcd");
        $dumpvars(0, Traffic_sys_tb);

        reset = 1;
        #10;
        reset = 0;

        #1000 $finish;
    end

endmodule
