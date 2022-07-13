module NPC (
    input  wire        op        ,
    input  wire [31:0] pc        ,
    input  wire [31:0] npc_change,

    output wire [31:0] npc       ,
    output wire [31:0] pc4
);

assign pc4 = pc + 4;

assign npc = op ? npc_change : pc4;

endmodule
