#include <gtk/gtk.h>
static int PHENOTYPIC_MODE = 0;
static int GENOTYPIC_MODE = 1;
static int MODE = 0;
static GtkWidget *button;
static GtkWidget *button;

static void buttonActivated (GtkWidget *widget, gpointer data) {		
	if(MODE == PHENOTYPIC_MODE) {
		MODE = GENOTYPIC_MODE;
		gtk_button_set_label (GTK_BUTTON(button), "MODO GENOTIPICO");
	} else {
		MODE = 0;
		gtk_button_set_label (GTK_BUTTON(button), "MODO FENOTIPICO");
	}	
}

static void activate (GtkApplication* app, gpointer user_data) {
	GtkWidget *window;
	GtkWidget *button_box;
	
	window = gtk_application_window_new (app);
	gtk_window_set_title (GTK_WINDOW (window), "Window");
	gtk_window_set_default_size (GTK_WINDOW (window), 800, 800);
	
	button_box = gtk_button_box_new (GTK_ORIENTATION_HORIZONTAL);
	gtk_container_add (GTK_CONTAINER (window), button_box);

	button = gtk_button_new_with_label ("MODO FENOTIPICO");
	g_signal_connect (button, "clicked", G_CALLBACK (buttonActivated), NULL);
	//g_signal_connect_swapped (button, "clicked", G_CALLBACK (gtk_widget_destroy), window);
	gtk_container_add (GTK_CONTAINER (button_box), button);
	
	gtk_widget_show_all (window);
}

int main (int argc, char **argv) {
	GtkApplication *app;
	int status;
	
	app = gtk_application_new ("org.gtk.example", G_APPLICATION_FLAGS_NONE);
	g_signal_connect (app, "activate", G_CALLBACK (activate), NULL);
	status = g_application_run (G_APPLICATION (app), argc, argv);
	g_object_unref (app);
	
	return status;
}
