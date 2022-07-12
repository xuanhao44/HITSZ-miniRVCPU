module miniCPU (
    input  wire        clk,
    input  wire        rst_n,

    output wire [31:0] pc_pc,
    input  wire [31:0] irom_inst,

    output wire        dram_we,
    output wire [31:0] addr,
    output wire [31:0] write_data,
    input  wire [31:0] read_data,

    output wire        debug_wb_have_inst,
    output wire [31:0] debug_wb_pc,
    output wire        debug_wb_ena,
    output wire [4:0]  debug_wb_reg,
    output wire [31:0] debug_wb_value
);

/*
 *  控制信号
 */
// npc_op: 选择 NPC.npc 输出的控制信号
wire npc_op_EX;
// wd_sel: 选择 SEXT 中立即数生成模式的控制信号
wire [1:0] wd_sel_ID, wd_sel_EX, wd_sel_MEM;
// rf_we: RF 的写控制信号
wire rf_we_ID, rf_we_EX, rf_we_MEM, rf_we_WB;
// alub_sel: 选择 ALU.B 输入的控制信号
wire alub_sel_ID, alub_sel_EX;
// dram_we: DRAM 的写控制信号
wire dram_we_ID, dram_we_EX, dram_we_MEM;
// sext_op: 选择 SEXT 中立即数生成模式的控制信号
wire [2:0] sext_op_ID, sext_op_EX;
// alu_op: 选择 ALU 运算方式
wire [3:0] alu_op_ID, alu_op_EX;
// zero: ALU.C 判 0 信号, 输入控制器
wire zero_EX;
// sgn: ALU.C 符号 信号, 输入控制器
wire sgn_EX;

wire [2:0] branch_ID, branch_EX;
wire [1:0] jump_ID, jump_EX;

/*
 * 数据信号
 */

wire [31:0] pcimm_ID, pcimm_EX;
wire [31:0] npc, npc_bj_EX;
wire [31:0] pc_IF, pc_ID;
wire [31:0] pc4_IF, pc4_ID;
wire [31:0] inst_IF, inst_ID;
wire [31:0] imm_ID, imm_EX;
wire [31:0] rD1_ID, rD1_EX;
wire [31:0] rD2_ID, rD2_EX, rD2_MEM;
wire [31:0] alu_c_EX, alu_c_MEM;
wire [31:0] dram_rd_MEM;
wire [31:0] wD_EX, wD_EX_tmp, wD_MEM, wD_MEM_tmp, wD_WB;
wire [4:0]  wR_ID, wR_EX, wR_MEM, wR_WB;

// ------------------------- debug for trace ------------------------- //

wire [31:0] debug_pc_EX, debug_pc_MEM, debug_pc_WB;
wire debug_have_inst_ID, debug_have_inst_EX, debug_have_inst_MEM, debug_have_inst_WB;

assign debug_wb_have_inst = debug_have_inst_WB;
assign debug_wb_pc = debug_pc_WB;
assign debug_wb_ena = rf_we_WB;
assign debug_wb_reg = wR_WB;
assign debug_wb_value = wD_WB;

// ------------------------- debug for trace ------------------------- //

// ------------------------- STALL & FLUSH & FORWARDING ------------------------- //

wire re1_ID, re2_ID;
wire [31:0] rD1_f, rD2_f;
wire rD1_op, rD2_op;
wire stall_PC, stall_IF_ID, stall_ID_EX, stall_EX_MEM, stall_MEM_WB;
wire flush_IF_ID, flush_ID_EX, flush_EX_MEM, flush_MEM_WB;

