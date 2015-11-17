global read_state







section .text






read_state:
	mov eax, 54
	mov ebx, 0
	mov ecx, 5401h
	mov edx, [esp+0x4]
	int 80h
	ret