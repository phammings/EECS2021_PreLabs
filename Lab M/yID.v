module yID(rd1, rd2, immOut, jTarget, branch, ins, wd, RegWrite, clk);
    //plays role of decoding and data write-back

    //decoding: component extracts various fields from ins and looks up needed regs. Produces in rd1 and rd2 contents of two registers rs and rt
    // imm is sign-extended immediate
    // jTarget is the 20bit jump target
    // some ins do not address two regs and some do not immediates. so sometimes not meaningful. Jump only meaningful if has jump-type instr.

    //write back: value wd written to register rd where rd is bits 11:7 of ins.
    //writing only done when regWrite signal set and at pos edge of clk

    output [31:0] rd1, rd2, immOut;
    output [31:0] jTarget;
    output [31:0] branch;

    input [31:0] ins, wd;
    input RegWrite, clk;

    wire [19:0] zeros, ones; // For I-Type and SB-Type
    wire [11:0] zerosj, onesj; // For UJ-Type
    wire [31:0] imm, saveImm; // For S-Type

    rf myRF(rd1, rd2, ins[19:15], ins[24:20], ins[11:7], wd, clk, RegWrite);

    assign imm[11:0] = ins[31:20];
    assign zeros = 20'h00000;
    assign ones = 20'hFFFFF;
    yMux #(20) se(imm[31:12], zeros, ones, ins[31]);

    assign saveImm[11:5] = ins[31:25];
    assign saveImm[4:0] = ins[11:7];

    yMux #(20) saveImmSe(saveImm[31:12], zeros, ones, ins[31]);
    yMux #(32) immSelection(immOut, imm, saveImm, ins[5]);

    assign branch[11] = ins[31];
    assign branch[10] = ins[7];
    assign branch[9:4] = ins[30:25];
    assign branch[3:0] = ins[11:8];
    yMux #(20) bra(branch[31:12], zeros, ones, ins[31]);

    assign zerosj = 12'h000;
    assign onesj = 12'hFFF;
    assign jTarget[19] = ins[31];
    assign jTarget[18:11] = ins[19:12];
    assign jTarget[10] = ins[20];
    assign jTarget[9:0] = ins[30:21];
    yMux #(12) jum(jTarget[31:20], zerosj, onesj, jTarget[19]);
endmodule