; =====================================================
; MINI OS v2.0 - HỆ ĐIỀU HÀNH MINI
; Tác giả: Mini OS Project
; Mô tả: Hệ điều hành 16-bit với giao diện đồ họa
; =====================================================

[BITS 16]           ; Chế độ 16-bit cho BIOS
[ORG 0x1000]        ; Kernel bắt đầu tại địa chỉ 0x1000

; =====================================================
; MINI OS v2.0 - Hệ điều hành minh họa 16-bit (Real Mode)
; Dòng chảy: show_boot_screen -> init_gui -> gui_main_loop
; Dùng BIOS: INT 10h (video), INT 16h (bàn phím), INT 1Ah (thời gian)
; =====================================================

; Điểm vào chính của kernel GUI: thiết lập segment/stack, splash, GUI.
start:
    ; Thiết lập các thanh ghi segment
    xor ax, ax      ; AX = 0
    mov ds, ax      ; Data Segment = 0
    mov es, ax      ; Extra Segment = 0
    mov ss, ax      ; Stack Segment = 0
    mov sp, 0x9000  ; Stack Pointer = 0x9000
    
    ; Hiển thị màn hình khởi động đẹp mắt
    call show_boot_screen
    
    ; Khởi tạo giao diện người dùng
    call init_gui
    
    ; Vào vòng lặp chính của GUI
    jmp gui_main_loop

; =====================================================
; MÀN HÌNH KHỞI ĐỘNG VỚI THANH TIẾN TRÌNH
; =====================================================
show_boot_screen:
    call clear_screen
    
    ; Vẽ logo ASCII với màu sắc
    mov dh, 3
    mov dl, 15
    call set_cursor
    mov si, logo_line1
    mov bl, 0x0B      ; Màu Cyan
    call print_colored
    
    mov dh, 4
    mov dl, 15
    call set_cursor
    mov si, logo_line2
    mov bl, 0x0B
    call print_colored
    
    mov dh, 5
    mov dl, 15
    call set_cursor
    mov si, logo_line3
    mov bl, 0x0E      ; Yellow
    call print_colored
    
    mov dh, 6
    mov dl, 15
    call set_cursor
    mov si, logo_line4
    mov bl, 0x0B
    call print_colored
    
    mov dh, 7
    mov dl, 15
    call set_cursor
    mov si, logo_line5
    mov bl, 0x0B
    call print_colored
    
    ; System name with gradient effect
    mov dh, 9
    mov dl, 30
    call set_cursor
    mov si, system_name
    mov bl, 0x0F      ; Bright white
    call print_colored
    
    mov dh, 10
    mov dl, 32
    call set_cursor
    mov si, system_version
    mov bl, 0x0A      ; Light green
    call print_colored
    
    ; Loading text
    mov dh, 13
    mov dl, 28
    call set_cursor
    mov si, loading_text
    mov bl, 0x07
    call print_colored
    
    ; Draw progress bar frame
    mov dh, 15
    mov dl, 15
    call set_cursor
    mov ah, 0x09
    mov al, '['
    mov bl, 0x07
    mov cx, 1
    int 0x10
    
    mov dl, 65
    call set_cursor
    mov al, ']'
    int 0x10
    
    ; Animated progress bar with colors
    mov cx, 48
    mov dl, 16
.progress:
    push cx
    push dx
    
    mov dh, 15
    call set_cursor
    mov ah, 0x09
    mov al, 0xDB      ; Full block
    
    ; Color gradient based on progress
    mov bl, 0x0A      ; Green for start
    cmp dl, 30
    jl .set_color
    mov bl, 0x0E      ; Yellow for middle
    cmp dl, 45
    jl .set_color
    mov bl, 0x0C      ; Red for end
    
.set_color:
    mov cx, 1
    int 0x10
    
    ; Small delay
    mov cx, 0x00
    mov dx, 0x3000
    mov ah, 0x86
    int 0x15
    
    pop dx
    pop cx
    inc dl
    loop .progress
    
    ; Boot complete message
    mov dh, 17
    mov dl, 30
    call set_cursor
    mov si, boot_done
    mov bl, 0x0A      ; Bright green
    call print_colored
    
    ; Wait a bit
    mov cx, 0x02
    mov dx, 0x0000
    mov ah, 0x86
    int 0x15
    
    ; Bật pixel font (không dùng transition để tránh treo)
    mov byte [use_pixel_font], 1    ; BẬT pixel font để test
    ; call transition_to_pixel_font  ; Comment out để debug
    
    ret

; ===== INITIALIZE GUI =====
init_gui:
    call clear_screen
    
    ; TEST PIXEL FONT - Hiển thị demo trước khi vào menu
    cmp byte [use_pixel_font], 1
    jne .skip_demo
    
    ; Demo pixel font
    mov dh, 10
    mov dl, 15
    mov si, pixel_demo_text
    mov bl, 0x0E
    call draw_pixel_string
    
    ; Wait to see demo
    mov cx, 0x05
    mov dx, 0x0000
    mov ah, 0x86
    int 0x15
    
    call clear_screen
    
.skip_demo:
    ; Hide cursor
    mov ah, 0x01
    mov ch, 0x20
    int 0x10
    
    ; Draw top bar (title bar)
    call draw_title_bar
    
    ; Draw main menu
    call draw_main_menu
    
    ; Draw bottom status bar
    call draw_status_bar
    
    ; Initialize menu
    mov byte [current_selection], 0
    call highlight_selection
    
    ret

; ===== DRAW TITLE BAR =====
draw_title_bar:
    ; Fill top line with blue background
    mov dh, 0
    mov dl, 0
    call set_cursor
    
    mov cx, 80
.fill_top:
    push cx
    mov ah, 0x09
    mov al, ' '
    mov bl, 0x1F      ; White on blue
    mov cx, 1
    int 0x10
    
    inc dl
    mov ah, 0x02
    xor bh, bh
    int 0x10
    
    pop cx
    loop .fill_top
    
    ; Print title
    mov dh, 0
    mov dl, 2
    call set_cursor
    
    mov si, system_name
.print_title:
    lodsb
    test al, al
    jz .done
    
    mov ah, 0x09
    mov bl, 0x1F
    mov cx, 1
    int 0x10
    
    inc dl
    mov ah, 0x02
    xor bh, bh
    int 0x10
    
    jmp .print_title
.done:
    ret

; ===== DRAW CLOCK BOX =====
draw_clock_box:
    ; Top border
    mov dh, 2
    mov dl, 48
    call set_cursor
    mov al, 0xC9      ; ╔
    call print_char
    
    mov cx, 29
.top_line:
    mov al, 0xCD      ; ═
    call print_char
    loop .top_line
    
    mov al, 0xBB      ; ╗
    call print_char
    
    ; Middle lines
    mov cx, 5
    mov dh, 3
.middle_lines:
    push cx
    mov dl, 48
    call set_cursor
    mov al, 0xBA      ; ║
    call print_char
    
    mov dl, 78
    call set_cursor
    mov al, 0xBA      ; ║
    call print_char
    
    inc dh
    pop cx
    loop .middle_lines
    
    ; Bottom border
    mov dl, 48
    call set_cursor
    mov al, 0xC8      ; ╚
    call print_char
    
    mov cx, 29
.bottom_line:
    mov al, 0xCD      ; ═
    call print_char
    loop .bottom_line
    
    mov al, 0xBC      ; ╝
    call print_char
    
    ; Clock label
    mov dh, 3
    mov dl, 58
    call set_cursor
    mov si, clock_label
    call print_string
    
    ; Date label  
    mov dh, 6
    mov dl, 58
    call set_cursor
    mov si, date_label
    call print_string
    
    ret

; ===== DRAW MAIN MENU =====
draw_main_menu:
    ; Top border with color
    mov dh, 7
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xC9
    mov bl, 0x0B      ; Cyan border
    mov cx, 1
    int 0x10
    
    mov cx, 38
    mov dl, 21
.menu_top:
    push cx
    call set_cursor
    mov ah, 0x09
    mov al, 0xCD
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    inc dl
    pop cx
    loop .menu_top
    
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBB
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    ; Title
    mov dh, 8
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov dl, 33
    call set_cursor
    mov si, menu_title
    mov bl, 0x0E      ; Yellow title
    call print_colored
    
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    ; Separator with color
    mov dh, 9
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xC7
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov cx, 38
    mov dl, 21
