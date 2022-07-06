module CLK_DIV (
    input  wire clk_in ,
    input  wire rst_n  ,
    output reg  clk_out
);

localparam CNT_END = 18'd199_999; // 设置为 2ms

reg [17:0] cnt; // 199_999 18bit

always @ (posedge clk_in or negedge rst_n) begin
    if (~rst_n) cnt <= 0;
        else if (cnt < CNT_END) cnt <= cnt + 1;
        else cnt <= 0;
end

always @ (posedge clk_in or negedge rst_n) begin
    if (~rst_n) clk_out <= 1'b0;
        else if (cnt == CNT_END) clk_out <= ~clk_out;
        else clk_out <= clk_out;
end

endmodule
