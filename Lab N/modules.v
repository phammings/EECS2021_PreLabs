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

module mem(memOut, address, memIn, clk, read, write);
/****************************
Behavioral Memory Unit.
Written by H. Roumani, 2009.
****************************/

parameter DEBUG = 0;

//Read a word: set address on address and set memRead. After delay, value can be read on memOut
//Write a word: set destination address on adress and set memWrite. Data will be written on destination at next pos. edge of clk
//mem stores 32-bit words (assums word addresses divisble by 4) not bytes! O/w it ignores instructions with unaligned address message


parameter CAPACITY = 16'hffff;
input clk, read, write;
input [31:0] address, memIn;
output [31:0] memOut;
reg [31:0] memOut;
reg [31:0] arr [0:CAPACITY];
reg fresh = 1;

always @(read or address or arr[address])
begin
	if (fresh == 1)
	begin
		fresh = 0;
		$readmemh("ram.dat", arr);			//mem has option to instantiate memory from rem.dat file, if present it will instantiate all the data
	end

	if (read == 1)
	begin
		if (address[1:0] != 2'b00)
		begin
			//$display("Unaligned Load Address %d", address); 
			memOut = 32'hxxxxxxxx;
		end
		else if (address > CAPACITY)
		begin
			//$display("Address %h out of range %d", address, CAPACITY);
			memOut = 32'hxxxxxxxx;
		end
		else
		begin
			memOut = arr[address];
		end
	end
end

always @(posedge clk)
begin
	if (write == 1)
	begin
		if (address[1:0] != 2'b00)
		begin
			//$display("Unaligned Store Address %d", address);
		end
		else if (address > CAPACITY)
		begin
			$display("Address %d out of range %d", address, CAPACITY);
		end
		else
		begin
			arr[address] <= memIn;
			if (DEBUG != 0) $display("MEM: wrote %0dd at address %0dd", memIn, address);
		end
	end
end

endmodule

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

module rf(RD1,RD2, RN1,RN2, WN,WD, clk, W);
/****************************
Behavioral register file
Written by H. Roumani, 2009
****************************/
parameter DEBUG = 0;

input clk, W;				//Value only written when pos edge of clk iff w = 1, so W is enabler
input [4:0] RN1, RN2, WN;	//register numbers supplied thru RN1 and RN2 
input [31:0] WD;			//to store 32-bit value, store it on WD and supply 5-bit number on WN
output [31:0] RD1, RD2;		//Output after two registers stable on RD1 and RD2
							
reg [31:0] RD1, RD2;	
reg [31:0] arr [1:31];

always @(RN1 or arr[RN1])
	if (RN1 == 0)
		RD1 = 0;
	else
	begin
		RD1 = arr[RN1];
		if (DEBUG != 0) $display("RF: read %0dd from reg#%0d", RD1, RN1);
	end

always @(RN2 or arr[RN2])
	if (RN2 == 0)
		RD2 = 0;
	else
	begin
		RD2 = arr[RN2];
		if (DEBUG != 0) $display("RF: read %0dd from reg#%0d", RD2, RN2);
	end
		

always @(posedge clk) 
	if (W == 1 && WN != 0)
	begin
		arr[WN] = WD;
		if (DEBUG != 0) $display("RF: wrote %0dd to reg#%0d", WD, WN);
	end

endmodule

module sk(upper, lower, a, b, c, d);
output upper, lower;
input a,b,c,d;

or (upper, a, b, c, d);
not (notC, c);
xor (lower, a, b, notC, d);

endmodule


