global write_to_file










section .text




write_to_file:
	mov eax, 4
	mov ebx, [esp+0x4]	;дескриптор файла
	mov ecx, [esp+0x8]	;сообщение
	mov edx, [esp+0xc]	;длина сообщения
	int 80h
	ret