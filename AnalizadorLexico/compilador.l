%{
#include <stdio.h>
#define ABREPARENTESIS 257
#define CIERRAPARENTESIS 258
#define ABRECORCHETES 259
#define CIERRACORCHETES 260
#define ABRELLAVES 261
#define CIERRALLAVES 262
#define TIPOREAL 263
#define TIPOVECTOR 264
#define TIPOLETRA 265
#define RESERVAESPACIOVECTOR 266
#define SI 267
#define SOLOSI 268
#define SINO 269
#define DEPENDE 270
#define CASO 271
#define FIN 272
#define PORDEFECTO 273
#define PUNTOYCOMA 274
#define DOSPUNTOS 275
#define MIENTRAS 276
#define PARA 278
#define FINAL 279
#define COMIENZAFUNCION 280
#define NULO   281
#define DEVUELVE 282
#define SALIDA 283
#define COMA 284
#define INICIO 285
#define NUMERO 286
#define IDENTIFICADOR 287
#define LEER 288
#define ESCRIBIR 289
#define ASIGNACION 290
#define LINEA_COMENTARIO 291
#define INICIO_COMENTARIO 292
#define FINAL_COMENTARIO 293
#define SUMA 300
#define RESTA 301
#define MULTIPLICACION 302
#define DIVISION 303
#define MODULO 304
#define SUMA_PUNTO 305
#define RESTA_PUNTO 306
#define MULTIPLICACION_PUNTO 307
#define DIVISION_PUNTO 308
#define MODULO_PUNTO 309
#define MAYOR_QUE 310
#define MAYOR_O_IGUAL_QUE 311
#define MENOR_QUE 312
#define MENOR_O_IGUAL_QUE 313
#define IGUAL_QUE 314
#define DISTINTO_QUE 315
#define AND 316
#define OR  317
#define NOT 318
%}
%option noyywrap
%option yylineno
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
"||"        {return OR;}
"#"         {return LINEA_COMENTARIO;}
"/*"		{return INICIO_COMENTARIO;}
"*/"        {return FINAL_COMENTARIO;}
{ignora}+   {;}
{digitos}+"."{digitos}* {yylval.num = atof(yytext);  return NUMERO;}
{digitos}+  {yylval.num = atof(yytext);  return NUMERO;}
{letras}({letras}|{digitos})* {return IDENTIFICADOR;}
.         printf("ERROR LEXICO EN LINEA %d \n",yylineno);}
%%
int main(int argc,char *argv[])
{
    if ((yyin = fopen("Prueba.txt", "rt")) == NULL)
    {
        printf("\nNo se puede abrir el archivo: %s\n","Prueba.txt");
    }
    else
    {
        yylex();
    }
    fclose(yyin);
    return 0;
}
