global _start:



section .bss





section .data
rez db 0





section .text





_start:
	mov eax, 25
	mov ebx, 24
	;xor edx, edx
	;xor ecx, ecx
	push eax
	push ebx
	call co_proc
	add esp, 0x8
	mov eax, 0xa
	push eax
	call output
	
	
	mov eax, 1
	xor ebx, ebx
	int 80h
	
	
	
	
	
	
	
	
	
output:
	mov ecx, [esp+0x4]
	mov edx, 1
	mov eax, 4
	mov ebx, 1
	int 80h
	ret
	
	
	
co_proc:
	push ebp
	mov ebp, esp
	finit
	fild dword [ebp+0xc]
	ficom dword [ebp+0x8]
	fstsw ax
	sahf
	je .exit
	fisub dword [ebp+0x8]
	fist dword [rez]
	fild dword [ebp+0x8]
	fiadd dword [ebp+0xc]
	fidiv dword [rez]
	fistp dword [rez]
	
	
.exit:
	mov eax, [rez]
	mov esp, ebp
	pop ebp
	ret
	
	
	
	
	
	
	
	
	
	
	
	
	