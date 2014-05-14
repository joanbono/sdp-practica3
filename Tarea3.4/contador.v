// -------------------------------------------------------------------- 
// Universitat Politècnica de València 
// Escuela Técnica Superior de Ingenieros de Telecomunicación 
// -------------------------------------------------------------------- 
// Sistemas Digitales Programables 
// Curso 2013 - 2014 
// -------------------------------------------------------------------- 
// Nombre del archivo: contador.v 
// 
// Descripción: Este código Verilog implementa una máquina de estados con 
// la siguiente funcionalidad de sus entradas y salidas: 
//  1. clock:    Señal de reloj.
//  2. reset_n:  Reset activo a nivel bajo. 
//  3. enable:   Señal de que habilita la cuenta.
//  4. count:    
//  5. TC:       Señal que indica cuando se llega al final de la cuenta.
// 
// -------------------------------------------------------------------- 
// Versión: V1.0 | Fecha Modificación: 13/05/2014 
// 
// Autor: Joan Bono Aguilar
// Ordenador de trabajo: DISE13
// Compartido con: Dario Alandes Codina
// -------------------------------------------------------------------- 



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
