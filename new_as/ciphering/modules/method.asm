global method


extern output



section .data
error_message db "incorrect method",10
len_err_mes equ $-error_message


section .text




method:
	push ebp
	mov ebp, esp
	mov eax, [ebp+0x8]	;массив выбора
	mov ecx, [ebp+0xc]	;его длина
	xor esi, esi
	mov bl, [eax]
	
	mov edi, 1
	cmp bl, 'c'
	je .check_cipher
	
	mov edi, 2
	cmp bl, 'd'
	je .check_decipher
	
	
	xor edi, edi
	jmp .error_message
	
	
	
	
.check_cipher:
	mov ebx, [ebp+0x18]
	mov edx, [ebp+0x1c]
	jmp .check_length
	
	
.check_decipher:
	mov ebx, [ebp+0x10]
	mov edx, [ebp+0x14]
	
	
	
.check_length:
	cmp ecx, edx
	jb .error_message
	
	
	
.m1:
	inc esi
	cmp esi, ecx
	je .end
	inc ebx
	mov dl, [ebx]
	inc eax
	cmp [eax], dl
	je .m1
	xor edi, edi
	jmp .end
	
	
	
	
.error_message:
	xor edi, edi
	mov eax, len_err_mes
	push eax
	mov eax, error_message
	push eax
	call output
	
	
	
	
	
	
	
.end:
	mov esp, ebp
	pop ebp
	mov eax, edi
	ret
	
	