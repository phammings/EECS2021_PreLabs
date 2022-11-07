module yMux(z, a, b, c);
    parameter SIZE = 2;     //similar to java FINAL statement
    output [SIZE-1:0] z;
    input [SIZE-1:0] a, b;
    input c;
    yMux1 mine[SIZE-1:0](z, a, b, c);   //this is only bus width 2 but can be expanded to 32
endmodule