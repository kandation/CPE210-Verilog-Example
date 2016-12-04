module lab_test(outR,outL,inL,inR,inH,clk,reset);
	input clk,reset,inR,inL,inH;
	output [3:1]outL;	//L1, L2, L3
	output [3:1]outR;	//R1, R2, R3
	wire [1:0]q;	//For counter -> Q1 and Q0

	counter Q1Q0(q,clk,reset);
	Light lightout(outR,outL,inL,inR,inH,q);

endmodule

module Light(outR,outL,inL,inR,inH,inQ);
	input inR,inL,inH;
	input [1:0]inQ;
	output [3:1]outL;
	output [3:1]outR; 
	
	wire [2:1]wireL;
	wire [2:1]wireR;

	wire HQ0;
	wire HnotLQ0;
	wire HnotRQ0;
	wire notHLQ1;
	wire notHRQ1;
	wire notH;
	wire notQ1;

	not not0(notH,inH);
	not not1(notQ1,inQ[1]);
	and and0(notHLQ1,notH,inL,inQ[1]);
	and and1(notHRQ1,notH,inR,inQ[1]);
	and and2(HQ0,inH,inQ[0]);
	
	//-----L1-----
	and and3(wireL[1],notH,inL,inQ[1],inQ[0]);
	or or0(outL[1],wireL[1],HQ0);
	//-----L2------
	or or1(outL[2],notHLQ1,HQ0);
	//-----L3------
	and and4(wireL[2],notH,inL,notQ1,inQ[0]);
	or or2(outL[3],notHLQ1,wireL[2],HQ0);
	//----------
	
	//-----R1-----
	and and5(wireR[1],notH,inR,notQ1,inQ[0]);
	or or3(outR[1],HQ0,wireR[1],notHRQ1);
	//-----R2------
	or or4(outR[2],HQ0,notHRQ1);
	//-----R3------
	and and6(wireR[2],notH,inR,inQ[1],inQ[0]);
	or or5(outR[3],HQ0,wireR[2]);
	//----------

endmodule

module counter(q,clk,reset);
	input clk,reset;
	output [1:0]q;
		
	T_FF t0(q[0],1'b1,clk,reset);
	T_FF t1(q[1],q[0],clk,reset);

endmodule

module D_FF(q,d,clk,reset);
	output q;
	input d,clk,reset;
	reg q;
	always @(posedge reset or negedge clk)
	if(reset)
		q<=1'b0;
	else
		q<=d;
endmodule

module T_FF(q,t,clk,reset);
	output q;
	input t,clk,reset;
	wire d;
	xor x1(d,q,t);
	D_FF d1(q,d,clk,reset);
endmodule
