; =====================================================
; STRING UTILITIES
; =====================================================
; Các hàm xử lý chuỗi: so sánh, copy
; =====================================================

strcmp:
    ; Input: SI = string 1, DI = string 2
    ; Output: AX = 0 if equal, 1 if not equal
    push si
    push di
.cmp_loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .not_equal
    cmp al, 0
    je .equal
    inc si
    inc di
    jmp .cmp_loop
.equal:
    pop di
    pop si
    xor ax, ax
    ret
.not_equal:
    pop di
    pop si
    mov ax, 1
    ret

strcpy:
    ; Input: SI = source, DI = destination
    push ax
    push si
    push di
.copy_loop:
    lodsb
    stosb
    cmp al, 0
    jne .copy_loop
    pop di
    pop si
    pop ax
    ret
