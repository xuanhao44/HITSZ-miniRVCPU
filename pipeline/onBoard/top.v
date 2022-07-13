module top (
    input  wire        clk       ,
    input  wire        rst       ,

    // 24 位拨码开关
    input  wire [23:0] device_sw ,
    // 24 个 led
    output wire [23:0] device_led,

    // 七段数码管
    output wire [7:0]  led_en    ,
    output wire        led_ca    ,
	output wire        led_cb    ,
    output wire        led_cc    ,
	output wire        led_cd    ,
	output wire        led_ce    ,
	output wire        led_cf    ,
	output wire        led_cg    ,
	output wire        led_dp
);

wire rst_n = ~rst;

// 测试用时钟频率
wire        clk_test      ;

// IROM 交互信号
wire [31:0] pc_pc         ;
wire [31:0] irom_inst     ;

// cpu - BUS 交互
wire        cpu_mem_we    ;
wire [31:0] cpu_addr      ;
wire [31:0] cpu_write_data;
wire [31:0] cpu_read_data ;

// BUS - MEM 交互
wire        mem_we        ;
wire [31:0] mem_addr      ;
wire [31:0] mem_write_data;
wire [31:0] mem_read_data ;

// BUS - IO 设备交互
wire        io_en         ;
wire [11:0] io_addr       ;
wire [31:0] io_write_data ;
wire [31:0] io_read_data  ;

// 时钟分频, 无 lock 和 rst, 输出 指定的时钟频率供部件使用
clk_div U_clk_div (
    .clk_in1        (clk                ),
    .clk_out1       (clk_test           )
);

prgrom U_prgrom (
    // input
    .a              (pc_pc[15:2]        ), // input wire [13:0] a
    // output
    .spo            (irom_inst          )  // output wire [31:0] spo
);

miniCPU U_miniCPU (
    .clk            (clk_test           ), // input
    .rst_n          (rst_n              ), // input

    // 连接 prgrom
    .pc_pc          (pc_pc              ), // output
    .irom_inst      (irom_inst          ), // input

    // 连接 BUS
    .dram_we        (cpu_mem_we         ), // output
    .addr           (cpu_addr           ), // output
    .write_data     (cpu_write_data     ), // output
    .read_data      (cpu_read_data      )  // input
);

BUS U_BUS (
    // cpu -BUS
    .cpu_mem_we     (cpu_mem_we         ), // input
    .cpu_addr       (cpu_addr           ), // input
    .cpu_write_data (cpu_write_data     ), // input
    .cpu_read_data  (cpu_read_data      ), // output

    // BUS - MEM
    .mem_we         (mem_we             ), // output
    .mem_addr       (mem_addr           ), // output
    .mem_write_data (mem_write_data     ), // output
    .mem_read_data  (mem_read_data      ), // input

    // BUS - IO
    .io_en          (io_en              ), // output
    .io_addr        (io_addr            ), // output
    .io_write_data  (io_write_data      ), // output
    .io_read_data   (io_read_data       )  // input
);

// 包装一下 dram
MEM U_MEM (
    // input
    .clk            (clk_test           ),
    .mem_we         (mem_we             ),
    // 用于下板测试的汇编程序采用 IROM 和 DRAM 统一编址, 因此需要对原 DRAM 的访存地址进行修改
    .mem_addr       (mem_addr - 16'h4000),
    .mem_write_data (mem_write_data     ),
    // output
    .mem_read_data  (mem_read_data      )
);

SwitchDriver U_SwitchDriver (
    // input
    .io_en          (io_en              ),
    .io_addr        (io_addr            ),
    // 无 io_write_data

    .device_sw      (device_sw          ),

    // output
    .io_read_data   (io_read_data       )
);

LedDriver U_LedDriver (
    // input
    .clk            (clk_test           ),
    .rst_n          (rst_n              ),

    .io_en          (io_en              ),
    .io_addr        (io_addr            ),
    .io_write_data  (io_write_data      ),
    // 无 io_read_data

    // output
    .device_led     (device_led         )
);

DigitDriver U_DigitDriver (
    // input
    .clk            (clk_test           ),
    .rst_n          (rst_n              ),

    .io_en          (io_en              ),
    .io_addr        (io_addr            ),
    .io_write_data  (io_write_data      ),
    // 无 io_read_data

    // output
    .led_en         (led_en             ),
    .led_ca         (led_ca             ),
    .led_cb         (led_cb             ),
    .led_cc         (led_cc             ),
    .led_cd         (led_cd             ),
    .led_ce         (led_ce             ),
    .led_cf         (led_cf             ),
    .led_cg         (led_cg             ),
    .led_dp         (led_dp             )
);

endmodule
