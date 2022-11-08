module register(q, d, clk, enable);
/****************************
An Edge-Triggerred Register.
Written by H. Roumani, 2008.
****************************/

parameter SIZE = 2;     
output [SIZE-1:0] q;        //z = q at all times, internal state of n bits (2 here). z = q since you can always read a reg anytime
input [SIZE-1:0] d;         //to write a register, enable set to 1 so z = d, then we can write on next rising clock edge from 0 to 1.
input clk, enable;

ff myFF[SIZE-1:0](q, d, clk, enable);       //the flip-flop writes into the reg when enable = 1 and clock goes from 0 to 1

endmodule
