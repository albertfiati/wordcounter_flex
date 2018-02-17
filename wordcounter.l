/* Declarations */

%option noyywrap	/* disable the default yywrap of flex */

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

main(argc, argv) 
int args;
char ** argv;
{
	if(argc>1){
		if(!(yyin = fopen(argv[1],"r"))){    /* reading input into flex yyin */
			perror(argv[1]);
			return (1);
		}
	}

	yylex(); 	/* call flex main routine to scan the input */
	printf("%8d%8d%8d\n",lines, words, chars);
}
