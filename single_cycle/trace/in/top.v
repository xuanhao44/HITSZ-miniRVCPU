module top (
    input  wire        clk               ,
    input  wire        rst_n             ,

    output wire        debug_wb_have_inst,   // WB 阶段是否有指令 (对单周期 CPU，此 flag 恒为 1)
    output wire [31:0] debug_wb_pc       ,   // WB 阶段的 PC (若 wb_have_inst = 0, 此项可为任意值)
    output wire        debug_wb_ena      ,   // WB 阶段的寄存器写使能 (若 wb_have_inst = 0，此项可为任意值)
    output wire [4:0]  debug_wb_reg      ,   // WB 阶段写入的寄存器号 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
    output wire [31:0] debug_wb_value        // WB 阶段写入寄存器的值 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
);

/*
 * 控制信号
 */

// IF
wire [1:0]  npc_op   ; // 选择 NPC.npc 输出的控制信号
// ID, WB
wire [2:0]  sext_op  ; // 选择 SEXT 中立即数生成模式的控制信号
wire        rf_we    ; // RF 的写控制信号
wire [1:0]  wd_sel   ; // 选择写回寄存器的控制信号
// EX
wire        alub_sel ; // 选择 ALU.B 输入的控制信号
wire [3:0]  alu_op   ; // 选择 ALU 运算方式
wire        alu_zero ; // ALU.C 判 0 信号, 输入控制器
wire        alu_sgn  ; // ALU.C 符号 信号, 输入控制器
// MEM
wire        dram_we  ; // DRAM 的写控制信号

/*
 * 数据信号
 */

// IF
wire [31:0] irom_inst; // IROM 读出的 指令
wire [31:0] npc_pc4  ; // NPC  生成的 PC + 4, 专门用于写回目的寄存器
// ID, WB
wire [31:0] sext_ext ; // SEXT 生成的 立即数
wire [31:0] rf_rd1   ; // RF 读出的寄存器 1 的值
wire [31:0] rf_rd2   ; // RF 读出的寄存器 2 的值
wire [31:0] rf_wd    ; // 由 ID 阶段的 RF 选择后输出出来的 rf.wd

// EX
wire [31:0] alu_c    ; // ALU 的计算结果 ALU.C
// MEM
wire [31:0] dram_rd  ; // DRAM 读出的数据 DRAM.rd

/*
 * 处理 output
 */

// debug_wb_have_inst: WB 阶段是否有指令 (对单周期 CPU，此 flag 恒为 1)
assign debug_wb_have_inst = 1; // 单周期
// debug_wb_pc: WB 阶段的 PC (若 wb_have_inst = 0, 此项可为任意值)
assign debug_wb_pc        = npc_pc4 - 4; // top 模块中没有出现 PC, 故用 NPC.pc4 - 4 代替
// debug_wb_ena: WB 阶段的寄存器写使能 (若 wb_have_inst = 0，此项可为任意值)
assign debug_wb_ena       = rf_we; // 即 RF 的写控制信号
// debug_wb_reg: WB 阶段写入的寄存器号 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
assign debug_wb_reg       = irom_inst[11:7]; // 目的寄存器
// debug_wb_value: WB 阶段写入寄存器的值 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
assign debug_wb_value     = rf_wd; // 由 ID 阶段的 RF 选择后输出出来的 rf.wd

CONTROLLER U_CONTROLLER (
    /*
    * input
     */
    // 从 IROM 得来的 32bit inst, 用于大部分控制信号的生成
    .inst      (irom_inst),
    // 从 ALU  得来的 zero 和 sgn, 特别用于 npc_op 的生成
    .zero      (alu_zero ),
    .sgn       (alu_sgn  ),

    /*
     * output
     */
    .npc_op    (npc_op   ),
    .sext_op   (sext_op  ),
    .rf_we     (rf_we    ),
    .wd_sel    (wd_sel   ),
    .alub_sel  (alub_sel ),
    .alu_op    (alu_op   ),
    .dram_we   (dram_we  )
);

IF U_IF (
    /*
     * input
     */
    // 时钟和复位信号, 由 PC 使用
    .clk       (clk      ),
    .rst_n     (rst_n    ),
    // 控制信号: 1 个
    .npc_op    (npc_op   ),
    // 数据信号
    .sext_ext  (sext_ext ),
    .alu_c     (alu_c    ),

    /*
     * output
     */
    .irom_inst (irom_inst),
    .npc_pc4   (npc_pc4  )
);

ID U_ID (
    /*
     * input
     */
    // 时钟和复位信号, 由 RF 使用
    .clk       (clk      ),
    .rst_n     (rst_n    ),
    // 控制信号: 3 个
    .sext_op   (sext_op  ),
    .rf_we     (rf_we    ),
    .wd_sel    (wd_sel   ),
    // 数据信号
    .irom_inst (irom_inst), // sext 和 RF 都需要 inst
    .alu_c     (alu_c    ), // 用于选择 wd 写回的值 ALU.C
    .dram_rd   (dram_rd  ), // 用于选择 wd 写回的值 DRAM.rd
    .npc_pc4   (npc_pc4  ), // 用于选择 wd 写回的值 NPC.pc4
    // 用于选择 wd 写回的值 SEXT.ext: SEXT.ext 是自家的

    /*
     * output
     */
    .sext_ext  (sext_ext ),
    .rf_rd1    (rf_rd1   ),
    .rf_rd2    (rf_rd2   ),
    .rf_wd     (rf_wd    ) // 内部把 wd 选出来之后又输出
);

EX U_EX (
    /*
     * input
     */
    // 控制信号: 2 个
    .alub_sel  (alub_sel ),
    .alu_op    (alu_op   ),
    // 数据信号
    .rf_rd1    (rf_rd1   ),
    .rf_rd2    (rf_rd2   ),
    .sext_ext  (sext_ext ),

    /*
     * output
     */
    .alu_c     (alu_c    ),
    .alu_zero  (alu_zero ),
    .alu_sgn   (alu_sgn  )
);

MEM U_MEM (
    /*
     * input
     */
    // 时钟信号, 由 DRAM 使用
    .clk       (clk      ),
    // 控制信号: 1 个
    .dram_we   (dram_we  ),
    // 数据信号
    .dram_adr  (alu_c    ),
    .dram_wdin (rf_rd2   ),

    /*
     * output
     */
    .dram_rd   (dram_rd  )
);

endmodule
