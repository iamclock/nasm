global _start:



section .bss
buffer resb 200
buffer_alloc_len equ $-buffer




section .data
ten dd 10.0
buffer_len db 0

section .text





_start:
	push dword buffer_len
	push dword buffer
	call input
	mov dword [buffer_len], eax
	dec eax
	mov bl, [buffer+eax]
	
	mov eax, 1
	xor ebx, ebx
	int 80h
	
	
	
magic:
	
	
	
	
	
	
	
	
	
	
	
input:
	mov edx, [esp+0x8]
	mov ecx, [esp+0x4]
	mov eax, 3
	mov ebx, 1
	int 80h
	ret
	
	
	
	
	
output:
	mov ecx, [esp+0x4]
	mov edx, [esp+0x8]
	mov eax, 4
	mov ebx, 1
	int 80h
	ret
	
	