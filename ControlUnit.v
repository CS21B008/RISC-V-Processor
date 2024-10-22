module ControlUnit(
    input [31:0] inst,
    output reg [4:0] ALUOp
);

reg [1:0] instType;
reg [4:0] opcode; // without instruction type
reg [2:0] funct3; 

always @(*) begin
    instType = inst[1:0];
    opcode = inst[6:2];
    case(instType)
        2'b00:  begin // R-Type Instructions
                opcode = inst[6:2];
                funct3 = inst[14:12];
                A = inst[24:20];
                B = inst[19:15];
                case(opcode)
                    5'b00000:   begin
                                case(funct3)
                                    3'b000: ALUOp = 5'b00000;
                                    3'b001: ALUOp = 5'b00001;
                                    3'b010: ALUOp = 5'b10101;
                                    3'b011: ALUOp = 5'b10110;
                                    3'b100: ALUOp = 5'b11010;
                                    3'b101: ALUOp = 5'b11100;
                                    default: ALUOp = 5'b00000; 
                                endcase
                                end
                    5'b00100:   begin
                                case(funct3)
                                    3'b010: ALUOp = 5'b10111;
                                    3'b011: ALUOp = 5'b11000;
                                    3'b100: ALUOp = 5'b11011;
                                    3'b101: ALUOp = 5'b11101; 
                                    default: ALUOp = 5'b10111;
                                endcase
                                end
                    5'b00001:   begin
                                case(funct3)
                                    3'b000: ALUOp = 5'b00010;
                                    3'b001: ALUOp = 5'b00011;
                                    3'b010: ALUOp = 5'b00100;
                                    3'b011: ALUOp = 5'b00101;
                                    3'b100: ALUOp = 5'b00110;
                                    default: ALUOp = 5'b00010;
                                endcase
                                end
                    5'b00011:   begin
                                case(funct3)
                                    3'b001: ALUOp = 5'b00111;
                                    3'b010: ALUOp = 5'b01000;
                                    3'b011: ALUOp = 5'b01001;
                                    3'b100: ALUOp = 5'b01010;
                                    default: ALUOp = 5'b00111;
                                endcase
                                end
                    5'b00010:   begin
                                case(funct3)
                                    3'b000: ALUOp = 5'b01011;
                                    3'b001: ALUOp = 5'b01100;
                                    3'b010: ALUOp = 5'b01110;
                                    3'b011: ALUOp = 5'b10000;
                                    3'b100: ALUOp = 5'b01101;
                                    3'b101: ALUOp = 5'b01111;
                                    3'b110: ALUOp = 5'b10001;
                                    default: ALUOp = 5'b01011; 
                                endcase
                                end
                    5'b00111:   begin
                                case(funct3)
                                    3'b000: ALUOp = 5'b10010;
                                    3'b001: ALUOp = 5'b10011;
                                    3'b011: ALUOp = 5'b10100;
                                    default: ALUOp = 5'b10010;
                                endcase
                                end
                    default: ALUOp = 5'b00000;
                endcase
                end
        2'b01:  begin // I-Type Instructions
                funct3 = inst[14:12];
                case(opcode)
                    5'b00000:   begin
                                case(funct3)
                                    3'b000: ALUOp = 5'b00000;
                                    3'b001: ALUOp = 5'b00001;
                                    3'b010: ALUOp = 5'b10101;
                                    3'b100: ALUOp = 5'b11010;
                                    3'b101:  ALUOp = 5'b11100;
                                    default: ALUOp = 5'b10101; 
                                endcase
                                end
                    5'b00001:   begin
                                case(funct3)
                                    3'b000: ALUOp = 5'b00010;
                                    3'b001: ALUOp = 5'b00011;
                                    3'b010: ALUOp = 5'b00100;
                                    3'b011: ALUOp = 5'b00101;
                                    3'b100: ALUOp = 5'b00110;
                                    default: ALUOp = 5'b00010;
                                endcase
                                end
                    5'b00011:   begin
                                case(funct3)
                                    3'b001: ALUOp = 5'b00111;
                                    3'b010: ALUOp = 5'b01000;
                                    3'b011: ALUOp = 5'b01001;
                                    3'b100: ALUOp = 5'b01010;
                                    default: ALUOp = 5'b00111;
                                endcase
                                end
                    5'b00010:   begin
                                case(funct3)
                                    3'b000: ALUOp = 5'b01011;
                                    3'b001: ALUOp = 5'b01100;
                                    3'b010: ALUOp = 5'b01110;
                                    3'b011: ALUOp = 5'b10000;
                                    3'b100: ALUOp = 5'b01101;
                                    3'b101: ALUOp = 5'b01111;
                                    3'b110: ALUOp = 5'b10001;
                                    default: ALUOp = 5'b01011; 
                                endcase
                                end
                    5'b00111:   begin
                                case(funct3)
                                    3'b000: ALUOp = 5'b10010;
                                    3'b001: ALUOp = 5'b10011;
                                    3'b011: ALUOp = 5'b10100;
                                    default: ALUOp = 5'b10010;
                                endcase
                                end
                    default: ALUOp = 5'b01011;
                endcase
                end
        2'b10:  begin // S-Type Instructions
            case(funct3)
                3'b001: begin
                    case(opcode)
                        5'b00001: ALUOp = 5'b00011; // BLT uses SLT
                        5'b00011: ALUOp = 5'b00111; // BLTU uses SLTU
                        default: ALUOp = 5'b11111;
                    endcase
                end 

                3'b010: begin
                    case(opcode)
                        5'b00001: ALUOp = 5'b00100; // BLE uses SLE
                        5'b00011: ALUOp = 5'b01000; // BLEU uses SLEU
                        default: ALUOp = 5'b11111;
                    endcase
                end

                3'b011: begin
                    case(opcode)
                        5'b00001: ALUOp = 5'b00101; // BGT uses SGT
                        5'b00011: ALUOp = 5'b01001; // BGTU uses SGTU
                        default: ALUOp = 5'b11111;
                    endcase
                end

                3'b100: begin
                    case(opcode)
                        5'b00001: ALUOp = 5'b00110; // BGE uses SGE
                        5'b00011: ALUOp = 5'b01010; // BGEU uses SGEU
                        default: ALUOp = 5'b11111;
                    endcase
                end

                default: ALUOp = 5'b11111;
            endcase
                end

        2'b11:  begin // U-Type Instructions
                ALUOp = 5'b11111; // ALU does nothing
                end

        default: ALUOp = 5'b11111;
    endcase
end
endmodule