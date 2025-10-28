; =====================================================
; KEYBOARD UTILITIES
; =====================================================
; Các hàm xử lý bàn phím: đọc phím, đọc dòng
; =====================================================

read_char:
    ; Output: AH = scan code, AL = ASCII
    mov ah, 0x00
    int 0x16
    ret

read_line:
    ; Input: None
    ; Output: input_buffer chứa chuỗi đã nhập
    push ax
    push bx
    push cx
    
    mov di, input_buffer
    xor cx, cx
    
.read_loop:
    call read_char
    
    cmp al, 0x0D      ; Enter
    je .read_done
    
    cmp al, 0x08      ; Backspace
    je .backspace
    
    cmp cx, 79        ; Max length
    jge .read_loop
    
    ; Store character
    mov [di], al
    inc di
    inc cx
    
    ; Echo character
    call print_char
    jmp .read_loop

.backspace:
    cmp cx, 0
    je .read_loop
    
    dec di
    dec cx
    
    ; Erase on screen
    mov al, 0x08
    call print_char
    mov al, ' '
    call print_char
    mov al, 0x08
    call print_char
    jmp .read_loop

.read_done:
    mov byte [di], 0
    mov al, 0x0D
    call print_char
    mov al, 0x0A
    call print_char
    
    pop cx
    pop bx
    pop ax
    ret
