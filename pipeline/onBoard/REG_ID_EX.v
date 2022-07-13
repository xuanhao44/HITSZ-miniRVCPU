module REG_ID_EX (
    input  wire        clk        ,
    input  wire        rst_n      ,

    input  wire        flush      ,

    input  wire [1:0]  wd_sel_i   ,
    output reg  [1:0]  wd_sel_o   ,

    input  wire [3:0]  alu_op_i   ,
    output reg  [3:0]  alu_op_o   ,

    input  wire        alub_sel_i ,
    output reg         alub_sel_o ,

    input  wire        rf_we_i    ,
    output reg         rf_we_o    ,

    input  wire        dram_we_i  ,
    output reg         dram_we_o  ,

    input  wire [2:0]  branch_i   ,
    output reg  [2:0]  branch_o   ,

    input  wire [1:0]  jump_i     ,
    output reg  [1:0]  jump_o     ,

    input  wire [31:0] pc_imm_i   ,
    output reg  [31:0] pc_imm_o   ,

    input  wire [31:0] imm_i      ,
    output reg  [31:0] imm_o      ,

    input  wire [31:0] pc4_i      ,
    output reg  [31:0] pc4_o      ,

    input  wire [4:0]  wR_i       ,
    output reg  [4:0]  wR_o       ,

    input  wire [31:0] rD1_i      ,
    output reg  [31:0] rD1_o      ,

    input  wire [31:0] rD2_i      ,
    output reg  [31:0] rD2_o      ,

    // forwarding
    input  wire        rD1_op     ,
    input  wire        rD2_op     ,
    input  wire [31:0] rD1_forward,
    input  wire [31:0] rD2_forward
);

// 可能接收前递 rD1/ rD2
always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)      rD1_o <= 32'b0;
    else if (rD1_op) rD1_o <= rD1_forward; // 由于 考虑前递，故排除在 flush 之外
    else             rD1_o <= rD1_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)      rD2_o <= 32'b0;
    else if (rD2_op) rD2_o <= rD2_forward;
    else             rD2_o <= rD2_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     wd_sel_o <= 2'b0;
    else if (flush) wd_sel_o <= 2'b0;
    else            wd_sel_o <= wd_sel_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     alu_op_o <= 4'b0;
    else if (flush) alu_op_o <= 4'b0;
    else            alu_op_o <= alu_op_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     alub_sel_o <= 1'b0;
    else if (flush) alub_sel_o <= 1'b0;
    else            alub_sel_o <= alub_sel_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     rf_we_o <= 1'b0;
    else if (flush) rf_we_o <= 1'b0;
    else            rf_we_o <= rf_we_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     dram_we_o <= 1'b0;
    else if (flush) dram_we_o <= 1'b0;
    else            dram_we_o <= dram_we_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     branch_o <= 3'b0;
    else if (flush) branch_o <= 3'b0;
    else            branch_o <= branch_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     jump_o <= 2'b0;
    else if (flush) jump_o <= 2'b0;
    else            jump_o <= jump_i;
end

// 数据信号可以选择不 flush, 也可以 flush; 这里选择全部 flush

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     pc_imm_o <= 32'b0;
    else if (flush) pc_imm_o <= 32'b0;
    else            pc_imm_o <= pc_imm_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     imm_o <= 32'b0;
    else if (flush) imm_o <= 32'b0;
    else            imm_o <= imm_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     pc4_o <= 32'b0;
    else if (flush) pc4_o <= 32'b0;
    else            pc4_o <= pc4_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     wR_o <= 5'b0;
    else if (flush) wR_o <= 5'b0;
    else            wR_o <= wR_i;
end

endmodule
