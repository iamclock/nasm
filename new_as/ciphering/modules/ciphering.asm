global ciphering_or_deciphering


extern read_from_file
extern write_to_file


section .text
	
	
ciphering_or_deciphering:
	push ebp
	mov ebp, esp
	
	mov esi, [ebp+0x18]	;len_buffer
	mov eax, [ebp+0x14]	;buffer
	mov edx, [ebp+0x10]	;output file descriptor
	mov ebx, [ebp+0xc]	;input file descriptor
	mov edi, [ebp+0x8]	;koefficient
	
	
	
.read:
	push dword [ebp+0x18]
	push dword [ebp+0x14]
	push dword [ebp+0xc]
	call read_from_file
	add esp, 12
	
	push eax	;len_buffer
	cmp eax, 0
	je .end
	mov ecx, eax
	mov eax, [ebp+0x1c]
	push eax
	popf
	je .ciphering
	
	jmp .deciphering
	
	
.write:
	push dword [ebp+0x14]
	push dword [ebp+0x10]
	call write_to_file
	add esp, 4
	
	;call output
	
	jmp .read
	
	
	
	
	
	
	
	
	
.ciphering:
	mov ebx, [ebp+0x14]
	xor esi, esi
	mov edi, [ebp+0x8]
.cip_m1:
	cmp esi, ecx
	je .write
	add dword [ebx], edi
	inc esi
	inc ebx
	jmp .cip_m1
	
	
	
	
	
	
	
	
	
	
	
.deciphering:
	mov ebx, [ebp+0x14]
	xor esi, esi
	mov edi, [ebp+0x8]
.decip_m1:
	cmp esi, ecx
	je .write
	sub dword [ebx], edi
	inc esi
	inc ebx
	jmp .decip_m1
	
	
	
	
	
	
	
	
	
	
	
.end:
	mov esp, ebp
	pop ebp
	ret
	
	
