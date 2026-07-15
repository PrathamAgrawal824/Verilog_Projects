`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 15:19:07
// Design Name: 
// Module Name: CPU_top
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


module CPU_top (
    input clk,
    input rst,

    output [9:0] instruction,
    output [7:0] alu_result,
    output [7:0] pc_value
        
);

    wire [9:0] instr;
    wire [2:0] opcode;
    wire [1:0] rd,rs;
    wire [2:0] imm;

    wire [7:0] reg_data1, reg_data2;
    wire [7:0] alu_in2;
    wire [7:0] alu_out;

    wire alu_src;
    wire reg_write;

    wire [7:0] pc_addr;
    wire [7:0] pc_next;
    
    wire mem_write;
    wire [7:0] mem_read_data;
    wire mem_or_reg;
    
    wire branch;
    wire branch_condition;
    wire branch_taken;
    
    wire [7:0] reg_write_data;
    
    assign branch_condition = (reg_data1 == 8'b0);
    assign branch_taken = branch & branch_condition;
   
    assign pc_next = (branch_taken == 1) ? (pc_addr + imm) : (pc_addr + 1); 

    assign instruction = instr;
    assign alu_result = alu_out;
    assign pc_value = pc_addr;

    // Program Counter
    PC pc_inst (
        .clk(clk),
        .reset(rst),
         .pc_next(pc_next),
        .pc_out(pc_addr)
    );

    // Instruction Memory
    instr_mem imem (
        .addr(pc_addr),
        .instruction(instr)
    );

    // Instruction Decoder
    decoder decode (
        .instruction(instr),
        .opcode(opcode),
        .rd(rd),
        .rs(rs),
        .imm(imm)
    );
    
    //data memory unit
    
    data_mem dmem(
    
        .clk(clk),
        .rst_mem(rst),
        .mem_write(mem_write),
        .mem_addr(imm),
        .write_mem(reg_data1),
        .read_mem(mem_read_data)); //

    // Control Unit
    control_unit ctrl (
        .opcode(opcode),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .branch(branch),
        .mem_or_reg(mem_or_reg)
    );

    // Register File
    registers reg_file (
        .clk(clk),
        .rst(rst),
        .read_reg1(rd),
        .read_reg2(rs),
        .write_reg(rd),
        .write_data(reg_write_data),
        .reg_write(reg_write),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );
    
    //data comes from reg or memory
    
    assign reg_write_data = (mem_or_reg ==1)? mem_read_data : alu_out;

    // ALU Input MUX
    assign alu_in2 = (alu_src == 1) ? imm : reg_data2;

    // ALU
    ALU alu_inst (
        .opcode(opcode),
        .operand1(reg_data1),
        .operand2(alu_in2),
        .result(alu_out)
    );

endmodule
