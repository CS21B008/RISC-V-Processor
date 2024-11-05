// Contains the state parameters for the state machine of Multi Cycle Control Unit

`ifndef STATEPARAMETERS_VH
`define STATEPARAMETERS_VH

// State parameters

`define IF 4'b0000
`define ID 4'b0001
`define MemAdr 4'b0010
`define MemRead 4'b0011
`define MemWB 4'b0100
`define MemWrite 4'b0101
`define ExR 4'b0110
`define ALUWB 4'b0111
`define ExI 4'b1000
`define JAL 4'b1001
`define Branch 4'b1010

`endif