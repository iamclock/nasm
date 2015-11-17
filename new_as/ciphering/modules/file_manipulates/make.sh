#!/bin/bash





nasm -felf -ggdb -g3 close_file.asm
nasm -felf -ggdb -g3 open_file.asm
nasm -felf -ggdb -g3 open_file_ro.asm
nasm -felf -ggdb -g3 read_from_file.asm
nasm -felf -ggdb -g3 write_to_file.asm
ar crs file_manipulates.a close_file.o open_file.o open_file_ro.o read_from_file.o write_to_file.o
rm *.o