.menu_sep:
    push cx
    call set_cursor
    mov ah, 0x09
    mov al, 0xC4
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    inc dl
    pop cx
    loop .menu_sep
    
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xB6
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    ; Menu items with icons
    mov dh, 10
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    mov dl, 23
    call set_cursor
    mov si, menu_1
    mov bl, 0x0F
    call print_colored
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov dh, 11
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    mov dl, 23
    call set_cursor
    mov si, menu_2
    mov bl, 0x0F
    call print_colored
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov dh, 12
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    mov dl, 23
    call set_cursor
    mov si, menu_3
    mov bl, 0x0F
    call print_colored
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov dh, 13
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    mov dl, 23
    call set_cursor
    mov si, menu_4
    mov bl, 0x0F
    call print_colored
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov dh, 14
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    mov dl, 23
    call set_cursor
    mov si, menu_5
    mov bl, 0x0F
    call print_colored
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov dh, 15
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    mov dl, 23
    call set_cursor
    mov si, menu_6
    mov bl, 0x0F
    call print_colored
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov dh, 16
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    mov dl, 23
    call set_cursor
    mov si, menu_7
    mov bl, 0x0F
    call print_colored
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov dh, 17
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    mov dl, 23
    call set_cursor
    mov si, menu_8
    mov bl, 0x0F
    call print_colored
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBA
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    ; Bottom border
    mov dh, 18
    mov dl, 20
    call set_cursor
    mov ah, 0x09
    mov al, 0xC8
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    mov cx, 38
    mov dl, 21
.menu_bottom:
    push cx
    call set_cursor
    mov ah, 0x09
    mov al, 0xCD
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    inc dl
    pop cx
    loop .menu_bottom
    
    mov dl, 59
    call set_cursor
    mov ah, 0x09
    mov al, 0xBC
    mov bl, 0x0B
    mov cx, 1
    int 0x10
    
    ret

; ===== DRAW STATUS BAR =====
draw_status_bar:
    mov dh, 24
    mov dl, 0
    call set_cursor
    
    mov cx, 80
.fill_status:
    push cx
    mov ah, 0x09
    mov al, ' '
    mov bl, 0x70      ; Black on white
    mov cx, 1
    int 0x10
    
    inc dl
    mov ah, 0x02
    xor bh, bh
    int 0x10
    
    pop cx
    loop .fill_status
    
    ; Status text
    mov dh, 24
    mov dl, 2
    call set_cursor
    
    mov si, status_msg
.print_status:
    lodsb
    test al, al
    jz .status_done
    
    mov ah, 0x09
    mov bl, 0x70
    mov cx, 1
    int 0x10
    
    inc dl
    mov ah, 0x02
    xor bh, bh
    int 0x10
    
    jmp .print_status
.status_done:
    ret

; ===== UPDATE CLOCK =====
update_clock:
    ; Get time
    mov ah, 0x02
    int 0x1A
    jc .skip_time
    
    ; Display time HH:MM:SS
    mov dh, 4
    mov dl, 56
    call set_cursor
    
    ; Hours
    mov al, ch
    call print_bcd
    mov al, ':'
    call print_char
    
    ; Minutes
    mov al, cl
    call print_bcd
    mov al, ':'
    call print_char
    
    ; Seconds
    push cx
    mov ah, 0x02
    int 0x1A
    mov al, dh
    call print_bcd
    pop cx
    
.skip_time:
    ; Get date
    mov ah, 0x04
    int 0x1A
    jc .skip_date
    
    ; Display date DD/MM/YYYY
    mov dh, 7
    mov dl, 52
    call set_cursor
    
    ; Day
    mov al, dl
    call print_bcd
    mov al, '/'
    call print_char
    
    ; Month
    mov al, dh
    call print_bcd
    mov al, '/'
    call print_char
    
    ; Year
    mov al, ch
    call print_bcd
    mov al, cl
    call print_bcd
    
.skip_date:
    ret

; ===== HIGHLIGHT SELECTION =====
highlight_selection:
    ; Calculate row (10 + selection)
    mov al, [current_selection]
    add al, 10
    mov dh, al
    mov dl, 22
    call set_cursor
    
    ; Draw arrow with color
    mov ah, 0x09
    mov al, 0x10      ; ►
    mov bl, 0x0E      ; Yellow
    mov cx, 1
    int 0x10
    
    ret

; ===== CLEAR HIGHLIGHT =====
clear_highlight:
    mov al, [current_selection]
    add al, 10
    mov dh, al
    mov dl, 22
    call set_cursor
    
    mov al, ' '
    call print_char
    ret

; Vòng lặp chính của GUI: chờ phím, xử lý di chuyển chọn và thực thi mục
; - F1: bật/tắt Pixel Font, Mũi tên: di chuyển, Enter: chọn
gui_main_loop:
    ; Check for input (non-blocking)
    mov ah, 0x01
    int 0x16
    jz gui_main_loop
    
    ; Get key
    mov ah, 0x00
    int 0x16
    
    ; Handle input
    cmp ah, 0x3B      ; F1 - Toggle pixel font
    je .toggle_font
    
    cmp ah, 0x48      ; Up arrow
    je .move_up
    
    cmp ah, 0x50      ; Down arrow
    je .move_down
    
    cmp ah, 0x1C      ; Enter
    je .execute
    
    cmp al, 'q'       ; Q to quit
    je .quit
    cmp al, 'Q'
    je .quit
    
    jmp gui_main_loop
    
.move_up:
    call clear_highlight
    dec byte [current_selection]
    cmp byte [current_selection], 0xFF
    jne .update
    mov byte [current_selection], 7
    jmp .update
    
.move_down:
    call clear_highlight
    inc byte [current_selection]
    cmp byte [current_selection], 8
    jl .update
    mov byte [current_selection], 0
    
.update:
    call highlight_selection
    jmp gui_main_loop
    
.execute:
    mov al, [current_selection]
    cmp al, 0
    je run_snake
    cmp al, 1
    je run_editor
    cmp al, 2
    je run_file_manager
    cmp al, 3
    je run_terminal
    cmp al, 4
    je run_calculator
    cmp al, 5
    je show_clock_full
    cmp al, 6
    je show_about_screen
    cmp al, 7
    je reboot_system
    jmp gui_main_loop
    
.quit:
    jmp reboot_system

.toggle_font:
    ; Toggle pixel font on/off
    xor byte [use_pixel_font], 1
    
    ; Show notification
    call clear_screen
    mov dh, 12
    mov dl, 25
    call set_cursor
    
    cmp byte [use_pixel_font], 1
    je .show_pixel_enabled
    
    ; BIOS font enabled
    mov si, bios_font_msg
    mov bl, 0x0A
    call print_colored
    jmp .wait_toggle
    
.show_pixel_enabled:
    ; Pixel font enabled
    mov si, pixel_enabled_msg
    mov bl, 0x0E
    call print_colored
    
.wait_toggle:
    ; Wait 1 second
    mov cx, 0x0F
.delay_outer_toggle:
    push cx
    mov cx, 0xFFFF
.delay_inner_toggle:
    loop .delay_inner_toggle
    pop cx
    loop .delay_outer_toggle
    
    ; Redraw GUI
    call init_gui
    jmp gui_main_loop

; ===== RUN SNAKE GAME =====
; Chạy game Snake từ GUI: hiện menu chọn độ khó rồi quay lại GUI.
run_snake:
    call snake_difficulty_menu
    call init_gui
    jmp gui_main_loop

; Menu chọn độ khó cho Snake
; - Phím 1/2/3 hoặc mũi tên + Enter
; - Đặt snake_base_speed/snakes_speed theo tick BIOS (1 tick ≈ 55ms)
snake_difficulty_menu:
    call clear_screen
    
    mov dh, 8
    mov dl, 28
    call set_cursor
    mov si, difficulty_title
    mov bl, 0x0E
    call print_colored
    
    mov dh, 11
    mov dl, 30
    call set_cursor
    mov si, diff_easy
    call print_string
    
    mov dh, 12
    mov dl, 30
    call set_cursor
    mov si, diff_normal
    call print_string
    
    mov dh, 13
    mov dl, 30
    call set_cursor
    mov si, diff_hard
    call print_string
    
    mov byte [diff_choice], 0
    
.diff_loop:
    ; Highlight current choice
    mov al, [diff_choice]
    add al, 11
    mov dh, al
    mov dl, 29
    call set_cursor
    mov ah, 0x09
    mov al, '>'
    mov bl, 0x0E
    mov cx, 1
    int 0x10
    
    ; Wait for key
    call read_char
    
    ; Clear highlight
    mov al, [diff_choice]
    add al, 11
    mov dh, al
    mov dl, 29
    call set_cursor
    mov al, ' '
    call print_char
    
    ; Check key
    cmp ah, 0x48      ; Up
    je .diff_up
    cmp ah, 0x50      ; Down
    je .diff_down
    cmp ah, 0x1C      ; Enter
    je .diff_select
    cmp ah, 0x01      ; ESC
    je .diff_cancel
    
    jmp .diff_loop
    
