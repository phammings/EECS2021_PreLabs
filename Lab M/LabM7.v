module labM;
    reg [31:0] PCin;
    reg clk;
    wire [31:0] ins, PCp4;
    yIF myIF(ins, PCp4, PCin, clk);     //given address PCin, we fetch address that contains the instructions in ram.dat and outputs it on pos. edge of clk
    initial
    begin
        //------------------------------------Entry point
        PCin = 16'h28;
        //------------------------------------Run program
        repeat (11)
        begin
            //---------------------------------Fetch an ins
            clk = 1; #1;
            //---------------------------------Execute the ins
            clk = 0; #1;
            //---------------------------------View results
            $display("instruction = %h", ins);                  //ouput is instructions in ram.dat file!
            // Add a statement to prepare for the next instruction
            PCin = PCp4;
            //register PC to store mem addr from which instruction is to be fetched. Register enabled at all times and has clk as its clock
            //we connect output of PC reg to address of input port of mem unit.
            //memIn left unconnected, and memRead = 1, memWrite = 0. CLK of mem irrelevant since it can only work when it has input from PC reg
            //which that already has clk to work with
        end
    $finish;
    end
endmodule