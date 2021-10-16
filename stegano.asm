%include "/include/io.inc"

extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0
        str_task2 db "C'est un proverbe francais.", 10, 0
section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1
    message:    resd 1
    img_t:      resd 1

section .text

verifica:
    xor cx, dx
    mov dx, word[eax + 4* ebx]
    xor cx, dx
    cmp cx, 'e'
    jne continu
    xor cx, dx
    mov dx, word[eax + 4* (ebx + 1)]
    xor cx, dx
    cmp cx, 'v'
    jne continu
    xor cx, dx
    mov dx, word[eax + 4* (ebx + 2)]
    xor cx, dx
    cmp cx, 'i'
    jne continu
    xor cx, dx
    mov dx, word[eax + 4* (ebx + 3)]
    xor cx, dx
    cmp cx, 'e'
    jne continu
    xor cx, dx
    mov dx, word[eax + 4* (ebx + 4)]
    xor cx, dx
    cmp cx, 'n'
    jne continu
    xor cx, dx
    mov dx, word[eax + 4* (ebx + 5)]
    xor cx, dx
    cmp cx, 't'
    je ret1
    jmp continu
buteforce_singlebyte_xor:
    push ebp
    mov ebp, esp
    mov eax, [esp + 8]
    mov cx, 1
for1:
    xor eax, eax
    xor edx, edx
    
    mov eax, [img_height]
    imul dword[img_width]
    mov ebx, eax
    mov eax, [esp + 8]
for2:
    mov dx, word[eax +4 *(ebx - 1)]
    xor cx, dx
    cmp cx, 'r'
    je verifica
continu:
    xor cx, dx
    dec ebx
    test ebx, ebx
    jnz for2
    inc cx
    cmp cx, 255
    jnz for1

ret1:
    xor cx, dx  
    mov [esp + 12], ecx 
    mov eax, ebx
    mov ebx, [img_width]
    cdq
    div ebx
    mov [esp + 16], eax
    
return:
    leave
    ret


print_task1:
    push ebp
    mov ebp, esp

    mov ecx, [esp + 16];key
    mov eax, [esp + 12];linia
    mov ebx, [img_width]
    mul ebx
    mov ebx, eax
    imul ebx, 4
    mov eax, [esp + 8];img
    add eax, ebx
while:
    mov edx, dword[eax]
    xor ecx, edx
    cmp ecx, 0x00
    je retf
    cmp ecx, '\n'
    je retf
    mov [eax], ecx
    PRINT_STRING [eax]
    xor ecx, edx
    add eax, 4
    jmp while
retf:  
    NEWLINE
    PRINT_DEC 4, [esp + 16]
    NEWLINE
    PRINT_DEC 4, [esp + 12]
    NEWLINE
    leave
    ret
    
    
decodifica:
    push ebp
    mov ebp, esp
    
    mov eax, [img_height]
    imul dword[img_width]
    mov ebx, eax
    mov ecx, [esp + 12];key
    mov eax, [esp + 8];img
    
    
for_d:
    mov edx, dword[eax + 4*(ebx - 1)]
    xor ecx, edx
    mov dword[eax + 4*(ebx - 1)], ecx
    xor ecx, edx
    dec ebx
    test ebx, ebx
    jnz for_d
    
    leave
    ret
    
add_mess:
    push ebp
    mov ebp, esp
    
    mov eax, [esp + 8];linia
    ;PRINT_STRING "linia......."
    ;PRINT_DEC 4, eax
    ;NEWLINE
    inc eax
    mov ebx, [img_width]
    mul ebx
    mov ebx, eax
    imul ebx, 4
    mov edx, [esp + 12];img
    add edx, ebx
    mov ebx, [esp + 16];messaj
    
    mov ebx, str_task2
for_add:
    mov ch, byte[ebx]
    ;PRINT_CHAR cx
    ;NEWLINE
    cmp ch, 0x00
    je ret_add
    mov byte[edx], ch
    ;PRINT_CHAR [eax]
    inc ebx
    add edx, 4
    jmp for_add

ret_add:
    sub edx, 4
    mov byte[edx], ch; 
    leave
    ret
    
    
new_key:
    push ebp
    mov ebp, esp
    
    mov eax, [esp + 8]
    imul eax, 2
    add eax, 3
    mov ebx, 5
    cdq 
    idiv ebx
    sub eax, 4
    

    leave 
    ret
    
