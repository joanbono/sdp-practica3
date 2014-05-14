// -------------------------------------------------------------------- 
// Universitat Politècnica de València 
// Escuela Técnica Superior de Ingenieros de Telecomunicación 
// -------------------------------------------------------------------- 
// Sistemas Digitales Programables 
// Curso 2013 - 2014 
// -------------------------------------------------------------------- 
// Nombre del archivo: LCD_SYNC.v 
// 
// Descripción: Este código Verilog implementa una máquina de estados con 
// la siguiente funcionalidad de sus entradas y salidas: 
//  1. CLK:     Señal de reloj.
//  2. NCLK:    Señal de reloj de salida hacia la pantalla. 
//  3. GREST:   Reset global de la pantalla.
//  4. HD,VD:   Señales de sincronismo horizontal y vertical respectivamente.  
//  5. DEN:     Señal de habilitación de la visualización en la pantalla.
//  6. Filas,Columnas: Salidas que indican la posición en la que se encuentra 
//              el refresco de la pantalla. 
//  7. RST_N:   Reset activo a nivel bajo.
//  8. R,G,B:	 Señales que indican el color.
// 
// -------------------------------------------------------------------- 
// Versión: V1.0 | Fecha Modificación: 13/05/2014 
// 
// Autor: Joan Bono Aguilar
// Ordenador de trabajo: DISE13
// Compartido con: Dario Alandes Codina
// -------------------------------------------------------------------- 


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

	always @(Columnas , Filas)
		begin
			if((Columnas>=H_FP) && (Columnas<(HL-H_BP)) && (Filas>=V_FP) && (Filas<(VL-V_BP)))
				DEN=1'b1;
				else
				DEN=1'b0;
		end
	

rayas r1(
	.R(R), 
	.G(G), 
	.B(B), 
	.columnas(Columnas), 
	.filas(Filas)); 
   
endmodule
