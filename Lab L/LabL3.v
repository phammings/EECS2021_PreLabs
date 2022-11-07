module labL;
    reg c;
    reg [31:0] a, b, expect;
    wire [31:0] z;
    integer i;

    // call function
    yMux #(.SIZE(32)) my_mux[31:0](z, a, b, c);     //#(.NAME(n)) parameter value set to n or #(n) can be used or:
                                                    //defparam my_mux.SIZE = 64;
                                                    //yMux my_mux(z, a, b, c);

    // exhaustive testing
    initial begin
        repeat (10)         //Because LabL3 is so large (2^65) exhaustive testing impossible so do random testing in this case 10 times
        begin
            a = $random;   //randomly returns 32 bit int
            b = $random;
            c = $random % 2;        //c is single bit so % 2 to get 0 or 1
            for (i = 0; i < 32; i = i + 1) // need a for loop to calculate each bit of expect properly. credit to RayM
            begin
                expect[i] = ((a[i] & ~c) + (b[i] & c)); // boolean logic representation of the circuit
            end
            #1; // wait for z - propagation delay

            // oracle
            // $display("EXPECT: expect=%b", expect);
            if (expect === z)
                $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
            else
                $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
        end
    $finish;
    end
endmodule