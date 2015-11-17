global GetPass

extern output





section .data

;Big Password message
big_pass db "Password too big", 10
big_pass_len equ $-big_pass


;star symbol
star db '*'





section .text
	
	
	
	
;секретный ввод
GetPass:
	push ebp
	mov ebp, esp
	mov ecx, [ebp+0xc]
	mov eax, [ebp+0x8]
	xor esi, esi
	
	
	
.next_symbol:
	cmp esi, ecx
	je .Big_password
	mov [ebp+0x8], eax
	push ecx
	call input_symb
	inc esi
	pop ecx
	mov eax,[ebp+0x8]
	mov bl, [eax]
	cmp bl, 10
	je .last_symbol
	push eax
	push ecx
	call star_output
	pop ecx
	pop eax
	inc eax
	jmp .next_symbol
	
	
	
	
.Big_password:
	mov eax, big_pass_len
	push eax
	mov eax, big_pass
	push eax
	call output
	jmp .end
	
	
	
	;изменить метку, чтобы выводила перевод строки сама
.last_symbol:
	mov ecx, [ebp+0x8]
	mov edx, 1
	mov eax, 4
	mov ebx, 1
	int 80h
	
	
	
.end:
	mov eax, esi
	mov esp, ebp
	pop ebp
	ret
	
	
	
	
	
input_symb:
	mov eax, 3
	xor ebx, ebx
	mov edx, 1
	mov ecx, [esp+0x10]
	int 80h
	ret
	
	
	
	
	
	
	
star_output:
	mov edx, 1
	mov ecx, star
	mov eax, 4
	mov ebx, 1
	int 80h
	ret