/* Declarations */

%{
	int chars = 0;
	int words = 0;
	int lines = 0;
%}

%%

/* scanner rules and actions */
[a-zA-Z0-9]+	{ words++; chars += strlen(yytext); }
\n		{ lines++; }
.		{ chars++; }

%%

/* c code */

main(int argc, chars **argv){
	yylex();
	printf("%8d%8d%8d\n",lines, words, chars);
	return 0;
}
