// A module to generate immediate values for I, S, U type instructions

`include "./OpCodeParameters.vh"
`include "./CUParameters.vh"

module ImmediateGen(
    input [31:0] Inst,
    output reg [31:0] Imm
);

always @(*) begin
    case(Inst[6:0])
        `TypicalIType, `LoadIType, `JALRIType : begin
            Imm = {{20{Inst[31]}}, Inst[31:20]};
        end
        `StoreSType, `BranchSType : begin
            Imm = {{20{Inst[31]}}, Inst[31:25], Inst[11:7]};
        end
        `JALUType : begin
            Imm = {{12{Inst[31]}},Inst[31:12]};
        end
        `AUIPCUType, `LUIUType : begin
            Imm = {Inst[31:12], 12'b0};
        end
    endcase
end

endmodule