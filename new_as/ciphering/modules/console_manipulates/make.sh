#!/bin/bash





nasm -felf -ggdb -g3 input.asm
nasm -felf -ggdb -g3 output.asm
ar crs console_manipulates.a input.o output.o
rm *.o