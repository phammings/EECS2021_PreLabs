
module labM; 
    reg [31:0] d;
    reg clk, enable, flag;
    wire [31:0] z;
    register #(32) mine(z, d, clk, enable);

    initial
    begin
        flag = $value$plusargs("enable=%b", enable);

        d = 15; clk = 0; #1;
        $display("clk=%b d=%d, z=%d", clk, d, z);       //z is still x, because clock is 0 so no writing

        d = 20; clk = 1; #1;
        $display("clk=%b d=%d, z=%d", clk, d, z);       //z = d = 20, because clock turned 1

        d = 25; clk = 0; #1;
        $display("clk=%b d=%d, z=%d", clk, d, z);       //z = 20 still since clock is 0 so it won't write anything yet

        d = 30; clk = 1; #1;
        $display("clk=%b d=%d, z=%d", clk, d, z);       //z = d = 30 now since clock changed to 1 and it writes the new d value
                                                        //Note this only works when enable set to 1, if set to 0, reg never written on
        
        $finish;
    end
endmodule