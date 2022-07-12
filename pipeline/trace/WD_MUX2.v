module WD_MUX2 (
    input  wire [1:0]  wd_sel ,
    input  wire [31:0] dram_rd,
    input  wire [31:0] wD     ,

    output reg  [31:0] wD_o
);

always @ (*) begin
    if (wd_sel == `DRAM_RD) wD_o = dram_rd;
    else                    wD_o = wD;
end

endmodule
