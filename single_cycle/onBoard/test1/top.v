/*
 * 偷懒版本的上板测试 1, 通过直接取出 x8 来在数码管上显示 2500 0018
 */
module top (
    input  wire       clk   ,
    input  wire       rst   ,

    output wire [7:0] led_en,
    output wire       led_ca,
	output wire       led_cb,
    output wire       led_cc,
	output wire       led_cd,
	output wire       led_ce,
	output wire       led_cf,
	output wire       led_cg,
	output wire       led_dp
);

wire rst_n = ~rst;

// RF 的 x8, 测试用信号, 预计将在数码管上显示 2500 0018
wire [31:0] rD8      ;
// 测试用时钟频率, 目前设置为 10 MHz
wire        clk_10m  ;

// IROM 交互信号
wire [31:0] pc_pc    ;
wire [31:0] irom_inst;

// DRAM 交互信号
wire        dram_we  ;
wire [31:0] alu_c    ;
wire [31:0] rf_rd2   ;
wire [31:0] dram_rd  ;

// 时钟分频, 无 lock 和 rst, 目前输出 10MHz 供 miniCPU, DRAM 使用
clk_div U_clk_div (
    .clk_in1   (clk        ),
    .clk_out1  (clk_10m    )
);

miniCPU U_miniCPU (
    .clk       (clk_10m    ), // input
    .rst_n     (rst_n      ), // input
    // 连接 inst_mem
    .pc_pc     (pc_pc      ), // output
    .irom_inst (irom_inst  ), // input
    // 连接 data_mem
    .dram_we   (dram_we    ), // output
    .alu_c     (alu_c      ), // output
    .rf_rd2    (rf_rd2     ), // output
    .dram_rd   (dram_rd    ), // input

    .rD8       (rD8        ) // output, for test
);

prgrom U_prgrom (
    // input
    .a         (pc_pc[15:2]), // input wire [13:0] a
    // output
    .spo       (irom_inst  )  // output wire [31:0] spo
);

// 用于下板测试的汇编程序采用 IROM 和 DRAM 统一编址, 因此需要对原 DRAM 的访存地址进行修改
wire [31:0] temp = alu_c - 16'h4000;

dram U_dram (
    // input
    .clk       (clk_10m    ), // input  wire clka
    .we        (dram_we    ), // input  wire [0:0] wea
    .a         (temp[15:2] ), // input  wire [13:0] addra
    .d         (rf_rd2     ), // input  wire [31:0] dina
    // output
    .spo       (dram_rd    )  // output wire [31:0] douta
);

DISPLAY U_DISPLAY (
    // input
    .clk       (clk_10m    ),
    .rst_n     (rst_n      ),

    .data      (rD8        ), // 数据输入

    // output
    .led_en    (led_en     ),
    .led_ca    (led_ca     ),
    .led_cb    (led_cb     ),
    .led_cc    (led_cc     ),
    .led_cd    (led_cd     ),
    .led_ce    (led_ce     ),
    .led_cf    (led_cf     ),
    .led_cg    (led_cg     ),
    .led_dp    (led_dp     )
);

endmodule
