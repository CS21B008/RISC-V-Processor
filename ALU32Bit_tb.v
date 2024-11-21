`timescale 1ns / 1ps

module ALU32Bit_tb;
  // Inputs
  reg [31:0] A;
  reg [31:0] B;
  reg [4:0] ALUOp;

  // Output
  wire [31:0] ALUOut;

  // Instantiate the ALU32Bit module
  ALU32Bit uut (
    .A(A), 
    .B(B), 
    .ALUOp(ALUOp), 
    .ALUOut(ALUOut)
  );

  initial begin
    // Monitor signals
    $monitor("Time=%0t A=%d B=%d ALUOp=%b ALUOut=%d", $time, A, B, ALUOp, ALUOut);

    // Initialize inputs
    A = 32'd10; 
    B = 32'd5;

    // Test various operations
    ALUOp = 5'b00000; #10; // Test ADD
    ALUOp = 5'b00001; #10; // Test SUB
    ALUOp = 5'b00010; #10; // Test SEQ
    ALUOp = 5'b00011; #10; // Test SLT
    ALUOp = 5'b00100; #10; // Test SLE
    ALUOp = 5'b00101; #10; // Test SGT
    ALUOp = 5'b00110; #10; // Test SGE
    ALUOp = 5'b00111; #10; // Test SLTU
    ALUOp = 5'b01000; #10; // Test SLEU
    ALUOp = 5'b01001; #10; // Test SGTU
    ALUOp = 5'b01010; #10; // Test SGEU
    ALUOp = 5'b01011; #10; // Test NOT
    ALUOp = 5'b01100; #10; // Test AND
    ALUOp = 5'b01101; #10; // Test NAND
    ALUOp = 5'b01110; #10; // Test OR
    ALUOp = 5'b01111; #10; // Test NOR
    ALUOp = 5'b10000; #10; // Test XOR
    ALUOp = 5'b10001; #10; // Test XNOR
    ALUOp = 5'b10010; #10; // Test SLL
    ALUOp = 5'b10011; #10; // Test SRL
    ALUOp = 5'b10100; #10; // Test SRA
    ALUOp = 5'b10101; #10; // Test MUL
    ALUOp = 5'b10110; #10; // Test MULH
    ALUOp = 5'b10111; #10; // Test MULU
    ALUOp = 5'b11010; #10; // Test DIV
    ALUOp = 5'b11011; #10; // Test DIVU
    ALUOp = 5'b11100; #10; // Test REM
    ALUOp = 5'b11101; #10; // Test REMU

    // Finish the simulation
    $stop;
  end
endmodule
