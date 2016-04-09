%{	
  #include <stdio.h>
  #include <stdlib.h>
  #include <math.h>
  extern int yylex(void);
  extern char *yytext;
  extern int linea;
  extern FILE *yyin;
  void yyerror(char *s);
%}
%union{
  float  real;
  char * texto;
}
%start Exp_l

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
%token <real> NUMERO 
%token <texto> IDENTIFICADOR 
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

%left MODULO MODULO_PUNTO
%left SUMA SUMA_PUNTO RESTA RESTA_PUNTO
%left DIVISION DIVISION_PUNTO MULTIPLICACION MULTIPLICACION_PUNTO

%type <real> Calcular
%type <real> Exp_l
%type <real> Imprimir
%%


Exp_l:  Exp_l Imprimir  
        |Imprimir
        ;
Imprimir : Calcular PUNTOYCOMA {printf ("%4.1f\n",$1);}     

Calcular: NUMERO {$$=$1;}
     |Calcular SUMA Calcular {$$=$1+$3;}
     |Calcular RESTA Calcular {$$=$1-$3;}
     |Calcular MULTIPLICACION Calcular {$$=$1*$3;}
     |Calcular DIVISION Calcular {$$=$1/$3;}
     ;
%%
void yyerror(char *s){
  printf("Error sintactico %s",s);
}

int main(int argc,char **argv){
  if (argc>1){
      yyin=fopen("Prueba.txt","rt");
  }else{
      yyin=stdin;
  }
  yyparse();
  return 0;
}
