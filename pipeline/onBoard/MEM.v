module MEM (
    input  wire        clk           ,
    input  wire        mem_we        ,
    input  wire [31:0] mem_addr      ,
    input  wire [31:0] mem_write_data,

    output wire [31:0] mem_read_data
);

dram U_dram (
    // input
    .clk (clk           ), // input  wire clka
    .we  (mem_we        ), // input  wire [0:0] wea
    .a   (mem_addr[15:2]), // input  wire [13:0] addra
    .d   (mem_write_data), // input  wire [31:0] dina
    // output
    .spo (mem_read_data )  // output wire [31:0] douta
);

endmodule
