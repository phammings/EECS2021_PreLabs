module labK;
reg [31:0] x, y, z, i;
initial
begin
    $monitor("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);     //instead of $display all the time, this displays for a var change

    #10 x = 5;
    //$display("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);
    #10 y = x + 1;
    //$display("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);
    #10 z = y + 1;
    //$display("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);

    
    #1 $finish; //delay 1 unit to check for change in z
end

initial
begin
    //Verilog run parallel blocks so this will run at the same time
    //#5 x = x + 1;   No change since x = 5 at #10 so negates this since it was done before

    // #7 x = x + 1;
    // #7 x = x + 1;
    // #7 x = x + 1;
    // #7 x = x + 1;

    /*
    More better is repeat:
    repeat (4)
        #7 x = x + 1;
    
    //Or for loop - make sure to initialize i
    for (i = 0; i < 4; i = i + 1)
        #7 x = x + 1;
    */

    //Or use always block

end

//circular initial block that repeats forever
always
    begin
        #7 x = x + 1;
    end

endmodule