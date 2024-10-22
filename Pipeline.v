// The Whole pipeline of the processor
// The pipeline is divided into 5 stages:
// 1. Fetch
// 2. Decode
// 3. Execute
// 4. Memory
// 5. WriteBack
// 

module Pipeline (
    input clk,
    input reset,
    input reg [31:0] instruction,
    input reg [31:0] data,
    output reg [31:0] instructionAddress,
    output reg [31:0] dataAddress
);

reg [31:0] PCIn;
wire [31:0] PCOut;
reg [31:0] IF_ID_InstAddIn;
wire [31:0] IF_ID_InstAddOut;
wire [31:0] IF_ID_InstOut;
reg [31:0] PC;

PC32Bit PC32Bit(
    .PCIn(PCIn),
    .PCReset(reset),
    .clk(clk),
    .PCOut(PCOut)
);

IF_ID_reg IF_ID_reg(
    .clk(clk),
    .instructionAddress(IF_ID_InstAddIn),
    .instruction(instruction),
    .instructionAddressOut(IF_ID_InstAddOut),
    .instructionOut(IF_ID_InstOut)
);

always @(posedge clk) begin
    instructionAddress = PCOut;
    PC = PCOut + 1;
    IF_ID_InstAddIn = PC;

end

endmodule