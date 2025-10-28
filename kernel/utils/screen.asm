; =====================================================
; SCREEN UTILITIES
; =====================================================
; Các hàm xử lý màn hình: clear, cursor, print
; =====================================================

clear_screen:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret

set_cursor:
    ; Input: DH = row, DL = column
    mov ah, 0x02
    mov bh, 0x00
    int 0x10
    ret

print_string:
    ; Input: SI = pointer to null-terminated string
    pusha
.loop:
    lodsb
    cmp al, 0
    je .done
    call print_char
    jmp .loop
.done:
    popa
    ret

print_char:
    ; Input: AL = character to print
    mov ah, 0x0E
    mov bh, 0x00
    int 0x10
    ret

print_colored:
    ; Input: SI = string, BL = color
    pusha
.loop:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x09
    mov bh, 0x00
    mov cx, 1
    int 0x10
    mov ah, 0x03
    mov bh, 0x00
    int 0x10
    inc dl
    mov ah, 0x02
    int 0x10
    jmp .loop
.done:
    popa
    ret
