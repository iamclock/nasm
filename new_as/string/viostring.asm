global _start:


section .bss
	string1 resb 100
	
	
	
	
	
	
	
	



section .data
	request db "Enter string: ",0
	req_len equ $-request
	thank db "Thank You",10
	thank_len equ $-thank
	string1_len dd 1
	
	
	
	
	
	
section .text
	
	
_start:
	mov edx, req_len
	mov ecx, request
	call output
	
	mov ecx, string1
	call input_string
	
	mov edx, thank_len
	mov ecx, thank
	call output
	
	mov edx, [string1_len]
	mov ecx, string1
	call output
	
	call uplotnenie_stroki
	
	
	mov edx, [string1_len]
	mov ecx, string1
	call output
	
	jmp eNd
	
	
	
	
	
output:
	mov eax, 4
	mov ebx, 1
	int 80h
	ret
	
	
	
input_string:
	mov eax, 3
	mov ebx, 0
	mov edx, 100
	int 80h
	mov [string1_len], eax;в eax хранится число считанных байт
	ret
	
	
uplotnenie_stroki:
	mov ecx, [string1_len]
	;dec ecx
	mov edi, 0
	mov esi, ecx
	dec esi
	cmp esi, edi
	je eNd


checkout:
	cmp esi, edi
	je Nextedi
	mov al, [string1+edi]
	cmp al, [string1+esi]
	je copy_neighbour
	dec esi
	jmp checkout


copy_neighbour:
	push edi
	mov edi, esi
	inc esi
	cmp esi, ecx
	jne rewrite_element
	dec ecx
	jmp Nextesi
	

rewrite_element:
	mov al, [string1+esi]
	mov [string1+edi], al
	

Nextesi:
	mov esi, edi
	pop edi
	dec esi
	cmp esi, edi
	je Nextedi
	jmp checkout


Nextedi:
	inc edi
	cmp edi, ecx
	je gotoret
	mov esi, [string1_len]
	dec esi
	jmp checkout
	
	
	
gotoret:
	cmp [string1_len], ecx
	je return
	mov [string1_len], ecx
	
	
	
	
return:
	ret
	
	
	
	
	
	
	
	
	
eNd:
	mov eax, 1
	mov ebx, 0
	int 80h
	
	
	
	
	
	
	