.diff_up:
    dec byte [diff_choice]
    cmp byte [diff_choice], 0xFF
    jne .diff_loop
    mov byte [diff_choice], 2
    jmp .diff_loop
    
.diff_down:
    inc byte [diff_choice]
    cmp byte [diff_choice], 3
    jl .diff_loop
    mov byte [diff_choice], 0
    jmp .diff_loop
    
.diff_select:
    ; Set game speed based on difficulty
    mov al, [diff_choice]
    cmp al, 0
    je .set_easy
    cmp al, 1
    je .set_normal
    cmp al, 2
    je .set_hard
    
.set_easy:
    mov word [snake_speed], 10      ; Rất chậm (~660ms)
    mov word [snake_base_speed], 10
    jmp .start_game
    
.set_normal:
    mov word [snake_speed], 8       ; Trung bình (~440ms)
    mov word [snake_base_speed], 8
    jmp .start_game
    
.set_hard:
    mov word [snake_speed], 4       ; Nhanh (~220ms)
    mov word [snake_base_speed], 4
    
.start_game:
    call snake_game
    ret
    
.diff_cancel:
    ret

; ===== RUN TERMINAL =====
; Chạy mini terminal: nhận lệnh cơ bản (help, clear, cat, ipconfig, ver, exit)
run_terminal:
    call mini_terminal
    call init_gui
    jmp gui_main_loop

; Vòng lặp terminal: in prompt, đọc lệnh, so sánh chuỗi và thực thi
mini_terminal:
    call clear_screen
    
    ; Header
    mov si, terminal_header
    mov bl, 0x0B
    call print_colored
    
    mov si, terminal_help
    call print_string
    
.term_loop:
    mov si, term_prompt
    mov bl, 0x0E
    call print_colored
    
    ; Read command
    call read_line
    
    ; Check commands
    mov si, input_buffer
    mov di, term_cmd_help
    call strcmp
    test ax, ax
    jz .term_help
    
    mov si, input_buffer
    mov di, term_cmd_clear
    call strcmp
    test ax, ax
    jz .term_clear
    
    mov si, input_buffer
    mov di, term_cmd_ipconfig
    call strcmp
    test ax, ax
    jz .term_ipconfig
    
    mov si, input_buffer
    mov di, term_cmd_cat
    call strcmp
    test ax, ax
    jz .term_cat
    
    mov si, input_buffer
    mov di, term_cmd_ver
    call strcmp
    test ax, ax
    jz .term_version
    
    mov si, input_buffer
    mov di, term_cmd_exit
    call strcmp
    test ax, ax
    jz .term_exit
    
    ; Unknown command
    mov si, term_unknown
    call print_string
    jmp .term_loop
    
.term_help:
    mov si, term_help_text
    call print_string
    jmp .term_loop
    
.term_clear:
    call clear_screen
    mov si, terminal_header
    mov bl, 0x0B
    call print_colored
    jmp .term_loop
    
.term_ipconfig:
    mov si, term_ip_header
    mov bl, 0x0A
    call print_colored
    mov si, term_ip_info
    call print_string
    jmp .term_loop
    
.term_cat:
    ; Đọc tên file cần xem
    mov si, term_cat_prompt
    call print_string
    call read_line
    
    ; Tìm file trong hệ thống
    call find_file
    cmp ax, 0xFFFF      ; Kiểm tra có tìm thấy không
    je .term_cat_notfound
    
    ; Tìm thấy file - in nội dung
    push ax
    mov si, newline_str
    call print_string
    pop ax
    
    mov bx, ax
    mov ax, bx
    mov dx, 512         ; Mỗi file = 512 bytes
    mul dx
    mov si, ax
    add si, file_data   ; SI trỏ đến nội dung file
    
    ; In toàn bộ nội dung file
    call print_string
    
    mov si, newline_str
    call print_string
    call print_string
    jmp .term_loop
    
.term_cat_notfound:
    mov si, fm_not_found
    mov bl, 0x0C        ; Màu đỏ
    call print_colored
    jmp .term_loop
    
.term_version:
    mov si, term_ver_info
    call print_string
    jmp .term_loop
    
.term_exit:
    ret

; ===== RUN CALCULATOR =====
run_calculator:
    call calculator
    call init_gui
    jmp gui_main_loop

; =====================================================
; MÁY TÍNH - HỖ TRỢ SỐ ÂM VÀ CHIA CÓ DÖ
; =====================================================
calculator:
    call clear_screen
    
    mov si, calc_header
    mov bl, 0x0E
    call print_colored
    
    mov si, calc_help
    call print_string
    
.calc_loop:
    mov si, calc_prompt
    mov bl, 0x0A
    call print_colored
    
    ; Đọc số thứ nhất
    call read_line
    
    ; Kiểm tra lệnh exit
    mov si, input_buffer
    mov di, term_cmd_exit
    call strcmp
    test ax, ax
    jz .calc_exit
    
    ; Chuyển chuỗi thành số (hỗ trợ số âm)
    call string_to_number_signed
    mov [calc_num1], ax
    
    ; Đọc phép toán
    mov si, calc_op_prompt
    call print_string
    call read_char
    mov [calc_operator], al
    call print_char
    
    mov si, newline_str
    call print_string
    
    ; Đọc số thứ hai
    mov si, calc_prompt
    mov bl, 0x0A
    call print_colored
    call read_line
    call string_to_number_signed
    mov [calc_num2], ax
    
    ; Thực hiện phép tính
    mov si, calc_result
    mov bl, 0x0B
    call print_colored
    
    mov al, [calc_operator]
    cmp al, '+'
    je .calc_add
    cmp al, '-'
    je .calc_sub
    cmp al, '*'
    je .calc_mul
    cmp al, '/'
    je .calc_div
    
    ; Phép toán không hợp lệ
    mov si, calc_error
    call print_string
    jmp .calc_loop
    
.calc_add:
    mov ax, [calc_num1]
    add ax, [calc_num2]
    call print_number_signed
    mov si, newline_str
    call print_string
    jmp .calc_loop
    
.calc_sub:
    mov ax, [calc_num1]
    sub ax, [calc_num2]
    call print_number_signed
    mov si, newline_str
    call print_string
    jmp .calc_loop
    
.calc_mul:
    mov ax, [calc_num1]
    mov bx, [calc_num2]
    imul bx             ; Nhân có dấu
    call print_number_signed
    mov si, newline_str
    call print_string
    jmp .calc_loop
    
.calc_div:
    mov ax, [calc_num1]
    mov bx, [calc_num2]
    cmp bx, 0
    je .calc_div_zero
    
    xor dx, dx
    
    ; Kiểm tra dấu để chia đúng
    push ax
    push bx
    xor cx, cx          ; CX = 0 (cờ dấu kết quả)
    
    ; Kiểm tra dấu của số chia
    test ax, 0x8000
    jz .num1_positive
    neg ax
    inc cx              ; Đổi dấu
.num1_positive:
    
    ; Kiểm tra dấu của số bị chia
    test bx, 0x8000
    jz .num2_positive
    neg bx
    inc cx              ; Đổi dấu
.num2_positive:
    
    xor dx, dx
    div bx              ; AX = thương, DX = số dư
    
    ; Áp dụng dấu cho kết quả
    test cx, 1
    jz .div_positive
    neg ax
.div_positive:
    
    push dx             ; Lưu số dư
    call print_number_signed
    
    ; Hiển thị số dư
    mov si, calc_remainder
    call print_string
    pop ax              ; Lấy số dư
    call print_number_signed
    
    mov si, newline_str
    call print_string
    
    pop bx
    pop ax
    jmp .calc_loop
    
.calc_div_zero:
    mov si, calc_div_error
    call print_string
    jmp .calc_loop
    
.calc_exit:
    ret

; Đọc một dòng từ bàn phím vào input_buffer (có echo ra màn hình)
; - Kết thúc khi Enter (AL=13)
; - Hỗ trợ Backspace (xóa 1 ký tự và di chuyển con trỏ)
read_line:
    pusha
    mov di, input_buffer
    xor cx, cx
    
.read_loop:
    call read_char
    
    ; Enter - done
    cmp al, 13
    je .read_done
    
    ; Backspace
    cmp al, 8
    je .read_backspace
    
    ; Normal char
    cmp al, 32
    jl .read_loop
    cmp al, 126
    jg .read_loop
    
    ; Store char
    cmp cx, 79
    jge .read_loop
    
    mov [di], al
    inc di
    inc cx
    
    call print_char
    jmp .read_loop
    
.read_backspace:
    cmp cx, 0
    je .read_loop
    
    dec di
    dec cx
    
    mov al, 8
    call print_char
    mov al, ' '
    call print_char
    mov al, 8
    call print_char
    
    jmp .read_loop
    
