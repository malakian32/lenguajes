%{
	int stats[13];
	void count(int category, char* text);
	char* getCategoryName(int category);
	void initStats();
	void printStats();
	char buf[1000000];
%}

%{
#undef ECHO
#define ECHO snprintf(buf, sizeof(buf), "%s", yytext)
%}

whiteSpace [ \t\n]+
pronoun (yo|tu|usted|ella|nosotros|vosotros|ellos|ellas|ustedes|vos)
article (el|la|lo|las|los|un|una|unos|unas)
ser (ser|estoy|estás|está|estamos|estáis|están|estaba|estabas|estábamos|estabais|estaban|estabas|estuve|estuviste|estuvo|estuvimos|estuvisteis|estuvieron|estuviste|estaré|estarás|estará|estaremos|estaréis|estarán|estarás|estaría|estarías|estaría|estaríamos|estaríais|estarían|estarías)
estar (estar|soy|eres|es|somos|sois|son|sos|era|eras|era|éramos|erais|eran|eras|fui|fuiste|fue|fuimos|fuisteis|fueron|fuiste|seré|serás|será|seremos|seréis|serán|serás|sería|serías|sería|seríamos|seríais|serían|serías) 
hacer (hacer|hago|haces|hace|hacemos|haceis|hacen|hice|hiciste|hizo|hicimos|hicisteis|hicieron|haré|harás|hará|haremos|haréis|haría|harías|harías|haríamos|haríais|harían) 
tener (tener|tengo|tiene|tienes|tenemos|teneis|tienen|tuve|tenías|tenía|teníamos|teníais|tenían|tuvo|tuviste|tuvieron|tuvimos|tuvisteis|tendré|tendrá|tendrás|tendremos|tendrán|tendréis|tendría|tendrías|tendríamos|tendrían|tendríais) 
buscar (buscar|busco|busca|buscas|buscamos|buscais|buscan|busqué|buscaste|buscó|buscamos|buscasteis|buscaron|buscaré|buscarás|buscará|buscaremos|buscaréis|buscarán|buscaría|buscarías|buscariamos|buscariais|buscarían) 
verb {ser}|{estar}|{hacer}|{tener}|{buscar}
noun (casa|gato|perro|persona|patio|ropa|comida|universidad|silla|mesa|lápiz)
adjective (bonito|feo|grande|pequeño|bueno|malo|mi|tu(s)?|su(s)?|nuestr(o|a|os|as)?|vuestr(o|a|os|as)?)
adverb (muy|mucho|poco|nada|bastante|demasiado|escasamente|menos|más|algo|extremadamente|infinitamente|absolutamente|tanto)
conjunction (y|e|ni|que|o|pero|mas|sino|ya)

naturalNumber [1-9][0-9]*|0
integerNumber (-)?[1-9][0-9]*|0
realNumber ((([1-9][0-9]*|0)"."[0-9]+)|([1-9][0-9]*))(E-?[1-9][0-9]*)?
imaginaryNumber {realNumber}("+"|"-"){realNumber}i
operator "+"|"-"|"*"|"/"|"("|")"
punctuation "."|","|":"|"¿"|"?"|"!"|"¡"

%%

{pronoun} {count(0, yytext);}
{article} {count(1, yytext);}
{verb} {count(2, yytext);}
{noun} {count(3, yytext);}
{adjective} {count(4, yytext);}
{adverb} {count(5, yytext);}
{conjunction} {count(6, yytext);}

{naturalNumber} {count(7, yytext);}
{integerNumber} {count(8, yytext);}
{realNumber} {count(9, yytext);}
{imaginaryNumber} {count(10, yytext);}
{operator} {count(11, yytext);}
{punctuation} {count(12, yytext);}
{whiteSpace} 
. count(-1, yytext);
stats {printStats();}

%%
void initStats() {
	int i;
	
	for(i=0; i<13;i++) {
		stats[i] = 0;
	}	
}

void count(int category, char* text) {
	char* categoryName = getCategoryName(category);
	FILE *f = fopen("file.txt", "a");
	if (f == NULL)
	{
		printf("Error opening file!\n");
		exit(1);
	}
	fprintf(f, "%s ", categoryName);

	fclose(f);
}

char* getCategoryName(int category) {
	char* categoryName = "";
	
	switch(category) {
		case 0:
			categoryName = "PRONOMBRE";
			stats[0] = stats[0] + 1;
			break;
		case 1:
			categoryName = "ARTICULO";
			stats[1] = stats[1] + 1;
			break;
		case 2:
			categoryName = "VERBO";
			stats[2] = stats[2] + 1;
			break;
		case 3:
			categoryName = "SUSTANTIVO";
			stats[3] = stats[3] + 1;
			break;
		case 4:
			categoryName = "ADJETIVO";
			stats[4] = stats[4] + 1;
			break;
		case 5:
			categoryName = "ADVERBIO";
			stats[5] = stats[5] + 1;
			break;
		case 6:
			categoryName = "CONJUNCION";
			stats[6] = stats[6] + 1;
			break;
		case 7:
			categoryName = "N-NATURAL";
			stats[7] = stats[7] + 1;
			break;
		case 8:
			categoryName = "N-ENTERO";
			stats[8] = stats[8] + 1;
			break;
		case 9:
			categoryName = "N-REAL";
			stats[9] = stats[9] + 1;
			break;
		case 10:
			categoryName = "N-IMAGINARIO";
			stats[10] = stats[10] + 1;
			break;
		case 11:
			categoryName = "OPERADOR";
			stats[11] = stats[11] + 1;
			break;
		case 12:
			categoryName = "S-PUNTUACION";
			stats[12] = stats[12] + 1;
			break;
		default:
			categoryName = "DESCONOCIDO";
	}
	
	return categoryName;
}

void printStats() {
	int i;
	FILE *statsFile = fopen("stats.txt", "a");
	if (statsFile == NULL)
	{
		printf("Error opening file!\n");
		exit(1);
	}
	for(i=0; i<13;i++) {
		fprintf(statsFile, "%s: %d\n", getCategoryName(i), stats[i]);
	}
	fclose(statsFile);
}

int getStringSize(char* string){
	int i = 0;
	
	while (string[i] != '\0') {
    	i++;
	}
	
	return i;
}
