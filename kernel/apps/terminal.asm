; =====================================================
; TERMINAL APPLICATION
; =====================================================
; Interactive command-line terminal
; =====================================================

run_terminal:
    call clear_screen
    call draw_header
    
    mov dh, 2
    mov dl, 2
    call set_cursor
    mov si, term_welcome
    mov bl, 0x0B
    call print_colored
    
    mov dh, 3
    mov dl, 2
    call set_cursor
    mov si, term_help
    call print_string
    
    mov byte [current_line], 5

.term_loop:
    ; Print prompt
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, term_prompt
    mov bl, 0x0E
    call print_colored
    
    ; Read command
    call read_line
    
    ; Increment line
    inc byte [current_line]
    
    ; Check commands
    mov si, input_buffer
    mov di, cmd_help
    call strcmp
    test ax, ax
    jz .show_help
    
    mov si, input_buffer
    mov di, cmd_clear
    call strcmp
    test ax, ax
    jz .clear_term
    
    mov si, input_buffer
    mov di, cmd_time
    call strcmp
    test ax, ax
    jz .show_time
    
    mov si, input_buffer
    mov di, cmd_date
    call strcmp
    test ax, ax
    jz .show_date
    
    mov si, input_buffer
    mov di, cmd_ver
    call strcmp
    test ax, ax
    jz .show_version
    
    mov si, input_buffer
    mov di, cmd_exit
    call strcmp
    test ax, ax
    jz .exit_term
    
    ; Unknown command
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, term_unknown
    call print_string
    inc byte [current_line]
    
    ; Check if screen full
    cmp byte [current_line], 24
    jl .term_loop
    mov byte [current_line], 5
    call clear_screen
    call draw_header
    jmp .term_loop

.show_help:
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, term_help_text
    call print_string
    inc byte [current_line]
    jmp .term_loop

.clear_term:
    call clear_screen
    call draw_header
    mov byte [current_line], 5
    jmp .term_loop

.show_time:
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, time_label
    call print_string
    call get_time_string
    mov si, time_buffer
    call print_string
    inc byte [current_line]
    jmp .term_loop

.show_date:
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, date_label
    call print_string
    call get_date_string
    mov si, date_buffer
    call print_string
    inc byte [current_line]
    jmp .term_loop

.show_version:
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, version_text
    call print_string
    inc byte [current_line]
    jmp .term_loop

.exit_term:
    jmp main_menu
