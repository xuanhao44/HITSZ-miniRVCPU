`include "param.v"

module SEXT (
    // 控制信号
    input  wire [2:0]  op ,
    // 数据信号
    input  wire [24:0] din, // inst[31:7]

    output reg  [31:0] ext
);

wire sgn;
assign sgn = din[24];

always @ (*) begin
    case (op)
        `IMM_I    :
            // sgn(20bit) + inst[31:20](12bit)
            ext = {{20{sgn}}, din[24:13]};
        `IMM_SHIFT:
            // 0(27bit) + inst[24:20](5bit)
            ext = {27'b0, din[17:13]};
        `IMM_S    :
            // sgn(20bit) + inst[31:25](7bit) + inst[11:7](5bit) or sgn(21bit) + inst[30:25](6bit) + inst[11:7](5bit)
            ext = {{20{sgn}}, din[24:18], din[4:0]};
        `IMM_U    :
            // inst[31:12](20bit) + 0(12bit)
            ext = {din[24:5], 12'b0};
        `IMM_B    :
            // sgn(20bit) + inst[7](1bit) + inst[30:25](6bit) + inst[11:8](4bit) + 0(1bit)
            ext = {{20{sgn}}, din[0], din[23:18], din[4:1], 1'b0};
        `IMM_J    :
            // sgn(12bit) + inst[19:12](8bit) + inst[20](1bit) + inst[30:22](9bit) + 0(1bit)
            ext = {{12{sgn}}, din[12:5], din[13], din[23:14], 1'b0};
        default   :
            ext = 32'b0;
    endcase
end

endmodule
