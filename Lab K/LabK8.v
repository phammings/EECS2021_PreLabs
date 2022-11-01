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


for (i = 0; i < 3; i = i + 1)
    begin
        for (j = 0; j < 3; j = j + 1)
        begin
            for (k = 0; k < 3; k = k + 1) 
            begin
                a = i; b = j; c = k;
                #1; //wait for z
                //NO ORACLE otherwise do expect = (a & ~c) | (c & b) and then if expect === z
                if ((a & ~c) | (c & b) === z)
                    $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
                else
                    $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);

                //$display("%s", (1 == 1) ? "YES, ONE EQUALS ONE" : "HOW DID YOU GET HERE");
                // ?: but doesnt work for some reason...
            end
        end
    end
$finish;
end


endmodule