`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 23:18:10
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


module control_unit(
input [2:0] opcode,
output reg alu_src,     //1=immediate, 0= register
output reg reg_write,   //1=right back to reg 
output reg mem_write,       //1=right back to memory or store in memory
output  reg mem_or_reg,      //0= take data from alu, 1= take  data from memory
output reg branch          //1=branch type instruction triggered
    );  
    
    always@(*)begin
    case (opcode) 
    
    3'b000: begin   //ADD
        alu_src=0;
        reg_write=1;
        mem_write=0;
        mem_or_reg=0;
        branch=0;
    end
    
    3'b001: begin //SUB
            alu_src=0;
            reg_write=1;
            mem_write=0;
            mem_or_reg=0;
            branch=0;
    end
    
    3'b010: begin //AND
            alu_src=0;
            reg_write=1;
            mem_write=0;
            mem_or_reg=0;
            branch=0;
    end
    
    3'b011: begin //OR
            alu_src=0;
            reg_write=1;
            mem_write=0;
            mem_or_reg=0;
            branch=0;
            
     end
    
    3'b100: begin //MOVI
            alu_src=1;      
            reg_write=1;
            mem_write=0;
            mem_or_reg=0;
            branch=0;
    end
    
    3'b101: begin //LOAD
            alu_src=0;          //ALU is basically unsused during LOAD condition
            reg_write=1;        
            mem_write=0;
            mem_or_reg=1;       //taking data from mem and writing in reg
            branch=0;
    end
    
    3'b110: begin //STORE
            alu_src=0;
            reg_write=0;
            mem_write=1;        //writing data in memory
            mem_or_reg=0;
            branch=0;
    end
    
    3'b111: begin //BEQ
            alu_src=0;
            reg_write=0;
            mem_write=0;
            mem_or_reg=0;
            branch=1;       
    end
    endcase
    end
endmodule
