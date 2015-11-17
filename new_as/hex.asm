global _start:

section .data
str1 db 'Symb    Dec    Hex  ',10
len1 equ $-str1

str2 db '                    ',10
len2 equ $-str2



section .text
_start:
    mov eax,4
    mov ebx,1
    mov ecx,str1
    mov edx,len1
    int 80h
    
    mov eax,32
    call mk
    
    
mk:
    mov esi, str2+5
    mov [str2],eax
    mov ebx,10
    mov esi,str2+11
    call nmb
    mov ebx,16
    xor ecx,ecx
    xor edx,edx
    mov esi, str2+17
    call nmb
    call gout
    inc eax
    cmp eax,127
    jb mk
    mov eax,1
    mov ebx,0
    int 80h
    
    
nmb:
    pushad
    xor ecx,ecx
c1:
    inc ecx
    xor edx,edx
    div ebx
    cmp edx,9
    ja c2
    add edx,'0'
    push edx
    jmp c3
    
    
c2:
    sub edx,10
    add edx,'A'
    push edx
    
c3:
    cmp eax,byte 0
    jne c1
    
c4:
    pop ebx
    inc esi
    mov [esi],bl
    dec ecx
    cmp ecx,0
    jne c4
    popad
    ret
    
gout:
    pushad
    mov eax,4
    mov ebx,1
    mov ecx,str2
    mov edx,len2
    int 80h
    popad
    ret