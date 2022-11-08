module labM;
   reg [31:0] PCin;
   reg        RegDst, RegWrite, clk, ALUSrc, MemRead, MemWrite, Mem2Reg;
   reg [2:0]  op;
   wire [31:0] rd1, rd2, imm, ins, PCp4, z, memOut, wb;
   wire [31:0] jTarget;
   wire        zero;

    wire [31:0] wd;

   yIF myIF(ins, PCp4, PCin, clk);
   yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);
   yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
   yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
   yWB myWB(wb, z, memOut, Mem2Reg);
   assign wd = wb;

   initial
     begin

        PCin = 128;


        repeat (43)
          begin

             clk = 1; #1;


             RegDst = 0; RegWrite = 0; ALUSrc = 1; op = 3'b010;


             if (ins[31:26] == 0)
               begin
                  RegDst = 1;
                  RegWrite = 1;
                  ALUSrc = 0;
                  MemRead = 0;
                  MemWrite = 0;
                  Mem2Reg = 0;


                  if (ins[5:0] == 'h20)
                    op = 3'b010;

                  else if (ins[5:0] == 'h25)
                    op = 3'b001;
               end


             else if (ins[31:26] == 'h2)
               begin
                  RegDst = 0;
                  RegWrite = 0;
                  ALUSrc = 1;
                  MemRead = 0;
                  MemWrite = 0;
                  Mem2Reg = 0;
               end


             else if (ins[31:26] == 'h23)
               begin
                  RegDst = 0;
                  RegWrite = 1;
                  ALUSrc = 1;
                  MemRead = 1;
                  MemWrite = 0;
                  Mem2Reg = 1;
               end


             else if (ins[31:26] == 'h4)
               begin
                  RegDst = 0;
                  RegWrite = 0;
                  ALUSrc = 0;
                  MemRead = 0;
                  MemWrite = 0;
                  Mem2Reg = 0;
               end


             else if (ins[31:26] == 'h8)
               begin
                  RegDst = 0;
                  RegWrite = 1;
                  ALUSrc = 1;
                  MemRead = 0;
                  MemWrite = 0;
                  Mem2Reg = 0;
               end


             else if (ins[31:26] == 'h2b)
               begin
                  RegDst = 0;
                  RegWrite = 0;
                  ALUSrc = 1;
                  MemRead = 0;
                  MemWrite = 1;
                  Mem2Reg = 0;
               end


             clk = 0; #1;


             $display("%h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d",
                      ins, rd1, rd2, z, zero, wb);


             if (ins[31:26] == 'h4 && zero == 1)
               PCin = PCp4 + (imm << 2);

             else if (ins[31:26] == 'h2)
               PCin = jTarget << 2;

             else
               PCin = PCp4;
          end
        $finish;
     end
endmodule