.read_done:
    mov byte [di], 0
    mov si, newline_str
    call print_string
    
    popa
    ret

; Tìm tên file trong danh sách file_list (tối đa 5 mục)
; - Input: input_buffer chứa tên cần tìm
; - Output: AX = index (0..4) nếu tìm thấy, 0xFFFF nếu không
find_file:
    push bx
    push cx
    push si
    push di
    
    xor bx, bx
    mov cx, 5
.find_loop:
    push cx
    push bx
    
    mov ax, bx
    mov dx, 32
    mul dx
    mov di, ax
    add di, file_list
    
    mov si, input_buffer
    call strcmp
    test ax, ax
    jz .found
    
    pop bx
    pop cx
    inc bx
    loop .find_loop
    
    ; Not found
    pop di
    pop si
    pop cx
    pop bx
    mov ax, 0xFFFF
    ret
    
.found:
    pop bx
    pop cx
    pop di
    pop si
    pop cx
    pop bx
    mov ax, bx
    ret

; =====================================================
; CHUYỂN CHUỖI THÀNH SỐ KHÔNG DẤU
; Input: SI trỏ đến chuỗi số
; Output: AX = số nguyên không dấu
; =====================================================
string_to_number:
    pusha
    xor ax, ax
    xor bx, bx
    mov si, input_buffer
    
.convert_loop:
    mov bl, [si]
    cmp bl, 0
    je .convert_done
    
    cmp bl, '0'
    jl .convert_done
    cmp bl, '9'
    jg .convert_done
    
    sub bl, '0'
    mov cx, 10
    mul cx
    add ax, bx
    
    inc si
    jmp .convert_loop
    
.convert_done:
    mov [temp_num], ax
    popa
    mov ax, [temp_num]
    ret

; =====================================================
; CHUYỂN CHUỖI THÀNH SỐ (HỖ TRỢ SỐ ÂM)
; Input: SI trỏ đến chuỗi số
; Output: AX = số nguyên (có dấu)
; =====================================================
string_to_number_signed:
    pusha
    xor ax, ax          ; AX = 0
    xor bx, bx          ; BX = 0
    xor cx, cx          ; CX = 0 (cờ dấu âm)
    mov si, input_buffer
    
    ; Kiểm tra dấu âm
    mov bl, [si]
    cmp bl, '-'
    jne .convert_loop
    
    inc cx              ; Đánh dấu số âm
    inc si              ; Bỏ qua dấu '-'
    
.convert_loop:
    mov bl, [si]
    cmp bl, 0
    je .convert_done
    
    cmp bl, '0'
    jl .convert_done
    cmp bl, '9'
    jg .convert_done
    
    sub bl, '0'         ; Chuyển ký tự thành số
    push dx
    mov dx, 10
    mul dx              ; AX = AX * 10
    pop dx
    add ax, bx          ; AX = AX + digit
    
    inc si
    jmp .convert_loop
    
.convert_done:
    ; Áp dụng dấu âm nếu có
    test cx, cx
    jz .positive
    neg ax              ; Đổi dấu AX
    
.positive:
    mov [temp_num], ax
    popa
    mov ax, [temp_num]
    ret

; =====================================================
; IN SỐ CÓ DẤU RA MÀN HÌNH
; Input: AX = số cần in (có dấu)
; =====================================================
print_number_signed:
    pusha
    
    ; Kiểm tra số âm
    test ax, 0x8000     ; Kiểm tra bit dấu
    jz .print_positive
    
    ; Số âm - in dấu '-'
    push ax
    mov al, '-'
    call print_char
    pop ax
    
    ; Chuyển thành số dương
    neg ax
    
.print_positive:
    xor cx, cx
    mov bx, 10
.divide_num:
    xor dx, dx
    div bx              ; AX = AX / 10, DX = dư
    push dx             ; Lưu chữ số
    inc cx
    test ax, ax
    jnz .divide_num
    
.print_num:
    pop ax
    add al, '0'         ; Chuyển số thành ký tự
    call print_char
    loop .print_num
    
    popa
    ret

; ===== RUN EDITOR =====
run_editor:
    call text_editor
    call init_gui
    jmp gui_main_loop

; ===== SHOW FULL CLOCK =====
show_clock_full:
    call clear_screen
    
    mov dh, 8
    mov dl, 28
    call set_cursor
    mov si, time_header
    mov bl, 0x0E
    call print_colored
    
    ; Show time (fix timezone - add 7 hours for Vietnam)
    mov ah, 0x02
    int 0x1A
    jc .skip_time
    
    ; Adjust hour for Vietnam timezone (UTC+7)
    mov al, ch
    add al, 0x07      ; Add 7 hours in BCD
    
    ; Check if hour >= 24
    cmp al, 0x24
    jl .hour_ok
    sub al, 0x24
.hour_ok:
    
    mov dh, 10
    mov dl, 35
    call set_cursor
    call print_bcd
    mov al, ':'
    call print_char
    mov al, cl
    call print_bcd
    mov al, ':'
    call print_char
    
    ; Get seconds
    mov ah, 0x02
    int 0x1A
    mov al, dh
    call print_bcd
    
.skip_time:
    mov dh, 13
    mov dl, 28
    call set_cursor
    mov si, date_header
    mov bl, 0x0E
    call print_colored
    
    ; Show date
    mov ah, 0x04
    int 0x1A
    jc .skip_date
    
    mov dh, 15
    mov dl, 33
    call set_cursor
    mov al, dl
    call print_bcd
    mov al, '/'
    call print_char
    mov al, dh
    call print_bcd
    mov al, '/'
    call print_char
    mov al, ch
    call print_bcd
    mov al, cl
    call print_bcd
    
.skip_date:
    mov dh, 20
    mov dl, 28
    call set_cursor
    mov si, press_any_key
    call print_string
    
    call read_char
    call init_gui
    jmp gui_main_loop

; ===== SHOW ABOUT =====
show_about_screen:
    call clear_screen
    
    mov dh, 6
    mov dl, 28
    call set_cursor
    mov si, about_header
    call print_string
    
    mov dh, 8
    mov dl, 18
    call set_cursor
    mov si, about_1
    call print_string
    
    mov dh, 10
    mov dl, 18
    call set_cursor
    mov si, about_2
    call print_string
    
    mov dh, 11
    mov dl, 18
    call set_cursor
    mov si, about_3
    call print_string
    
    mov dh, 12
    mov dl, 18
    call set_cursor
    mov si, about_4
    call print_string
    
    mov dh, 14
    mov dl, 18
    call set_cursor
    mov si, about_5
    call print_string
    
    mov dh, 20
    mov dl, 28
    call set_cursor
    mov si, press_any_key
    call print_string
    
    call read_char
    call init_gui
    jmp gui_main_loop

; ===== SHOW SETTINGS =====
show_settings:
    call clear_screen
    
    mov dh, 8
    mov dl, 30
    call set_cursor
    mov si, settings_header
    call print_string
    
    mov dh, 12
    mov dl, 22
    call set_cursor
    mov si, settings_1
    call print_string
    
    mov dh, 13
    mov dl, 22
    call set_cursor
    mov si, settings_2
    call print_string
    
    mov dh, 20
    mov dl, 28
    call set_cursor
    mov si, press_any_key
    call print_string
    
    call read_char
    call init_gui
    jmp gui_main_loop

; ===== REBOOT =====
reboot_system:
    jmp 0xFFFF:0x0000

; ===== UTILITY FUNCTIONS =====

; In chuỗi kết thúc bằng 0 tại vị trí con trỏ hiện tại (INT 10h AH=0Eh)
print_string:
    pusha
    mov ah, 0x0E
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    popa
    ret

print_string_colored:
    pusha
    mov ah, 0x09
    mov bl, 0x0B      ; Cyan
.loop:
    lodsb
    cmp al, 0
    je .done
    mov cx, 1
    int 0x10
    
    mov ah, 0x03
    xor bh, bh
    int 0x10
    inc dl
    mov ah, 0x02
    int 0x10
    mov ah, 0x09
    jmp .loop
.done:
    popa
    ret

print_colored:
    pusha
    mov ah, 0x09
    ; BL already contains color
.loop_col:
    lodsb
    cmp al, 0
    je .done_col
    mov cx, 1
    int 0x10
    
    mov ah, 0x03
    xor bh, bh
    int 0x10
    inc dl
    mov ah, 0x02
    int 0x10
    mov ah, 0x09
    jmp .loop_col
.done_col:
    popa
    ret

; In 1 ký tự tại vị trí con trỏ hiện tại (INT 10h AH=0Eh)
print_char:
    pusha
    mov ah, 0x0E
    int 0x10
    popa
    ret

; Xóa màn hình (đặt chế độ 80x25 text mode 03h)
clear_screen:
    pusha
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    popa
    ret

