global echo_on


extern read_state
extern write_state





section .text




echo_on:
	push dword [esp+0x4]
	call read_state
	add esp, 4
	mov ebx, [esp+0x4]
	mov eax, [ebx+12]
	xor eax, (2+8)
	mov [ebx+12], eax
	push ebx
	call write_state
	add esp, 4
	ret