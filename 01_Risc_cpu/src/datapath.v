module datapath (
    input clk,
    input rst,

    output [7:0] instruction,
    output [7:0] alu_result,
    output [7:0] pc_value
);

    wire [7:0] instr;
    wire [2:0] opcode, rs;
    wire [1:0] rd;
    wire [7:0] imm;

    wire [7:0] reg_data1, reg_data2;
    wire [7:0] alu_in2;
    wire [7:0] alu_out;

    wire alu_src;
    wire reg_write;

    wire [7:0] pc_addr;
    wire [7:0] pc_next;
   
    assign pc_next = pc_addr + 1; // assuming sequential execution for now

    assign instruction = instr;
    assign alu_result = alu_out;
    assign pc_value = pc_addr;

    // Program Counter
    pc pc_inst (
        .clk(clk),
        .reset(rst),
         .pc_next(pc_next),
        .pc_out(pc_addr)
    );

    // Instruction Memory
    instr_mem imem (
        .addr(pc_addr),
        .instr(instr)
    );

    // Instruction Decoder
    decoder decode (
        .instr(instr),
        .opcode(opcode),
        .rd(rd),
        .src(rs),
        .imm(imm)
    );

    // Control Unit
    control_unit ctrl (
        .opcode(opcode),
        .alu_src(alu_src),
        .reg_write(reg_write)
    );

    // Register File
    registers reg_file (
        .clk(clk),
        .rst(rst),
        .read_reg1(rs[1:0]),
        .read_reg2(rd),
        .write_reg(rd),
        .write_data(alu_out),
        .reg_write(reg_write),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // ALU Input MUX
    assign alu_in2 = (alu_src == 1) ? imm : reg_data2;

    // ALU
    alu alu_inst (
        .opcode(opcode),
        .operand1(reg_data1),
        .operand2(alu_in2),
        .result(alu_out)
    );

endmodule
