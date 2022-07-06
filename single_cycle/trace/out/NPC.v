`include "param.v"

module NPC (
    input  wire [1:0]  op   ,
    input  wire [31:0] pc   ,
    input  wire [31:0] imm  ,
    input  wire [31:0] alu_c,
    output reg  [31:0] npc  ,
    output wire [31:0] pc4
);

assign pc4 = pc + 4;

always @ (*) begin
    case (op)
        `PC_4   : npc = pc4;                 // pc + 4
        `PC_IMM : npc = pc + imm;            // branch, jal: pc + imm
        `RD1_IMM: npc = {alu_c[31:1], 1'b0}; // jalr: ALU.C = rd1 + imm
        default : npc = pc4;
    endcase
end

endmodule
