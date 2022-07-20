`include "param.v"

module HAZARD_DETECTION (
    input  wire        clk        ,
    input  wire        rst_n      ,

    // 用于判断是否是 LOAD 指令
    input  wire [1:0]  wd_sel_EX  ,

    // 用于判断 rD1/rD2 是否被使用
    input  wire        rD1_used   ,
    input  wire        rD2_used   ,

    input  wire        rf_we_EX   ,
    input  wire        rf_we_MEM  ,
    input  wire        rf_we_WB   ,

    input  wire [4:0]  rR1_ID     ,
    input  wire [4:0]  rR2_ID     ,

    input  wire [4:0]  wR_EX      ,
    input  wire [4:0]  wR_MEM     ,
    input  wire [4:0]  wR_WB      ,

    input  wire [31:0] wD_EX      ,
    input  wire [31:0] wD_MEM     ,
    input  wire [31:0] wD_WB      ,

    input  wire        npc_op     ,

    // 暂停(保持)使能
    output reg         keep_PC    ,
    output reg         keep_IF_ID ,

    // 清空使能
    output reg         flush_IF_ID,
    output reg         flush_ID_EX,

    // 前递的使能
    output wire        rD1_op     ,
    output wire        rD2_op     ,
    // 前递数据
    output reg  [31:0] rD1_forward,
    output reg  [31:0] rD2_forward
);

// 数据冒险: RAW

// RAW - A 相邻
wire RAW_A_rD1 = (wR_EX  == rR1_ID) && rf_we_EX  && rD1_used && wR_EX;
wire RAW_A_rD2 = (wR_EX  == rR2_ID) && rf_we_EX  && rD2_used && wR_EX;

// RAW - B 间隔一条
wire RAW_B_rD1 = (wR_MEM == rR1_ID) && rf_we_MEM && rD1_used && wR_MEM;
wire RAW_B_rD2 = (wR_MEM == rR2_ID) && rf_we_MEM && rD2_used && wR_MEM;

// RAW - C 间隔两条
wire RAW_C_rD1 = (wR_WB  == rR1_ID) & rf_we_WB  && rD1_used && wR_WB;
wire RAW_C_rD2 = (wR_WB  == rR2_ID) & rf_we_WB  && rD2_used && wR_WB;

// 逻辑与就是 &&, 别以为 1 位就真是 按位与和逻辑与一样, 至少含义是不一样的; 另外不是一位的话就不能使用按位与代替逻辑与了, 切记

// 前递的使能
assign rD1_op = RAW_A_rD1 || RAW_B_rD1 || RAW_C_rD1;
assign rD2_op = RAW_A_rD2 || RAW_B_rD2 || RAW_C_rD2;

// if - else 体现了优先级: 相邻 > 间隔 1 条 > 间隔 2 条
always @ (*) begin
    if (RAW_A_rD1)      rD1_forward = wD_EX;
    else if (RAW_B_rD1) rD1_forward = wD_MEM;
    else if (RAW_C_rD1) rD1_forward = wD_WB;
    else                rD1_forward = 32'b0;
end

always @ (*) begin
    if (RAW_A_rD2)      rD2_forward = wD_EX;
    else if (RAW_B_rD2) rD2_forward = wD_MEM;
    else if (RAW_C_rD2) rD2_forward = wD_WB;
    else                rD2_forward = 32'b0;
end

// 载入-使用型数据冒险: 相邻的数据冒险 + load 指令(代表是写回是 rd)
// 处理方式: 1) 停顿, 插入气泡(PC, IF/ID 不变; ID/EX 置 0); 2) 前递(前面已经写好了逻辑)
wire load_use_hazard = (RAW_A_rD1 || RAW_A_rD2) & (wd_sel_EX == `DRAM_RD);

// 控制冒险
// 处理方式: 静态分支预测, 总是预测不跳转; 清除后二条指令, 即 flush IF/ID, ID/EX
wire control_hazard = npc_op;

always @ (*) begin
    if (load_use_hazard) keep_PC = 1'b1;
    else                 keep_PC = 1'b0;
end

always @ (*) begin
    if (load_use_hazard) keep_IF_ID = 1'b1;
    else                 keep_IF_ID = 1'b0;
end

always @ (*) begin
    if (control_hazard) flush_IF_ID = 1'b1;
    else                flush_IF_ID = 1'b0;
end

always @ (*) begin
    if (load_use_hazard || control_hazard) flush_ID_EX = 1'b1;
    else                                   flush_ID_EX = 1'b0;
end

endmodule
