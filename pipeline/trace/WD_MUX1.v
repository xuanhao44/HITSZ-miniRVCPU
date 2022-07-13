module WD_MUX1 (
    input  wire [1:0]  wd_sel,
    input  wire [31:0] pc4   ,
    input  wire [31:0] imm   ,
    input  wire [31:0] alu_c ,

    output reg  [31:0] wD
);

always @ (*) begin
    case (wd_sel)
        `SEXT_EXT: wD = imm;
        `ALU_C:    wD = alu_c;
        `NPC_PC4:  wD = pc4;
        default:   wD = 32'b0;
    endcase
end

endmodule
