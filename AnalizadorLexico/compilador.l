%{
#include <stdio.h>
int num_lineas = 0, num_caracteres = 0;
%}
%option noyywrap
%option yylineno
digitos [0-9]
letras [a-zA-Z]
tipos REAL|VECTOR|LETRA
ignora " "|\t|\n
operlog &&|!
operel <|>|<=|>=|==|!=
%%
{tipos}                        {printf("Tipo de datos ---> %s\n",yytext);}
{letras}({letras}|{digitos})*  {printf("IDENTIFICADOR ---> %s\n",yytext);}
{digitos}+"."{digitos}*        {printf("Numero ---> %s\n",yytext);}
{digitos}+                     {printf("Numero ---> %s\n",yytext);}
{operel}                   	   {printf("Operador relacional ---> %s\n",yytext);}
{operlog}                      {printf("Operador logico ---> %s\n",yytext);}
"||"                           {printf("Operador logico ---> %s\n",yytext);}
{ignora}+                      {;}
"="                            {printf("ASIGNADOR\n");}
";"                            {printf("PUNTO_COMA\n");}
\n                             ++num_lineas;
.                              {printf("ERROR LEXICO EN LINEA %d \n",yylineno);}
%%
int main(int argc,char *argv[])
{
    char NomArch[30];
    printf("Ingrese nombre de archivo: ");
    
    if ((yyin = fopen("Prueba.txt", "rt")) == NULL)
    {
        printf("\nNo se puede abrir el archivo: %s\n", "Prueba.txt");
    }
    else
    {
        yylex();
    }
    fclose(yyin);
    
    return 0;
}