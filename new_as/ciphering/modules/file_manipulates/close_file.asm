global close_file





section .text


close_file:
	mov eax, 6
	mov ebx, [esp+0x4]
	int 80h
	ret