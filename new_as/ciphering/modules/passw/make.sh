#!/bin/bash





nasm -felf -ggdb -g3 CheckPass.asm
nasm -felf -ggdb -g3 GetPass.asm
ar crs passw.a CheckPass.o GetPass.o
rm *.o