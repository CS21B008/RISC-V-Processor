// 32-bit ALU supports the following functions:
// Integer type: ADD,SUB,MUL,DIV,AND,OR,NOT,SLT,SLTU,SGT,SGTU,SEQ,SLL,SRL,SLA,SRA
// ORDER: ADD,SUB,SEQ,SLT,SGT,AND,OR,NOT,SLTU,SGTU,SLL,SRL,SLA,SRA,MUL,DIV
// Floating point type: need to do in the future


module ALU32Bit(
  input [31:0] A,
  input [31:0] B,
  input [3:0] ALUOp,
  output reg [31:0] ALUOut,
  output reg Zero,
  output reg LT,
  output reg GT,
  output reg Overflow
);


always @(*) begin
  // Reset flags
  Zero = 1'b0;
  LT = 1'b0;
  GT = 1'b0;
  Overflow = 1'b0;
  
  // ALU operations based on ALU_Sel
  case(ALUOp)
      4'b0000: ALUOut = A + B;           // Add
      4'b0001: ALUOut = A - B;           // Subtract
      4'b0010: ALUOut = (A == B) ? 32'h00000001 : 32'h00000000; // Equal
      4'b0011: ALUOut = ($Signed(A) < $Signed(B)) ? 32'h00000001 : 32'h00000000;  // SLT (Signed Comparison)
      4'b0100: ALUOut = ($Signed(A) > $Signed(B)) ? 32'h00000001 : 32'h00000000;  // Greater than (Signed)
      4'b0101: ALUOut = A & B;           // AND
      4'b0110: ALUOut = A | B;           // OR
      4'b0111: ALUOut = ~A;              // NOT
      4'b1000: ALUOut = (A < B) ? 32'h00000001 : 32'h00000000;  // SLTU (Unsigned Comparison)
      4'b1001: ALUOut = (A > B) ? 32'h00000001 : 32'h00000000;  // Greater than (Unsigned)
      4'b1010: ALUOut = A << B;          // Shift Left Logical
      4'b1011: ALUOut = A >> B;          // Shift Right Logical
      4'b1100: ALUOut = $Signed(A) << B;          // Shift Left Arithmetic
      4'b1101: ALUOut = $Signed(A) >> B;          // Shift Right Arithmetic
      4'b1110: ALUOut = A * B;
      4'b1111: ALUOut = A / B;
      default: ALUOut = 32'h00000000;        // Default output is zero
  endcase

  // Set flags based on output
  Zero = (ALUOut == 32'h00000000) ? 1'b1 : 1'b0;  // Zero flag is set if ALUOut is zero
  LT = (A < B) ? 1'b1 : 1'b0;                 // Less than flag (Signed for SLT)
  GT = (A > B) ? 1'b1 : 1'b0;                 // Greater than flag (Signed for SLT)
end
endmodule
