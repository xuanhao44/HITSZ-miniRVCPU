`include "param.v"

module ID (
    input  wire        clk      ,
    input  wire        rst_n    ,

    input  wire [2:0]  sext_op  ,
    input  wire        rf_we    ,
    input  wire [1:0]  wd_sel   ,

    input  wire [31:0] irom_inst,
    input  wire [31:0] alu_c    ,
    input  wire [31:0] dram_rd  ,
    input  wire [31:0] npc_pc4  ,

    output wire [31:0] sext_ext ,
    output wire [31:0] rf_rd1   ,
    output wire [31:0] rf_rd2
);

reg [31:0] rf_wd;

// MUX4_1
always @ (*) begin
    case (wd_sel)
        `ALU_C   : rf_wd = alu_c;
        `DRAM_RD : rf_wd = dram_rd;
        `NPC_PC4 : rf_wd = npc_pc4;
        `SEXT_EXT: rf_wd = sext_ext;
        default  : rf_wd = alu_c;
    endcase
end

SEXT U_SEXT (
    // input
    .op         (sext_op         ),
    .din        (irom_inst[31:7] ),
    // output
    .ext        (sext_ext        )
);

RF U_RF (
    // input
    .clk        (clk             ),
    .rst_n      (rst_n           ),
    .rf_we      (rf_we           ),
    .rR1        (irom_inst[19:15]),
    .rR2        (irom_inst[24:20]),
    .wR         (irom_inst[11:7] ),
    .wD         (rf_wd           ),
    // output
    .rD1        (rf_rd1          ),
    .rD2        (rf_rd2          )
);

endmodule
