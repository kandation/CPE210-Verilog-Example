module T_flipflop(q,t,clk,reset);	//T-flipflop posedge clk with reset
	output q;
	input	t,clk,reset;
	
	reg q;
	always@(posedge clk or posedge reset)
		begin
			if(reset)
				q <= 1'b0;
			else if(t==1'b0)
				q <= !q;
		end	


endmodule 


module delay(o,clk);
	output o;
	input clk;
	wire [7:0]w;
	T_flipflop t1(w[0],1'b1,clk,1'b0);
	T_flipflop t2(w[1],1'b1,w[0],1'b0);
	T_flipflop t3(w[2],1'b1,w[1],1'b0);
	T_flipflop t4(w[3],1'b1,w[2],1'b0);
	T_flipflop t5(w[4],1'b1,w[3],1'b0);
	T_flipflop t6(w[5],1'b1,w[4],1'b0);
	T_flipflop t7(w[6],1'b1,w[5],1'b0);
	T_flipflop t8(w[7],1'b1,w[6],1'b0);
	T_flipflop t9(o,1'b1,w[7],1'b0);

endmodule



