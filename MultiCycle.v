// A Multi-Cycle Processor

`include "./CUParameters.vh"

module MultiCycle (
    input clk,
    input reset
    // input reg [31:0] MemData,
    // output reg [31:0] MemAddress,
    // output reg [31:0] MemWriteData,
    // output MemWrite
);

reg [31:0] PC;
reg [31:0] OldPC;
reg [31:0] Inst;
reg [31:0] Data;
reg [31:0] ALUOut;
reg [31:0] SrcA;
reg [31:0] SrcB;
reg [31:0] Result;
reg [31:0] MemWriteData;
reg [31:0] MemAddress;

wire [31:0] MemData;
wire PCWrite;
wire AdrSrc;
wire IRWrite;
wire [1:0] ResultSrc;
wire [4:0] ALUControl;
wire [1:0] ALUSrcA;
wire [1:0] ALUSrcB;
wire RegWrite;
wire [31:0] Reg1;
wire [31:0] Reg2;
wire [31:0] Imm;
wire [31:0] ALUResult;
wire Eq;
wire Gt;
wire GtU;
wire MemWrite;

MultiCycleControlUnit MultiCycleControlUnit(
    .clk(clk),
    .OpCode(Inst[6:0]),
    .funct3(Inst[14:12]),
    .funct7(Inst[31:25]),
    .Eq(Eq),
    .Gt(Gt),
    .GtU(GtU),
    .PCWrite(PCWrite),
    .AdrSrc(AdrSrc),
    .MemWrite(MemWrite),
    .IRWrite(IRWrite),
    .ResultSrc(ResultSrc),
    .ALUControl(ALUControl),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .RegWrite(RegWrite)
);

RegisterFile32Bit RegisterFile32Bit(
    .ReadPort1(Inst[19:15]),
    .ReadPort2(Inst[24:20]),
    .WritePort(Inst[11:7]),
    .WriteData(Result),
    .WriteEnable(RegWrite),
    .clk(clk),
    .ReadData1(Reg1),
    .ReadData2(Reg2)
);

ImmediateGen ImmediateGen(
    .Inst(Inst),
    .Imm(Imm)
);

ALU32Bit ALU32Bit(
    .A(SrcA),
    .B(SrcB),
    .ALUOp(ALUControl),
    .ALUOut(ALUResult),
    .Eq(Eq),
    .Gt(Gt),
    .GtU(GtU)
);

RAM #(65536,32) RAM(
    .dataIn(MemWriteData),
    .address(MemAddress[17:2]),
    .writeEnable(MemWrite),
    .dataOut(MemData)
);

initial begin
    PC = 32'd0;
end

always @(*) begin
    
    MemWriteData = Reg2;

    case(AdrSrc)
        `PC_Addr : MemAddress = PC;
        `ALUResult_Addr : MemAddress = Result;
    endcase

    case(ALUSrcA)
        `PC_4 : SrcA = PC;
        `OldPC : SrcA = OldPC;
        `RegA : SrcA = Reg1;
        `Zero : SrcA = 32'd0;
    endcase

    case(ALUSrcB)
        `RegB : SrcB = Reg2;
        `Imm : SrcB = Imm;
        `PC_4_Imm : SrcB = 32'd4;
    endcase

    case(ResultSrc)
        `ALUResult : Result = ALUOut;
        `MemData : Result = Data;
        `NoDelayALUResult : Result = ALUResult;
    endcase
    
end

always @(posedge clk) begin
    if(reset) PC = 32'd0;
    if(PCWrite) PC = Result;
    if(IRWrite) begin
        Inst = MemData;
        OldPC = PC;
    end
    Data = MemData;
    ALUOut = ALUResult;
end

endmodule