module ControlUnit(
    input [31:0] inst,
    output reg [31:0] A,
    output reg [31:0] B,
    output reg [4:0] ALUOp
);

reg [1:0] instType;
reg [4:0] opcode; // without instruction type
reg [2:0] funct3; 

always @(*) begin
    instType = inst[1:0];
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
                opcode = inst[6:2];
                funct3 = inst[14:12];
                case(opcode)
                    5'b00000:   begin
                                case(funct3)
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
                                    3'b101:  ALUOp = 5'b01111;
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

                end

        2'b11:  begin // U-Type Instructions

                end

        default: ALUOp = 5'b00000;
    endcase
end
endmodule