global _start:



section .bss
buffer resb 200
answer resb 12
state resb 36
f1_ro resd 1
f2_wo resd 1


section .data



file1_name db "cipher.txt",0
len_file1 equ $-file1_name


file2_name db "decipher.txt",0
len_file2 equ $-file2_name


koefficient dd 3


question1 db "What type of method do you prefer [ciphering/deciphering]?",10
len_question1 equ $-question1

question2 db "Enter file name: ",0
len_question2 equ $-question2


;star symbol
star db '*'

error_message db "incorrect method",10
len_err_mes equ $-error_message



cipher db "ciphering",0
len_cipher equ $-cipher
len_method1 dd 6


decipher db "deciphering",0
len_decipher equ $-cipher
len_method2 dd 8



;верный пароль
correct_passw db "qwerty"
cor_pass_len equ $-correct_passw

;запрос пароля
passw_request db "Enter Password: "
passw_req_len equ $-passw_request


;Access_denied massage
negative_message db "Access Denied", 10
negative_message_len equ $-negative_message

;Access_granted massage
positive_message db "Access Granted", 10
positive_message_len equ $-positive_message


;Big Password message
big_pass db "Password too big", 10
big_pass_len equ $-big_pass


;password_was_correct? dd 0

entered_passw_len dd 1
len_answer dd 1
len_file_path dd 1
len_buffer dd 200


section .text

_start:
	push passw_req_len
	push passw_request
	xor ebx, ebx
	xor ecx, ecx

	call output
	add esp, 8
	
	
	call echo_off
	push len_buffer
	push buffer
	call GetPass
	add esp, 8
	mov [entered_passw_len], eax
	
	
	push eax
	push buffer
	call echo_on
	
	
	push cor_pass_len
	push correct_passw
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
	
	
	
	
	push len_err_mes
	push error_message
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
	
	
	
	
	
	
	
	
ciphering_or_deciphering:
	push ebp
	mov ebp, esp
	
	mov esi, [ebp+0x18]	;len_buffer
	mov eax, [ebp+0x14]	;buffer
	mov edx, [ebp+0x10]	;output file descriptor
	mov ebx, [ebp+0xc]	;input file descriptor
	mov edi, [ebp+0x8]	;koefficient
	
	
	
.read:
	push dword [ebp+0x18]
	push dword [ebp+0x14]
	push dword [ebp+0xc]
	call read_from_file
	add esp, 12
	
	push eax	;len_buffer
	cmp eax, 0
	je .end
	mov ecx, eax
	mov eax, [ebp+0x1c]
	push eax
	popf
	je .ciphering
	
	jmp .deciphering
	
	
.write:
	push dword [ebp+0x14]
	push dword [ebp+0x10]
	call write_to_file
	add esp, 4
	
	;call output
	
	jmp .read
	
	
	
	
	
	
	
	
	
.ciphering:
	mov ebx, [ebp+0x14]
	xor esi, esi
	mov edi, [ebp+0x8]
.cip_m1:
	cmp esi, ecx
	je .write
	add dword [ebx], edi
	inc esi
	inc ebx
	jmp .cip_m1
	
	
	
	
	
	
	
	
	
	
	
.deciphering:
	mov ebx, [ebp+0x14]
	xor esi, esi
	mov edi, [ebp+0x8]
.decip_m1:
	cmp esi, ecx
	je .write
	sub dword [ebx], edi
	inc esi
	inc ebx
	jmp .decip_m1
	
	
	
	
	
	
	
	
	
	
	
.end:
	mov esp, ebp
	pop ebp
	ret
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
method:
	push ebp
	mov ebp, esp
	mov eax, [ebp+0x8]	;массив выбора
	mov ecx, [ebp+0xc]	;его длина
	xor esi, esi
	mov bl, [eax]
	
	mov edi, 1
	cmp bl, 'c'
	je .check_cipher
	
	mov edi, 2
	cmp bl, 'd'
	je .check_decipher
	
	
	xor edi, edi
	jmp .error_message
	
	
	
	
.check_cipher:
	mov ebx, [ebp+0x18]	;массив шаблона
	mov edx, [ebp+0x1c]	;его длина
	jmp .check_length
	
	
.check_decipher:
	mov ebx, [ebp+0x10]	;массив шаблона
	mov edx, [ebp+0x14]	;его длина
	
	
	
.check_length:
	cmp ecx, edx
	jb .error_message
	
	
	
.m1:
	inc esi
	cmp esi, ecx
	je .end
	inc ebx
	mov dl, [ebx]
	inc eax
	cmp [eax], dl
	je .m1
	xor edi, edi
	jmp .end
	
	
	
	
.error_message:
	xor edi, edi
	mov eax, len_err_mes
	push eax
	mov eax, error_message
	push eax
	call output
	
	
	
	
	
	
	
