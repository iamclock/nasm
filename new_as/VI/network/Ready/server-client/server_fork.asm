global _start:


section .bss
buffer resb 100
len_buffer_orig equ $-buffer
client resd 1
newsocket resd 1



section .data
server_adr1 db 2,0,0xAA,0xAA,192,168,0,101,0,0,0,0,0,0,0,0,0
connected db "You are connected!", 10, "Type Something: ",0
len_connected equ $-connected
more db "More: ",0
len_more equ $-more
name db "The Best Server In Whole World says: "
len_name equ $-name
addrlen dd 102
socket dd 2,1,0
len_buffer dd 0


section .text



_start:
	push socket
	call socket_create
	add esp, 0x4
	mov dword [client], eax
	
	push dword 16
	push server_adr1
	push dword [client]
	call socket_bind
	
	add esp, 0xc
	
	push dword 20
	push dword [client]
	call socket_listen
	add esp, 0x8
	
	
	
.m1:
	push 0
	push 0
	push dword [client]
	call socket_accept
	mov dword [newsocket], eax
	add esp, 0xc
	
	cmp eax, 0
	jl .exit
	
	call fork
	cmp eax, 0
	jl .exit
	je .m2
	
	push dword [newsocket]
	call socket_close
	jmp .m1
	
	
.m2:
	push dword [client]
	call socket_close
	push dword [newsocket]
	call echo
	
.exit:
	mov eax, 1
	xor ebx, ebx
	int 80h
	
	
	
	
	
echo:
	mov edx, [esp+0x4]
	
	;убрать, если будут проблемы первый вывод
	push dword 0
	push len_connected
	push connected
	push edx
	call socket_send
	add esp, 0x10
	
.m1:
	
	push len_name
	push name
	push buffer
	call string_konkaten
	add esp, 0xc
	
	mov eax, len_buffer_orig
	sub eax, len_name
	mov dword [len_buffer], eax
	
	push dword 0
	push dword [len_buffer]
	push buffer+len_name
	push edx
	call socket_recv
	add esp, 0x10
	
	cmp eax, 0
	jl .m2
	
	mov ebx, buffer+len_name
	add ebx, eax
	
	push len_more
	push more
	push ebx
	call string_konkaten
	add esp, 0xc
	
	mov ebx, len_name
	add ebx, len_more
	add ebx, eax
	mov dword [len_buffer], ebx
	
	
	push dword 0
	push dword [len_buffer]
	push buffer
	push edx
	call socket_send
	add esp, 0x10
	
	jmp .m1
	
.m2:
	push edx
	call socket_close
	ret
	
	
	
	
	
string_konkaten:
	mov edi, [esp+0x4]
	mov esi, [esp+0x8]
	mov ecx, [esp+0xc]
	repnz movsb
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
	
	
	
	
	
	
	
	
socket_create:
	mov eax, 102
	mov ebx, 1
	mov ecx, [esp+0x4]
	int 80h
	ret
	
	
	
	
	
socket_bind:
	mov eax, 102
	mov ebx, 2
	add esp, 0x4
	mov ecx, esp
	sub esp, 0x4
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
	
	
	
	
	
	
socket_listen:
	mov eax, 102
	mov ebx, 4
	add esp, 0x4
	mov ecx, esp
	sub esp, 0x4
	int 80h
	ret
	
	
	
	
socket_accept:
	mov eax, 102
	mov ebx, 5
	add esp, 0x4
	mov ecx, esp
	sub esp, 0x4
	int 80h
	ret
	
	
fork:
	mov eax, 2
	int 80h
	ret
	
	
	
_wait:
	
	
	
	
	
	
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
	
	
	
	
socket_recv:
	mov eax, 102
	mov ebx, 10
	add esp, 0x4
	mov ecx, esp
	sub esp, 0x4
	int 80h
	ret
	
	
	
	
socket_sendto:
	
	
	
	
	
	
	
	int 80h
	ret
	
	
	
	
	
	
	
socket_recvfrom:
	
	
	
	
	
	
	
	int 80h
	ret
	
	
	
	
	
	
socket_close:
	mov eax, 102
	mov ebx, 6
	mov ecx, [esp+0x4]
	int 80h
	ret
	
	