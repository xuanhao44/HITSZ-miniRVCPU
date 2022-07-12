module SEXT (
    // 控制信号
    input  wire [2:0]  op ,
    // 数据信号
    input  wire [24:0] din,

    output reg  [31:0] ext
);

wire sgn = din[24];

always @ (*) begin
    case (op)
        3'b000:  ext = {{20{sgn}}, din[24:13]};
        3'b001:  ext = {27'b0, din[17:13]};
        3'b010:  ext = {{20{sgn}}, din[24:18], din[4:0]};
        3'b011:  ext = {din[24:5], 12'b0};
        3'b100:  ext = {{20{sgn}}, din[0], din[23:18], din[4:1], 1'b0};
        3'b101:  ext = {{12{sgn}}, din[12:5], din[13], din[23:14], 1'b0};
        default: ext = 32'b0;
    endcase
end

endmodule
