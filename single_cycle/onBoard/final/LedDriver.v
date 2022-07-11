`include "param.v"

module LedDriver (
    input  wire        clk          ,
	input  wire        rst_n        ,

    input  wire        io_en        ,
    input  wire [11:0] io_addr      ,
    input  wire [31:0] io_write_data,

	output reg  [23:0] device_led
);

wire wr = io_en && (io_addr == `LED);

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) device_led <= 0;
        else if (wr) device_led <= io_write_data[23:0];
end

endmodule
