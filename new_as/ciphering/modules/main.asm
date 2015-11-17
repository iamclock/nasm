global _start




section .bss
buffer resb 200
answer resb 12
f1_ro resd 1
f2_wo resd 1
state db 36


extern output
extern input
extern echo_off
extern echo_on
extern GetPass
extern check_passw
extern ciphering_or_deciphering
extern method
extern open_file
extern open_file_ro
extern close_file








section .data


file1_name db "cipher.txt",0
len_file1 equ $-file1_name


file2_name db "decipher.txt",0
len_file2 equ $-file2_name


koefficient dd 3


question1 db "What type of method do you prefer [ciphering/deciphering]?",10
len_question1 equ $-question1



entered_passw_len dd 1
len_answer dd 1
len_file_path dd 1
len_buffer dd 200




question2 db "Enter file name: ",0
len_question2 equ $-question2




;запрос пароля
passw_request db "Enter Password: "
passw_req_len equ $-passw_request


cipher db "ciphering",0
len_cipher equ $-cipher
len_method1 dd 6




decipher db "deciphering",0
len_decipher equ $-cipher
len_method2 dd 8





section .text




section .text


_start:
	push passw_req_len
	push passw_request
	xor ebx, ebx
	xor ecx, ecx

	call output
	add esp, 8
	
	push state
	call echo_off
	add esp, 4
	push len_buffer
	push buffer
	call GetPass
	add esp, 8
	mov [entered_passw_len], eax
	
	
	push eax
	push buffer
	push state
	call echo_on
	add esp, 4
	
	call check_passw
	add esp, 8
	cmp eax, 0
	je .exit
	push len_question1
	push question1
	call output
	add esp, 8
	push len_answer
	push answer
	call input
	dec eax
	mov [len_answer], eax
	add esp, 8
	
	
	
	
	push dword [len_method1]
	push cipher
	push dword [len_method2]
	push decipher
	push dword [len_answer]
	push answer
	call method
	add esp, 32
	mov ebx, eax
	cmp ebx, 0
	je .exit
	
	
	push ebx
	push len_question2
	push question2
	call output
	add esp, 8
	push len_file_path
	push answer
	call input
	add esp, 8
	dec eax
	mov [len_file_path], eax
	mov ecx, answer
	mov dword [ecx+eax], 0
	pop ebx
	
	
	mov eax, file1_name
	
	cmp ebx, 1
	pushf
	je .m1
	
	mov eax, file2_name
	
	
	
.m1:
	push eax
	call open_file
	mov [f2_wo], eax
	
	push answer
	call open_file_ro
	mov [f1_ro], eax
	add esp, 8
	
	mov [len_buffer], dword 200
	push dword [len_buffer]
	push buffer
	push dword [f2_wo]
	push dword [f1_ro]
	push dword [koefficient]
	
	
	call ciphering_or_deciphering
	add esp, 24
	
	
	push dword [f1_ro]
	call close_file
	push dword [f2_wo]
	call close_file
	
	
	
.exit:
	mov eax, 1
	xor ebx, ebx
	int 80h