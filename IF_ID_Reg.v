// A register to store the intermediate value between stages Instruction Fetch and Instruction Decode

module IF_ID_reg(
    input clk,
    input [31:0] instructionAddress,
    input [31:0] instruction,
    output reg [31:0] instructionAddressOut,
    output reg [31:0] instructionOut
);

always @(posedge clk) 
begin
    instructionAddressOut = instructionAddress;
    instructionOut = instruction;
end

endmodule