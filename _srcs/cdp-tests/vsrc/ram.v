`define STRINGIFY(x) `"x`"

module inst_mem # (
    ADDR_BITS = 16
)
(
	input [ADDR_BITS - 1:0] a,
    output [31:0] spo
);

integer i, j, mem_file;
// (* RAM_STYLE="BLOCK" *)
reg [32-1:0] mem[(2**20)-1:0];
reg [32-1:0] mem_rd[(2**20)-1:0];
initial begin
    // two nested loops for smaller number of iterations per loop
    // workaround for synthesizer complaints about large loop counts
    for (i = 0; i < 2**20; i = i + 2**(20/2)) begin
        for (j = i; j < i + 2**(20/2); j = j + 1) begin
            mem[j] = 0;
        end
    end
    mem_file = $fopen(`STRINGIFY(`PATH), "r");
    if(mem_file == 0) begin
        $display("[ERROR] Open file %s failed, please check whether file exists!\n", `STRINGIFY(`PATH));
        $fatal;
    end
    $display("[INFO] Instruction ROM initialized with %s", `STRINGIFY(`PATH));
    $fread(mem_rd, mem_file);
    for (i = 0; i < 2**20; i = i + 2**(20/2)) begin
        for (j = i; j < i + 2**(20/2); j = j + 1) begin
            mem[j] = {{mem_rd[j][07:00]}, {mem_rd[j][15:08]}, {mem_rd[j][23:16]}, {mem_rd[j][31:24]}};
        end
    end
end
assign spo = mem[a];

endmodule

module data_mem # (
    ADDR_BITS = 16
)
(
    input clk,
	input [ADDR_BITS - 1: 0] a,
	input we,
	input [31: 0] d,
    output [31:0] spo
);

integer i, j, mem_file;
// (* RAM_STYLE="BLOCK" *)
reg [32-1:0] mem[(2**20)-1:0];
reg [32-1:0] mem_rd[(2**20)-1:0];
initial begin
    // two nested loops for smaller number of iterations per loop
    // workaround for synthesizer complaints about large loop counts
    for (i = 0; i < 2**20; i = i + 2**(20/2)) begin
        for (j = i; j < i + 2**(20/2); j = j + 1) begin
            mem[j] = 0;
        end
    end
    mem_file = $fopen(`STRINGIFY(`PATH), "r");
    if(mem_file == 0) begin
        $display("[ERROR] Open file %s failed, please check whether file exists!\n", `STRINGIFY(`PATH));
        $fatal;
    end
    $display("[INFO] Data RAM initialized with %s", `STRINGIFY(`PATH));
    $fread(mem_rd, mem_file);
    for (i = 0; i < 2**20; i = i + 2**(20/2)) begin
        for (j = i; j < i + 2**(20/2); j = j + 1) begin
            mem[j] = {{mem_rd[j][07:00]}, {mem_rd[j][15:08]}, {mem_rd[j][23:16]}, {mem_rd[j][31:24]}};
        end
    end
end
assign spo = mem[a];
always @(posedge clk) begin
    if(we) begin
        mem[a] = d;
    end
end
endmodule
