module REG_EX_MEM (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [1:0]  wd_sel_i,
    output reg  [1:0]  wd_sel_o,

    input  wire        rf_we_i,
    output reg         rf_we_o,

    input  wire        dram_we_i,
    output reg         dram_we_o,

    input  wire [4:0]  wR_i,
    output reg  [4:0]  wR_o,

    input  wire [31:0] wD_i,
    output reg  [31:0] wD_o,

    input  wire [31:0] alu_c_i,
    output reg  [31:0] alu_c_o,

    input  wire [31:0] rD2_i,
    output reg  [31:0] rD2_o,

    input  wire [31:0] pc_i,
    output reg  [31:0] pc_o,

    input  wire        have_inst_i,
    output reg         have_inst_o
);

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) pc_o <= 32'b0;
    else        pc_o <= pc_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) have_inst_o <= 1'b0;
    else        have_inst_o <= have_inst_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) wd_sel_o <= 2'b0;
    else        wd_sel_o <= wd_sel_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) rf_we_o <= 1'b0;
    else        rf_we_o <= rf_we_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) dram_we_o <= 1'b0;
    else        dram_we_o <= dram_we_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) wR_o <= 5'b0;
    else        wR_o <= wR_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) wD_o <= 32'b0;
    else        wD_o <= wD_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) alu_c_o <= 32'b0;
    else        alu_c_o <= alu_c_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) rD2_o <= 32'b0;
    else        rD2_o <= rD2_i;
end

endmodule
