RELEASE_FOLDER=release
EXEC=$(RELEASE_FOLDER)/analizador-lexico
CC=gcc
DEBUG=-g
OPT=-O0
WARN=-Wall
PTHREAD=-pthread
LFL=-lfl
CCFLAGS=$(DEBUG) $(OPT) $(WARN) $(PTHREAD) $(LFL) -pipe
GTKLIB=`pkg-config --cflags --libs gtk+-3.0`
LD=gcc
LDFLAGS=$(PTHREAD) $(LFL) $(GTKLIB) -export-dynamic
OBJS=main.o


all: pre-build build post-build

build: main.o
	$(LD) -o $(EXEC) $(RELEASE_FOLDER)/main.o $(RELEASE_FOLDER)/flex.o $(LDFLAGS)
	
flex.c:
	lex -o src/flex.c --header-file=src/flex.h src/flex.l
	
flex.o: flex.c
	$(CC) -c $(CCFLAGS) src/flex.c -o $(RELEASE_FOLDER)/flex.o 
    
main.o: flex.o
	$(CC) -c $(CCFLAGS) src/main.c $(GTKLIB) -o $(RELEASE_FOLDER)/main.o
    
clear:
	-rm -f *.o src/flex.c src/flex.h
	
pre-build: clear
	-rm -f $(EXEC)
	
post-build: clear
	-rm -f $(RELEASE_FOLDER)/*.o src/flex.c src/flex.h
	./$(EXEC)
	