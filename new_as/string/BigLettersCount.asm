global _start:
	
section .data
		str1 db 'GoGoGo',0
		len1 equ $-str1

		;str2 db '                    ',10
		;len2 equ $-str2

		
		
		
		
		
		
		
		
section .text

_start:
		mov ecx, len1
		mov esi, 0
		mov ebx, 0
		
		
CountChars:
		mov al, [str1+esi]
		cmp al, 65
		jl checkLength
		cmp al, 90
		jg checkLength
		inc ebx
		
		
		
		
checkLength:
		inc esi
		cmp esi, ecx
		jl CountChars
		mov eax, 1
		mov ebx, 0
		int 80h