; Đặt vị trí con trỏ: BH=0 (page), DH=row, DL=col; INT 10h AH=02h
set_cursor:
    pusha
    mov ah, 0x02
    xor bh, bh
    int 0x10
    popa
    ret

; Đọc 1 phím từ bàn phím (chặn): INT 16h AH=00h, trả về AL (ASCII), AH (scancode)
read_char:
    mov ah, 0x00
    int 0x16
    ret

print_bcd:
    pusha
    push ax
    shr al, 4
    add al, '0'
    call print_char
    pop ax
    and al, 0x0F
    add al, '0'
    call print_char
    popa
    ret

strcmp:
    pusha
    xor ax, ax
.cmp_loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .not_equal
    test al, al
    jz .equal
    inc si
    inc di
    jmp .cmp_loop
.equal:
    popa
    xor ax, ax
    ret
.not_equal:
    popa
    mov ax, 1
    ret

; =====================================================
; PIXEL FONT WRAPPER FUNCTIONS
; Các hàm wrapper để sử dụng pixel font dễ dàng
; =====================================================

; Biến cờ để bật/tắt pixel font
use_pixel_font: db 1    ; 1 = dùng pixel font, 0 = dùng BIOS font

; ===== HÀM IN CHUỖI VỚI PIXEL FONT =====
; Input: SI = con trỏ chuỗi, DH = row, DL = col, BL = màu
print_string_pixel:
    pusha
    
    ; Kiểm tra có dùng pixel font không
    cmp byte [use_pixel_font], 1
    jne .use_bios
    
    ; Dùng pixel font
    call draw_pixel_string
    jmp .done
    
.use_bios:
    ; Dùng BIOS font thông thường
    call set_cursor
    call print_colored
    
.done:
    popa
    ret

; ===== HÀM IN SỐ VỚI PIXEL FONT =====
; Input: AX = số, DH = row, DL = col, BL = màu
print_number_pixel:
    pusha
    
    cmp byte [use_pixel_font], 1
    jne .use_bios
    
    ; Dùng pixel font
    call draw_pixel_number
    jmp .done
    
.use_bios:
    ; Dùng BIOS
    call set_cursor
    call print_number_signed
    
.done:
    popa
    ret

; ===== HÀM CHUYỂN ĐỔI CHẬM TỪ BIOS SANG PIXEL FONT =====
; Hiệu ứng transition đẹp mắt (TẠM THỜI VÔ HIỆU HÓA)
transition_to_pixel_font:
    pusha
    ; Không làm gì cả - tránh treo hệ thống
    popa
    ret

pixel_font_msg: db 'PIXEL FONT MODE ACTIVATED', 0
bios_font_msg: db 'BIOS Font Mode - Standard Text', 0
pixel_enabled_msg: db 'Pixel Font Mode - Custom 8x8 Font', 0
pixel_demo_text: db 'TESTING PIXEL FONT 8x8 - ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789', 0

; Include snake game and editor from original kernel
; %include "kernel/snake.asm"
; %include "kernel/editor.asm"

; Trò chơi Snake (phiên bản trong GUI)
; - Dùng INT 1Ah để đo thời gian, tốc độ theo tick BIOS
; - Tự va chạm: đọc ký tự màn hình tại đầu mới ('o'/'@' => thua)
; - Đuôi bám đường: tìm “đốt thân” lân cận sau khi xóa đuôi
; - Mồi không đè thân/viền: spawn_food chỉ đặt vào ô trống
snake_game:
    call clear_screen
    
    ; Initialize
    mov word [snake_head_x], 39
    mov word [snake_head_y], 12
    mov word [snake_tail_x], 36
    mov word [snake_tail_y], 12
    mov word [snake_dx], 1
    mov word [snake_dy], 0
    mov word [snake_length], 4
    mov word [game_score], 0
    mov word [game_ticks], 0
    ; Initialize timestamp for time-based movement
    mov ah, 0x00
    int 0x1A                 ; CX:DX = BIOS tick count
    mov [last_tick_lo], dx
    mov [last_tick_hi], cx
    
    ; Draw initial snake
    mov cx, 4
    mov ax, 36
.draw_init_snake:
    push ax
    push cx
    mov dh, 12
    mov dl, al
    call set_cursor
    mov al, 'o'
    call print_char
    pop cx
    pop ax
    inc ax
    loop .draw_init_snake
    
    mov word [snake_head_x], 39
    
    ; Draw border
    call draw_border
    
    ; Spawn food
    call spawn_food
    
.snake_loop:
    ; Draw score
    mov dh, 0
    mov dl, 2
    call set_cursor
    mov si, score_msg
    call print_string
    mov ax, [game_score]
    call print_number
    
    mov dl, 15
    call set_cursor
    mov si, snake_help
    call print_string
    
    ; Check key
    mov ah, 0x01
    int 0x16
    jz .no_snake_key
    
    mov ah, 0x00
    int 0x16
    
    cmp ah, 0x01      ; ESC
    je .snake_over
    cmp al, 'q'
    je .snake_over
    cmp al, 'Q'
    je .snake_over
    
    cmp ah, 0x48      ; Up
    je .snake_up
    cmp ah, 0x50      ; Down
    je .snake_down
    cmp ah, 0x4B      ; Left
    je .snake_left
    cmp ah, 0x4D      ; Right
    je .snake_right
    
    cmp al, 'w'
    je .snake_up
    cmp al, 'W'
    je .snake_up
    cmp al, 's'
    je .snake_down
    cmp al, 'S'
    je .snake_down
    cmp al, 'a'
    je .snake_left
    cmp al, 'A'
    je .snake_left
    cmp al, 'd'
    je .snake_right
    cmp al, 'D'
    je .snake_right
    
    jmp .no_snake_key
    
.snake_up:
    cmp word [snake_dy], 1
    je .no_snake_key
    mov word [snake_dx], 0
    mov word [snake_dy], -1
    jmp .no_snake_key
    
.snake_down:
    cmp word [snake_dy], -1
    je .no_snake_key
    mov word [snake_dx], 0
    mov word [snake_dy], 1
    jmp .no_snake_key
    
.snake_left:
    cmp word [snake_dx], 1
    je .no_snake_key
    mov word [snake_dx], -1
    mov word [snake_dy], 0
    jmp .no_snake_key
    
.snake_right:
    cmp word [snake_dx], -1
    je .no_snake_key
    mov word [snake_dx], 1
    mov word [snake_dy], 0
    
.no_snake_key:
    ; Time-based delay using BIOS tick (18.2 Hz)
    mov ah, 0x00
    int 0x1A                 ; CX:DX current tick count
    mov ax, dx
    sub ax, [last_tick_lo]
    mov bx, cx
    sbb bx, [last_tick_hi]
    ; If high word diff != 0, enough time passed
    test bx, bx
    jnz .tick_ok
    ; Otherwise compare low diff with required delay
    cmp ax, [snake_speed]
    jl .snake_loop
.tick_ok:
    ; Store new last tick
    mov [last_tick_lo], dx
    mov [last_tick_hi], cx

    ; Compute new head position
    mov ax, [snake_head_x]
    add ax, [snake_dx]
    mov [snake_head_x], ax
    mov ax, [snake_head_y]
    add ax, [snake_dy]
    mov [snake_head_y], ax

    ; Check walls (x:2..77, y:2..23)
    cmp word [snake_head_x], 2
    jl .snake_over
    cmp word [snake_head_x], 77
    jg .snake_over
    cmp word [snake_head_y], 2
    jl .snake_over
    cmp word [snake_head_y], 23
    jg .snake_over

    ; Check food at new head
    mov ax, [snake_head_x]
    cmp ax, [food_x]
    jne .not_on_food
    mov ax, [snake_head_y]
    cmp ax, [food_y]
    jne .not_on_food
    jmp .eaten

.not_on_food:
    ; Allow stepping into current tail cell (since tail moves this turn)
    mov ax, [snake_head_x]
    cmp ax, [snake_tail_x]
    jne .check_body
    mov ax, [snake_head_y]
    cmp ax, [snake_tail_y]
    je .shrink_and_continue

.check_body:
    ; Self-collision by reading screen char at new head
    mov dh, byte [snake_head_y]
    mov dl, byte [snake_head_x]
    call set_cursor
    xor bh, bh
    mov ah, 0x08
    int 0x10
    cmp al, 'o'
    je .snake_over
    cmp al, '@'
    je .snake_over

