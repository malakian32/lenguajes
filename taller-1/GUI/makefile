# change application name here (executable output name)
TARGET=taller

# compiler
CC=gcc
# debug
DEBUG=-g
# optimisation
OPT=-O0
# warnings
WARN=-Wall

PTHREAD=-pthread

CCFLAGS=$(DEBUG) $(OPT) $(WARN) $(PTHREAD) -pipe

GTKLIB=`pkg-config --cflags --libs gtk+-3.0`

# linker
LD=gcc
LDFLAGS=$(PTHREAD) $(GTKLIB) -export-dynamic

OBJS=main.o

all: pre-build build post-build

build: $(OBJS)
	$(LD) -o $(TARGET) $(OBJS) $(LDFLAGS)
	
flex.c:
	lex -o src/flex.c --header-file=src/flex.h src/flex.l
	
flex.o: flex.c
	$(CC) -c $(CCFLAGS) -o flex.o src/flex.c -lfl
    
main.o: flex.o src/main.c
	$(CC) -c $(CCFLAGS) src/main.c flex.o $(GTKLIB) -o main.o
    
clear:
	-rm -f *.o src/flex.c src/flex.h src/flex.o
	
pre-build: clear
	-rm -f $(TARGET) 
	
post-build: clear
	-rm -f *.o src/flex.c src/flex.h src/flex.o
	./$(TARGET)
