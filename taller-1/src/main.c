#include <gtk/gtk.h>
#include "flex.h"

int PHENOTYPIC_MODE = 0;
int GENOTYPIC_MODE = 1;
int MODE = 0;
int counter = 0;

extern int myArray[13] = { 0 };

GtkWidget *editorModeButton;
GtkWidget *editorTextView;
GtkWidget *lexicalAnalysisTextView;
GtkWidget *meaningsTextView;
GtkWidget *statsTextView;
GtkTextBuffer *editorTextBuffer;
GtkTextBuffer *lexicalAnalysisTextBuffer;
//GtkTextBuffer *meaningsTextBuffer;
GtkTextBuffer *statsTextBuffer;
FILE *file;

int main(int argc, char *argv[]) {
	GtkBuilder *builder;
	GtkWidget *window;

	gtk_init(&argc, &argv);

	builder = gtk_builder_new();
	gtk_builder_add_from_file(builder, "glade/main-window.glade", NULL);

	window = GTK_WIDGET(gtk_builder_get_object(builder, "main-window"));
	gtk_builder_connect_signals(builder, NULL);

	editorModeButton = GTK_WIDGET(gtk_builder_get_object(builder, "editorMode"));

	editorTextView = GTK_WIDGET(gtk_builder_get_object(builder, "editor"));
	editorTextBuffer = gtk_text_view_get_buffer(editorTextView);

	lexicalAnalysisTextView = GTK_WIDGET(gtk_builder_get_object(builder, "lexicalAnalysis"));
	lexicalAnalysisTextBuffer = gtk_text_view_get_buffer(lexicalAnalysisTextView);

	//meaningsTextView = GTK_WIDGET(gtk_builder_get_object(builder, "meanings"));
	//meaningsTextBuffer = gtk_text_view_get_buffer(meaningsTextView);

	statsTextView = GTK_WIDGET(gtk_builder_get_object(builder, "stats"));
	statsTextBuffer = gtk_text_view_get_buffer(statsTextView);

	readFile();

	g_object_unref(builder);
	gtk_widget_show(window);
	gtk_main();

	return 0;
}

void mainWindowDestroyed() {
	gtk_main_quit();
}

void buttonActivated() {
	if (MODE == PHENOTYPIC_MODE) {
		MODE = GENOTYPIC_MODE;
		gtk_button_set_label(GTK_BUTTON(editorModeButton), "MODO GENOTÍPICO");
		readFenotipycFile();
		readStatsFile();
	} else {
		MODE = PHENOTYPIC_MODE;
		gtk_button_set_label(GTK_BUTTON(editorModeButton), "MODO FENOTÍPICO");
		readFile();
	}
}

void keyPressedInEditor() {
	GtkTextIter start, end;
	char *text;
	int size;

	size = gtk_text_buffer_get_char_count(editorTextBuffer);
	gtk_text_buffer_get_start_iter(editorTextBuffer, &start);
	gtk_text_buffer_get_end_iter(editorTextBuffer, &end);
	text = gtk_text_buffer_get_text(editorTextBuffer, &start, &end, FALSE);

	initStats();
	updateFile(text);

	if (MODE == GENOTYPIC_MODE) {
		FILE *fileIn = fopen("output.txt", "r");      
		if (!fileIn)
		{
			fprintf(stderr, "Could not open %s\n", "output.txt");
			exit(1);
		}
		yyin = fileIn;
		
		FILE *f = fopen("file.txt", "w");
		if (f == NULL)
		{
			printf("Error opening file!\n");
			exit(1);
		}
		fprintf(f, "");
		fclose(f);

		
		FILE *stats = fopen("stats.txt", "w");
		if (stats == NULL)
		{
			printf("Error opening file!\n");
			exit(1);
		}
		fprintf(stats, "");
		fclose(stats);

		yylex();

		readFenotipycFile();
		printStats();
		readStatsFile();
	}else{
		updateLexicalAnalysis(text, size);
	}
}

void updateFile(char *text) {
	file = fopen("output.txt", "w");

	if (file == NULL) {
		printf("Error saving file!\n");
		exit(1);
	}

	fprintf(file, "%s", text);
	fclose(file);
}

void readFile() {
	char buffer[255];
	char *text = malloc(100000000);
	file = fopen("output.txt", "r");

	if (file != NULL) {

		while (fgets(buffer, 255, file)) {
			strcat(text, buffer);
		}

		updateTextEditor(text, strlen(text));
		fclose(file);
	}
}

void readFenotipycFile() {
	char buffer[255];
	char *text = malloc(100000000);
	file = fopen("file.txt", "r");

	if (file != NULL) {

		while (fgets(buffer, 255, file)) {
			strcat(text, buffer);
		}

		updateLexicalAnalysis(text, strlen(text));
		fclose(file);
	}
}

void readStatsFile() {
	char buffer[255];
	char *text = malloc(100000000);
	file = fopen("stats.txt", "r");

	if (file != NULL) {

		while (fgets(buffer, 255, file)) {
			strcat(text, buffer);
		}

		updateStats(text, strlen(text));
		fclose(file);
	}
}

void updateTextEditor(char* text, int size) {
	gtk_text_buffer_set_text(editorTextBuffer, text, size);
}

void updateLexicalAnalysis(char* text, int size) {
	gtk_text_buffer_set_text(lexicalAnalysisTextBuffer, text, size);
}

void updateMeanings(char* text, int size) {
	
}

void updateStats(char* text, int size) {
	gtk_text_buffer_set_text(statsTextBuffer, text, size);
}
