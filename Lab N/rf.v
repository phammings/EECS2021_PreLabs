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