.end:
	mov esp, ebp
	pop ebp
	mov eax, edi
	ret
	
	
	
	
	
	
	
	;секретный ввод
	
GetPass:
	push ebp
	mov ebp, esp
	mov ecx, [ebp+0xc]
	mov eax, [ebp+0x8]
	xor esi, esi
	
	
	
.next_symbol:
	cmp esi, ecx
	je .Big_password
	mov [ebp+0x8], eax
	push ecx
	call input_symb
	inc esi
	pop ecx
	mov eax,[ebp+0x8]
	mov bl, [eax]
	cmp bl, 10
	je .last_symbol
	push eax
	push ecx
	call star_output
	pop ecx
	pop eax
	inc eax
	jmp .next_symbol
	
	
	
	
.Big_password:
	mov eax, big_pass_len
	push eax
	mov eax, big_pass
	push eax
	call output
	jmp .end
	
	
	
	;изменить метку, чтобы выводила перевод строки сама
.last_symbol:
	mov ecx, [ebp+0x8]
	mov edx, 1
	mov eax, 4
	mov ebx, 1
	int 80h
	
	
	
.end:
	mov eax, esi
	mov esp, ebp
	pop ebp
	ret
	
	
	
	
	
input_symb:
	mov eax, 3
	xor ebx, ebx
	mov edx, 1
	mov ecx, [esp+0x10]
	int 80h
	ret
	
	
	
	
	
	
	
star_output:
	mov edx, 1
	mov ecx, star
	mov eax, 4
	mov ebx, 1
	int 80h
	ret
	
	;;;;;;;;;;;;;;
	
	
	

	
	
	
	
	
	
	
	
	;обычный ввод
input:
	mov eax, 3
	xor ebx, ebx
	mov edx, [esp+0x8]	;длина
	mov ecx, [esp+0x4]	;массив
	int 80h
	ret
	
	
	
	
;вывод
output:
	mov edx, [esp+0x8]	;длина
	mov ecx, [esp+0x4]	;сообщение
	mov eax, 4
	mov ebx, 1
	int 80h
	ret
	
	
	
	
	
	
	;проверка пароля
check_passw:
	push ebp
	mov ebp, esp
	mov eax, [ebp+0x8]	;correct_passw
	mov ecx, [ebp+0xc]	;cor_pass_len
	mov ebx, [ebp+0x10]	;entered_password
	mov edx, [ebp+0x14]	;entered_passw_len
	dec edx
	xor edi, edi
	cmp ecx, edx
	je .m1
	
	
.massage_access_denied:
	mov eax, negative_message
	mov ecx, negative_message_len
	push ecx
	push eax
	call output
	mov eax, 0	;признак не правильного входа
	jmp .end
	
	
.m1:
	mov dl, [eax]
	cmp dl, [ebx]
	jne .massage_access_denied
	inc edi
	inc eax
	inc ebx
	cmp edi, ecx
	jl .m1
	mov edx, positive_message_len
	mov ebx, positive_message
	push edx
	push ebx
	call output
	mov eax, 1	;признак правильного входа
	
.end:
	mov esp, ebp
	pop ebp
	ret
	
	
	
	
	
	

	
	
;passw_change:
	
	
	
echo_off:
	call read_state
	mov eax, [state+12]
	and eax, ~(2+8)
	mov [state+12], eax
	call write_state
	ret
	
	
	
	
	
	
	
	
read_state:
	mov eax, 54
	mov ebx, 0
	mov ecx, 5401h
	mov edx, state
	int 80h
	ret
	
	
	
	
	
	
	
	
write_state:
	mov eax, 54
	mov ebx, 0
	mov ecx, 5402h
	mov edx, state
	int 80h
	ret
	
	
	
	
	
	
	
	
echo_on:
	call read_state
	mov eax, [state+12]
	xor eax, (2+8)
	mov [state+12], eax
	call write_state
	ret
	
	
	
	
	
	
	
	
	
open_file:
	mov eax, 5
	mov ebx, [esp+0x4]
	mov ecx, 102q
	mov edx, 700q
	int 80h
	ret
	
	
	
	
open_file_ro:
	mov eax, 5
	mov ebx, [esp+0x4]
	mov ecx, 0
	int 80h
	ret
	
	
	
	
	
	
read_from_file:
	mov eax, 3
	mov ebx, [esp+0x4]	;дескриптор файла
	mov ecx, [esp+0x8]	;массив
	mov edx, [esp+0xc]	;длина
	int 80h
	ret
	
	
	
	
	
	
	
	
write_to_file:
	mov eax, 4
	mov ebx, [esp+0x4]	;дескриптор файла
	mov ecx, [esp+0x8]	;сообщение
	mov edx, [esp+0xc]	;длина сообщения
	int 80h
	ret
	
	
	
	
	
	
	
	
	
close_file:
	mov eax, 6
	mov ebx, [esp+0x4]
	int 80h
	ret
	
	
	
	
