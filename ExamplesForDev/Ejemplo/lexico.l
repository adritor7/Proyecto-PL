/*****************
 * Declaraciones *
 ****************/ 

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "sintactico.tab.h"	
	
	int linea=0;
%}

DIGITO [0-9]
NUMERO {DIGITO}+("."{DIGITO}+)?


%%


 /*********************
  * Reglas y Acciones *
 **********************/

{NUMERO} {yylval.real=atof(yytext); return(NUMERO);}
"(" 	{return(PARA);}
")" 	{return(PARC);}
"," 	{return(COMA);}
"=" 	{return(IGUAL);}
">" 	{return(MAYOR);}
"[" 	{return(CORCHA);}
"]" 	{return(CORCHC);}
";" 	{return(PUNTOCOMA);}
"\n" 	{linea++;}
[\t\r\f] {}
" "		{}
 
.	{printf("Error lexico en linea %d",linea);}
%%
/*********************
 * Codigo de Usuario *
*********************/



