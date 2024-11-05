// Contains the Control Unit parameters for the immediate generation; ALUSrcA, ALUSrcB, ResultSrc, AddrSrc selection of RISC-V RS32IM

`ifndef CUPARAMETERS_VH
`define CUPARAMETERS_VH

// ALUSrcA parameters
`define PC_4 2'b00
`define OldPC 2'b01
`define RegA 2'b10

// ALUSrcB parameters
`define RegB 2'b00
`define Imm 2'b01
`define PC_4_Imm 2'b10

// ResultSrc parameters
`define ALUResult 2'b00
`define MemData 2'b01
`define NoDelayALUResult 2'b10

// AddrSrc parameters
`define PC_Addr 1'b0
`define ALUResult_Addr 1'b1

`endif