HAZARDKILLER U_HAZARDKILLER (
    // input
    .clk            (clk),
    .rst_n          (rst_n),

    .wd_sel         (wd_sel_EX),
    .re1_ID         (re1_ID),
    .re2_ID         (re2_ID),
    .rf_we_EX       (rf_we_EX),
    .rf_we_MEM      (rf_we_MEM),
    .rf_we_WB       (rf_we_WB),
    .rR1_ID         (inst_ID[19:15]),
    .rR2_ID         (inst_ID[24:20]),
    .wR_EX          (wR_EX),
    .wR_MEM         (wR_MEM),
    .wR_WB          (wR_WB),
    .wD_EX          (wD_EX),
    .wD_MEM         (wD_MEM),
    .wD_WB          (wD_WB),
    .npc_op         (npc_op_EX),

    // output
    .stall_PC       (stall_PC),
    .stall_IF_ID    (stall_IF_ID),
    .stall_ID_EX    (stall_ID_EX),
    .stall_EX_MEM   (stall_EX_MEM),
    .stall_MEM_WB   (stall_MEM_WB),
    .flush_IF_ID    (flush_IF_ID),
    .flush_ID_EX    (flush_ID_EX),
    .flush_EX_MEM   (flush_EX_MEM),
    .flush_MEM_WB   (flush_MEM_WB),

    .rD1_f          (rD1_f),
    .rD2_f          (rD2_f),
    .rD1_op         (rD1_op),
    .rD2_op         (rD2_op)
);

// ------------------------- STALL & FLUSH & FORWARDING ------------------------- //

// ------------------------- IF ------------------------- //

PC U_PC (
    // input
    .clk        (clk     ),
    .rst_n      (rst_n   ),
    .stall      (stall_PC),
    .npc        (npc     ),

    // output
    .pc         (pc_IF   )
);

NPC U_NPC (
    // input
    .op         (npc_op_EX),
    .pc         (pc_IF    ),
    .npc_bj     (npc_bj_EX),

    // output
    .npc        (npc      ),
    .pc4        (pc4_IF   )
);

REG_IF_ID U_REG_IF_ID (
    .clk        (clk),
    .rst_n      (rst_n),

    .stall      (stall_IF_ID),
    .flush      (flush_IF_ID),

    .pc_i       (pc_IF),
    .pc_o       (pc_ID),

    .pc4_i      (pc4_IF),
    .pc4_o      (pc4_ID),

    .inst_i     (inst_IF),
    .inst_o     (inst_ID)
);

assign inst_IF = irom_inst;
assign pc_pc = pc_IF;

// ------------------------- IF ------------------------- //

// ------------------------- ID ------------------------- //

assign pcimm_ID = pc_ID + imm_ID;

SEXT U_SEXT (
    // input
    .op         (sext_op_ID),
    .din        (inst_ID[31:7]),

    // output
    .ext        (imm_ID)
);

RF U_RF (
    // input
    .clk        (clk),
    .rst_n      (rst_n),

    .rf_we      (rf_we_WB),

    .rR1        (inst_ID[19:15]),
    .rR2        (inst_ID[24:20]),
    .wR         (wR_WB),
    .wD         (wD_WB),

    // output
    .rD1        (rD1_ID),
    .rD2        (rD2_ID)
);

assign wR_ID = inst_ID[11:7];

CONTROLLER U_CONTROLLER (
    // input
    .inst       (inst_ID),

    // output
    .wd_sel     (wd_sel_ID),
    .alu_op     (alu_op_ID),
    .alub_sel   (alub_sel_ID),
    .rf_we      (rf_we_ID),
    .dram_we    (dram_we_ID),
    .sext_op    (sext_op_ID),
    .branch     (branch_ID),
    .jump       (jump_ID),
    .re1        (re1_ID),
    .re2        (re2_ID),

    .debug_have_inst    (debug_have_inst_ID)
);

