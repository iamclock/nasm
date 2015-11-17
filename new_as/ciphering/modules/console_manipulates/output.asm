global output







section .text


output:
	mov edx, [esp+0x8]	;длина
	mov ecx, [esp+0x4]	;сообщение
	mov eax, 4
	mov ebx, 1
	int 80h
	ret