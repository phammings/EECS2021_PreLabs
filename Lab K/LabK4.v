//Exhaustive Testing - every possible input - for loops
//Sampled Testing - subset of possible cases
//Random Testing - random test cases - repeat

module labK;
reg a, b;
wire z;
integer i, j;
not my_not(tmp, b);
and my_and(z, a, tmp);
initial
begin
    for (i = 0; i < 2; i = i + 1)
    begin
        for (j = 0; j < 2; j = j + 1)
        begin
            a = i; b = j;               //Must use i and j because a and b have fixed size and hence they will wrap = incorrect!
            #1 $display("a=%b b=%b z=%b", a, b, z);
        end
    end
    $finish;
end
endmodule
