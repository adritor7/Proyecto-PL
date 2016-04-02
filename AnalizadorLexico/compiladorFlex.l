%{
#include <stdio.h>
#include <stdlib.h>
#include "tokenDef.h"
%}

%option noyywrap
%option yylineno
%option yylineno
%x INCOMMENT INSTRING
digitos [0-9]
letras [a-zA-Z]
ignora " "|\t|\n
%%
","         {return COMA;}
"="         {return ASIGNACION;}
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
"lee"       {return LEER;}
"escribe"   {return ESCRIBIR;}
"+"         {return SUMA;}
"-"         {return RESTA;}
"*"         {return MULTIPLICACION;}
"/"         {return DIVISION;}
"%"         {return MODULO;}
".+"        {return SUMA_PUNTO;}
".-"        {return RESTA_PUNTO;}
".*"        {return MULTIPLICACION_PUNTO;}
"./"        {return DIVISION_PUNTO;}
".%"        {return MODULO_PUNTO;}
">"         {return MAYOR_QUE;}
"<"         {return MENOR_QUE;}
">="        {return MAYOR_O_IGUAL_QUE;}
"<="		{return MENOR_O_IGUAL_QUE;}
"=="        {return IGUAL_QUE;}
"!="        {return DISTINTO_QUE;}
"!"         {return NOT;}
"&&"        {return AND;}
"||"    	{return OR;}

<INITIAL>"/*"   {BEGIN(INCOMMENT);}
<INCOMMENT>"*/" {BEGIN(INITIAL);}
<INCOMMENT>.|\n {;}

<<<<<<< Updated upstream
<INITIAL>\"     {BEGIN(INSTRING);}
<INSTRING>\"    {BEGIN(INITIAL);}
<INSTRING>.     {;}
=======
<INITIAL>\"     {printf("%s",yytext); BEGIN(INSTRING);}
<INSTRING>\"    {printf("%s",yytext);BEGIN(INITIAL);}
<INSTRING>.    {printf("%s",yytext);}
>>>>>>> Stashed changes


"#"({letras}|{digitos}|[" "|\t|])*[\n]? {;}
{ignora}+   {;}
{digitos}+"."{digitos}* {return NUMERO;}
{digitos}+  {return NUMERO;}
{letras}({letras}|{digitos})* {return IDENTIFICADOR;}
<<<<<<< Updated upstream
. 							  {return ERROR;}
=======
. 							  {printf("error  %s",yytext);}
>>>>>>> Stashed changes
%%
int main(int argc,char *argv[])
{
    if ((yyin = fopen("Prueba.txt", "rt")) == NULL)
    {
        printf("\nNo se puede abrir el archivo: %s\n","Prueba.txt");
    }
    else
    {
        while(yylex() != 0);
    }
    fclose(yyin);
    return 0;
}
