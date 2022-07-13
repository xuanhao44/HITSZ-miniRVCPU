module top (
    input  wire        clk               ,
    input  wire        rst_n             ,

    output wire        debug_wb_have_inst,   // WB 阶段是否有指令 (对单周期 CPU，此 flag 恒为 1)
    output wire [31:0] debug_wb_pc       ,   // WB 阶段的 PC (若 wb_have_inst = 0, 此项可为任意值)
    output wire        debug_wb_ena      ,   // WB 阶段的寄存器写使能 (若 wb_have_inst = 0，此项可为任意值)
    output wire [4:0]  debug_wb_reg      ,   // WB 阶段写入的寄存器号 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
    output wire [31:0] debug_wb_value        // WB 阶段写入寄存器的值 (若 wb_ena 或 wb_have_inst = 0, 此项可为任意值)
);

wire [31:0] pc_pc     ;
wire [31:0] irom_inst ;

wire        dram_we   ;
wire [31:0] addr      ;
wire [31:0] write_data;
wire [31:0] read_data ;

inst_mem imem (
    // input
    .a                  (pc_pc[15:2]       ),  // input wire [13:0] a
    // output
    .spo                (irom_inst         )   // output wire [31:0] spo
);

miniCPU U_miniCPU (
    .clk                (clk               ),
    .rst_n              (rst_n             ),

    // 连接 IROM
    .pc_pc              (pc_pc             ), // output
    .irom_inst          (irom_inst         ), // input

    // 连接 MEM
    .dram_we            (dram_we           ), // output
    .addr               (addr              ), // output
    .write_data         (write_data        ), // output
    .read_data          (read_data         ), // input

    .debug_wb_have_inst (debug_wb_have_inst),
    .debug_wb_pc        (debug_wb_pc       ),
    .debug_wb_ena       (debug_wb_ena      ),
    .debug_wb_reg       (debug_wb_reg      ),
    .debug_wb_value     (debug_wb_value    )
);

// 包装一下 dram
MEM U_MEM (
    // input
    .clk                (clk               ),
    .mem_we             (dram_we           ),

    .mem_addr           (addr              ),
    .mem_write_data     (write_data        ),
    // output
    .mem_read_data      (read_data         )
);

endmodule
