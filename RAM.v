// a Height Length 32-bit width RAM

module RAM #(
    parameter Height = 64,
    parameter Length = 32
)(
    input [Length-1:0] dataIn,
    input [$clog2(Height)-1:0] address,
    input writeEnable,
    output reg [Length-1:0] dataOut
);

reg [Length-1:0] Registers[0:Height-1];

integer i=0;

initial begin
  while(i<Height) begin
    Registers[i] = 32'd0;
    i=i+1;
  end
end

always @(*) 
begin
  if(address < $clog2(Height)-1) begin
    if(writeEnable) begin
      Registers[address] = dataIn;
    end
    dataOut = Registers[address];
  end
end

endmodule