global open_file_ro






section .text


open_file_ro:
	mov eax, 5
	mov ebx, [esp+0x4]
	mov ecx, 0
	int 80h
	ret