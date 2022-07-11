`include "param.v"

module DigitDriver (
    input  wire        clk          ,
	input  wire        rst_n        ,

    input  wire        io_en        ,
    input  wire [11:0] io_addr      ,
    input  wire [31:0] io_write_data,

	output wire [7:0]  led_en       ,
	output wire        led_ca       ,
	output wire        led_cb       ,
    output wire        led_cc       ,
	output wire        led_cd       ,
	output wire        led_ce       ,
	output wire        led_cf       ,
	output wire        led_cg       ,
	output wire        led_dp
);

reg [31:0] data;

wire wr = io_en && (io_addr == `DIGIT);

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) data <= 0;
        else if (wr) data <= io_write_data;
end

DISPLAY U_DISPLAY (
    // input
    .clk    (clk   ),
    .rst_n  (rst_n ),

    .data   (data  ), // 数据输入

    // output
    .led_en (led_en),
    .led_ca (led_ca),
    .led_cb (led_cb),
    .led_cc (led_cc),
    .led_cd (led_cd),
    .led_ce (led_ce),
    .led_cf (led_cf),
    .led_cg (led_cg),
    .led_dp (led_dp)
);

endmodule
