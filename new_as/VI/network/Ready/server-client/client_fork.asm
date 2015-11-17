global _start:






section .bss
buffer resb 100
len_buffer_orig equ $-buffer
sock_desc resd 1




section .data
server_adr db 2,0,0xAA,0xAA,192,168,203,6,0,0,0,0,0,0,0,0
len_buffer dd 0
socket dd 2,1,0
shutdown db "shutdown"
len_shutdown equ $-shutdown



section .text





_start:
	push socket
	call socket_create
	mov [sock_desc], eax
	
	push dword 16
	push server_adr
	push dword [sock_desc]
	call socket_connect
	
	add esp, 0xc
	
	cmp eax, 0
	jne .exit
	
	
; 	push dword 0
; 	push len_buffer_orig
; 	push buffer
; 	push dword [sock_desc]
; 	call socket_recv
; 	
; 	add esp, 0x10
; 	
; 	
; 	push eax
; 	push buffer
; 	call output
; 	
; 	add esp, 0x8
	
.m1:
	push len_buffer_orig
	push buffer
	call input_string
	
	add esp, 0x8
	
	push eax
	push buffer
	call check_shutdown
	
	add esp, 0x4
	
	cmp eax, 1
	je .m2
	
	pop eax
	
	push dword 0
	push eax
	push buffer
	push dword [sock_desc]
	call socket_send
	
	add esp, 0x10
	
	push dword 0
	push len_buffer_orig
	push buffer
	push dword [sock_desc]
	call socket_recv
	
	add esp, 0x10
	
	
	push eax
	push buffer
	call output
	
	
	add esp, 0x8
	
	jmp .m1
	
	
.m2:
	push dword [sock_desc]
	call socket_close
	
	
.exit:
	mov eax, 1
	xor ebx, ebx
	int 80h
	
	
	

; 	1 в случае совпадения и надо выйти, иначе 0
check_shutdown:
	mov edi, [esp+0x4]
	xor edx, edx
	xor esi, esi
	mov ecx, [esp+0x8]
	dec ecx
	cmp ecx, len_shutdown
	jne .exit
	dec ecx
.m1:
	
	mov bl, [shutdown+edx]
	mov al, [edi+edx]
	cmp bl, al
	jne .exit
	cmp edx, ecx
	jge .eq
	inc edx
	jmp .m1
.eq:
	mov esi, 1
.exit:
	mov eax, esi
	ret
	
	
	
	
socket_create:
	mov eax, 102
	mov ebx, 1
	mov ecx, [esp+0x4]
	int 80h
	ret
	
	
	
	
socket_connect:
	mov eax, 102
	mov ebx, 3
	add esp, 0x4
	mov ecx, esp
	sub esp, 0x4
	int 80h
	ret
	
	
	
	
	
socket_recv:
	mov eax, 102
	mov ebx, 10
	add esp, 0x4
	mov ecx, esp
	sub esp, 0x4
	int 80h
	ret
	
	
	
	
	
socket_send:
	mov eax, 102
	mov ebx, 9
	add esp, 0x4
	mov ecx, esp
	sub esp, 0x4
	int 80h
	ret
	
	
	
	
socket_write:
	mov eax, 4
	mov ebx, [esp+0x4]
	mov ecx, [esp+0x8]
	mov edx, [esp+0xc]
	int 80h
	ret
	
	
	
	
	
	
socket_read:
	mov eax, 3
	mov ebx, [esp+0x4]
	mov ecx, [esp+0x8]
	mov edx, [esp+0xc]
	int 80h
	ret
	
	
	
	
	
	
	
	
	
socket_close:
	mov eax, 102
	mov ebx, 6
	mov ecx, [esp+0x4]
	int 80h
	ret
	
	
	
	
	
output:
	mov ecx, [esp+0x4]
	mov edx, [esp+0x8]
	mov eax, 4
	mov ebx, 1
	int 80h
	ret
	
	
	
input_string:
	mov eax, 3
	mov ebx, 0
	mov ecx, [esp+0x4]
	mov edx, [esp+0x8]
	int 80h
	ret
	
