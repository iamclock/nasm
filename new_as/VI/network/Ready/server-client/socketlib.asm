


section .data
SYS_socketcall dd 102
socket dd 2,1,0













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
	
	
	
	
socket_write:
	
	
	
	
	
	
	int 80h
	ret