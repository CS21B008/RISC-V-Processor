// Contains the function 3 parameters for the RISC-V RS32IM

`ifndef FUNCT3PARAMETERS_VH
`define FUNCT3PARAMETERS_VH

// Function 3 parameters
`define ADDFunct3 3'b000
`define SUBFunct3 3'b000
`define MULFunct3 3'b000
`define MULHFunct3 3'b001
`define MULHSUFunct3 3'b010
`define MULHUFunct3 3'b011
`define DIVFunct3 3'b100
`define DIVUFunct3 3'b101
`define REMFunct3 3'b110
`define REMUFunct3 3'b111
`define SLTFunct3 3'b010
`define SLTUFunct3 3'b011
`define ANDFunct3 3'b111
`define ORFunct3 3'b110
`define XORFunct3 3'b100
`define SLLFunct3 3'b001
`define SRLFunct3 3'b101
`define SRAFunct3 3'b101
`define JALRFunct3 3'b000
`define LBFunct3 3'b000
`define LBUFunct3 3'b100
`define LHFunct3 3'b001
`define LHUFunct3 3'b101
`define LWFunct3 3'b010
`define BEQFunct3 3'b000
`define BNEFunct3 3'b001
`define BLTFunct3 3'b100
`define BLTUFunct3 3'b110
`define BGEFunct3 3'b101
`define BGEUFunct3 3'b111
`define SBFunct3 3'b000
`define SHFunct3 3'b001
`define SWFunct3 3'b010

`endif