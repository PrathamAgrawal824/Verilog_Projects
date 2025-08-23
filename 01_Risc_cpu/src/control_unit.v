`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2025 17:03:01
// Design Name: 
// Module Name: control_unit
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


// control_unit.v - Generates control signals based on opcode
module control_unit (
    input [2:0] opcode,
    output reg alu_src,     // 0 = register, 1 = immediate
    output reg reg_write    // 1 = write back to register
);

always @(*) begin
    case (opcode)
        3'b000: begin // ADD
            alu_src = 0;
            reg_write = 1;
        end
        3'b001: begin // SUB
            alu_src = 0;
            reg_write = 1;
        end
        3'b010: begin // AND
            alu_src = 0;
            reg_write = 1;
        end
        3'b011: begin // OR
            alu_src = 0;
            reg_write = 1;
        end
        3'b100: begin // MOV (immediate move)
            alu_src = 1;
            reg_write = 1;
        end
        3'b111: begin // NOP or HALT
            alu_src = 0;
            reg_write = 0;
        end

        default: begin
            alu_src = 0;
            reg_write = 0;
        end
    endcase
end

endmodule

