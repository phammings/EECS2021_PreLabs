module labM; 
    reg [31:0] d, e;
    reg clk, enable, flag;
    wire [31:0] z;
    register #(32) mine(z, d, clk, enable);

    always
    begin
        #5 clk = ~clk;      //clock cycle we make it 5 units
        if (clk)
            e = d;
    end

    initial begin
        flag = $value$plusargs("enable=%b", enable);        //input for enable value do vvp a.out +enable=1
        clk = 0;            //clock value stats at zero

        repeat (20)
        begin
            #2 d = $random;     //generate d value every 2 units of time
            if (z === e)
                $monitor("PASS %5d:clk=%b,d=%d,z=%d,expect=%d", $time,clk,d,z, e);
            else
                $monitor("FAIL %5d:clk=%b,d=%d,z=%d,expect=%d", $time,clk,d,z, e);
        end
        //if clk = 1, for time 5, 6, 8 even if d changes, z takes the first d when clk = 1 and does not change even if d changes while clk = 1
        
        $finish;
    end
endmodule