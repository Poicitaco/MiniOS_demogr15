; =====================================================
; MAIN MENU MODULE
; =====================================================
; Menu chính với 7 options
; =====================================================

main_menu:
    call clear_screen
    
    ; Vẽ header
    call draw_header
    
    ; Vẽ menu
    mov dh, 5
    mov dl, 30
    call set_cursor
    mov si, menu_title
    mov bl, 0x0E
    call print_colored
    
    ; Menu items
    mov byte [menu_selection], 0
    call draw_menu_items
    
.menu_loop:
    call highlight_menu_item
    
    ; Read key
    call read_char
    
    ; Handle navigation
    cmp ah, 0x48      ; Up arrow
    je .menu_up
    cmp ah, 0x50      ; Down arrow
    je .menu_down
    cmp ah, 0x1C      ; Enter
    je .menu_select
    jmp .menu_loop

.menu_up:
    call clear_menu_highlight
    dec byte [menu_selection]
    cmp byte [menu_selection], 0xFF
    jne .menu_loop
    mov byte [menu_selection], 6
    jmp .menu_loop

.menu_down:
    call clear_menu_highlight
    inc byte [menu_selection]
    cmp byte [menu_selection], 7
    jl .menu_loop
    mov byte [menu_selection], 0
    jmp .menu_loop

.menu_select:
    mov al, [menu_selection]
    cmp al, 0
    je run_terminal
    cmp al, 1
    je run_clock
    cmp al, 2
    je run_file_editor
    cmp al, 3
    je run_game
    cmp al, 4
    je run_calculator
    cmp al, 5
    je run_about
    cmp al, 6
    je run_reboot
    jmp .menu_loop

draw_header:
    ; Top line
    mov dh, 0
    mov dl, 0
    call set_cursor
    mov si, header_line
    mov bl, 0x1F
    call print_colored
    
    ; Title
    mov dh, 0
    mov dl, 32
    call set_cursor
    mov si, header_title
    call print_colored
    
    ret

draw_menu_items:
    mov dh, 7
    mov dl, 32
    call set_cursor
    mov si, menu_item1
    call print_string
    
    mov dh, 8
    mov dl, 32
    call set_cursor
    mov si, menu_item2
    call print_string
    
    mov dh, 9
    mov dl, 32
    call set_cursor
    mov si, menu_item3
    call print_string
    
    mov dh, 10
    mov dl, 32
    call set_cursor
    mov si, menu_item4
    call print_string
    
    mov dh, 11
    mov dl, 32
    call set_cursor
    mov si, menu_item5
    call print_string
    
    mov dh, 12
    mov dl, 32
    call set_cursor
    mov si, menu_item6
    call print_string
    
    mov dh, 13
    mov dl, 32
    call set_cursor
    mov si, menu_item7
    call print_string
    
    ret

highlight_menu_item:
    mov al, [menu_selection]
    add al, 7
    mov dh, al
    mov dl, 31
    call set_cursor
    mov ah, 0x09
    mov al, '>'
    mov bl, 0x0A
    mov cx, 1
    int 0x10
    ret

clear_menu_highlight:
    mov al, [menu_selection]
    add al, 7
    mov dh, al
    mov dl, 31
    call set_cursor
    mov al, ' '
    call print_char
    ret
