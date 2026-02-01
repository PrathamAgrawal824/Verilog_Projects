module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4         
)(
    // Write 
    input  wire                  wr_clk,
    input  wire                  wr_rst_n,
    input  wire                  wr_en,
    input  wire [DATA_WIDTH-1:0] wr_data,
    output wire                  full,

    // Read 
    input  wire                  rd_clk,
    input  wire                  rd_rst_n,
    input  wire                  rd_en,
    output reg  [DATA_WIDTH-1:0] rd_data,
    output wire                  empty
);

    // Memory
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

  // Binary and Gray pointers (we add extra MSB bit for full and empty detection)
    reg [ADDR_WIDTH:0] wr_ptr_bin, wr_ptr_bin_next;
    reg [ADDR_WIDTH:0] rd_ptr_bin, rd_ptr_bin_next;

    reg [ADDR_WIDTH:0] wr_ptr_gray, wr_ptr_gray_next;
    reg [ADDR_WIDTH:0] rd_ptr_gray, rd_ptr_gray_next;

  
    // Synchronized Gray pointers
    reg [ADDR_WIDTH:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2;
    reg [ADDR_WIDTH:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2;

  
  
    // Binary to Gray 
    always @(*) begin
        wr_ptr_bin_next  = wr_ptr_bin + (wr_en && !full);
        rd_ptr_bin_next  = rd_ptr_bin + (rd_en && !empty);

        wr_ptr_gray_next = (wr_ptr_bin_next >> 1) ^ wr_ptr_bin_next;
        rd_ptr_gray_next = (rd_ptr_bin_next >> 1) ^ rd_ptr_bin_next;
    end

    // Write pointer (wr_clk)
   
  always @(posedge wr_clk or negedge wr_rst_n) begin
        if (!wr_rst_n) begin
            wr_ptr_bin  <= 0;
            wr_ptr_gray <= 0;
        end else begin
            wr_ptr_bin  <= wr_ptr_bin_next;
            wr_ptr_gray <= wr_ptr_gray_next;

            if (wr_en && !full)
                mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= wr_data;
        end
    end

    // Read pointer (rd_clk)
   
  always @(posedge rd_clk or negedge rd_rst_n) begin
        if (!rd_rst_n) begin
            rd_ptr_bin  <= 0;
            rd_ptr_gray <= 0;
            rd_data     <= 0;
        end else begin
            rd_ptr_bin  <= rd_ptr_bin_next;
            rd_ptr_gray <= rd_ptr_gray_next;

            if (rd_en && !empty)
                rd_data <= mem[rd_ptr_bin[ADDR_WIDTH-1:0]];
        end
    end

    // Now we Synchronize Read pointer into Write clock domain
    
  always @(posedge wr_clk or negedge wr_rst_n) begin
        if (!wr_rst_n) begin
            rd_ptr_gray_sync1 <= 0;
            rd_ptr_gray_sync2 <= 0;
        end 
      else 
        begin
            rd_ptr_gray_sync1 <= rd_ptr_gray;
            rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
        end
    end

    //Now we Synchronize Write pointer into Read clock domain
    always @(posedge rd_clk or negedge rd_rst_n) begin
        if (!rd_rst_n) begin
            wr_ptr_gray_sync1 <= 0;
            wr_ptr_gray_sync2 <= 0;
        end 
      else 
        begin
            wr_ptr_gray_sync1 <= wr_ptr_gray;
            wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
        end
    end

    // To check empty condition (read clock domain)
   
  assign empty = (rd_ptr_gray_next == wr_ptr_gray_sync2);

  // to check full condition of fifo (write clock domain)
    // Invert MSBs of synchronized read pointer to indicate a full wrap
    
  assign full = (wr_ptr_gray_next =={~rd_ptr_gray_sync2[ADDR_WIDTH:ADDR_WIDTH-1], rd_ptr_gray_sync2[ADDR_WIDTH-2:0]});
                   
                  
endmodule
