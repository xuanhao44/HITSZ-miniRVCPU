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

assign C = (op == `AND) ? (A & B) :
           (op == `OR ) ? (A | B) :
           (op == `ADD) ? (A + B) :
           (op == `SUB) ? (A + (~B) + 1) : // A - B = A + B' + 1
           (op == `XOR) ? (A ^ B) :
           (op == `SLL) ? (A << shamt) :
           (op == `SRL) ? (A >> shamt) :
           (op == `SRA) ? ($signed(A) >>> shamt) : // $signed(A) 强调 A 有符号
           32'b0;

assign zero = (C == 32'b0) ? 1'b1 : 1'b0;
assign sgn  = C[31];

endmodule
