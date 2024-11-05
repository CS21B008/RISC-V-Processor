// A Control unit for multi cycle processor

`include "./StateParameters.vh"
`include "./ALUParameters.vh"
`include "./CUParameters.vh"
`include "./OpCodeParameters.vh"

module MultiCycleControlUnit(
    input clk,
    input [6:0] OpCode,
    input [2:0] funct3,
    input [6:0] funct7,
    input Eq,
    input Gt,
    input GtU,
    output reg PCWrite,
    output reg AdrSrc,
    output reg MemWrite,
    output reg IRWrite,
    output reg [1:0] ResultSrc,
    output reg [4:0] ALUControl,
    output reg [1:0] ALUSrcA,
    output reg [1:0] ALUSrcB,
    // output reg [1:0] ImmSrc,
    output reg RegWrite
);

reg [3:0] current_state, next_state;

initial current_state = `IF;

wire [4:0] ALUOp;
ALUControlUnit ALUControlUnit(
    .OpCode(OpCode),
    .funct3(funct3),
    .funct7(funct7),
    .ALUOp(ALUOp)
);

wire jump;
JumpController JumpController(
    .funct3(funct3),
    .Eq(Eq),
    .Gt(Gt),
    .GtU(GtU),
    .jump(jump)
);

always @(*) begin

    // case(OpCode)
    //     `TypicalIType, `LoadIType, `JALRIType : ImmSrc = `ITypeImm; // I-Type
    //     `StoreSType, `BranchSType : ImmSrc = `STypeImm; // S-Type
    //     `JALUType, `AUIPCUType, `LUIUType : ImmSrc = `UTypeImm; // U-Type
    // endcase

    case (current_state)
        `IF : begin
            PCWrite = 1;
            AdrSrc = `PC_Addr;
            MemWrite = 0;
            IRWrite = 1;
            ResultSrc = `NoDelayALUResult; // Direct from ALUOut to update PC
            ALUControl = `ADD; // Add
            ALUSrcA = `PC_4; // PC
            ALUSrcB = `RegA; // 4
            RegWrite = 0;
        end
        `ID : begin
            PCWrite = 0;
            // AdrSrc = `PC_Addr is same as previous state that is IF state so no need to change
            // MemWrite = 0 is same as previous state that is IF state so no need to change;
            IRWrite = 0;
            // ResultSrc = `NoDelayALUResult doesn't matter as PC, Mem, Reg are not updated in this state
            ALUControl = `ADD; // Add
            ALUSrcA = `OldPC; // old PC
            ALUSrcB = `Imm; // Imm
            // RegWrite = 0 is same as previous state that is IF state so no need to change;
        end
        `MemAdr : begin
            // PCWrite = 0 is same as previous state that is ID state so no need to change
            // AdrSrc = `PC_Addr is same as previous state that is ID state so no need to change
            // MemWrite = 0 is same as previous state that is ID state so no need to change;
            // IRWrite = 0 is same as previous state that is ID state so no need to change;
            // ResultSrc = `NoDelayALUResult doesn't matter as PC, Mem, Reg are not updated in this state
            ALUControl = `ADD; // Adding immediate to address in Reg1
            ALUSrcA = `RegA; // Reg1
            ALUSrcB = `Imm; // Imm
            // RegWrite = 0 is same as previous state that is ID state so no need to change;
        end
        `MemRead : begin
            // PCWrite = 0 is same as previous state that is MemAdr state so no need to change
            AdrSrc = `ALUResult_Addr; // ALUOut
            // MemWrite = 0 is same as previous state that is MemAdr state so no need to change;
            // IRWrite = 0 is same as previous state that is MemAdr state so no need to change;
            ResultSrc = `ALUResult; // ALUOut contains the address
            // Don't care about ALUControl as we don't use ALU in this state
            // Don't care about ALUSrcA as we don't use ALU in this state
            // Don't care about ALUSrcB as we don't use ALU in this state
            // RegWrite = 0 is same as previous state that is MemAdr state so no need to change;
        end
        `MemWB : begin
            // PCWrite is same as previous state that is MemRead state so no need to change
            // AdrSrc is same as previous state that is MemRead state so no need to change
            // MemWrite is same as previous state that is MemRead state so no need to change;
            // IRWrite is same as previous state that is MemRead state so no need to change;
            ResultSrc = `MemData; // MemData
            // Don't care about ALUControl as we don't use ALU in this state
            // Don't care about ALUSrcA as we don't use ALU in this state
            // Don't care about ALUSrcB as we don't use ALU in this state
            RegWrite = 1;
        end
        `MemWrite : begin
            // PCWrite is same as previous state that is MemAdr state so no need to change
            AdrSrc = `ALUResult_Addr; // ALUOut
            MemWrite = 1;
            // IRWrite is same as previous state that is MemAdr state so no need to change;
            ResultSrc = `ALUResult; // ALUOut contains the address
            // Don't care about ALUControl as we don't use ALU in this state
            // Don't care about ALUSrcA as we don't use ALU in this state
            // Don't care about ALUSrcB as we don't use ALU in this state
            // RegWrite is same as previous state that is MemAdr state so no need to change;
        end
        `ExR : begin
            // PCWrite = 0 is same as previous state that is ID state so no need to change
            // AdrSrc = 0 is same as previous state that is ID state so no need to change
            // MemWrite = 0 is same as previous state that is ID state so no need to change;
            // IRWrite = 0 is same as previous state that is ID state so no need to change;
            // ResultSrc doesn't matter as PC, Mem, Reg are not updated in this state
            ALUControl = ALUOp; // ALUOp
            ALUSrcA = `RegA; // Reg1
            ALUSrcB = `RegB; // Reg2
            // RegWrite is same as previous state that is ID state so no need to change;
        end
        `ALUWB : begin
            // PCWrite = 0 is same as previous state that is ExR, ExI, JAL state so no need to change
            // AdrSrc = 0 is same as previous state that is ExR, EXI, JAL state so no need to change
            // MemWrite = 0 is same as previous state that is ExR, EXI, JAL state so no need to change
            // IRWrite = 0 is same as previous state that is ExR, EXI, JAL state so no need to change
            ResultSrc = `ALUResult; // ALUOut
            // Don't care about ALUControl as we don't use ALU in this state
            // Don't care about ALUSrcA as we don't use ALU in this state
            // Don't care about ALUSrcB as we don't use ALU in this state
            RegWrite = 1;
        end
        `ExI : begin
            // PCWrite = 0 is same as previous state that is ID state so no need to change
            // AdrSrc = 0 is same as previous state that is ID state so no need to change
            // MemWrite = 0 is same as previous state that is ID state so no need to change
            // IRWrite = 0 is same as previous state that is ID state so no need to change
            // ResultSrc doesn't matter as PC, Mem, Reg are not updated in this state
            ALUControl = ALUOp; // ALUOp
            ALUSrcA = `RegA; // Reg1
            ALUSrcB = `Imm; // Imm
            // RegWrite is same as previous state that is ID state so no need to change;
        end
        `JAL : begin
            PCWrite = 1;
            // AdrSrc = 0 is same as previous state that is ID state so no need to change
            // MemWrite = 0 is same as previous state that is ID state so no need to change
            // IRWrite = 0 is same as previous state that is ID state so no need to change
            ResultSrc = `ALUResult; // ALUOut
            ALUControl = `ADD; // Add
            ALUSrcA = `OldPC; // old PC
            ALUSrcB = `PC_4_Imm; // 4
            // RegWrite = 0 is same as previous state that is ID state so no need to change;
        end
        `Branch : begin
            PCWrite = jump;
            // AdrSrc = 0 is same as previous state that is ID state so no need to change
            // MemWrite = 0 is same as previous state that is ID state so no need to change
            // IRWrite = 0 is same as previous state that is ID state so no need to change
            ResultSrc = `ALUResult; // ALUOut
            // Don't care about ALUControl as we don't use ALUOperation but use Eq, Gt, GtU
            ALUSrcA = `RegA; // Reg1
            ALUSrcB = `RegB; // Reg2
            // RegWrite = 0 is same as previous state that is ID state so no need to change;
        end 
        default: begin
        end
    endcase
end

always @(posedge clk) begin
    case(current_state)
        `IF: begin
            next_state = `ID;
        end
        `ID: begin
            case(OpCode)
                `LoadIType, `StoreSType : next_state = `MemAdr;
                `RType : next_state = `ExR;
                `TypicalIType : next_state = `ExI;
                `JALUType : next_state = `JAL;
                `BranchSType : next_state = `Branch;
            endcase
        end
        `MemAdr: begin
            if(OpCode == `StoreSType) next_state = `MemWrite;
            else next_state = `MemRead;
        end
        `MemRead: begin
            next_state = `MemWB;
        end
        `MemWB: begin
            next_state = `IF;
        end
        `MemWrite: begin
            next_state = `IF;
        end
        `ExR: begin
            next_state = `ALUWB;
        end
        `ALUWB: begin
            next_state = `IF;
        end
        `ExI: begin
            next_state = `ALUWB;
        end
        `JAL: begin
            next_state = `ALUWB;
        end
        `Branch: begin
            next_state = `IF;
        end
        default: begin
        end
    endcase
    current_state = next_state;
end

endmodule