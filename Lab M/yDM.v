module yDM(memOut, exeOut, rd2, clk, MemRead, MemWrite);
    //DATA MEMORY: reads from address z or writes rd2 to that address based on two control signals and a clock
    output [31:0] memOut;
    input [31:0] exeOut, rd2;
    input clk, MemRead, MemWrite;

    // instantiate the circuit (only one line)
    mem data_mem(memOut, exeOut, rd2, clk, MemRead, MemWrite);
endmodule