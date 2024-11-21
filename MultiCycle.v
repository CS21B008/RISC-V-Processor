// A Multi-Cycle Processor

`include "./CUParameters.vh"

module MultiCycle (
    input clk,
    input reset
    // input ps2c,
    // input ps2d,
    // output [3:0] led,
    // output [2:0] TMDSp,
    // output [2:0] TMDSn,
    // output TMDSp_clock,
    // output TMDSn_clock
);
/*
// slowing sysclk by 4 times so that IO can complete its operation
wire clk;
reg [2:0] clk_div;
always @(posedge sysclk) clk_div <= clk_div + 1'b1;
assign clk = clk_div[2];
// end of slowing sysclk

// Display Drivers
wire [31:0] display_address;
wire [31:0] display_dataOut;

DisplayDriver dispDriver (
    .clk(sysclk),
    .displayData(display_dataOut),
    .TMDSp(TMDSp),
    .TMDSn(TMDSn),
    .pointer(display_address),
    .TMDSp_clock(TMDSp_clock),
    .TMDSn_clock(TMDSn_clock)
);
// End of Display Drivers

// KeyBoard Controller
wire scan_code_ready;
wire [7:0] ascii_code;

parameter lowercase = 0;
parameter state_break = 1;
parameter BREAK = 8'hf0; //key released

wire scan_done_tick;
wire [7:0] scan_out;
reg [7:0] key_reg;

wire [2:0] next_state;
reg [2:0] current_state;
reg sample;

initial
begin
    sample<=1'b1;
end

ps2_rx ps2_rx_unit (.clk(sysclk), .reset(1'b0), .rx_en(1'b1), .ps2d(ps2d), .ps2c(ps2c), .rx_done_tick(scan_done_tick), .rx_data(scan_out));

initial 
begin
    current_state = lowercase;
end

always @(posedge scan_done_tick)
begin
    current_state <= next_state;
end

assign next_state = (current_state == lowercase && scan_out == BREAK ) ? state_break : lowercase;
assign scan_code_ready = (current_state == state_break) ? 1'b1 : 1'b0;

scanToAscii scanToAscii_unit (.letter_case(1'b0), .scan_code(scan_out), .ascii_code(ascii_code));


always @(negedge scan_code_ready) begin
    key_reg <= ascii_code;
    sample <= ~sample;
end
// End of KeyBoard Controller
*/

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
    .reset(reset),
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

RAM_NoClk #(256,32,"./test.bin",45) RAM(
    .dataIn(MemWriteData),
    .address(MemAddress[7:0]),
    .writeEnable(MemWrite),
    .dataOut(MemData)
);

/*Memory mem (
    .clock(clk), 
    .isWrite(MemWrite), 
    // .byteWrite(Zero),
    .address(MemAddress), 
    .writeData(MemWriteData), 
    .RD(MemData), 
    .displayAddr(display_address), 
    .displayData(display_dataOut), 
    .sample(sample), 
    .key_reg(key_reg),
    .led(led)
);*/

initial begin
    PC = 32'd0;
    Result = 32'd0;
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
        `PC_4_Imm : SrcB = 32'd1;
    endcase

    case(ResultSrc)
        `ALUResult : Result = ALUOut;
        `MemData : Result = Data;
        `NoDelayALUResult : Result = ALUResult;
    endcase
    
end

always @(posedge clk) begin
    if(reset) PC = 32'd0;
    if(PCWrite) PC <= Result;
    if(IRWrite) begin
        Inst <= MemData;
        OldPC <= PC;
    end
    Data <= MemData;
    ALUOut <= ALUResult;
end

task displayMemory(); 
    begin
        RegisterFile32Bit.displayMemory();
        RAM.displayMemory();
    end
endtask

task displaySignals(); 
    begin
        MultiCycleControlUnit.displayState();
        $display("Time: %0dns | PCWrite: %b | AdrSrc: %b | MemWrite: %b | IRWrite: %b | ResultSrc: %b | ALUControl: %b | ALUSrcA: %b | ALUSrcB: %b | RegWrite: %b", 
                 $time, PCWrite, AdrSrc, MemWrite, IRWrite, ResultSrc, ALUControl, ALUSrcA, ALUSrcB, RegWrite);
    end
endtask

endmodule