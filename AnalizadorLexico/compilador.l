%{
#include <stdio.h>
//int num_lineas = 0, num_caracteres = 0;
#declare ABREPARENTESIS 257
#declare CIERRAPARENTESIS 258
#declare ABRECORCHETES 259
#declare CIERRACORCHETES 260
#declare ABRELLAVES 261
#declare CIERRALLAVES 262
#declare TIPOREAL 263
#declare TIPOVECTOR 264
#declare TIPOLETRA 265
#declare RESERVAESPACIOVECTOR 266
#declare SI 267
#declare SOLOSI 268
#declare SINO 269
#declare DEPENDE 270
#declare CASO 271
#declare FIN 272
#declare PORDEFECTO 273
#declare PUNTOYCOMA 274
#declare DOSPUNTOS 275
#declare MIENTRAS 276
#declare PARA 278
#declare FINAL 279
#declare COMIENZAFUNCION 280
#declare NULO   281
#declare DEVUELVE 282
#declare SALIDA 283
#declare COMA 284
#declare INICIO 285
#declare NUMERO 286
#declare IDENTIFICADOR 287

%}
%option noyywrap
%option yylineno
ignora " "|\t|\n
/*
digitos [0-9]
letras [a-zA-Z]
tipos REAL|VECTOR|LETRA
operlog &&|!
operel <|>|<=|>=|==|!=
*/
%%
/*
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
.                              {printf("ERROR LEXICO EN LINEA %d \n",yylineno);}*/

{ignora}+
","         {return COMA;}
";"         {return PUNTOYCOMA;}
":"         {return DOSPUNTOS;}
"("         {return ABREPARENTESIS;}
")"         {return CIERRAPARENTESIS;}
"["         {return ABRECORCHETES;}
"]"         {return CIERRACORCHETES;}
"{"         {return ABRELLAVES;}
"}"         {return CIERRALLAVES;}
"si"        {return SI;}
"fin"       {return FIN;}
"caso"      {return CASO;}
"func"      {return COMIENZAFUNCION;}
"nulo"      {return NULO;}
"para"      {return PARA;}
"sino"      {return SINO;}
"final"     {return FINAL;}
"inicio"    {return INICIO;}
"salida"    {return SALIDA;}
"soloSi"    {return SOLOSI;}
"espacio"   {return RESERVAESPACIOVECTOR;}
"devuelve"  {return DEVUELVE;}
"mientras"  {return MIENTRAS;}
"dependeDe" {return DEPENDE;}
"porDefecto" {return PORDEFECTO;}
"REAL"      {return TIPOREAL;}
"VECTOR"    {return TIPOVECTOR;}
"LETRA"     {return TIPOLETRA;}
{digitos}+"."{digitos}* {yylval.num = atof(yytext);  return NUMERO;}
{digitos}+  {yylval.num = atof(yytext);  return NUMERO;}
{letras}({letras}|{digitos})* {return IDENTIFICADOR;}



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