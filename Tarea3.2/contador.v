module contador (clock, reset_n, enable, count, TC);

	parameter fin_cuenta = 20;
	`include "MathFun.vh"
	parameter WIDTH=CLogB2(fin_cuenta);
	
	input clock, reset_n, enable;
	
	output reg [WIDTH-1:0] count;
	output TC;
	
	always @ (posedge clock , negedge reset_n)
	
			if (!reset_n)
				count <= 0;
			else if (enable == 1'b1)

					if (count == fin_cuenta-1)
						count <= 0;
					else
						count <= count + 1;


		
	assign TC = (count == fin_cuenta-1)? 1'b1 : 1'b0;
	
endmodule
