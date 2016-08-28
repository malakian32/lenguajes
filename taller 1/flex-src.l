%{
	int var;
%}

whiteSpace [ \t\n]+
pronoun (yo|tu|usted|ella|nosotros|vosotros|ellos|ellas|ustedes|vos)
article (el|la|lo|las|los|un|una|unos|unas)
verb (soy|eres|es|somos|sois|son|sos|era|eras|era|éramos|erais|eran|eras|fui|fuiste|fue|fuimos|fuisteis|fueron|fuiste|seré|serás|será|seremos|seréis|serán|serás|sería|serías|sería|seríamos|seríais|serían|serías)
noun (casa|gato|perro|persona|patio|ropa|comida|universidad|silla|mesa|lápiz)
adjective (bonito|feo|grande|pequeño|bueno|malo|mi|tu(s)?|su(s)?|nuestr(o|a|os|as)?|vuestr(o|a|os|as)?)
adverb (muy|mucho|poco|nada|bastante|demasiado|escasamente|menos|más|algo|extremadamente|infinitamente|absolutamente|tanto)
conjunction (y|e|ni|que|o|pero|mas|sino|ya)

naturalNumber [1-9][0-9]*|0
integerNumber (-)?[1-9][0-9]*|0
realNumber ((([1-9][0-9]*|0)"."[0-9]+)|([1-9][0-9]*))(E-?[1-9][0-9]*)?
imaginaryNumber {realNumber}("+"|"-"){realNumber}i

%%

{pronoun} {printf("%s: pronombre\n", yytext);}
{article} {printf("%s: articulo\n", yytext);}
{verb} {printf("%s: verbo\n", yytext);}
{noun} {printf("%s: pronombre\n", yytext);}
{adjective} {printf("%s: adjetivo\n", yytext);}
{adverb} {printf("%s: adverbio\n", yytext);}
{conjunction} {printf("%s: conjuncion\n", yytext);}


{naturalNumber} {printf("%s: natural\n", yytext);}
{integerNumber} {printf("%s: entero\n", yytext);}
{realNumber} {printf("%s: real\n", yytext);}
{imaginaryNumber} {printf("%s: imaginario\n", yytext);}
{whiteSpace} 
. printf( "Unrecognized character: %s\n", yytext );

%%

int main() {
	yylex();
	return 0;
}
