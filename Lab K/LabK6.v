module labK;
reg a, b, c, expect;
wire z, notOutput, lowerInput, and1, and2, orFinal;
integer i, j, k;

not my_not(notOutput, c);
assign lowerInput = notOutput;

and(and1, lowerInput, a);
and(and2, b, c);

or(orFinal, and1, and2);
assign z = orFinal;

initial 
begin 
    a = 1; b = 0; c=0; 
    expect = (a & ~c) | (c & b);
    #1; // wait for z 
    if (expect === z) 
        $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z); 
    else 
        $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z); 
    $finish; 
end 

endmodule