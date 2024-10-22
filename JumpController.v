module JumpController(
  input A,
  input B,
  input [31:0] ALUOut,
  input [2:0] funct3,
  input [6:0] opcode,
  output reg jump
);

reg [1:0] instType;

always @(*) begin
    zr = $signed(ALUOut) == 32'b0;
    instType = opcode[1:0];

    case(opcode)
        2'b10: begin
            case(funct3)
                3'b000: jump = zr; // BEQ
                3'b111: jump = ~zr; // BNE
                default: jump = ALUOut[0]; // BLT, BLTU, BLE, BLEU, BGT, BGTU, BGE, BGEU
            endcase
        end
        default: jump = 1'b0;
    endcase 
end

endmodule