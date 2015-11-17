global _start:



section .bss
buffer resb 200
len_alloc_buffer equ $-buffer






section .data
rez dd 0.0
number dq 0.0
len_buffer dd 0
flag dd 0
divide dq 0
ten dq 10.0







section .text





_start:
	push dword len_alloc_buffer
	push dword buffer
	
	call input
	add esp, 0x8
	dec eax
	cmp eax, 0
	je .exit
	mov dword [len_buffer], eax
	push dword [ten]
	push dword [ten+4]
	push dword [len_buffer]
	push dword buffer
	call to_number
	
	
	
.exit:
	mov eax, 1
	xor ebx, ebx
	int 80h
	
	
	
	
	
	
	
	
to_number:
	push ebp
	mov ebp, esp
	
	mov edi, [ebp+0x10]
	mov dword [divide+4], edi
	mov edi, [ebp+0x14]
	mov dword [divide], edi
	
	xor edi, edi
	mov ecx, [ebp+0xc]
	dec ecx
	mov eax, [ebp+0x8]
	add eax, ecx
	finit
	fldz
	
	
.m1:
	mov bl, [eax]
	cmp bl, '.'
	je .m2
	cmp bl, ','
	je .m2
	sub bl, '0'
	;push ebx
	mov [number], ebx
	
	
	fiadd dword [number]
	add esp, 0x4
	fdiv qword [divide]
	inc edi
	dec eax
	jmp .m1
	
.m2:
	dec eax
	inc edi
	fldz
	
	
.m3:
	cmp edi, ecx
	;je .kuda-nibud
	mov bl, [eax]
	
	
	
	
	
	
	
	
	
	
.exit:
	mov esp, ebp
	pop ebp
	ret
	
	
	
	
	
	
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
	
	
	
	
	
	
	
	
	
	
	
	
	