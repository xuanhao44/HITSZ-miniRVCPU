`include "param.v"

module ALU (
    // 控制信号
    input  wire [3:0]  op  ,
    // 数据信号
    input  wire [31:0] A   ,
    input  wire [31:0] B   ,

    output wire [31:0] C   ,
    output wire        zero,
    output wire        sgn
);

/*
 * 简单的说, 在 RV-32I 中, 实现移位指令时, B 有用的位数只有低五位
 * 详细见 RISC-V 手册 P159
 */

wire [4:0] shamt = B[4:0];

// 谜之问题, 不知道为什么必须要用 reg 存
reg  [31:0] calc;

always @ (*) begin
    case (op)
        `AND   : calc = A & B;
        `OR    : calc = A | B;
        `ADD   : calc = A + B;
        `SUB   : calc = A + (~B) + 1; // A - B = A + B' + 1
        `XOR   : calc = A ^ B;
        `SLL   : calc = A << shamt;
        `SRL   : calc = A >> shamt;
        `SRA   : calc = $signed(A) >>> shamt; // $signed(A) 强调 A 有符号
        default: calc = 32'b0;
    endcase
end

assign C = calc;

assign zero = (calc == 32'b0) ? 1'b1 : 1'b0;
assign sgn  = calc[31];

endmodule
