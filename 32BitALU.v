// 32-bit ALU supports the following functions:
// ORDER(Integer Type): ADD,SUB,SEQ,SLT,SGT,SLTU,SGTU,AND,OR,NOT,SLL,SRL,SLA,SRA,MUL,MULH,MULHU,MULHSU,DIV,DIVU,REM,REMU
// Floating point type: need to do in the future


module ALU32Bit(
  input [31:0] A,
  input [31:0] B,
  input [4:0] ALUOp,
  output reg [31:0] ALUOut,
  output reg Zero,
  output reg LT,
  output reg GT,
  output reg Overflow
);

reg [63:0] ALUOutTemp;

always @(*) begin
  
  // ALU operations based on ALU_Sel
  case(ALUOp)
      5'b00000: ALUOut = $signed(A) + $signed(B);                         // Add
      5'b00001: ALUOut = $signed(A) - $signed(B);                         // Subtract
      5'b00010: ALUOut = (A == B) ? 32'd1 : 32'd0;                        // Equal
      5'b00011: ALUOut = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;       // SLT (signed Comparison)
      5'b00100: ALUOut = ($signed(A) > $signed(B)) ? 32'd1 : 32'd0;       // Greater than (signed)
      5'b00101: ALUOut = (A < B) ? 32'd1 : 32'd0;                         // SLTU (Unsigned Comparison)
      5'b00110: ALUOut = (A > B) ? 32'd1 : 32'd0;                         // Greater than (Unsigned)
      5'b00111: ALUOut = A & B;                                           // Bitwise AND
      5'b01000: ALUOut = A | B;                                           // Bitwise OR
      5'b01001: ALUOut = ~A;                                              // Bitwise NOT
      5'b01010: ALUOut = A << B;                                          // Shift Left Logical
      5'b01011: ALUOut = A >> B;                                          // Shift Right Logical
      5'b01100: ALUOut = $signed(A) << B;                                 // Shift Left Arithmetic
      5'b01101: ALUOut = $signed(A) >> B;                                 // Shift Right Arithmetic
      5'b01110: begin
                	ALUOutTemp = $signed(A) * $signed(B);                     
                	ALUOut = ALUOutTemp[31:0];
		end                 		    			  // Multiply lower 32 bits
      5'b01111: begin
			ALUOutTemp = $signed(A) * $signed(B);                
      			ALUOut = ALUOutTemp[63:32];
                end                                                       // Multiply higher 32 bits  
      5'b10000: begin
                  ALUOutTemp = A * B;
                  ALUOut = ALUOutTemp[63:32];
                end                                                       // Multiply higher 32 bits (Unsigned)
      5'b10001: begin
                  ALUOutTemp = $signed(A) * B;
                  ALUOut = ALUOutTemp[63:32];
                end                                                       // Multiply higher 32 bits (signed and unsigned)
      5'b10010: ALUOut = ($signed(A) / $signed(B));                       // Divide (signed)
      5'b10011: ALUOut = (A / B);                                         // Divide (unsigned)
      5'b10100: ALUOut = ($signed(A) % $signed(B));                       // Remainder (signed)
      5'b10101: ALUOut = (A % B);                                         // Remainder (unsigned)
      default: ALUOut = 32'h00000000;                                     // Default output is zero
  endcase               
end
endmodule
