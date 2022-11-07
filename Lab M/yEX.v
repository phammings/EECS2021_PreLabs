module yEX(z, zero, rd1, rd2, imm, op, ALUSrc);
    output [31:0] z;
    output zero;
    input [31:0] rd1, rd2, imm;
    input [2:0] op;
    input ALUSrc;
    wire [31:0] muxOut;

    yMux #(32) reg_or_imm(muxOut, rd2, imm, ALUSrc);    //operands are rd1 and either rd2 or imm depending if ALUSrc is 1 or 0
    yAlu execAlu(z, zero, rd1, muxOut, op);     //performs operation depending on op signal
                                                
endmodule