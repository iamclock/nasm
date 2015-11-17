#!/bin/bash





nasm -felf -ggdb -g3 echo_off.asm
nasm -felf -ggdb -g3 echo_on.asm
nasm -felf -ggdb -g3 read_state.asm
nasm -felf -ggdb -g3 write_state.asm
ar crs state_change.a echo_off.o echo_on.o read_state.o write_state.o
rm *.o