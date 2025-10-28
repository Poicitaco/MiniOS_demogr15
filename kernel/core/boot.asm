; =====================================================
; BOOT SCREEN MODULE
; =====================================================
; Màn hình boot với logo MiniOS và thông tin nhóm 15
; =====================================================

show_boot_screen:
    call clear_screen
    
    ; Draw top border
    mov dh, 4
    mov dl, 13
    call set_cursor
    mov cx, 54
.draw_top:
    push cx
    mov al, '='
    mov bl, 0x09
    call print_char
    pop cx
    loop .draw_top
    
    ; Draw logo - Line 1
    mov dh, 6
    mov dl, 13
    call set_cursor
    mov si, logo_line1
    mov bl, 0x0B
    call print_colored
    
    ; Draw logo - Line 2
    mov dh, 7
    mov dl, 13
    call set_cursor
    mov si, logo_line2
    mov bl, 0x0B
    call print_colored
    
    ; Draw logo - Line 3
    mov dh, 8
    mov dl, 13
    call set_cursor
    mov si, logo_line3
    mov bl, 0x0B
    call print_colored
    
    ; Draw logo - Line 4
    mov dh, 9
    mov dl, 13
    call set_cursor
    mov si, logo_line4
    mov bl, 0x0B
    call print_colored
    
    ; Version
    mov dh, 11
    mov dl, 13
    call set_cursor
    mov si, boot_version
    mov bl, 0x0E
    call print_colored
    
    ; Team info
    mov dh, 12
    mov dl, 13
    call set_cursor
    mov si, boot_team
    mov bl, 0x0A
    call print_colored
    
    ; Course info
    mov dh, 13
    mov dl, 13
    call set_cursor
    mov si, boot_members
    mov bl, 0x07
    call print_colored
    
    ; Draw middle border
    mov dh, 15
    mov dl, 13
    call set_cursor
    mov cx, 54
.draw_middle:
    push cx
    mov al, '-'
    mov bl, 0x08
    call print_char
    pop cx
    loop .draw_middle
    
    ; Loading message
    mov dh, 16
    mov dl, 13
    call set_cursor
    mov si, boot_msg
    mov bl, 0x0E
    call print_colored
    
    ; Progress bar frame
    mov dh, 18
    mov dl, 28
    call set_cursor
    mov si, boot_progress
    call print_string
    
    ; Animated progress bar
    mov cx, 20
    mov dh, 18
    mov dl, 29
.progress:
    push cx
    call set_cursor
    mov ah, 0x09
    mov al, 0xDB        ; Block character
    mov bl, 0x0A        ; Green color
    mov cx, 1
    int 0x10
    
    ; Delay for animation
    mov cx, 0x01
    mov dx, 0x8000
    mov ah, 0x86
    int 0x15
    
    pop cx
    inc dl
    loop .progress
    
    ; Draw bottom border
    mov dh, 20
    mov dl, 13
    call set_cursor
    mov cx, 54
.draw_bottom:
    push cx
    mov al, '='
    mov bl, 0x09
    call print_char
    pop cx
    loop .draw_bottom
    
    ; Final message
    mov dh, 21
    mov dl, 25
    call set_cursor
    mov si, press_any_key
    mov bl, 0x0F
    call print_colored
    
    ; Wait for key
    call read_char
    
    ret
