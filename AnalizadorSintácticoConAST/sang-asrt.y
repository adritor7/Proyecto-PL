%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string>
#include <vector>
#include "ASTNodes.hpp"

Main_node* root;

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

%token ABREPARENTESIS 
%token CIERRAPARENTESIS 
%token ABRECORCHETES
%token CIERRACORCHETES 
%token ABRELLAVES 
%token CIERRALLAVES 
%token TIPOREAL 
%token TIPOVECTOR 
%token TIPOLETRA 
%token RESERVAESPACIOVECTOR 
%token SI 
%token SOLOSI 
%token SINO 
%token DEPENDE 
%token CASO 
%token FIN 
%token PORDEFECTO 
%token PUNTOYCOMA 
%token DOSPUNTOS 
%token MIENTRAS 
%token PARA 
%token FINAL 
%token COMIENZAFUNCION 
%token NULO   
%token DEVUELVE 
%token SALIDA 
%token COMA 
%token INICIO 
%token NUMERO 
%token IDENTIFICADOR 
%token LEER 
%token ESCRIBIR 
%token ASIGNACION 
%token ERROR 
%token SUMA 
%token RESTA 
%token MULTIPLICACION 
%token DIVISION 
%token MODULO 
%token SUMA_PUNTO 
%token RESTA_PUNTO 
%token MULTIPLICACION_PUNTO 
%token DIVISION_PUNTO 
%token MODULO_PUNTO 
%token MAYOR_QUE 
%token MAYOR_O_IGUAL_QUE 
%token MENOR_QUE 
%token MENOR_O_IGUAL_QUE 
%token IGUAL_QUE 
%token DISTINTO_QUE 
%token AND 
%token OR  
%token NOT 
%token CADENA 
%token ESPACIO

%left MODULO MODULO_PUNTO
%left SUMA SUMA_PUNTO RESTA RESTA_PUNTO
%left DIVISION DIVISION_PUNTO MULTIPLICACION MULTIPLICACION_PUNTO

%type <numero> espacio
%type <real> NUMERO RHSreal 
%type <a> asignacion LHSreal LHSvector

//TODO añadir todos los tipos de nodos: IDENTIFICADOR -> string parametros -> std::vector<Node*>; La familia LHS es del tipo variable Node.

%%

inicio: COMIENZAFUNCION NULO INICIO ABREPARENTESIS TIPOVECTOR IDENTIFICADOR CIERRAPARENTESIS ABRELLAVES { $$ = new Main_node(); root = $$} comando CIERRALLAVES ;

comando:
        | declaracion {root->nuevoHijo($1);} PUNTOYCOMA comando 
        | asignacion {root->nuevoHijo($1);} PUNTOYCOMA comando
        | Calcular {root->nuevoHijo($1);} PUNTOYCOMA comando
        | llamadaFuncion {root->nuevoHijo($1);} PUNTOYCOMA comando
        | devuelve {root->nuevoHijo($1);} PUNTOYCOMA comando
        | nombreVariable {root->nuevoHijo($1);} PUNTOYCOMA //para el return?
        ; //añadir más

llamadaFuncion: IDENTIFICADOR ABREPARENTESIS {$$ = new FunctionCall_node($1);} parametros {$$->setParams($3);} CIERRAPARENTESIS ;

parametros:
        |parametro {$$ = new std::vector<Node*>(); $$->push_back($1);}
        |parametro {$$ = new std::vector<Node*>(); $$->push_back($1);} COMA parametros {$$.insert( $$.end(), $3->begin(), $3->end() );}
        ;

parametro:TIPOLETRA IDENTIFICADOR {$$ = new Variable_node<char>($2)};
	| TIPOREAL IDENTIFICADOR {$$ = new Variable_node<double>($2)};
	| TIPOVECTOR IDENTIFICADOR {$$ = new Variable_node<void*>($2)};

LHSletra: TIPOLETRA IDENTIFICADOR {$$ = new Variable_node<char>($2)};
LHSreal: TIPOREAL IDENTIFICADOR {$$ = new Variable_node<double>($2)};
LHSvector: TIPOVECTOR IDENTIFICADOR {$$ = new Variable_node<void*>($2)};

RHSreal: NUMERO {$$ = new Value_node<double>($1);}; //TODO modificar el tipo de datos de RHSreal
RHSvector: RESERVAESPACIOVECTOR ESPACIO TIPOLETRA {$$ = new Value_node(malloc($2*sizeof(char)))};
		| RESERVAESPACIOVECTOR ESPACIO TIPOREAL {$$ = new Value_node(malloc($2*sizeof(double)))};


asignacion: LHSreal ASIGNACION RHSreal  {$$ = $1->setValue($3); } 
	| LHSvector ASIGNACION RHSvector  {$$ = $->setValue($3); }
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
	