module MUX1 (
    input  wire [1:0]  wd_sel,
    input  wire [31:0] wD    ,
    input  wire [31:0] imm   ,
    input  wire [31:0] alu_c ,

    output reg  [31:0] wD_o
);

always @ (*) begin
    if (wd_sel == 2'b11)      wD_o = imm;
    else if (wd_sel == 2'b00) wD_o = alu_c;
    else                      wD_o = wD;
end

endmodule
