global open_file






section .text



open_file:
	mov eax, 5
	mov ebx, [esp+0x4]
	mov ecx, 102q
	mov edx, 700q
	int 80h
	ret