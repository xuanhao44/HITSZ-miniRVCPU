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

wire clk_display;
wire rst_n;
wire busy;
wire [31:0] rD19;

assign rst_n = ~rst;
assign busy = 1'b0;

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
    .rf_wd     (rf_wd      ), // output

    .rD19      (rD19       ) // output, for test
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
    .clk       (clk        ), // input  wire clka
    .we        (dram_we    ), // input  wire [0:0] wea
    .a         (temp[15:2] ), // input  wire [13:0] addra
    .d         (rf_rd2     ), // input  wire [31:0] dina
    // output
    .spo       (dram_rd    )  // output wire [31:0] douta
);

CLK_DIV U_CLK_DIV (
    .clk_in    (clk        ), // input
    .rst_n     (rst_n      ), // input
    .clk_out   (clk_display)  // output
);

DISPLAY U_DISPLAY (
    // input
    .clk       (clk_display),
    .rst_n     (rst_n      ),

    .busy      (busy       ),

    .z1        (rD19[31:24]),
    .r1        (rD19[23:16]),
    .z2        (rD19[15:8 ]),
    .r2        (rD19[7 :0 ]),

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
