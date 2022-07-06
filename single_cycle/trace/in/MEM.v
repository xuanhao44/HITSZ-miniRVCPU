module MEM (
    input  wire        clk      ,
    input  wire        dram_we  ,
    input  wire [31:0] dram_adr ,
    input  wire [31:0] dram_wdin,

    output wire [31:0] dram_rd
);

// 64KB DRAM 32bit × 65536
data_mem dmem (
    // input
    .clk (clk           ), // input  wire clka
    .we  (dram_we       ), // input  wire [0:0] wea
    .a   (dram_adr[15:2]), // input  wire [13:0] addra
    .d   (dram_wdin     ), // input  wire [31:0] dina
    // output
    .spo (dram_rd       )  // output wire [31:0] douta
);

endmodule
