module ControlUnit(
    input [31:0] inst,
    output reg [4:0] aluControl
);

wire [1:0] instType = inst[1:0];
wire [4:0] opcode; // without instruction type
wire [2:0] funct3; 

always @(*) begin
    case(instType)
        2'b00:  begin // R-Type Instructions
                opcode = inst[6:2];
                funct3 = inst[14:12];
                case(opcode)
                    5'b000000:  begin
                                case(funct3)
                                    3'b000: aluControl = 5'b00000
                                endcase
                                end
                endcase
                end
        2'b01:  begin // I-Type Instructions

                end
        2'b10:  begin // S-Type Instructions

                end

        2'b11:  begin // U-Type Instructions

                end

        default: 5'b00000;
    endcase
end
endmodule