%{
#include <stdio.h>
#include <stdlib.h>
%}

/*Declaración de variables de C para usarlas en Bison*/
%union{
	struct ast *a;
	double d;
}

/*
	Declaración de tokens
*/

%token <d> NUMBER
%token EOL

%type <a> exp factor term //cada vez que bison se encuentre con estos tokens se creará un ast.

%%
calclist: /*nothing*/
		| calclist exp EOL  { printf("= %4.4g\n", eval($2)); treefree($2); printf("> ");}  //evalua el AST, lo muestra y lo libera
		| calclist EOL { printf("> ");} 
		;

exp: factor
	| exp '+' factor {$$ = newcast('+', $1,$3);}
	| exp '-' factor {$$ = newcast('-', $1,$3);}
	;

factor: term
	| factor '*' term {$$ = newcast('*', $1,$3);}
	| factor '/' term {$$ = newcast('/', $1,$3);}
	;

term: NUMBER { $$ = newnum($1);}
	| '|' term {$$ = newast('|',$2,NULL);}
	| '(' exp ')' { $$ = $2;}
	| '-' term {$$ = newast('M', $2, NULL);}
	;
%% 
		

