// Contains the ALUOp parameters for the ALU of RISC-V RS32IM

`ifndef ALUPARAMETERS_VH
`define ALUPARAMETERS_VH

// ALUOp parameters
`define ADD 5'b00000
`define SUB 5'b00001
`define MUL 5'b00010
`define MULH 5'b00011
`define MULHSU 5'b00100
`define MULHU 5'b00101
`define DIV 5'b00110
`define DIVU 5'b00111
`define REM 5'b01000
`define REMU 5'b01001
`define SLT 5'b01010
`define SLTU 5'b01011
`define AND 5'b01100
`define OR 5'b01101
`define XOR 5'b01110
`define SLL 5'b01111
`define SRL 5'b10000
`define SRA 5'b10001

`endif