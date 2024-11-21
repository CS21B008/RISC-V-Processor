// a Height Length 32-bit width RAM

module RAM_NoClk #(
    parameter Height = 256,
    parameter Length = 32,
    parameter FilePath = "../RISC-V-Processor/RAM.mem",
    parameter LoadLenght = 203
)(
    input [Length-1:0] dataIn,
    input [$clog2(Height)-1:0] address,
    input writeEnable,
    output reg [Length-1:0] dataOut
);

reg [Length-1:0] Registers[0:Height-1];

integer i=LoadLenght;

initial begin
  // A Test program to check the working of cpu
  $readmemb(FilePath, Registers, 0, LoadLenght-1);
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

task displayMemory();
  integer i;
  for(i=0;i<Height;i=i+1)
  begin
    $display("RAM[%0d]: %b",i,Registers[i]);
  end
endtask

endmodule