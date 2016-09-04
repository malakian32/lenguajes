%{
	int stats[13];
	void count(int category, char* text);
	char* getCategoryName(int category);
	void initStats();
	void printStats();
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
. printf( "Unrecognized character: %s\n", yytext );
stats {printStats();}


%%
void initStats() {
	int i;
	
	for(i=0; i<sizeof(stats);i++) {
		stats[i] = 0;
	}	
}

void count(int category, char* text) {
	char* categoryName = getCategoryName(category);
	
	printf("%s: %s\n", text, categoryName);
	stats[category] = stats[category] + 1;
}

char* getCategoryName(int category) {
	char* categoryName = "";
	
	switch(category) {
		case 0:
			categoryName = "PRONOMBRE";
			break;
		case 1:
			categoryName = "ARTICULO";
			break;
		case 2:
			categoryName = "VERBO";
			break;
		case 3:
			categoryName = "SUSTANTIVO";
			break;
		case 4:
			categoryName = "ADJETIVO";
			break;
		case 5:
			categoryName = "ADVERBIO";
			break;
		case 6:
			categoryName = "CONJUNCION";
			break;
		case 7:
			categoryName = "N-NATURAL";
			break;
		case 8:
			categoryName = "N-ENTERO";
			break;
		case 9:
			categoryName = "N-REAL";
			break;
		case 10:
			categoryName = "N-IMAGINARIO";
			break;
		case 11:
			categoryName = "OPERADOR";
			break;
		case 12:
			categoryName = "S-PUNTUACION";
			break;
		default:
			categoryName = "DESCONOCIDO";
	}
	
	return categoryName;
}

void printStats() {
	int i;
	
	for(i=0; i<sizeof(stats);i++) {
		printf("%d%s:%d\n", i,getCategoryName(i), stats[i]);
	}
}

int getStringSize(char* string){
	int i = 0;
	
	while (string[i] != '\0') {
    	i++;
	}
	
	return i;
}



