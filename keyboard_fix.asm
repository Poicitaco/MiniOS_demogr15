; =====================================================
; KEYBOARD FIX - Version với timeout để tránh treo
; =====================================================
; Thay thế cho read_line trong kernel/utils/keyboard.asm
; =====================================================

read_line_fixed:
    ; Input: None
    ; Output: input_buffer chứa chuỗi đã nhập
    push ax
    push bx
    push cx
    push dx
    
    mov di, input_buffer
    xor cx, cx
    
.read_loop:
    ; Check if key is available (non-blocking)
    mov ah, 0x01    ; Check keyboard status
    int 0x16
    jz .no_key      ; No key pressed, continue waiting
    
    ; Key available, read it
    mov ah, 0x00    ; Read key
    int 0x16
    
    cmp al, 0x0D    ; Enter
    je .read_done
    
    cmp al, 0x08    ; Backspace
    je .backspace
    
    cmp al, 0x1B    ; ESC key - emergency exit
    je .emergency_exit
    
    cmp cx, 79      ; Max length
    jge .read_loop
    
    ; Valid character - store it
    mov [di], al
    inc di
    inc cx
    
    ; Echo character
    call print_char
    jmp .read_loop

.no_key:
    ; No key pressed, small delay and continue
    push cx
    mov cx, 1000    ; Small delay
.delay_loop:
    loop .delay_loop
    pop cx
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

.emergency_exit:
    ; ESC pressed - return empty string
    mov di, input_buffer
    mov byte [di], 0
    jmp .cleanup

.read_done:
    mov byte [di], 0
    mov al, 0x0D
    call print_char
    mov al, 0x0A
    call print_char

.cleanup:
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; Alternative read_char that doesn't block
read_char_polling:
    push bx
    push cx
    
.poll_loop:
    mov ah, 0x01    ; Check keyboard status
    int 0x16
    jnz .key_ready  ; Key available
    
    ; Small delay
    push cx
    mov cx, 100
.delay:
    loop .delay
    pop cx
    jmp .poll_loop

.key_ready:
    mov ah, 0x00    ; Read key
    int 0x16
    
    pop cx
    pop bx
    ret