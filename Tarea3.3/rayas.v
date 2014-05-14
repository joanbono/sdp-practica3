// -------------------------------------------------------------------- 
// Universitat Politècnica de València 
// Escuela Técnica Superior de Ingenieros de Telecomunicación 
// -------------------------------------------------------------------- 
// Sistemas Digitales Programables 
// Curso 2013 - 2014 
// -------------------------------------------------------------------- 
// Nombre del archivo: rayas.v 
// 
// Descripción: Este código Verilog implementa una máquina de estados con 
// la siguiente funcionalidad de sus entradas y salidas: 
//
//  1. R,G,B:	Señales que indican el color.
//  2. columnas, filas:	Salidas que indican la posición en la que se encuentra 
//                      el refresco de la pantalla.
// 
// -------------------------------------------------------------------- 
// Versión: V1.0 | Fecha Modificación: 13/05/2014 
// 
// Autor: Joan Bono Aguilar
// Ordenador de trabajo: DISE13
// Compartido con: Dario Alandes Codina
// -------------------------------------------------------------------- 



module rayas (R,G,B, columnas, filas);

	output reg [7:0] R, G, B;
	
	input [WIDTH1-1:0] columnas;
	input [WIDTH2-1:0] filas;
	
	parameter H_LINE=1056;
	parameter V_LINE=525;
	
	`include "MathFun.vh"
	parameter WIDTH1=CLogB2(H_LINE);
	parameter WIDTH2=CLogB2(V_LINE);

	always @ (filas)
			if(filas<190)
				begin
					R=8'b11111111;
					G=8'b00000000;
					B=8'b00000000;
				end
			else if(filas<360)
					begin
						R=8'b11111111;
						G=8'b11111111;
						B=8'b00000000;
					end
			else
				begin
					R=8'b00000000;
					G=8'b11111111;
					B=8'b00000000;
				end 

endmodule
