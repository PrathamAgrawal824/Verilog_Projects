
module tb_async_fifo;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    reg wr_clk = 0;
    reg rd_clk = 0;
    reg wr_rst_n = 0;
    reg rd_rst_n = 0;
    reg wr_en = 0;
    reg rd_en = 0;
    reg [DATA_WIDTH-1:0] wr_data = 0;

    wire [DATA_WIDTH-1:0] rd_data;
    wire full;
    wire empty;

    integer i;

  
    async_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .wr_clk(wr_clk),
        .wr_rst_n(wr_rst_n),
        .wr_en(wr_en),
        .wr_data(wr_data),
        .full(full),
        .rd_clk(rd_clk),
        .rd_rst_n(rd_rst_n),
        .rd_en(rd_en),
        .rd_data(rd_data),
        .empty(empty)
    );

    //2 different clock domains
    always #5 wr_clk = ~wr_clk;
    always #7 rd_clk = ~rd_clk;

    initial begin
        $display("TB STARTED");

        // reset
        #20;
        wr_rst_n = 1;
        rd_rst_n = 1;

        // Write
        $display("WRITE START");
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge wr_clk);
            wr_en   = 1;
            wr_data = i;
            $display("WRITE %0d", i);

            @(posedge wr_clk);
            wr_en = 0;
        end

        // allow pointer sync
        #100;

        // Read
        $display("READ START");
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge rd_clk);
            rd_en = 1;

            @(posedge rd_clk);
            rd_en = 0;
            $display("READ %0d", rd_data);
        end

        #50;
        $display("SIM END");
        $finish;
    end
    
    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, tb_async_fifo);
    end

endmodule