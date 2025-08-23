module registers (
    input clk,
    input rst,
    input reg_write,
    input [1:0] read_reg1, read_reg2,
    input [1:0] write_reg,
    input [7:0] write_data,
    output [7:0] read_data1, read_data2
);
    reg [7:0] regfile [3:0];  // 4 registers, 8-bit each

    // Combinational reads
    assign read_data1 = regfile[read_reg1];
    assign read_data2 = regfile[read_reg2];

    // Synchronous write and reset
    integer i;
    always @(posedge clk) begin
        if (rst) begin
            // Preload values instead of clearing to 0
            regfile[0] <= 8'd5;
            regfile[1] <= 8'd10;
            regfile[2] <= 8'd20;
            regfile[3] <= 8'd30;
        end else if (reg_write) begin
            regfile[write_reg] <= write_data;
        end
    end
endmodule
