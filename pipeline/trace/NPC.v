module NPC (
    input  wire        op    ,
    input  wire [31:0] pc    ,
    input  wire [31:0] npc_bj, // pc + imm(branch/jal) or alu_c&-1(jalr)

    output wire [31:0] npc   ,
    output wire [31:0] pc4
);

assign pc4 = pc + 4;

assign npc = op ? npc_bj : pc4;

endmodule
