module ff(q, d, clk, enable);
/****************************
An Edge-Triggerred Flip-flop 
Written by H. Roumani, 2008.
****************************/
output q;
input d, clk, enable;
reg q;                    //q is internal state, the read value

always @ (posedge clk)    //at rising edge of clock going from 0 to 1
  if (enable) q <= d;     //if enable = 1, nonblocking assignment of d to q where d is write value

                          //<= is nonblocking assignment, since its in an always block, every line done in parallel so all lines done at once
                          //vs = where is blocking assignment, since line of code executed only after previous line executed
endmodule
