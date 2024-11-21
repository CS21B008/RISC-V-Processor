`timescale 1ns / 1ns

module MultiCycle_tb;

    // Parameters for clock period
    parameter CLK_PERIOD = 10; // Clock period in nanoseconds

    // Inputs to the DUT (Device Under Test)
    reg clk;
    reg reset;

    // Instantiate the MultiCycle Processor
    MultiCycle uut (
        .clk(clk),
        .reset(reset)
    );

    // Generate the clock signal
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Stimulus for testing
    initial begin
        reset = 0;

        // Run simulation for some cycles
        #(200 * CLK_PERIOD);

        // End simulation
        $stop;
    end

    // Monitor key signals for debugging
    initial begin
        $monitor("Time: %0dns | PC: %h | Inst: %h | MemData: %h| ALUOut: %h", 
                 $time, uut.PC, uut.Inst, uut.Data, uut.ALUOut);
        forever begin
            #CLK_PERIOD
            uut.displaySignals();
            uut.displayMemory();
        end
    end

endmodule

