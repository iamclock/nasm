global write_state











section .text





write_state:
	mov eax, 54
	mov ebx, 0
	mov ecx, 5402h
	mov edx, [esp+0x4]
	int 80h
	ret