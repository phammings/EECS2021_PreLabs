module yAdder(z, cout, a, b, cin);
    // outputs
    output [31:0] z;
    output cout;

    // inputs
    input [31:0] a, b;
    input cin;

    // interconnects
    wire[31:0] in, out;

    // yAdder1 is defined in yAdder1.v
    yAdder1 mine[31:0](z, out, a, b, in);
    
    //runs parallel so code order does not matter
    assign in[0] = cin;
    assign in[31:1] = out[30:0];        //all inputs from yAdder1 bit 32 to bit 2, last bit 1 is  Cin, so as the operations go on
                                        //the next Cin is bit 1 of Cout and goes into bit 2 of Cin, then next Cin is bit 2 of Cout
                                        //and goes into bit 3 of Cin, where the final 32nd bit of Cout is the Cout output of the 32bit adder  
endmodule