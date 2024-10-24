// PC = PC + 4 or PC = JumpAddr

module PCMux(
  input [31:0] PCIn,
  input [31:0] JumpAddr
  input jump,
  input clk,
  output reg [31:0] PCOut
);

reg [31:0] PC;

always @(posedge clk)
begin
  if(jump)
    PC = JumpAddr;
  else
    PC = PCIn + 4;
  
  PCOut = PC;
end

endmodule