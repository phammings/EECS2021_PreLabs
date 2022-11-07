module yArith(z, cout, a, b, ctrl);
    // add if ctrl=0, subtract if ctrl=1
    output [31:0] z;
    output cout;
    input [31:0] a, b;
    input ctrl;
    wire[31:0] notB, tmp;
    wire cin;

    // instantiate the components and connect them
    // Hint: about 4 lines of code
    // this circuit is from Figure A.5.8 in Appendix A of the textbk, pg. A-30

    //this is for subtraction to work. -x = notx + 1 so a - b = a + notb + 1
    //Where if Cin is already 1 (vs. default value 0) we call that control to do
    //subtraction if Cin = 1 and just do a + notb + Cin 
    //otherwise if Cin = 0 means addition of a + b + Cin

    not c_not[31:0](notB, b);
    yMux #(.SIZE(32)) my_mux[31:0](tmp, b, notB, ctrl);     //so if Ctrl = 0, we do addition with a + b + Cin, we need to choose b only
                                                            //so if Ctrl = 1, we do subtraction with a + notb + Cin, we need to choose notb only
    assign cin = ctrl;
    yAdder my_add[31:0](z, cout, a, tmp, cin);
endmodule