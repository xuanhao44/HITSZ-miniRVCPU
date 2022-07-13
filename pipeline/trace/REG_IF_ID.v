module REG_IF_ID (
    input  wire        clk,
    input  wire        rst_n,

    input  wire        keep,
    input  wire        flush,

    input  wire [31:0] pc_i,
    output reg  [31:0] pc_o,

    input  wire [31:0] pc4_i,
    output reg  [31:0] pc4_o,

    input  wire [31:0] inst_i,
    output reg  [31:0] inst_o
);

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     pc_o <= 32'b0;
    else if (flush) pc_o <= 32'b0;
    else if (keep) pc_o <= pc_o;
    else            pc_o <= pc_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     pc4_o <= 32'b0;
    else if (flush) pc4_o <= 32'b0;
    else if (keep) pc4_o <= pc4_o;
    else            pc4_o <= pc4_i;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)     inst_o <= 32'b0;
    else if (flush) inst_o <= 32'b0;
    else if (keep) inst_o <= inst_o;
    else            inst_o <= inst_i;
end

endmodule