swap_morse:
    cmp ch, 'A'
    je A
    cmp ch, 'B'
    je B
    cmp ch, 'C'
    je C
    cmp ch, 'D'
    je D
    cmp ch, 'E'
    je E
    cmp ch, 'F'
    je F
    cmp ch, 'G'
    je G
    cmp ch, 'H'
    je H
    cmp ch, 'I'
    je I
    cmp ch, 'J'
    je J
    cmp ch, 'K'
    je K
    cmp ch, 'L'
    je L
    cmp ch, 'M'
    je M
    cmp ch, 'N'
    je N
    cmp ch, 'O'
    je O
    cmp ch, 'P'
    je P
    cmp ch, 'Q'
    je Q
    cmp ch, 'R'
    je R
    cmp ch, 'S'
    je S
    cmp ch, 'T'
    je T
    cmp ch, 'U'
    je U
    cmp ch, 'V'
    je V
    cmp ch, 'W'
    je W
    cmp ch, 'X'
    je X
    cmp ch, 'Y'
    je Y
    cmp ch, 'Z'
    je Z
    cmp ch, '1'
    je c1
    cmp ch, '2'
    je c2
    cmp ch, '3'
    je c3
    cmp ch, '4'
    je c4
    cmp ch, '5'
    je c5
    cmp ch, '6'
    je c6
    cmp ch, '7'
    je c7
    cmp ch, '8'
    je c8
    cmp ch, '9'
    je c9
    cmp ch, '0'
    je c0 
    cmp ch, ' '
    je new_word
    cmp ch, ','
    je comma
    cmp ch, 0x00
    je don_m_e
    
    
A:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
B: 
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4  
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
C:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
D:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
E:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
F:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
G:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
H:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
I:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
J:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
K:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
L:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
M:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
N:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
O:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
P:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
Q:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
R:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
S:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
T:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
U:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
V:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
W:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
X:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
Y:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
Z:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c1:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c2:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c3:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c4:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c5:
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c6:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c7:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c8:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c9:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
c0:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
comma:
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '.'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, '-'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e
new_word:
    mov cl, '|'
    mov byte[eax], cl
    add eax, 4
    mov cl, ' '
    mov byte[eax], cl
    add eax, 4
    inc ebx
    jmp for_m_e


morse_encrypt:
    push ebp
    mov ebp, esp
    
    mov eax, [esp + 8] ;img
    mov ebx, [esp + 12] ; mesaj
    mov ecx, [esp + 16] ; byte_id
    
    imul ecx, 4
    add eax, ecx
for_m_e:
    mov ch, byte[ebx]
    jmp swap_morse
don_m_e:
    sub eax, 4
    mov byte[eax], 0x00
    leave
    ret



add_bit:  
    or byte[eax], dh
    jmp continue_lsb
    
lsb_encode:
    push ebp
    mov ebp, esp
    
    mov eax, [esp + 8] ;img
    mov ebx, [esp + 12] ; mesaj
    mov ecx, [esp + 16] ; byte_id
    dec ecx
    
    imul ecx, 4
    add eax, ecx
for_lsb:
    mov dh, byte[ebx]
    mov dl, dh
    mov ch, 8
for_bit:
    dec ch
    mov cl, 7
    sub cl, ch
    shl dh, cl
    shr dh, 7
    test dh, dh
    jnz add_bit
    shr dword[eax], 1
    shl dword[eax], 1
continue_lsb:
    add eax, 4
    test ch, ch
    mov dh, dl
    jnz for_bit
    inc ebx
    
    cmp dl, 0x00
    jnz for_lsb
    
    leave
    ret
    
    
lsb_decode:
    push ebp
    mov ebp, esp
    
    mov eax, [esp + 8]
    mov ecx, [esp + 12]
    dec ecx
    imul ecx, 4
    add eax, ecx
    mov ebx, message

for_d_lsb:
    mov ch, 8
    xor dl, dl
for_d_bit:
    dec ch
    mov dh, byte[eax]
    mov cl, ch
    shl dh, 7
    shr dh, 7
    shl dh, cl
    or dl, dh
    shr dword[eax], 1
    shl dword[eax], 1
    add eax, 4
    test ch, ch
    jnz for_d_bit
    mov byte[ebx], dl
    inc ebx
    cmp dl, 0
    jnz for_d_lsb
    
    mov eax, message
    leave
    ret


