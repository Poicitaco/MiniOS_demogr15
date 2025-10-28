; =====================================================
; ABOUT APPLICATION
; =====================================================
; System information screen
; =====================================================

run_about:
    call clear_screen
    call draw_header
    
    mov dh, 4
    mov dl, 28
    call set_cursor
    mov si, about_title
    mov bl, 0x0E
    call print_colored
    
    mov dh, 7
    mov dl, 15
    call set_cursor
    mov si, about_line1
    mov bl, 0x0B
    call print_colored
    
    mov dh, 9
    mov dl, 15
    call set_cursor
    mov si, about_line2
    call print_string
    
    mov dh, 10
    mov dl, 15
    call set_cursor
    mov si, about_line3
    call print_string
    
    mov dh, 12
    mov dl, 15
    call set_cursor
    mov si, about_line4
    call print_string
    
    mov dh, 14
    mov dl, 15
    call set_cursor
    mov si, about_line5
    call print_string
    
    mov dh, 16
    mov dl, 15
    call set_cursor
    mov si, about_line6
    mov bl, 0x0E
    call print_colored
    
    mov dh, 17
    mov dl, 15
    call set_cursor
    mov si, about_line7
    call print_string
    
    mov dh, 19
    mov dl, 15
    call set_cursor
    mov si, about_line8
    call print_string
    
    mov dh, 22
    mov dl, 25
    call set_cursor
    mov si, press_any_key
    call print_string
    
    call read_char
    jmp main_menu
