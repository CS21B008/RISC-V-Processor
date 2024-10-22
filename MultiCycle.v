// A Multi-Cycle Processor

module MultiCycle (
    input clk,
    input reset,
    input reg [31:0] Data,
    output reg [31:0] Address
);

reg [31:0] PCIn;
wire [31:0] PCOut;

PC32Bit PC32Bit(
    .PCIn(PCIn),
    .PCReset(reset),
    .clk(clk),
    .PCOut(PCOut)
);

endmodule