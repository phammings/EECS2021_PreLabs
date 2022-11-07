module yWB(wb, exeOut, memOut, Mem2Reg);
    //WRITE BACK: is 2-to-1 mux that selects either memOut or z based on Mem2Reg value
    output [31:0] wb;
    input [31:0] exeOut, memOut;
    input Mem2Reg;

    // instantiate the circuit (only one line)
    yMux #(32) writeback(wb, exeOut, memOut, Mem2Reg);
endmodule