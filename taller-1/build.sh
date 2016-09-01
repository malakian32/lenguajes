flex flex-src.l
gcc lex.yy.c -lfl -o flex-exec
gcc `pkg-config --cflags gtk+-3.0` -o gui gui.c `pkg-config --libs gtk+-3.0`
./flex-exec
