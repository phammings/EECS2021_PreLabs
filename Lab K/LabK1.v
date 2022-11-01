module labK;
reg [31:0] x; // a 32-bit register
reg [0:0] one;  //1 bit reg
reg [1:0] two;  //2 bit reg
reg [2:0] three;    //3 bit reg

initial
begin
    //$display($time, " ", x);        This is decimal or %d
    $display("time = %5d, x = %b", $time, x);
    //x = 0;
    x = 32'hffff0000;
    //$display($time, " %b", x);      binary
    $display("time = %5d, x = %b", $time, x);   //syntax: [bit size]['base]value
    x = x + 2;
    //$display($time, " %h", x);      hexadecimal
    $display("time = %5d, x = %b", $time, x);

    one = &x;               //and reduction
    two = x[1:0];           //part-selecting two LSB of x
    three = {one, two};     //concatenating
    $display("one = %b, two = %b, three = %b", one, two, three);
    
    //also have === and !==

    $finish;
end

endmodule