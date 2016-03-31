%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "string.h"
extern int yylex(void);
extern char *yytext;
extern int linea;
extern FILE *yyin;
void yyerror(char *s);
%}


%union
{
  float real;
  int numero;
  char* texto;
}

%start lista_i;
//TODO símbolos de la gramatica 

%token <real> NUMERO
%token PARA
%token PARC
%token COMA
%token IGUAL
%token MAYOR
%token CORCHA
%token CORCHC
%token PUNTOCOMA



%type <texto> celda
%type <real> valor
%%
/* RULES*/

%%


/**********************
 * Codigo C Adicional *
 **********************/
void yyerror(char *s)
{
	printf("Error sintactico %s \n",s);
}

int main(int argc,char **argv)
{
	
	if (argc>1)
		yyin=fopen(argv[1],"rt");
	else
		yyin=fopen("entrada.txt","rt");
		

	yyparse();
	return 0;
}