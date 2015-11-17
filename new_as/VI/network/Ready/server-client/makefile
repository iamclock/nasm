all: clean client server cleanos


client:
	nasm -felf -ggdb -g3 client_fork.asm
	ld -melf_i386 -o client client_fork.o

server:
	nasm -felf -ggdb -g3 server_fork.asm
	ld -melf_i386 -o server server_fork.o

clean:
	rm server client

cleanos:
	rm *.o
