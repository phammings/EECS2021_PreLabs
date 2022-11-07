module yMux1(z, a, b, c);   //similar to a library class to an app with main method since it has no initial block
output z;
input a, b, c;
wire notC, upper, lower;
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);
//If c = 0, door 0 opens for z = a.
//If c = 1, door 1 opens for z = b as per diagram.
endmodule 
