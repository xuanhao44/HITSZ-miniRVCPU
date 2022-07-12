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

// MUX2_1
wire [31:0] alu_b = (alub_sel == `ALU_B_RF_RD2) ? rf_rd2 :
                    (alub_sel == `ALU_B_SEXT_EXT) ? sext_ext :
                    rf_rd2;

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
