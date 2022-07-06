`include "param.v"

module EX (
    input  wire        alub_sel,
    input  wire [3:0]  alu_op  ,

    input  wire [31:0] rf_rd1  ,
    input  wire [31:0] rf_rd2  ,
    input  wire [31:0] sext_ext,

    output wire [31:0] alu_c   ,
    output wire        alu_zero,
    output wire        alu_sgn
);

reg [31:0] alu_b;

// MUX2_1
always @ (*) begin
    case (alub_sel)
        `ALU_B_RF_RD2  : alu_b = rf_rd2;
        `ALU_B_SEXT_EXT: alu_b = sext_ext;
        default        : alu_b = rf_rd2;
    endcase
end

ALU U_ALU (
    // input
    .op     (alu_op  ),
    .A      (rf_rd1  ),
    .B      (alu_b   ),
    // output
    .C      (alu_c   ),
    .zero   (alu_zero),
    .sgn    (alu_sgn )
);

endmodule
