module RF (
    // 时钟和复位信号
    input  wire        clk  ,
    input  wire        rst_n,
    // 控制信号
    input  wire        rf_we,
    // 数据信号
    input  wire [4:0]  rR1  ,
    input  wire [4:0]  rR2  ,
    input  wire [4:0]  wR   ,
    input  wire [31:0] wD   ,

    output wire [31:0] rD1  ,
    output wire [31:0] rD2
);

reg [31:0] rf[31:0];

// 寄存器读无时钟限制
assign rD1 = rf[rR1];
assign rD2 = rf[rR2];

/*
 * 另一种实现: 写 0 的时候不判断照常写，读的时候只输出 0
 * assign rD1 = (rR1 == 5'b0) ? 32'b0 : rf[rR1];
 * assign rD2 = (rR2 == 5'b0) ? 32'b0 : rf[rR2];
 */

integer i;

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (i = 0; i <= 31; i = i + 1) begin
            rf[i] <= 32'b0;
        end
    end
        else if (rf_we && wR) rf[wR] <= wD; // 注意向 x0 中的写入无效
        else rf[0] <= 32'b0;
end

endmodule
