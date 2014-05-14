module LCD_SYNC (CLK, NCLK, GREST, HD, VD, DEN, Filas, Columnas, RST_N,R,G,B);

	parameter HL=1056;
	parameter VL=525;
	parameter H_BP=216;//Back porch
	parameter H_FP=40; //Front  "
	parameter V_BP=35; //Back porch
	parameter V_FP=10; //Front  "

	parameter WIDTH1=CLogB2(HL);
	parameter WIDTH2=CLogB2(VL);

	`include "MathFun.vh"
	input CLK, RST_N;
	
	output NCLK, GREST, HD, VD;
	output [WIDTH1-1:0] Columnas;
	output [WIDTH2-1:0] Filas;
	output [7:0] R, G, B;
	output reg DEN;
	
	wire cable, cable2;

	assign R=8'b11111111;  //color pantalla
	assign G=8'b00000000;
	assign B=8'b11111111;
	
	pll_ltm u0 (.inclk0(CLK), .c0( NCLK ));


contador #(.fin_cuenta(HL)) c1(  
	.clock (NCLK), 
	.reset_n (RST_N), 
	.enable (1'b1), 
	.count(Columnas), 
	.TC(cable)); 

contador #(.fin_cuenta(VL)) c2(
	.clock (NCLK), 
	.reset_n (RST_N), 
	.enable (cable), 
	.count(Filas), 
	.TC(cable2)); 


	assign HD=!cable;
	assign VD=!cable2;
	assign GREST=RST_N;

	always @(Columnas or Filas)
		begin
			if((Columnas>=H_FP) && (Columnas<(HL-H_BP)) && (Filas>=V_FP) && (Filas<(VL-V_BP)))
				DEN=1'b1;
				else
				DEN=1'b0;
		end
	
endmodule
