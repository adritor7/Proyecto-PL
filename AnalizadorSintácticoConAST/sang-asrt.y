%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string>
#include <vector>
#include "ASTNodes.hpp"

extern int yylex(void);
extern char *yytext;
extern int linea;
extern FILE *yyin;
void yyerror(char* s);

%}

%union{
	double real;
	int numero;
	char* texto;
    class Value_node<int>* nodoEntero;
    class Value_node<double>* nodoReal;
    class Value_node<std::string>* nodoCadena;
    class Value_node<std::vector<double>>* nodoVectorReales;
    class Variable_node<Value_node<double>>* variableReal;
    class Variable_node<Value_node<std::string>>* variableCadena;
    class Variable_node<Value_node<char>>* variableLetra;
    class Variable_node<Value_node<std::vector<double>>>* variableVectorReal;
}

%start inicio

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

%left MODULO MODULO_PUNTO
%left SUMA SUMA_PUNTO RESTA RESTA_PUNTO
%left DIVISION DIVISION_PUNTO MULTIPLICACION MULTIPLICACION_PUNTO

%type <numero> espacio
%type <real> NUMERO RHSreal 
%type <a> asignacion LHSreal LHSvector



%%

inicio: COMIENZAFUNCION NULO INICIO ABREPARENTESIS TIPOVECTOR IDENTIFICADOR CIERRAPARENTESIS ABRELLAVES comando CIERRALLAVES ;

comando:
        | declaracion PUNTOYCOMA comando
        | asignacion PUNTOYCOMA comando
        | Calcular PUNTOYCOMA comando
        | llamadaFuncion PUNTOYCOMA comando
        | devuelve PUNTOYCOMA comando
        | nombreVariable PUNTOYCOMA
        ; //añadir más

llamadaFuncion: IDENTIFICADOR ABREPARENTESIS parametros CIERRAPARENTESIS ;

parametros:
        |parametro
        |parametro COMA parametros
        ;

parametro:tipo IDENTIFICADOR;

LHSletra: TIPOLETRA IDENTIFICADOR ;
LHSreal: TIPOREAL IDENTIFICADOR;:
LHSvector: TIPOVECTOR IDENTIFICADOR;

RHSreal: NUMERO  { $$ = (double) $1};
RHSvector: RESERVAESPACIOVECTOR espacio tipo ;

espacio: NUMERO { $$ = (int) $1};

tipo: TIPOLETRA
	|TIPOREAL
    |TIPOVECTOR
	;

asignacion: LHSreal ASIGNACION RHSreal  {$$ = newast(‘=’&’R’ , $1,$3); } //TODO modificar con la nueva estructura .cpp
	| LHSvector ASIGNACION RHSvector  {$$ = newast(‘=’&’V’ , $1,$3); }
	;

declaracion: LHSletra
	| LHSreal
	| LHSvector
	;

Calcular: NUMERO
    |Calcular SUMA Calcular {$$=$1+$3;}
    |Calcular RESTA Calcular {$$=$1-$3;}
    |Calcular MULTIPLICACION Calcular {$$=$1*$3;}
    |Calcular DIVISION Calcular {$$=$1/$3;}
    ;

declaracionFuncion: COMIENZAFUNCION tipo IDENTIFICADOR ABREPARENTESIS parametros CIERRAPARENTESIS ABRELLAVES comando CIERRALLAVES;

devuelve: DEVUELVE comando;

nombreVariable: IDENTIFICADOR;

OperacionesVectores: vector
    |OperacionesVectores SUMA_PUNTO OperacionesVectores
    |OperacionesVectores RESTA_PUNTO OperacionesVectores
    |OperacionesVectores MODULO_PUNTO OperacionesVectores
    |OperacionesVectores MULTIPLICACION_PUNTO OperacionesVectores
    |OperacionesVectores DIVISION_PUNTO OperacionesVectores
    ;

vector: ABRECORCHETES elementosVector CIERRACORCHETES
    | nombreVariable
    ;

elementosVector: NUMERO COMA elementosVector  // aquí añadir código entre tokens para crear el vector?
        | NUMERO
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
	