blur:
    push ebp
    mov ebp, esp
    
    mov eax, [img_height]
    dec eax
    dec eax
    imul dword[img_width]
    mov ecx, eax
    mov eax, [esp + 8]
    add eax, dword[img_width]
    add eax, dword[img_width]
    add eax, dword[img_width]
    add eax, dword[img_width]
    mov ebx, [img_t]
for_blur: 
    push eax
    sub eax, [ebp + 8]
    cdq
    xor edx, edx
    push ecx
    mov ecx, dword[img_width]
    imul ecx, 4
    idiv ecx
    pop ecx
    test edx, edx
    jz no_change
    pop eax
    push eax
    sub eax, [ebp + 8]
    add eax, 4
    xor edx, edx
    push ecx
    mov ecx, dword[img_width]
    imul ecx, 4
    cdq
    idiv ecx
    pop ecx
    test edx, edx
    jz no_change
    
    
    pop eax
    push ecx
    
    mov edx, dword[eax]
    add edx, dword[eax + 4]
    add edx, dword[ebx]
    mov ecx, dword[img_width]
    imul ecx, 4
    add edx, dword[ebx + ecx - 4]
    add edx, dword[eax + ecx - 0]
    push eax
    mov eax, edx
    mov ecx, 5
    cdq
    idiv ecx
    mov ecx, eax
    pop eax
    mov dword[eax], ecx
    
    pop ecx
    push eax
    
    
no_change:
    pop eax
    dec ecx
    add eax, 4
    add ebx, 4
    test ecx, ecx
    jnz for_blur
    
    leave 
    ret


global main
main:
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax
    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax
    
    
    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

solve_task1:
    push 0
    push 0
    push dword[img]
    call buteforce_singlebyte_xor
    add esp, 4
    pop eax ;key
    pop ebx ;line
    
    push eax
    push ebx
    push dword[img]
    call print_task1
    add esp, 12
    jmp done
solve_task2:
    push 0  ;line
    push 0 ;key
    push dword[img]
    call buteforce_singlebyte_xor
    add esp, 4
    
    push dword[img]
    call decodifica
    pop dword[img]
    pop eax
    pop ebx
    push eax
    push dword[str_task2]
    push dword[img]
    push ebx
    call add_mess
    add esp, 4
    pop dword[img]
    add esp, 4
    
    
    call new_key;return eax
    add esp, 4
    
    push eax;new key
    push dword[img]
    call decodifica
    pop dword[img]
    add esp, 4
    
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image
    pop dword[img]
    add esp, 8
    
    jmp done
solve_task3:
    mov eax, [ebp + 12]
    add eax, 12
    mov ebx, [eax]
    push ebx ; mesajul
    add eax, 4
    mov ebx, [eax]
    push ebx
    call atoi
    add esp, 4
    
    pop ebx; mesaj
    push eax ; byte_id
    push ebx 
    push dword[img] ;img
    call morse_encrypt
    pop dword[img]
    add esp, 8
    
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image
    pop dword[img]
    add esp, 8
    
    jmp done
solve_task4:
    mov eax, [ebp + 12]
    add eax, 12
    mov ebx, [eax]
    push ebx ; mesajul
    add eax, 4
    mov ebx, [eax]
    push ebx
    call atoi
    add esp, 4
    
    pop ebx; mesaj
    push eax ; byte_id
    push ebx 
    push dword[img] ;img
    call lsb_encode
    pop dword[img]
    add esp, 8
    
    
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image
    pop dword[img]
    add esp, 8
    ; TODO Task4
    jmp done
solve_task5:
    mov eax, [ebp + 12]
    add eax, 12
    mov ebx, [eax]
    push ebx
    call atoi
    add esp, 4
    
    push eax ; byte_id
    push dword[img] ;img
    call lsb_decode
    pop dword[img]
    add esp, 4
    PRINT_STRING [eax]
    
    ; TODO Task5
    jmp done
solve_task6:
    
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img_t], eax
    
    push dword[img]
    call blur
    pop dword[img]
    
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image
    pop dword[img]
    add esp, 8
    
    
    push DWORD[img_t]
    call free_image
    add esp, 4
    ; TODO Task6
    jmp done

    ; Free the memory allocated for the image.
done:
    
    push DWORD[img]
    call free_image
    add esp, 4
    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret