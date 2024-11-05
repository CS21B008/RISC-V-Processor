// A control unit for ALU operations based on opcode, funct3, and funct7

`include "./ALUParameters.vh"
`include "./OpCodeParameters.vh"
`include "./Funct3Parameters.vh"
`include "./Funct7Parameters.vh"

module ALUControlUnit(
    input [6:0] OpCode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [4:0] ALUOp
);

// reg [1:0] instType;
// reg [4:0] opcode; // without instruction type
// reg [2:0] funct3; 

always @(*) begin

    if(OpCode == `RType) begin
        case(funct7)
            `RS32MFunct7: begin
                case(funct3)
                    `MULFunct3 : ALUOp = `MUL;
                    `MULHFunct3 : ALUOp = `MULH;
                    `MULHUFunct3 : ALUOp = `MULHU;
                    `MULHSUFunct3 : ALUOp = `MULHSU;
                    `DIVFunct3 : ALUOp = `DIV;
                    `DIVUFunct3 : ALUOp = `DIVU;
                    `REMFunct3 : ALUOp = `REM;
                    `REMUFunct3 : ALUOp = `REMU;
                endcase
            end
            7'b0000000: begin  // for `ADDFunct7, `SetFunct7, `BitFunct7, `LogicalFunct7
                case(funct3)
                    `ADDFunct3 : ALUOp = `ADD;
                    `SLTFunct3 : ALUOp = `SLT;
                    `SLTUFunct3 : ALUOp = `SLTU;
                    `ANDFunct3 : ALUOp = `AND;
                    `ORFunct3 : ALUOp = `OR;
                    `XORFunct3 : ALUOp = `XOR;
                    `SLLFunct3 : ALUOp = `SLL;
                    `SRLFunct3 : ALUOp = `SRL;
                endcase
            end
            7'b0100000: begin // for `SUBFunct7, `SRAFunct7
                case(funct3)
                    `SUBFunct3 : ALUOp = `SUB;
                    `SRAFunct3 : ALUOp = `SRA;
                endcase
            end
        endcase
    end
    if(OpCode == `TypicalIType) begin
        case(funct3)
            `ADDFunct3 : ALUOp = `ADD;
            `SLTFunct3 : ALUOp = `SLT;
            `SLTUFunct3 : ALUOp = `SLTU;
            `ANDFunct3 : ALUOp = `AND;
            `ORFunct3 : ALUOp = `OR;
            `XORFunct3 : ALUOp = `XOR;
            `SLLFunct3 : ALUOp = `SLL;
            3'b101: begin // for `SRLFunct3, `SRAFunct3
                case(funct7)
                    `LogicalFunct7 : ALUOp = `SRL;
                    `ArthematicFunct7 : ALUOp = `SRA;
                endcase
            end
        endcase
    end

//     instType = inst[1:0];
//     opcode = inst[6:2];
//     case(instType)
//         2'b00:  begin // R-Type Instructions
//                 opcode = inst[6:2];
//                 funct3 = inst[14:12];
//                 A = inst[24:20];
//                 B = inst[19:15];
//                 case(opcode)
//                     5'b00000:   begin
//                                 case(funct3)
//                                     3'b000: ALUOp = 5'b00000;
//                                     3'b001: ALUOp = 5'b00001;
//                                     3'b010: ALUOp = 5'b10101;
//                                     3'b011: ALUOp = 5'b10110;
//                                     3'b100: ALUOp = 5'b11010;
//                                     3'b101: ALUOp = 5'b11100;
//                                     default: ALUOp = 5'b00000; 
//                                 endcase
//                                 end
//                     5'b00100:   begin
//                                 case(funct3)
//                                     3'b010: ALUOp = 5'b10111;
//                                     3'b011: ALUOp = 5'b11000;
//                                     3'b100: ALUOp = 5'b11011;
//                                     3'b101: ALUOp = 5'b11101; 
//                                     default: ALUOp = 5'b10111;
//                                 endcase
//                                 end
//                     5'b00001:   begin
//                                 case(funct3)
//                                     3'b000: ALUOp = 5'b00010;
//                                     3'b001: ALUOp = 5'b00011;
//                                     3'b010: ALUOp = 5'b00100;
//                                     3'b011: ALUOp = 5'b00101;
//                                     3'b100: ALUOp = 5'b00110;
//                                     default: ALUOp = 5'b00010;
//                                 endcase
//                                 end
//                     5'b00011:   begin
//                                 case(funct3)
//                                     3'b001: ALUOp = 5'b00111;
//                                     3'b010: ALUOp = 5'b01000;
//                                     3'b011: ALUOp = 5'b01001;
//                                     3'b100: ALUOp = 5'b01010;
//                                     default: ALUOp = 5'b00111;
//                                 endcase
//                                 end
//                     5'b00010:   begin
//                                 case(funct3)
//                                     3'b000: ALUOp = 5'b01011;
//                                     3'b001: ALUOp = 5'b01100;
//                                     3'b010: ALUOp = 5'b01110;
//                                     3'b011: ALUOp = 5'b10000;
//                                     3'b100: ALUOp = 5'b01101;
//                                     3'b101: ALUOp = 5'b01111;
//                                     3'b110: ALUOp = 5'b10001;
//                                     default: ALUOp = 5'b01011; 
//                                 endcase
//                                 end
//                     5'b00111:   begin
//                                 case(funct3)
//                                     3'b000: ALUOp = 5'b10010;
//                                     3'b001: ALUOp = 5'b10011;
//                                     3'b011: ALUOp = 5'b10100;
//                                     default: ALUOp = 5'b10010;
//                                 endcase
//                                 end
//                     default: ALUOp = 5'b00000;
//                 endcase
//                 end
//         2'b01:  begin // I-Type Instructions
//                 funct3 = inst[14:12];
//                 case(opcode)
//                     5'b00000:   begin
//                                 case(funct3)
//                                     3'b000: ALUOp = 5'b00000;
//                                     3'b001: ALUOp = 5'b00001;
//                                     3'b010: ALUOp = 5'b10101;
//                                     3'b100: ALUOp = 5'b11010;
//                                     3'b101:  ALUOp = 5'b11100;
//                                     default: ALUOp = 5'b10101; 
//                                 endcase
//                                 end
//                     5'b00001:   begin
//                                 case(funct3)
//                                     3'b000: ALUOp = 5'b00010;
//                                     3'b001: ALUOp = 5'b00011;
//                                     3'b010: ALUOp = 5'b00100;
//                                     3'b011: ALUOp = 5'b00101;
//                                     3'b100: ALUOp = 5'b00110;
//                                     default: ALUOp = 5'b00010;
//                                 endcase
//                                 end
//                     5'b00011:   begin
//                                 case(funct3)
//                                     3'b001: ALUOp = 5'b00111;
//                                     3'b010: ALUOp = 5'b01000;
//                                     3'b011: ALUOp = 5'b01001;
//                                     3'b100: ALUOp = 5'b01010;
//                                     default: ALUOp = 5'b00111;
//                                 endcase
//                                 end
//                     5'b00010:   begin
//                                 case(funct3)
//                                     3'b000: ALUOp = 5'b01011;
//                                     3'b001: ALUOp = 5'b01100;
//                                     3'b010: ALUOp = 5'b01110;
//                                     3'b011: ALUOp = 5'b10000;
//                                     3'b100: ALUOp = 5'b01101;
//                                     3'b101: ALUOp = 5'b01111;
//                                     3'b110: ALUOp = 5'b10001;
//                                     default: ALUOp = 5'b01011; 
//                                 endcase
//                                 end
//                     5'b00111:   begin
//                                 case(funct3)
//                                     3'b000: ALUOp = 5'b10010;
//                                     3'b001: ALUOp = 5'b10011;
//                                     3'b011: ALUOp = 5'b10100;
//                                     default: ALUOp = 5'b10010;
//                                 endcase
//                                 end
//                     default: ALUOp = 5'b01011;
//                 endcase
//                 end
//         2'b10:  begin // S-Type Instructions
//             case(funct3)
//                 3'b001: begin
//                     case(opcode)
//                         5'b00001: ALUOp = 5'b00011; // BLT uses SLT
//                         5'b00011: ALUOp = 5'b00111; // BLTU uses SLTU
//                         default: ALUOp = 5'b11111;
//                     endcase
//                 end 

//                 3'b010: begin
//                     case(opcode)
//                         5'b00001: ALUOp = 5'b00100; // BLE uses SLE
//                         5'b00011: ALUOp = 5'b01000; // BLEU uses SLEU
//                         default: ALUOp = 5'b11111;
//                     endcase
//                 end

//                 3'b011: begin
//                     case(opcode)
//                         5'b00001: ALUOp = 5'b00101; // BGT uses SGT
//                         5'b00011: ALUOp = 5'b01001; // BGTU uses SGTU
//                         default: ALUOp = 5'b11111;
//                     endcase
//                 end

//                 3'b100: begin
//                     case(opcode)
//                         5'b00001: ALUOp = 5'b00110; // BGE uses SGE
//                         5'b00011: ALUOp = 5'b01010; // BGEU uses SGEU
//                         default: ALUOp = 5'b11111;
//                     endcase
//                 end

//                 default: ALUOp = 5'b11111;
//             endcase
//                 end

//         2'b11:  begin // U-Type Instructions
//                 ALUOp = 5'b11111; // ALU does nothing
//                 end

//         default: ALUOp = 5'b11111;
//     endcase
end
endmodule