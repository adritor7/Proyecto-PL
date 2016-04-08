%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include “sang-astHeader.h”

extern yylex(void);
extern char *yytext;
extern int linea;
extern FILE *yyin;
void yyerror(char* s);

%}

%union{
	double real;
	int numero;
	char* texto;
	struct ast *a;
}


%token ABREPARENTESIS 257
%token CIERRAPARENTESIS 258
%token ABRECORCHETES 259
%token CIERRACORCHETES 260
%token ABRELLAVES 261
%token CIERRALLAVES 262
%token TIPOREAL 263
%token TIPOVECTOR 264
%token TIPOLETRA 265
%token RESERVAESPACIOVECTOR 266
%token SI 267
%token SOLOSI 268
%token SINO 269
%token DEPENDE 270
%token CASO 271
%token FIN 272
%token PORDEFECTO 273
%token PUNTOYCOMA 274
%token DOSPUNTOS 275
%token MIENTRAS 276
%token PARA 278
%token FINAL 279
%token COMIENZAFUNCION 280
%token NULO   281
%token DEVUELVE 282
%token SALIDA 283
%token COMA 284
%token INICIO 285
%token NUMERO 286
%token IDENTIFICADOR 287
%token LEER 288
%token ESCRIBIR 289
%token ASIGNACION 290
%token ERROR 291
%token SUMA 300
%token RESTA 301
%token MULTIPLICACION 302
%token DIVISION 303
%token MODULO 304
%token SUMA_PUNTO 305
%token RESTA_PUNTO 306
%token MULTIPLICACION_PUNTO 307
%token DIVISION_PUNTO 308
%token MODULO_PUNTO 309
%token MAYOR_QUE 310
%token MAYOR_O_IGUAL_QUE 311
%token MENOR_QUE 312
%token MENOR_O_IGUAL_QUE 313
%token IGUAL_QUE 314
%token DISTINTO_QUE 315
%token AND 316
%token OR  317
%token NOT 318
%token CADENA 319


%type <real> NUMERO RHSreal 
%type <a> asignacion LHSreal LHSvector



%%

LHSletra: TIPOLETRA IDENTIFICADOR ;
LHSreal: TIPOREAL IDENTIFICADOR;
LHSvector: TIPOVECTOR IDENTIFICADOR;

RHSreal: NUMERO  { $$ = (double) $1};
RHSvector: RESERVAESPACIOVECTOR NUMERO tipo ;

tipo: TIPOLETRA
	|TIPOREAL
	|TIPOVECTOR
	;

asignacion: LHSreal ASIGNACION RHSreal {$$ = newast(‘=’&’R’ , $1,$3); }
	| LHSvector ASIGNACION RHSvector
	;

declaracion: LHSletra PUNTOYCOMA
	| LHSreal PUNTOYCOMA
	| LHSvector PUNTOYCOMA
	;

%%

void yyerror(char* s){
	printf(“Error syntactic %s \n”,s);
}

int main (int argc, char** argv){
	
	if(argc > 1)
		yyin=fopen(argv[1], “rt”);
	else
		yyin=fopen(“entrada.txt”,”rt”);
	yyparse();
	return 0;
}
	