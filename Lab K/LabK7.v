module labK;
reg a, b, c, expect, flag;
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
    //$value$plusargs system task has two parameters: first enables vvp to parse command line extract arg
    //second specifies var to be intialized so a=%b instructs vvp to look for a= followed by single bit
    //if +a=1 not specified, a=x and z=x where x is unknown variable
    flag = $value$plusargs("a=%b", a);      //get user input by vvp a.out +a=1 +b=0 +c=0 for example
    if (flag === 0)
        $display("Argument a is missing.");
            
    flag = $value$plusargs("b=%b", b); 
    if (flag === 0)
        $display("Argument b is missing.");
            
    flag = $value$plusargs("c=%b", c); 
    if (flag === 0)
        $display("Argument c is missing.");
            
    if (flag === 1)   
        begin
            expect = (a & ~c) | (c & b);            
            #1; // wait for z 
            if (expect === z) 
                $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z); 
            else 
                $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z); 
            $finish; 
        end
end 

endmodule