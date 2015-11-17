#!/bin/bash





nasm -felf -ggdb -g3 main.asm
nasm -felf -ggdb -g3 ciphering.asm
nasm -felf -ggdb -g3 method.asm

ld -melf_i386 -o cipher main.o method.o ciphering.o console_manipulates.a file_manipulates.a passw.a state_change.a
rm *.o