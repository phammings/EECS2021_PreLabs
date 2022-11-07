module yIF(ins, PCp4, PCin, clk);
    output [31:0] ins, PCp4;        //give address PCin, circuit fetches from memory the instuction ins and makes it availble
    input [31:0] PCin;              
    input clk;                      //Circuit initiates fetch as pos edge of clk o/w remain unchanged even if PCin changed
    wire zerflag;
    wire [31:0] regOut;
    // build and connect the circuit
    // refer to the 2nd diagram on pg 9 - needs a reg, alu, and mem
    
    register #(32) my_reg(regOut, PCin, clk, 1'b1);
    yAlu pc_inc(PCp4, zerflag, 4, regOut, 3'b010);      //also computes PCp4 = PCin + 4 in anticipation of fetching physically-following instrc.
    mem data(ins, regOut, , clk, 1'b1, 1'b0); // the memIn port is left unconnected
endmodule