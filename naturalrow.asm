global _start:

section .data
str1 db 'Enter your number: ', 10



section .text
_start:
	mov ecx, 0
	

m:
	add ecx, 1
	jmp m




