global _start:




section .bss
	string1 resb 100
	
	
	
	
	
section .data
	request db "Enter string: ",0
	req_len equ $-request
	
	string1_len dd 1
	
	
	
	
section .text



_start:
	mov edx, req_len
	mov ecx, request
	call output
	
	mov ecx, string1
	mov edx, 100
	call input_string
	
	mov edi, 0
	mov esi, 1
	mov ecx, [string1_len]
	dec ecx
	
	call delneigh
	
	mov ecx, string1
	mov edx, [string1_len]
	call output
	
	mov eax, 1
	mov ebx, 0
	int 80h
	
	
	
	
output:
	mov eax, 4
	mov ebx, 1
	int 80h
	ret
	
	
	
input_string:
	mov eax, 3
	mov ebx, 0
	int 80h
	mov [string1_len], eax;в eax хранится число считанных байт
	ret
	
	;esi - начало строки ecx - длина строки
	; рез-т  eax - новая длина
	
delneigh:
	push esi
	
	
	mov edi,esi
	inc esi
	xor ebx,ebx
	
.b:
  inc ebx
  cmp ebx,ecx
  jae .end
  
	mov al, [esi]
	cmp al, [edi]
	jne .erase_the_same
	
	inc edi
	mov edx,esi
	sub edx,edi
	sub ecx,edx
	sub ebx,edx
  push ecx
	sub ecx,ebx
	call strcpy
	pop ecx
	inc esi
	jmp .b
	
.erase_the_same:
  inc edi
  inc ebx
  mov al,[esi]
  mov [edi],al
  cmp ebx,ecx
  jb .erase_the_same

.end:
  mov eax,ecx
  ret
	
;esi,edi - начала строк ecx - длина строки
strcpy:	
  push esi
  push edi
  push ecx
  cld
  rep movsb
  pop ecx
  pop edi
  pop esi
  ret
	
	
	