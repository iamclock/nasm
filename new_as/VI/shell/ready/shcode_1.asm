BITS 32
section .text

_start:
	
	jmp short mes_addr
	
	
back:
; 	mes output
	xor eax, eax
	xor ebx, ebx
	xor edx, edx
	mov al, 4
	mov bl, 1
	pop ecx
	mov dl, 9
	int 80h
	
	
	
	xor eax, eax
	xor ebx, ebx
	mov al, 1
	int 80h
	
	
mes_addr:
	call back
	mes db "Hello!", 10
	
	
section .data