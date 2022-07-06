// use for trace
module miniCPU (
    input  wire        clk      ,
    input  wire        rst_n    ,

    input  wire [31:0] dram_rd  ,
    input  wire [31:0] irom_inst,

    output wire [31:0] pc_pc    ,
    output wire [31:0] alu_c    ,
    output wire [31:0] rf_rd2   ,
    output wire        dram_we  ,
    output wire        rf_we    ,
    output wire [31:0] rf_wd
);

/*
 *  控制信号
 */

// IF
wire [1:0]  npc_op  ; // 选择 NPC.npc 输出的控制信号

// ID, WB
wire [2:0]  sext_op ; // 选择 SEXT 中立即数生成模式的控制信号
// rf_we: RF 的写控制信号, 已经在 output 中定义
wire [1:0]  wd_sel  ; // 选择写回寄存器的控制信号

// EX
wire        alub_sel; // 选择 ALU.B 输入的控制信号
wire [3:0]  alu_op  ; // 选择 ALU 运算方式
wire        alu_zero; // ALU.C 判 0 信号, 输入控制器
wire        alu_sgn ; // ALU.C 符号 信号, 输入控制器

// MEM
// dram_we: DRAM 的写控制信号, 已经在 output 中定义

/*
 * 数据信号
 */

// IF
// irom_inst: IROM 读出的指令, 已经在 input 中由 IROM 提供
wire [31:0] npc_pc4 ; // NPC 生成的 PC + 4, 专门用于写回目的寄存器

// ID, WB
wire [31:0] sext_ext; // SEXT 生成的立即数
wire [31:0] rf_rd1  ; // RF 读出的寄存器 1 的值
// rf_rd2: RF 读出的寄存器 2 的值, 已经在 output 中定义
// rf_wd: 由 ID 阶段的 RF 选择后输出出来的 rf.wd,  已经在 output 中定义

// EX
// alu_c: ALU 的计算结果 ALU.C, 已经在 output 中定义

// MEM
// dram_rd: DRAM 读出的数据 DRAM.rd, 已经在 input 中由 DRAM 提供

CONTROLLER U_CONTROLLER (
    // input
    .inst       (irom_inst),
    .zero       (alu_zero ),
    .sgn        (alu_sgn  ),
    // output
    .npc_op     (npc_op   ),
    .rf_we      (rf_we    ),
    .wd_sel     (wd_sel   ),
    .sext_op    (sext_op  ),
    .alu_op     (alu_op   ),
    .alub_sel   (alub_sel ),
    .dram_we    (dram_we  )
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
    .pc        (pc_pc    ), // 输出内部的 pc, 供外部的 IROM 使用
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


endmodule
