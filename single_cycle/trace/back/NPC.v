`include "param.v"

module NPC (
    input  wire [1:0]  op   ,
    input  wire [31:0] pc   ,
    input  wire [31:0] imm  ,
    input  wire [31:0] alu_c,
    output wire [31:0] npc  ,
    output wire [31:0] pc4
);

assign pc4 = pc + 4;

assign npc = (op == `PC_4) ? pc4 : // pc + 4
             (op == `PC_IMM) ? (pc + imm) : // branch, jal: pc + imm
             (op == `RD1_IMM) ? {alu_c[31:1], 1'b0} : // jalr: ALU.C = rd1 + imm
             pc4;

endmodule
