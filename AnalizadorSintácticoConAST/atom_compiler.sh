bison -d sang-asrt.y
flex lang.l
cc lex.yy.c sang-asrt.tab.c  -o sang 
