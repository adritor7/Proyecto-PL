%{

/********************** 
 * Declaraciones en C *
 **********************/


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

/*************************
  Declaraciones de Bison *
 *************************/


%union
{
  float real;
  int numero;
  char* texto;
}


%start lista_i;


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
/***********************
 * Reglas Gramaticales *
 ***********************/


lista_i : 	lista_i i;
			| i
			;
i:			instruccion PUNTOCOMA
			|error PUNTOCOMA  /* Recuperacion de error modo panico */
			;

instruccion:	celda IGUAL MAYOR valor {printf ("   otra vez valor = %1.0f\n",$4);}
				|celda IGUAL valor { printf ("Error Sintcatico, falta >\n"); }
				|celda MAYOR valor { printf ("Error Sintactico, falta = \n");}
			;
celda:		PARA NUMERO COMA NUMERO PARC {printf ("  celda %1.0f , %1.0f ",$2,$4);};
			| NUMERO COMA NUMERO PARC {printf("Error Sintactico, falta (\n");}
			| PARA NUMERO COMA NUMERO {printf ("Error Sintactico, falta )\n");}
			
			;
			
valor:	CORCHA NUMERO CORCHC {  printf ("  valor = %1.0f\n",$2);
								$$=$2;	
								
							}
		


			;	

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
		//yyin=stdin;
		yyin=fopen("entrada.txt","rt");
		

	yyparse();
	return 0;
}