.shrink_and_continue:
    ; Save and erase current tail
    mov ax, [snake_tail_x]
    mov [old_tail_x], ax
    mov ax, [snake_tail_y]
    mov [old_tail_y], ax

    mov dh, byte [old_tail_y]
    mov dl, byte [old_tail_x]
    call set_cursor
    mov al, ' '
    call print_char

    ; Find new tail by scanning neighbors of old tail
    call find_new_tail

    ; Draw previous head as body 'o'
    mov ax, [snake_head_x]
    sub ax, [snake_dx]
    mov dl, al
    mov ax, [snake_head_y]
    sub ax, [snake_dy]
    mov dh, al
    call set_cursor
    mov al, 'o'
    call print_char

    ; Draw new head '@'
    mov dh, byte [snake_head_y]
    mov dl, byte [snake_head_x]
    call set_cursor
    mov al, '@'
    call print_char
    jmp .snake_loop

.eaten:
    ; Increase score/length and accelerate
    add word [game_score], 10
    inc word [snake_length]
    call update_speed

    ; Draw previous head as body 'o'
    mov ax, [snake_head_x]
    sub ax, [snake_dx]
    mov dl, al
    mov ax, [snake_head_y]
    sub ax, [snake_dy]
    mov dh, al
    call set_cursor
    mov al, 'o'
    call print_char

    ; Draw head '@'
    mov dh, byte [snake_head_y]
    mov dl, byte [snake_head_x]
    call set_cursor
    mov al, '@'
    call print_char

    ; Spawn new food at empty cell
    call spawn_food

    jmp .snake_loop
    
.snake_over:
    call clear_screen
    mov si, game_over_msg
    call print_string
    
    mov si, final_score_msg
    call print_string
    
    mov ax, [game_score]
    call print_number
    
    ; Update and show high scores
    call update_high_scores

    mov si, newline_str
    call print_string
    call print_string

    mov si, highs_header
    call print_string

    mov si, highs_1
    call print_string
    mov ax, [high_score_1]
    call print_number
    mov si, newline_str
    call print_string

    mov si, highs_2
    call print_string
    mov ax, [high_score_2]
    call print_number
    mov si, newline_str
    call print_string

    mov si, highs_3
    call print_string
    mov ax, [high_score_3]
    call print_number
    mov si, newline_str
    call print_string
    
    mov si, press_key_msg
    call print_string
    
    call read_char
    ret

draw_border:
    ; Top
    mov dh, 1
    mov dl, 1
    call set_cursor
    mov cx, 78
.border_top:
    mov al, '#'
    call print_char
    loop .border_top
    
    ; Bottom
    mov dh, 23
    mov dl, 1
    call set_cursor
    mov cx, 78
.border_bottom:
    mov al, '#'
    call print_char
    loop .border_bottom
    
    ; Sides
    mov cx, 21
    mov dh, 2
.border_sides:
    push cx
    mov dl, 1
    call set_cursor
    mov al, '#'
    call print_char
    
    mov dl, 78
    call set_cursor
    mov al, '#'
    call print_char
    
    inc dh
    pop cx
    loop .border_sides
    
    ret

; Chọn vị trí mồi ngẫu nhiên trong khung (2..77, 2..23)
; Lặp đến khi gặp ô trống ' ' để không đè lên thân/viền
spawn_food:
    ; Keep trying until an empty cell is found
.try_again:
    mov ah, 0x00
    int 0x1A
    
    mov ax, dx
    xor dx, dx
    mov bx, 73
    div bx
    add dx, 3
    mov [food_x], dx
    
    mov ah, 0x00
    int 0x1A
    mov ax, cx
    xor dx, dx
    mov bx, 19
    div bx
    add dx, 3
    mov [food_y], dx
    
    mov dh, byte [food_y]
    mov dl, byte [food_x]
    call set_cursor
    
    ; Read char at position and retry if not empty
    xor bh, bh
    mov ah, 0x08
    int 0x10
    cmp al, ' '
    jne .try_again
    
    mov ah, 0x09
    mov al, '$'
    mov bl, 0x0E
    mov cx, 1
    int 0x10
    
    ret

; Compute snake speed from score and base difficulty
; speed = max(1, snake_base_speed - (score/50))
; Tính lại tốc độ rắn (đơn vị: tick BIOS ~55ms)
; speed = max(1, snake_base_speed - (score/50))
update_speed:
    pusha
    mov ax, [game_score]
    xor dx, dx
    mov bx, 50
    div bx
    mov bx, [snake_base_speed]
    sub bx, ax
    cmp bx, 1
    jge .store
    mov bx, 1
.store:
    mov [snake_speed], bx
    popa
    ret

; Determine new tail by scanning neighbors of the just-erased tail
; Cập nhật đuôi: sau khi xóa ô đuôi cũ, tìm ô thân ('o' hoặc '@')
; lân cận (trái/phải/trên/dưới) để gán vị trí đuôi mới bám theo đường đi.
find_new_tail:
    pusha
    ; Left
    mov ax, [old_tail_x]
    dec ax
    mov dl, al
    mov dh, byte [old_tail_y]
    call set_cursor
    xor bh, bh
    mov ah, 0x08
    int 0x10
    cmp al, 'o'
    je .found_left
    cmp al, '@'
    je .found_left

    ; Right
    mov ax, [old_tail_x]
    inc ax
    mov dl, al
    mov dh, byte [old_tail_y]
    call set_cursor
    xor bh, bh
    mov ah, 0x08
    int 0x10
    cmp al, 'o'
    je .found_right
    cmp al, '@'
    je .found_right

    ; Up
    mov dl, byte [old_tail_x]
    mov ax, [old_tail_y]
    dec ax
    mov dh, al
    call set_cursor
    xor bh, bh
    mov ah, 0x08
    int 0x10
    cmp al, 'o'
    je .found_up
    cmp al, '@'
    je .found_up

    ; Down
    mov dl, byte [old_tail_x]
    mov ax, [old_tail_y]
    inc ax
    mov dh, al
    call set_cursor
    xor bh, bh
    mov ah, 0x08
    int 0x10
    cmp al, 'o'
    je .found_down
    cmp al, '@'
    je .found_down

    jmp .done_tail

.found_left:
    mov ax, [old_tail_x]
    dec ax
    mov [snake_tail_x], ax
    mov ax, [old_tail_y]
    mov [snake_tail_y], ax
    jmp .done_tail
.found_right:
    mov ax, [old_tail_x]
    inc ax
    mov [snake_tail_x], ax
    mov ax, [old_tail_y]
    mov [snake_tail_y], ax
    jmp .done_tail
.found_up:
    mov ax, [old_tail_x]
    mov [snake_tail_x], ax
    mov ax, [old_tail_y]
    dec ax
    mov [snake_tail_y], ax
    jmp .done_tail
.found_down:
    mov ax, [old_tail_x]
    mov [snake_tail_x], ax
    mov ax, [old_tail_y]
    inc ax
    mov [snake_tail_y], ax

.done_tail:
    popa
    ret

; Insert current score into high score table (top 3)
; Chèn điểm hiện tại vào bảng Top 3 (giảm dần)
; Dịch chuyển: h1->h2, h2->h3 khi cần; chỉ giữ 3 giá trị cao nhất.
update_high_scores:
    pusha
    mov ax, [game_score]
    cmp ax, [high_score_1]
    jl .check2
    mov bx, [high_score_2]
    mov [high_score_3], bx
    mov bx, [high_score_1]
    mov [high_score_2], bx
    mov [high_score_1], ax
    jmp .done
.check2:
    cmp ax, [high_score_2]
    jl .check3
    mov bx, [high_score_2]
    mov [high_score_3], bx
    mov [high_score_2], ax
    jmp .done
.check3:
    cmp ax, [high_score_3]
    jl .done
    mov [high_score_3], ax
.done:
    popa
    ret

print_number:
    pusha
    
    xor cx, cx
    mov bx, 10
.divide_num:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz .divide_num
    
.print_num:
    pop ax
    add al, '0'
    call print_char
    loop .print_num
    
    popa
    ret

; =====================================================
; TEXT EDITOR VỚI CHỨC NĂNG LƯU FILE
; =====================================================
text_editor:
    call clear_screen
    
    ; Hỏi tên file muốn tạo
    mov si, editor_filename_prompt
    mov bl, 0x0E
    call print_colored
    
    call read_line
    
    ; Kiểm tra xem file đã tồn tại chưa
    call find_file
    cmp ax, 0xFFFF
    je .file_not_exist
    
    ; File đã tồn tại - hỏi có muốn ghi đè không
    mov si, file_exists_msg
    mov bl, 0x0C      ; Màu đỏ cảnh báo
    call print_colored
    
    mov si, overwrite_prompt
    call print_string
    
    call read_char
    cmp al, 'y'
    je .file_not_exist
    cmp al, 'Y'
    je .file_not_exist
    
    ; Không ghi đè - quay lại menu
    ret
    
.file_not_exist:
    ; Sao chép tên file vào bộ nhớ
    mov si, input_buffer
    mov di, current_filename
    mov cx, 32
