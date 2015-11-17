global read_from_file





section .text





read_from_file:
	mov eax, 3
	mov ebx, [esp+0x4]	;дескриптор файла
	mov ecx, [esp+0x8]	;массив
	mov edx, [esp+0xc]	;длина
	int 80h
	ret