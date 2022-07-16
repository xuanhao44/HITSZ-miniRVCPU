`include "param.v"

module BUS (
    // cpu -BUS
    input  wire        cpu_mem_we    ,
    input  wire [31:0] cpu_addr      ,
    input  wire [31:0] cpu_write_data,
    output wire [31:0] cpu_read_data ,

    // BUS - MEM
    output wire        mem_we        ,
    output wire [31:0] mem_addr      ,
    output wire [31:0] mem_write_data,
    input  wire [31:0] mem_read_data ,

    // BUS - IO
    output wire        io_en         ,
    output wire [11:0] io_addr       ,
    output wire [31:0] io_write_data ,
    input  wire [31:0] io_read_data
);

// IO 设备使能·
assign io_en = (cpu_addr[31:12] == `IO);

// 判断 cpu 传来的地址是否是传向 MEM 的地址
wire is_mem_addr = ~io_en;

// cpu_read_data
assign cpu_read_data = (cpu_mem_we == `READ) ? (io_en ? io_read_data : mem_read_data) : 32'h0000_0000;

// MEM 写使能
assign mem_we = is_mem_addr && (cpu_mem_we == `WRITE);
// 传入 MEM 的地址
assign mem_addr = is_mem_addr ? cpu_addr : 32'hffff_ffff;
// 写入 MEM 的数据
assign mem_write_data = mem_we ? cpu_write_data : 32'h0000_0000;

// IO 写使能
wire io_we = io_en && (cpu_mem_we == `WRITE);
// 传入 IO 的地址
assign io_addr = io_en ? cpu_addr[11:0] : 12'hfff;
// 写入 IO 的数据
assign io_write_data = io_we ? cpu_write_data : 32'h0000_0000;

endmodule
