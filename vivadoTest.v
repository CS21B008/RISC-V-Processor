module vivadoTest.v(
    input in1,
    input in2,
    input in3,
    input in4,
    input funct3,
    input opcode,
    output out1,
    output out2,
    output out3,
    output out4,
);

wire [1:0] inp1;
wire [1:0] inp2;
wire [31:0] inst;
wire [31:0] A;
wire [31:0] B;
wire [4:0] ALUOp;

always @(*) begin
    inp1[0] = in2;
    inp1[1] = in1;
    inp2[0] = in4;
    inp2[1] = in3;

    assign temp1 = {3'b000, inp1};
    assign temp2 = {3'b000, inp2};
    inst = {7'b0000000, inp2, inp1, funct3, 5'b0, opcode};
    ControlUnit(.inst(inst), .A(A), .B(B), .ALUOp(ALUOp));
    ALU32Bit(.A(A), .B(B), .ALUOp(ALUOp), .ALUOut(ALUOut));

    out1 = ALUOut[3];
    out2 = ALUOut[2];
    out3 = ALUOut[1];
    out4 = ALUOut[0];
end
endmodule