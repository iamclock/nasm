global input








section .text

input:
	mov eax, 3
	xor ebx, ebx
	mov edx, [esp+0x8]	;длина
	mov ecx, [esp+0x4]	;массив
	int 80h
	ret