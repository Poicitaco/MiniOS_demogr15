; =====================================================
; CLOCK & CALENDAR APPLICATION
; =====================================================
; Real-time clock display
; =====================================================

run_clock:
    call clear_screen
    call draw_header
    call init_rtc
    
    mov dh, 2
    mov dl, 25
    call set_cursor
    mov si, clock_title
    mov bl, 0x0E
    call print_colored
    
    mov dh, 4
    mov dl, 20
    call set_cursor
    mov si, clock_help
    call print_string

.clock_loop:
    ; Display time
    mov dh, 8
    mov dl, 30
    call set_cursor
    mov si, time_label
    mov bl, 0x0B
    call print_colored
    call get_time_string
    mov si, time_buffer
    mov bl, 0x0F
    call print_colored
    
    ; Display date
    mov dh, 10
    mov dl, 30
    call set_cursor
    mov si, date_label
    mov bl, 0x0B
    call print_colored
    call get_date_string
    mov si, date_buffer
    mov bl, 0x0F
    call print_colored
    
    ; Display day of week
    mov dh, 12
    mov dl, 30
    call set_cursor
    mov si, day_label
    mov bl, 0x0B
    call print_colored
    call get_day_of_week
    mov si, day_buffer
    mov bl, 0x0F
    call print_colored
    
    ; Small delay to prevent flickering
    mov cx, 0x05
    mov dx, 0x0000
    mov ah, 0x86
    int 0x15
    
    ; Check for ESC
    mov ah, 0x01
    int 0x16
    jz .clock_loop
    
    call read_char
    cmp ah, 0x01      ; ESC
    jne .clock_loop
    
    jmp main_menu
