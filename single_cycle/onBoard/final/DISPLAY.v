module DISPLAY (
    input  wire        clk   ,
	input  wire        rst_n ,

    input  wire [31:0] data  ,

	output reg  [7:0]  led_en,
	output wire        led_ca,
	output wire        led_cb,
    output wire        led_cc,
	output wire        led_cd,
	output wire        led_ce,
	output wire        led_cf,
	output wire        led_cg,
	output wire        led_dp
);

assign led_dp = 1;

reg [17:0] cnt;
localparam CNT_END = 18'd199_999; // 设置为 2ms, 199_999: 18bit

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) cnt <= 0;// 复位 变为 0
    	else if (cnt == CNT_END) cnt <= 0; // 当到达限值时,也变为 0
    	else cnt <= cnt + 1; // 计数
end

// 使能按照 2ms 的周期变化
always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) led_en <= 8'b1111_1110;
        else if (cnt == CNT_END) led_en <= {led_en[0], led_en[7:1]};
end

// 分解 data 到每一位上, data 的 4bit 对应 1 个 16 进制数字 hex
wire [3:0] hex = (led_en == 8'b0111_1111) ? data[31:28] :
                 (led_en == 8'b1011_1111) ? data[27:24] :
                 (led_en == 8'b1101_1111) ? data[23:20] :
                 (led_en == 8'b1110_1111) ? data[19:16] :
                 (led_en == 8'b1111_0111) ? data[15:12] :
                 (led_en == 8'b1111_1011) ? data[11:8 ] :
                 (led_en == 8'b1111_1101) ? data[7 :4 ] :
                 (led_en == 8'b1111_1110) ? data[3 :0 ] :
                 4'h0;

wire eq0 = (hex == 4'h0);
wire eq1 = (hex == 4'h1);
wire eq2 = (hex == 4'h2);
wire eq3 = (hex == 4'h3);
wire eq4 = (hex == 4'h4);
wire eq5 = (hex == 4'h5);
wire eq6 = (hex == 4'h6);
wire eq7 = (hex == 4'h7);
wire eq8 = (hex == 4'h8);
wire eq9 = (hex == 4'h9);
wire eqa = (hex == 4'ha);
wire eqb = (hex == 4'hb);
wire eqc = (hex == 4'hc);
wire eqd = (hex == 4'hd);
wire eqe = (hex == 4'he);
wire eqf = (hex == 4'hf);

// 七段数码管如何表示 hex
assign led_ca = ~(eq0 | eq2 | eq3 | eq5 | eq6 | eq7 | eq8 | eq9 | eqa | eqe | eqf); // 无 1 4 b c d
assign led_cb = ~(eq0 | eq1 | eq2 | eq3 | eq4 | eq7 | eq8 | eq9 | eqa | eqd); // 无 5 6 b c e f
assign led_cc = ~(eq0 | eq1 | eq3 | eq4 | eq5 | eq6 | eq7 | eq8 | eq9 | eqa | eqb | eqd); // 无 2 c e f
assign led_cd = ~(eq0 | eq2 | eq3 | eq5 | eq6 | eq8 | eqb | eqc | eqd | eqe); // 无 1 4 7 9 a f
assign led_ce = ~(eq0 | eq2 | eq6 | eq8 | eqa | eqb | eqc | eqd | eqe | eqf); // 无 1 3 4 5 7 9
assign led_cf = ~(eq0 | eq4 | eq5 | eq6 | eq8 | eq9 | eqa | eqb | eqe | eqf); // 无 1 2 3 7 c d
assign led_cg = ~(eq2 | eq3 | eq4 | eq5 | eq6 | eq8 | eq9 | eqa | eqb | eqc | eqd | eqe | eqf); // 无 0 1 7

endmodule
