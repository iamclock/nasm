global check_passw


extern output


section .data
;Access_denied massage
negative_message db "Access Denied", 10
negative_message_len equ $-negative_message



;Access_granted massage
positive_message db "Access Granted", 10
positive_message_len equ $-positive_message


;верный пароль
correct_passw db "qwerty"
cor_pass_len equ $-correct_passw






section .text





;проверка пароля
check_passw:
	push ebp
	mov ebp, esp
	mov eax, correct_passw
	mov ecx, cor_pass_len
	mov ebx, [ebp+0x8]	;entered_password
	mov edx, [ebp+0xc]	;entered_passw_len
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