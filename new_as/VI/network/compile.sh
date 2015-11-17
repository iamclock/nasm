#! /bin/bash








var=`basename $1 .asm`
nasm -felf -ggdb -g3 $1
ld -melf_i386 -o $var "$var.o"
rm *.o