.copy_name:
    lodsb
    stosb
    test al, al
    jz .name_done
    loop .copy_name
.name_done:
    
    call clear_screen
    
    ; Clear buffer
    mov di, edit_buffer
    mov cx, 512
    xor al, al
    rep stosb
    
    ; Show header
    mov si, editor_header
    call print_string
    
    mov si, current_filename
    mov bl, 0x0A
    call print_colored
    
    mov si, editor_help
    call print_string
    
    ; Init position
    mov word [edit_pos], 0
    mov byte [edit_row], 4
    mov byte [edit_col], 0
    
    ; Set cursor
    mov dh, 4
    mov dl, 0
    call set_cursor
    
.editor_loop:
    call read_char
    
    ; ESC to save and exit
    cmp ah, 0x01
    je .editor_save
    
    ; Enter
    cmp al, 13
    je .editor_newline
    
    ; Backspace
    cmp al, 8
    je .editor_backspace
    
    ; Normal char
    cmp al, 32
    jl .editor_loop
    cmp al, 126
    jg .editor_loop
    
    ; Save char
    mov di, word [edit_pos]
    cmp di, 511
    jge .editor_loop
    
    mov byte [edit_buffer + di], al
    inc word [edit_pos]
    
    ; Print char
    call print_char
    
    ; Update col
    inc byte [edit_col]
    cmp byte [edit_col], 80
    jl .editor_loop
    
.editor_newline:
    ; Save newline
    mov di, word [edit_pos]
    cmp di, 510
    jge .editor_loop
    mov byte [edit_buffer + di], 13
    inc word [edit_pos]
    mov byte [edit_buffer + di + 1], 10
    inc word [edit_pos]
    
    mov byte [edit_col], 0
    inc byte [edit_row]
    
    cmp byte [edit_row], 24
    jge .editor_save
    
    mov dh, byte [edit_row]
    mov dl, 0
    call set_cursor
    
    jmp .editor_loop
    
.editor_backspace:
    cmp word [edit_pos], 0
    je .editor_loop
    
    dec word [edit_pos]
    
    cmp byte [edit_col], 0
    je .editor_back_newline
    
    dec byte [edit_col]
    mov dh, byte [edit_row]
    mov dl, byte [edit_col]
    call set_cursor
    mov al, ' '
    call print_char
    mov dl, byte [edit_col]
    call set_cursor
    
    jmp .editor_loop
    
.editor_back_newline:
    cmp byte [edit_row], 4
    je .editor_loop
    
    dec byte [edit_row]
    mov byte [edit_col], 79
    
    mov dh, byte [edit_row]
    mov dl, byte [edit_col]
    call set_cursor
    
    jmp .editor_loop
    
.editor_save:
    ; Save file to memory
    call save_file_to_memory
    
    ; Show save message
    call clear_screen
    mov si, file_saved_msg
    mov bl, 0x0A
    call print_colored
    
    mov si, current_filename
    call print_string
    
    mov si, newline_str
    call print_string
    call print_string
    
    mov si, press_any_key
    call print_string
    
    call read_char
    ret

; ===== SAVE FILE TO MEMORY =====
; =====================================================
; LƯU FILE VÀO BỘ NHỚ
; Tìm slot trống và lưu file vào đó
; =====================================================
save_file_to_memory:
    ; Tìm slot trống (tối đa 5 file)
    xor bx, bx          ; BX = index bắt đầu từ 0
    mov cx, 5           ; Duyệt qua 5 slot
.find_slot:
    ; Kiểm tra xem slot này có file chưa
    push bx
    mov ax, bx          ; AX = index
    mov dx, 32          ; Mỗi tên file = 32 bytes
    mul dx              ; AX = index * 32
    mov si, ax
    add si, file_list   ; SI trỏ đến tên file
    mov al, [si]        ; Lấy ký tự đầu tiên
    pop bx
    
    test al, al         ; Kiểm tra ký tự đầu = 0?
    jz .found_slot      ; Nếu = 0 thì slot trống
    
    inc bx              ; Tăng index
    loop .find_slot     ; Tiếp tục tìm
    
    ; Không còn slot trống
    mov si, no_space_msg
    mov bl, 0x0C        ; Màu đỏ
    call print_colored
    
    mov si, press_any_key
    call print_string
    call read_char
    ret
    
.found_slot:
    ; Lưu tên file vào slot đã tìm được
    push bx
    mov ax, bx
    mov dx, 32
    mul dx
    mov di, ax
    add di, file_list
    
    mov si, current_filename
    mov cx, 32
.copy_filename:
    lodsb
    stosb
    test al, al
    jz .filename_copied
    loop .copy_filename
    
.filename_copied:
    pop bx
    
    ; Lưu nội dung file (512 bytes)
    mov ax, bx
    mov dx, 512
    mul dx              ; AX = index * 512
    mov di, ax
    add di, file_data   ; DI trỏ đến vị trí lưu data
    
    mov si, edit_buffer
    mov cx, 512
.copy_content:
    lodsb
    stosb
    loop .copy_content
    
    ret

; =====================================================
; FILE MANAGER - QUẢN LÝ FILE
; =====================================================
; Mở File Manager dạng văn bản: liệt kê, xóa file (RAM FS tạm thời)
run_file_manager:
    call file_manager
    call init_gui
    jmp gui_main_loop

; File Manager: giao diện dòng lệnh đơn giản
; - list: liệt kê, delete: xóa, exit: thoát
file_manager:
    call clear_screen
    
    ; Tiêu đề File Manager
    mov si, fm_header
    mov bl, 0x0E
    call print_colored
    
    ; Hiển thị ngay danh sách file hiện có
    call list_files
    
    ; Hướng dẫn sử dụng
    mov si, fm_help
    call print_string
    
.fm_loop:
    mov si, fm_prompt
    mov bl, 0x0A
    call print_colored
    
    call read_line
    
    ; Kiểm tra các lệnh
    mov si, input_buffer
    mov di, fm_cmd_list
    call strcmp
    test ax, ax
    jz .fm_list
    
    mov si, input_buffer
    mov di, fm_cmd_delete
    call strcmp
    test ax, ax
    jz .fm_delete
    
    mov si, input_buffer
    mov di, term_cmd_exit
    call strcmp
    test ax, ax
    jz .fm_exit
    
    ; Lệnh không hợp lệ
    mov si, term_unknown
    call print_string
    jmp .fm_loop
    
.fm_list:
    call list_files
    jmp .fm_loop
    
.fm_delete:
    mov si, fm_delete_prompt
    call print_string
    call read_line
    call delete_file
    jmp .fm_loop
    
.fm_exit:
    ret

; =====================================================
; LIỆT KÊ TẤT CẢ FILE TRONG HỆ THỐNG
; =====================================================
list_files:
    mov si, fm_list_header
    mov bl, 0x0B        ; Màu cyan
    call print_colored
    
    xor bx, bx          ; BX = 0 (index)
    mov cx, 5           ; Duyệt qua 5 slot
    xor dx, dx          ; DX = số file đã tìm thấy
    
.list_loop:
    push cx
    push bx
    
    ; Tính địa chỉ tên file
    mov ax, bx
    mov cx, 32          ; Mỗi tên file = 32 bytes
    mul cx
    mov si, ax
    add si, file_list
    
    ; Kiểm tra xem có file không
    mov al, [si]
    test al, al
    jz .next_file       ; Nếu rỗng thì bỏ qua
    
    ; Có file - in ra màn hình
    inc dx              ; Tăng số file
    
    ; In số thứ tự
    mov al, ' '
    call print_char
    mov al, ' '
    call print_char
    
    ; In số thứ tự file
    mov ax, dx
    add al, '0'
    call print_char
    
    mov al, '.'
    call print_char
    mov al, ' '
    call print_char
    
    ; In tên file
    call print_string
    
    ; Xuống dòng
    mov si, newline_str
    call print_string
    
.next_file:
    pop bx
    pop cx
    inc bx
    loop .list_loop
    
    ; Kiểm tra nếu không có file nào
    test dx, dx
    jnz .has_files
    
    mov si, no_files_msg
    mov bl, 0x0E        ; Màu vàng
    call print_colored
    
.has_files:
    mov si, newline_str
    call print_string
    ret

; ===== DELETE FILE =====
delete_file:
    ; Search for file
    xor bx, bx
    mov cx, 5
.search_loop:
    push cx
    push bx
    
    mov ax, bx
    mov dx, 32
    mul dx
    mov di, ax
    add di, file_list
    
    mov si, input_buffer
    call strcmp
    test ax, ax
    jz .file_found
    
    pop bx
    pop cx
    inc bx
    loop .search_loop
    
    ; File not found
    mov si, fm_not_found
    call print_string
    ret
    
