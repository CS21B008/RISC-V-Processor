// A PC that is 32 bits and increments by 1 each cycle
// A control input to reset the PC to 0
// A control input to set the PC to a specific value

module PC32Bit(
  input [31:0] PCIn,
  input PCReset,
  input PCSet,
  input clk,
  output reg [31:0] PCOut
);

reg [31:0] PC;

always @(posedge clk)
begin
  PC = PC + 1;
  if(PCReset)
    PC = 0;
  else if(PCSet)
    PC = PCIn;
  
  PCOut = PC;
  
end

endmodule