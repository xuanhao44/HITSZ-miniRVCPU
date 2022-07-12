module top (
    input  wire        clk               ,
    input  wire        rst_n             ,

    output wire        debug_wb_have_inst,   // WB 阶段是否有指令 (对单周期 CPU，此 flag 恒为 1)
    output wire [31:0] debug_wb_pc       ,   // WB 阶段的 PC (若 wb_have_inst = 0, 此项可为任意值)
    output wire        debug_wb_ena      ,   // WB 阶段的寄存器写使能 (若 wb_have_inst = 0，此项可为任意值)
    output wire [4:0]  debug_wb_reg      ,   // WB 阶段写入的寄存器号 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
    output wire [31:0] debug_wb_value        // WB 阶段写入寄存器的值 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
);

wire [31:0] pc_pc    ;
wire [31:0] irom_inst;

wire        dram_we  ;
wire        rf_we    ;
wire [31:0] dram_rd  ;
wire [31:0] alu_c    ;
wire [31:0] rf_rd2   ;
wire [31:0] rf_wd    ;

miniCPU U_miniCPU (
    .clk       (clk        ), // input
    .rst_n     (rst_n      ), // input
    // 连接 inst_mem
    .pc_pc     (pc_pc      ), // output
    .irom_inst (irom_inst  ), // input
    // 连接 data_mem
    .dram_we   (dram_we    ), // output
    .alu_c     (alu_c      ), // output
    .rf_rd2    (rf_rd2     ), // output
    .dram_rd   (dram_rd    ), // input

    .rf_we     (rf_we      ), // output
    .rf_wd     (rf_wd      )  // output
);

// 下面两个模块，只需要实例化并连线，不需要添加文件

/*
 * miniRV-1 的每条指令都是 4 个字节，因此 PC 的值是 4 的整数倍，即 PC[1:0] 恒等于 2'b00
 * 相应地，IROM 的数据宽度是 32 位，则每个数据单元正好存放一条指令
 * 因此使用 PC[15:2] 作为地址来访问 IROM
 * 64KB IROM 32bit × 65536
 */
inst_mem imem (
    // input
    .a         (pc_pc[15:2]), // input wire [13:0] a
    // output
    .spo       (irom_inst  )  // output wire [31:0] spo
);

// 64KB DRAM 32bit × 65536
data_mem dmem (
    // input
    .clk       (clk        ), // input  wire clka
    .we        (dram_we    ), // input  wire [0:0] wea
    .a         (alu_c[15:2]), // input  wire [13:0] addra
    .d         (rf_rd2     ), // input  wire [31:0] dina
    // output
    .spo       (dram_rd    )  // output wire [31:0] douta
);

// debug_wb_have_inst: WB 阶段是否有指令 (对单周期 CPU，此 flag 恒为 1)
assign debug_wb_have_inst = 1; // 单周期
// debug_wb_pc: WB 阶段的 PC (若 wb_have_inst = 0, 此项可为任意值)
assign debug_wb_pc        = pc_pc; // PC.pc 的输出
// debug_wb_ena: WB 阶段的寄存器写使能 (若 wb_have_inst = 0，此项可为任意值)
assign debug_wb_ena       = rf_we; // 即 RF 的写控制信号
// debug_wb_reg: WB 阶段写入的寄存器号 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
assign debug_wb_reg       = irom_inst[11:7]; // 目的寄存器
// debug_wb_value: WB 阶段写入寄存器的值 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
assign debug_wb_value     = rf_wd; // 由 ID 阶段的 RF 选择后输出出来的 rf_wd

endmodule
