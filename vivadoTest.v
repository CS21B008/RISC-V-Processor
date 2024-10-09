module VivadoTest(
    input in1,
    input in2,
    input in3,
    input in4,
    output reg out1,
    output reg out2,
    output reg out3,
    output reg out4
);

reg [1:0] inp1;
reg [1:0] inp2;
reg [31:0] inst;
wire [31:0] A;
wire [31:0] B;
wire [4:0] ALUOp;
wire [31:0] ALUOut;
reg [4:0] temp1;
reg [4:0] temp2;

ControlUnit CU(.inst(inst), .A(A), .B(B), .ALUOp(ALUOp));
ALU32Bit ALU(.A(A), .B(B), .ALUOp(ALUOp), .ALUOut(ALUOut));

always @(*) begin
    inp1[0] = in2;
    inp1[1] = in1;
    inp2[0] = in4;
    inp2[1] = in3;

    temp1 = {3'b000, inp1};
    temp2 = {3'b000, inp2};
    inst = {7'b0000000, temp2, temp1, 3'b000, 5'b0, 7'b0};

    out1 = ALUOut[3];
    out2 = ALUOut[2];
    out3 = ALUOut[1];
    out4 = ALUOut[0];
end
endmodule