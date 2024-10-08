// 32-bit ALU supports the following functions:
// ORDER(Integer Type): ADD,SUB,SEQ,SLT,SLE,SGT,SGE,SLTU,SLEU,SGTU,SGEU,NOT,AND,NAND,OR,NOR,XOR,XNOR,SLL,SRL,SRA,MUL,MULH,MULU,MULHU,MULHSU,DIV,DIVU,REM,REMU
// Floating point type: need to do in the future


module ALU32Bit(
  input [31:0] A,
  input [31:0] B,
  input [4:0] ALUOp,
  output reg [31:0] ALUOut
);

reg [63:0] ALUOutTemp;

always @(*) begin
  
  // ALU operations based on ALU_Sel
  case(ALUOp)
      5'b00000: ALUOut = $signed(A) + $signed(B);                         // Add
      5'b00001: ALUOut = $signed(A) - $signed(B);                         // Subtract
      5'b00010: ALUOut = (A == B) ? 32'd1 : 32'd0;                        // Equal
      5'b00011: ALUOut = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;       // SLT (signed Comparison)
      5'b00100: ALUOut = ($signed(A) <= $signed(B)) ? 32'd1 : 32'd0;      // SLE (signed Comparison)
      5'b00101: ALUOut = ($signed(A) > $signed(B)) ? 32'd1 : 32'd0;       // SGT (signed Comparison)
      5'b00110: ALUOut = ($signed(A) >= $signed(B)) ? 32'd1 : 32'd0;      // SGE (signed Comparison)
      5'b00111: ALUOut = (A < B) ? 32'd1 : 32'd0;                         // SLTU (Unsigned Comparison)
      5'b01000: ALUOut = (A <= B) ? 32'd1 : 32'd0;                        // SLEU (Unsigned Comparison)
      5'b01001: ALUOut = (A > B) ? 32'd1 : 32'd0;                         // SGTU (Unsigned Comparison)
      5'b01010: ALUOut = (A >= B) ? 32'd1 : 32'd0;                        // SGEU (Unsigned Comparison)
      5'b01011: ALUOut = ~A;                                              // Bitwise NOT
      5'b01100: ALUOut = A & B;                                           // Bitwise AND
      5'b01101: ALUOut = ~(A & B);                                        // Bitwise NAND
      5'b01110: ALUOut = A | B;                                           // Bitwise OR
      5'b01111: ALUOut = ~(A | B);                                        // Bitwise NOR
      5'b10000: ALUOut = A ^ B;                                           // Bitwise XOR
      5'b10001: ALUOut = ~(A ^ B);                                        // Bitwise XNOR
      5'b10010: ALUOut = A << B;                                          // Shift Left Logical
      5'b10011: ALUOut = A >> B;                                          // Shift Right Logical
      5'b10100: ALUOut = $signed(A) >>> B;                                // Shift Right Arithmetic
      5'b10101: begin
                	ALUOutTemp = $signed(A) * $signed(B);                     
                	ALUOut = ALUOutTemp[31:0];
                end                                                       // Multiply lower 32 bits (signed)
      5'b10110: begin
                  ALUOutTemp = $signed(A) * $signed(B);                
      			      ALUOut = ALUOutTemp[63:32];
                end                                                       // Multiply higher 32 bits (signed)
      5'b10111: begin
                  ALUOutTemp = A * B;
                  ALUOut = ALUOutTemp[31:0];
                end                                                       // Multiply lower 32 bits (Unsigned)
      5'b11000: begin
                  ALUOutTemp = A * B;
                  ALUOut = ALUOutTemp[63:32];
                end                                                       // Multiply higher 32 bits (Unsigned)                                                   // Multiply lower 32 bits (Unsigned)
      5'b11001: begin
                  ALUOutTemp = $signed(A) * B;
                  ALUOut = ALUOutTemp[63:32];
                end                                                       // Multiply higher 32 bits (signed and unsigned)
      5'b11010: ALUOut = ($signed(A) / $signed(B));                       // Divide (signed)
      5'b11011: ALUOut = (A / B);                                         // Divide (unsigned)
      5'b11100: ALUOut = ($signed(A) % $signed(B));                       // Remainder (signed)
      5'b11101: ALUOut = (A % B);                                         // Remainder (unsigned)

      default: ALUOut = 32'd0;                                            // Default output is zero
  endcase               
end
endmodule
