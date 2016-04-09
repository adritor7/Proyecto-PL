#!/bin/bash
bison -d sintactico.y
flex compiladorFlex.l
cc lex.yy.c sintactico.tab.c -o analizador –lm