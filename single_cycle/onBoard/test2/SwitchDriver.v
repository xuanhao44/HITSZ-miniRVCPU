`include "param.v"

module SwitchDriver (
    input  wire        io_en        ,
    input  wire [11:0] io_addr      ,

    input  wire [23:0] device_sw    ,

	output wire [31:0] io_read_data
);

wire wr = io_en && (io_addr == `SWITCH);

assign io_read_data = wr ? {8'b0, device_sw} : 32'h0000_0000;

endmodule
