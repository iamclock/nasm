global _start:


section .data
str1 db 'HHHelllo',10
len1 equ $-str1



section .text

_start:
	mov ecx, len1-1
	mov edi, 0
	mov esi, ecx
	dec esi
	cmp esi, edi
	je eNd


checkout:
	mov al, [str1+edi]
	cmp al, [str1+esi]
	je copy_neighbour
	dec esi
	cmp esi, edi
	je Nextedi
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
	mov al, [str1+esi]
	mov [str1+edi], al
	

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
	je eNd
	mov esi, len1-2
	jmp checkout


	
eNd:
mov ecx, edi
mov eax, 1
mov ebx, 0
int 80h