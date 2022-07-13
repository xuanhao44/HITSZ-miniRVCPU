module WD_MUX2 (
    input  wire [1:0]  wd_sel ,
    input  wire [31:0] dram_rd,
    input  wire [31:0] wD_temp,

    output reg  [31:0] wD
);

always @ (*) begin
    if (wd_sel == `DRAM_RD) wD = dram_rd;
    else                    wD = wD_temp;
end

endmodule
