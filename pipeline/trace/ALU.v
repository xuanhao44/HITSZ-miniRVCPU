`include "param.v"

module ALU (
    input  wire        alub_sel,
    input  wire [3:0]  alu_op  ,

    input  wire [31:0] rD1     ,
    input  wire [31:0] rD2     ,
    input  wire [31:0] imm     ,

    output reg  [31:0] C       ,
    output wire        zero    ,
    output wire        sgn
);

wire [31:0] A = rD1;
wire [31:0] B = (alub_sel == 1'b0) ? rD2 : imm;

/*
 * 简单的说, 在 RV-32I 中, 实现移位指令时, B 有用的位数只有低五位
 * 详细见 RISC-V 手册 P159
 */

wire [4:0] shamt = B[4:0];

always @ (*) begin
    case (alu_op)
        `AND   : C = A & B;
        `OR    : C = A | B;
        `ADD   : C = A + B;
        `SUB   : C = A + (~B) + 1; // A - B = A + B' + 1
        `XOR   : C = A ^ B;
        `SLL   : C = A << shamt;
        `SRL   : C = A >> shamt;
        `SRA   : C = $signed(A) >>> shamt; // $signed(A) 强调 A 有符号
        default: C = 32'b0;
    endcase
end

assign zero = (C == 32'b0) ? 1'b1 : 1'b0;
assign sgn = C[31];

endmodule