REG_ID_EX U_REG_ID_EX (
    .clk        (clk),
    .rst_n      (rst_n),

    .flush      (flush_ID_EX),

    .wd_sel_i   (wd_sel_ID),
    .wd_sel_o   (wd_sel_EX),

    .alu_op_i   (alu_op_ID),
    .alu_op_o   (alu_op_EX),

    .alub_sel_i (alub_sel_ID),
    .alub_sel_o (alub_sel_EX),

    .rf_we_i    (rf_we_ID),
    .rf_we_o    (rf_we_EX),

    .dram_we_i  (dram_we_ID),
    .dram_we_o  (dram_we_EX),

    .branch_i   (branch_ID),
    .branch_o   (branch_EX),

    .jump_i     (jump_ID),
    .jump_o     (jump_EX),

    .pcimm_i    (pcimm_ID),
    .pcimm_o    (pcimm_EX),

    .rD1_i      (rD1_ID),
    .rD1_o      (rD1_EX),

    .rD2_i      (rD2_ID),
    .rD2_o      (rD2_EX),

    .imm_i      (imm_ID),
    .imm_o      (imm_EX),

    .wD_i       (pc4_ID),
    .wD_o       (wD_EX_tmp),

    .wR_i       (wR_ID),
    .wR_o       (wR_EX),

    .rD1_f      (rD1_f),
    .rD2_f      (rD2_f),
    .rD1_op     (rD1_op),
    .rD2_op     (rD2_op),

    .debug_pc_i         (pc_ID),
    .debug_pc_o         (debug_pc_EX),

    .debug_have_inst_i  (debug_have_inst_ID),
    .debug_have_inst_o  (debug_have_inst_EX)
);

// ------------------------- ID ------------------------- //

// ------------------------- EX ------------------------- //

AUXCONTROL U_AUXCONTROL (
    // input
    .branch     (branch_EX),
    .jump       (jump_EX),
    .zero       (zero_EX),
    .sgn        (sgn_EX),
    .pcimm      (pcimm_EX),
    .alu_c      (alu_c_EX),

    // output
    .npc_op     (npc_op_EX),
    .npc_bj     (npc_bj_EX)
);

ALU U_ALU (
    // input
    .alub_sel   (alub_sel_EX),
    .alu_op     (alu_op_EX),

    .rD1        (rD1_EX),
    .rD2        (rD2_EX),
    .imm        (imm_EX),

    // output
    .C          (alu_c_EX),
    .zero       (zero_EX),
    .sgn        (sgn_EX)
);

MUX1 U_MUX1 (
    // input
    .wd_sel     (wd_sel_EX),
    .wD         (wD_EX_tmp),
    .imm        (imm_EX),
    .alu_c      (alu_c_EX),

    // output
    .wD_o       (wD_EX)
);

REG_EX_MEM U_REG_EX_MEM (
    .clk        (clk),
    .rst_n      (rst_n),

    .wd_sel_i   (wd_sel_EX),
    .wd_sel_o   (wd_sel_MEM),

    .rf_we_i    (rf_we_EX),
    .rf_we_o    (rf_we_MEM),

    .dram_we_i  (dram_we_EX),
    .dram_we_o  (dram_we_MEM),

    .wR_i       (wR_EX),
    .wR_o       (wR_MEM),

    .wD_i       (wD_EX),
    .wD_o       (wD_MEM_tmp),

    .alu_c_i    (alu_c_EX),
    .alu_c_o    (alu_c_MEM),

    .rD2_i      (rD2_EX),
    .rD2_o      (rD2_MEM),

    .debug_pc_i         (debug_pc_EX),
    .debug_pc_o         (debug_pc_MEM),

    .debug_have_inst_i  (debug_have_inst_EX),
    .debug_have_inst_o  (debug_have_inst_MEM)
);

// ------------------------- EX ------------------------- //

// ------------------------- MEM ------------------------- //

assign dram_we     = dram_we_MEM;
assign addr        = alu_c_MEM  ;
assign write_data  = rD2_MEM    ;
assign dram_rd_MEM = read_data  ;

MUX2 U_MUX2 (
    // input
    .wd_sel     (wd_sel_MEM),
    .dram_rd    (dram_rd_MEM),
    .wD         (wD_MEM_tmp),

    // output
    .wD_o       (wD_MEM)
);

REG_MEM_WB U_REG_MEM_WB (
    .clk        (clk),
    .rst_n      (rst_n),

    .rf_we_i    (rf_we_MEM),
    .rf_we_o    (rf_we_WB),

    .wR_i       (wR_MEM),
    .wR_o       (wR_WB),

    .wD_i       (wD_MEM),
    .wD_o       (wD_WB),

    .debug_pc_i         (debug_pc_MEM),
    .debug_pc_o         (debug_pc_WB),

    .debug_have_inst_i  (debug_have_inst_MEM),
    .debug_have_inst_o  (debug_have_inst_WB)
);

// ------------------------- MEM ------------------------- //

endmodule