.file_found:
    pop bx
    pop cx
    
    ; Clear filename
    mov ax, bx
    mov dx, 32
    mul dx
    mov di, ax
    add di, file_list
    
    xor al, al
    mov cx, 32
    rep stosb
    
    ; Clear content
    mov ax, bx
    mov dx, 512
    mul dx
    mov di, ax
    add di, file_data
    
    xor al, al
    mov cx, 512
    rep stosb
    
    mov si, fm_deleted
    mov bl, 0x0A
    call print_colored
    ret

; ===== DATA SECTION =====

; Boot screen
logo_line1:     db '   ###   ###  ####  ##   ##  ####     #####   #####  ', 0
logo_line2:     db '   ## # # ##   ##   ###  ##   ##      ##   ## ##      ', 0
logo_line3:     db '   ## ### ##   ##   ## # ##   ##      ##   ##  ####   ', 0
logo_line4:     db '   ##     ##   ##   ##  ###   ##      ##   ##     ##  ', 0
logo_line5:     db '   ##     ##  ####  ##   ##  ####     #####   #####   ', 0

system_name:    db 'MINI OS v2.0', 0
system_version: db 'GUI Edition Pro', 0
loading_text:   db 'Initializing System...', 0
boot_done:      db 'System Ready!', 0

menu_title:     db 'MAIN MENU', 0
menu_1:         db '  Play Snake Game', 0
menu_2:         db '  Text Editor', 0
menu_3:         db '  File Manager', 0
menu_4:         db '  Terminal', 0
menu_5:         db '  Calculator', 0
menu_6:         db '  Clock & Date', 0
menu_7:         db '  About System', 0
menu_8:         db '  Reboot', 0

clock_label:    db 'TIME:', 0
date_label:     db 'DATE:', 0

status_msg:     db 'F1=Font | UP/DOWN=Nav | ENTER=Select | Q=Quit', 0

time_header:    db 'CURRENT TIME', 0
date_header:    db 'CURRENT DATE', 0

about_header:   db '=== ABOUT MINI OS v2.0 ===', 0
about_1:        db 'Mini Operating System - Educational Project', 0
about_2:        db '', 0
about_3:        db 'A 16-bit operating system written in x86 Assembly', 0
about_4:        db 'Features: GUI Menu, Snake Game, Text Editor,', 0
about_5:        db 'Terminal, Calculator, Real-Time Clock', 0

settings_header: db '=== SETTINGS ===', 0
settings_1:     db 'Display Mode: VGA Text Mode 80x25', 0
settings_2:     db 'Boot Mode: BIOS Legacy', 0

press_any_key:  db 'Press any key to continue...', 0

; Snake difficulty
difficulty_title: db '=== SELECT DIFFICULTY ===', 0
diff_easy:      db '1. Easy   (Slow)', 0
diff_normal:    db '2. Normal (Medium)', 0
diff_hard:      db '3. Hard   (Fast)', 0
diff_choice:    db 0

; Terminal - Dòng lệnh
terminal_header: db '=== DONG LENH MINI OS ===', 13, 10, 0
terminal_help:   db 'Go "help" de xem cac lenh hoac "exit" de thoat', 13, 10, 10, 0
term_prompt:     db '> ', 0
term_cmd_help:   db 'help', 0
term_cmd_clear:  db 'clear', 0
term_cmd_ipconfig: db 'ipconfig', 0
term_cmd_cat:    db 'cat', 0
term_cmd_ver:    db 'ver', 0
term_cmd_exit:   db 'exit', 0
term_unknown:    db 17, ' Lenh khong hop le. Go "help"', 13, 10, 0
term_help_text:  db 7, ' Cac lenh: help, clear, cat, ipconfig, ver, exit', 13, 10, 0
term_cat_prompt: db 'Ten file: ', 0
term_ip_header:  db 13, 10, 7, ' Thong tin mang:', 13, 10, 0
term_ip_info:    db '  ', 254, ' Giao dien: eth0', 13, 10
                 db '  ', 254, ' Dia chi IP: 192.168.1.100', 13, 10
                 db '  ', 254, ' Subnet Mask: 255.255.255.0', 13, 10
                 db '  ', 254, ' Gateway: 192.168.1.1', 13, 10
                 db '  ', 254, ' Dia chi MAC: 00:11:22:33:44:55', 13, 10, 0
term_ver_info:   db 13, 10, 254, ' Mini OS Phien ban 2.0 Build 2025', 13, 10
                 db 254, ' Ban quyen (C) 2025 Mini OS Project', 13, 10, 0

; Calculator - Máy tính
calc_header:     db '=== MAY TINH ===', 13, 10, 0
calc_help:       db 'Nhap phep tinh (+, -, *, /)', 13, 10
                 db 'Ho tro so am va chia co du', 13, 10
                 db 'Go "exit" de thoat', 13, 10, 10, 0
calc_prompt:     db 'So: ', 0
calc_op_prompt:  db 'Phep toan (+,-,*,/): ', 0
calc_result:     db 7, ' Ket qua: ', 0
calc_remainder:  db ' (Du: ', 0
calc_error:      db 17, ' Phep toan khong hop le!', 13, 10, 0
calc_div_error:  db 17, ' Loi: Chia cho 0!', 13, 10, 0
calc_num1:       dw 0
calc_num2:       dw 0
calc_operator:   db 0
temp_num:        dw 0

input_buffer:    times 80 db 0

current_selection: db 0

; Snake game data
score_msg:      db 'Score: ', 0
snake_help:     db 'Arrows/WASD=Move, ESC=Exit', 0
game_over_msg:  db 10, 10, '    =========================', 13, 10
                db '        GAME OVER!', 13, 10
                db '    =========================', 13, 10, 10, 0
final_score_msg: db '    Final Score: ', 0
press_key_msg:  db 10, 10, '    Press any key to continue...', 0
newline_str:    db 13, 10, 0
highs_header:   db '    High Scores:', 13, 10, 0
highs_1:        db '     1) ', 0
highs_2:        db '     2) ', 0
highs_3:        db '     3) ', 0

snake_head_x:   dw 39
snake_head_y:   dw 12
snake_tail_x:   dw 36
snake_tail_y:   dw 12
old_tail_x:     dw 0
old_tail_y:     dw 0
snake_dx:       dw 1
snake_dy:       dw 0
snake_length:   dw 4
snake_speed:    dw 3
snake_base_speed: dw 3
food_x:         dw 20
food_y:         dw 10
game_score:     dw 0
game_ticks:     dw 0
last_tick_lo:   dw 0
last_tick_hi:   dw 0
high_score_1:   dw 0
high_score_2:   dw 0
high_score_3:   dw 0

; Editor data - Dữ liệu trình soạn thảo
editor_header:  db 'TRINH SOAN THAO - ', 0
editor_filename_prompt: db 'Nhap ten file: ', 0
editor_help:    db 13, 10, 'Nhan ESC de luu va thoat (Toi da 512 ky tu)', 13, 10, 13, 10, 0
file_saved_msg: db 13, 10, 13, 10, 7, ' Da luu file: ', 0
file_exists_msg: db 13, 10, 17, ' CANH BAO: File da ton tai!', 13, 10, 0
overwrite_prompt: db 'Ban co muon ghi de? (y/n): ', 0
no_space_msg:   db 13, 10, 17, ' Loi: Khong con cho trong! (Toi da 5 file)', 13, 10, 0
current_filename: times 32 db 0

edit_buffer:    times 512 db 0
edit_pos:       dw 0
edit_row:       db 4
edit_col:       db 0

; File Manager data - Dữ liệu quản lý file
fm_header:      db '=== QUAN LY FILE ===', 13, 10, 0
fm_help:        db 'Lenh: list (xem file), delete (xoa), exit (thoat)', 13, 10, 13, 10, 0
fm_prompt:      db 'FM> ', 0
fm_cmd_list:    db 'list', 0
fm_cmd_delete:  db 'delete', 0
fm_list_header: db 13, 10, 7, ' Danh sach file:', 13, 10, 0
fm_delete_prompt: db 'Ten file can xoa: ', 0
fm_not_found:   db 17, ' Khong tim thay file!', 13, 10, 0
fm_deleted:     db 7, ' Da xoa file!', 13, 10, 0
no_files_msg:   db '  (Chua co file nao)', 13, 10, 0

; File storage (5 files max, 32 bytes name + 512 bytes content each)
file_list:      times 160 db 0    ; 5 files * 32 bytes for names
file_data:      times 2560 db 0   ; 5 files * 512 bytes for content

; =====================================================
; INCLUDE PIXEL FONT 8x8 - NOW ENABLED (32KB KERNEL)
; =====================================================
%include "kernel/pixel_font.asm"

; Pad kernel to new size: 32KB
times 32768-($-$$) db 0
