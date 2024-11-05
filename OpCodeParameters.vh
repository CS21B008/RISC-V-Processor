// Contains the OpCode parameters for the different Instructions of RISC-V RS32IM

`ifndef OPCODEPARAMETERS_VH
`define OPCODEPARAMETERS_VH

// OpCode parameters

`define RType 7'b0110011
`define TypicalIType 7'b0010011
`define LoadIType 7'b0000011
`define BranchSType 7'b1100011
`define JALRIType 7'b1100111
`define StoreSType 7'b0100011
`define JALUType 7'b1101111
`define LUIUType 7'b0110111
`define AUIPCUType 7'b0010111

`endif 