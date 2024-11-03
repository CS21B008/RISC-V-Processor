// A Control unit for multi cycle processor

`include "./StateParameters.vh"
`include "./ALUParameters.vh"
`include "./ImmParameters.vh"

module MultiCycleControlUnit(
    input clk,
    input [6:0] OpCode,
    input [2:0] funct3,
    input [6:0] funct7,
    input zr,
    input gt,
    output reg PCWrite,
    output reg AdrSrc,
    output reg MemWrite,
    output reg IRWrite,
    output reg [1:0] ResultSrc,
    output reg [4:0] ALUControl,
    output reg [1:0] ALUSrcA,
    output reg [1:0] ALUSrcB,
    output reg [1:0] ImmSrc,
    output reg RegWrite
);

reg [4:0] current_state, next_state;

initial current_state = `IF;

always @(*) begin
    case (current_state)
        `IF : begin
            PCWrite = 1;
            AdrSrc = 0;
            MemWrite = 0;
            IRWrite = 1;
            ResultSrc = 2'b10; // Direct from ALUOut to update PC
            ALUControl = `ADD; // Add
            ALUSrcA = 2'b00; // PC
            ALUSrcB = 2'b10; // 4
            // Immsrc can be anything as we don't take it in ALUSrcB
            RegWrite = 0;
        end
        `ID : begin
            PCWrite = 0;
            // AdrSrc is same as previous state that is IF state so no need to change
            // MemWrite is same as previous state that is IF state so no need to change;
            IRWrite = 0;
            // ResultSrc doesn't matter as PC, Mem, Reg are not updated in this state
            ALUControl = `ADD; // Add
            ALUSrcA = 2'b01; // old PC
            ALUSrcB = 2'b01; // Imm
            Immsrc = `UTypeImm; // U-Type
            RegWrite = 0;
        end
        `MemAdr : begin

        end
        `MemRead : begin

        end
        `MemWB : begin

        end
        `MemWrite : begin

        end
        `ExR : begin

        end
        `ALUWB : begin

        end
        `ExI : begin

        end
        `JAL : begin

        end
        `BEQ : begin

        end 
        default: begin
        end
    endcase
end

endmodule