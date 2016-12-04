module hw2out(R,L,inL,inR,inE,clk,reset);
	input clk,reset,inR,inL,inE;
	output [2:0]R;
	output [2:0]L;
	wire [1:0]q;

	hw2counter counter(q,clk,reset);
	hw2Light lightOut(R,L,inL,inR,inE,q);

endmodule

module hw2Light(r,l,inL,inR,inE,inQ);
	input inR,inL,inE;
	input [1:0]inQ;
	output [2:0]r; output [2:0]l;

	wire [2:0]wl;
	wire [2:0]wr;


	wire EQ0;
	wire orQ1Q0;
	wire notE;

	and and3(EQ0,inE,inQ[0]);
	or or0(orQ1Q0,inQ[1],inQ[0]);
	not not0(notE,inE);

	//-----L0-----
	and and4(wl[0],inL,notE,orQ1Q0);
	or or2(l[0],wl[0],EQ0);
	//----------
	//----L1-------
	and and5(wl[1],inL,inQ[1],notE);
	or or3(l[1],wl[1],EQ0);
	//----------
	//----L3------
	and and6(wl[2],inL,inQ[1],inQ[0],notE);
	or or4(l[2],wl[2],EQ0);
	//----------

	//-----R0-----
	and and7(wr[0],inR,notE,orQ1Q0);
	or or5(r[0],wr[0],EQ0);
	//----------
	//----R1-------
	and and8(wr[1],inR,inQ[1],notE);
	or or6(r[1],wr[1],EQ0);
	//----------
	//----R3------
	and and9(wr[2],inR,inQ[1],inQ[0],notE);
	or or7(r[2],wr[2],EQ0);
	//----------

endmodule

module hw2counter(q,clk,reset);
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
