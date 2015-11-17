#!/usr/bin/python3
# -*- coding: UTF-8 -*-


import sys



if len(sys.argv) < 2:
	file_name = print("Аргументом должно быть название программы, введите его сейчас: ")
else:
	file_name = sys.argv[1]

f_stream = open(file_name, 'rt')

x = f_stream.read(1)
while x != '':
	sys.stdout.write(hex(x))
	x = f_stream.read(1)
print('')