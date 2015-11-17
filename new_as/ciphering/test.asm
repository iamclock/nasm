global _start:




section .bss
buffer resb 100


section .data
len_buffer dd 1



section .text




_start:
	push len_buffer
	push buffer
	call input
	mov [len_buffer], eax
	add esp, 8
	push len_buffer
	push buffer
	call output
	add esp, 8
	push len_buffer
	push buffer
	call input
	sub esp, 8
	push len_buffer
	push buffer
	call output
	
	
	mov eax, 1
	xor ebx, ebx
	int 80h
	
	
	
	
	
	
	
	
	
;обычный ввод
input:
	mov eax, 3
	xor ebx, ebx
	mov edx, [esp+0x8]	;длина
	mov ecx, [esp+0x4]	;массив
	int 80h
	ret
	
	
	
	
;вывод
output:
	mov edx, [esp+0x8]	;длина
	mov ecx, [esp+0x4]	;сообщение
	mov eax, 4
	mov ebx, 1
	int 80h
	ret
	