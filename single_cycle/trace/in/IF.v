module IF (
    input  wire        clk      ,
    input  wire        rst_n    ,

    input  wire [1:0]  npc_op   ,

    input  wire [31:0] sext_ext ,
    input  wire [31:0] alu_c    ,

    output wire [31:0] irom_inst,
    output wire [31:0] npc_pc4
);

wire [31:0] pc;
wire [31:0] npc;

PC U_PC (
    // input
    .clk   (clk     ),
    .rst_n (rst_n   ),
    .din   (npc     ),
    // output
    .pc    (pc      )
);

NPC U_NPC (
    // input
    .op    (npc_op  ),
    .pc    (pc      ),
    .imm   (sext_ext),
    .alu_c (alu_c   ),
    // output
    .npc   (npc     ),
    .pc4   (npc_pc4 )
);

inst_mem imem (
    // input
    .a    (pc[15:2] ), // input wire [13:0] a
    // output
    .spo  (irom_inst)  // output wire [31:0] spo
);

/*
 * miniRV-1 的每条指令都是 4 个字节，因此 PC 的值是 4 的整数倍，即 PC[1:0] 恒等于 2'b00
 * 相应地，IROM 的数据宽度是 32 位，则每个数据单元正好存放一条指令
 * 因此使用 PC[15:2] 作为地址来访问 IROM
 * 64KB IROM 32bit × 65536
 */

endmodule
