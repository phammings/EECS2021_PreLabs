module labK;
reg a, b; // reg without size means 1-bit
//wire tmp, z;        //vars for ciruit uses wire instead of reg known as nets - read only
wire notOutput, lowerInput, tmp, z;

//not my_not(tmp, b);     //simulates circuit class not, name is my_not, and params tmp and b - ports
                        //not (tmp, b) also works - no name needed -> tmp is the output of the negated b
//and my_and(z, a, tmp);  //same thing for and circuit gate, z is output, a and tmp are the inputs

not my_not(notOutput, b);
and my_and(z, a, lowerInput);
assign lowerInput = notOutput;

//Better to not share names and use assign to explicitly connect ports

initial
begin
    a = 1; b = 1;
    #1 $display("a=%b b=%b z=%b", a, b, z);     //delay 1 unit for calculation of z
    $finish;
end
endmodule