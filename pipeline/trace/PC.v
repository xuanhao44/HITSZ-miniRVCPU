module PC (
    input  wire        clk  ,
    input  wire        rst_n,
    input  wire        stall,
    input  wire [31:0] npc  ,

    output reg  [31:0] pc
);

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     pc <= -4;
    else if (stall) pc <= pc;
    else            pc <= npc;
end

endmodule
