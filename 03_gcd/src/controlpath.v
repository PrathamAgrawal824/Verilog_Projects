`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2025 20:11:13
// Design Name: 
// Module Name: controlpath
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


module controlpath(ldA, ldB, sel1, sel2, sel_in, done, clk, lt, gt, eq, start);
    input clk, lt, gt, eq, start;
    output reg ldA, ldB, sel1, sel2, sel_in, done;

    reg [2:0] state, next_state;
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;

    // State register (Sequential logic)
    always @(posedge clk) begin
        state <= next_state;
    end

    // FSM (Combinational logic)
    always @(*) begin
        // Default values to prevent latches
        sel_in = 0;
        ldA = 0;
        ldB = 0;
        sel1 = 0;
        sel2 = 0;
        done = 0;
        
        case (state)
            S0: begin 
                sel_in = 1; 
                ldA = 1; 
                ldB = 0; 
                done = 0;
                if (start)
                    next_state = S1;
                else
                    next_state = S0;
            end
            
            S1: begin 
                sel_in = 1; 
                ldA = 0; 
                ldB = 1;
                next_state = S2;
            end
            
            S2: begin 
                if (eq) begin 
                    done = 1;
                    next_state = S5;
                end
                else if (lt) begin
                    sel1 = 1; 
                    sel2 = 0; 
                    sel_in = 0;
                    next_state = S3;
                    ldA = 0; 
                    ldB = 1;
                end
                else if (gt) begin
                    sel1 = 0; 
                    sel2 = 1; 
                    sel_in = 0;
                    next_state = S4;
                    ldA = 1; 
                    ldB = 0;
                end
            end
            
            S3: begin 
                if (eq) begin 
                    done = 1; 
                    next_state = S5;
                end
                else if (lt) begin
                    sel1 = 1; 
                    sel2 = 0; 
                    sel_in = 0;
                    next_state = S3;
                    ldA = 0; 
                    ldB = 1;
                end
                else if (gt) begin
                    sel1 = 0; 
                    sel2 = 1; 
                    sel_in = 0;
                    next_state = S4;
                    ldA = 1; 
                    ldB = 0;
                end
            end
            
            S4: begin 
                if (eq) begin 
                    done = 1; 
                    next_state = S5;
                end
                else if (lt) begin
                    sel1 = 1; 
                    sel2 = 0; 
                    sel_in = 0;
                    next_state = S3;
                    ldA = 0; 
                    ldB = 1;
                end
                else if (gt) begin
                    sel1 = 0; 
                    sel2 = 1; 
                    sel_in = 0;
                    next_state = S4;
                    ldA = 1; 
                    ldB = 0;
                end
            end
            
            S5: begin 
                done = 1; 
                sel1 = 0; 
                sel2 = 0; 
                ldA = 0; 
                ldB = 0;
                next_state = S0;
            end

            default: begin 
                ldA = 0; 
                ldB = 0; 
                sel1 = 0; 
                sel2 = 0; 
                sel_in = 0;
                done = 0;
                next_state = S0;
            end
        endcase
    end
endmodule
