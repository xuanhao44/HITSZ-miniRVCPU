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
        4'b0000: C = A & B;
        4'b0001: C = A | B;
        4'b0010: C = A + B;
        4'b0110: C = A + (~B) + 1; // A - B = A + B' + 1
        4'b0101: C = A ^ B;
        4'b1000: C = A << shamt;
        4'b1010: C = A >> shamt;
        4'b1011: C = $signed(A) >>> shamt; // $signed(A) 强调 A 有符号
        default: C = 32'b0;
    endcase
end

assign zero = (C == 32'b0) ? 1'b1 : 1'b0;
assign sgn = C[31];

endmodule
