/* Declarations */

%option noyywrap	/* disable the default yywrap of flex */

%{
	int chars = 0;
	int words = 0;
	int lines = 0;

	int totalChars = 0;
	int totalWords = 0;
	int totalLines = 0;
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
	if(argc<2){
		yylex(); 	/* call flex main routine to scan the input */
		printf("%8d%8d%8d\n",lines, words, chars);
		return 0;
	}

	for(i=1; i<argc;i++){
		FILE *f = fopen(argv[i], "r");
		
		if(!f){
			perror(argv[i]);
			return (1);
		}
	
		yyretart(f);
		yylex();
		fclose(f);

		printf("%8d%8d%8d\n",lines, words, chars);
		totalChars += chars; chars = 0;
		totalLines += lines; lines = 0;
		totalWords += words; words = 0;

	}	
	
	if(argc>1){
		printf("%8d%8d%8d total\n",totalLines, totalWords, totalChars);
		return 0;
	}

}	
