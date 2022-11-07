module labM;
    reg clk, read, write;
    reg [31:0] address, memIn;
    wire [31:0] memOut;

    mem data(memOut, address, memIn, clk, read, write);

    initial begin
        clk = 0;
        address = 16; write = 1; read = 0;      //write = 1 so mem knows we are writing into reg address 16
        memIn = 32'h12345678;                   //this is value we are writing with
        clk = 1;                                //clk = 1 so we actaully do it
        #1;
        clk = 0;
        write = 1; read = 0;                    
        address = address + 8;                  //next address of 24
        memIn = 32'h89abcdef;                   //same logic as above, writing into reg address 24 on next pos edge of clk
        clk = 1;
        #1;                                     //in case that we read/write a word address that is not divisble by 4, we get unalligned msg

        write = 0; read = 1; address = 16;      //reseting address for output testing
        repeat (3)
        begin
            #1; $display("Address %d contains %h", address, memOut); address = address + 4;     //addr 20 contains nothing since we didnt write anything
        end
        
        $finish;
    end
endmodule