; =====================================================
; ỨNG DỤNG TERMINAL
; =====================================================
; Giao diện dòng lệnh tương tác đơn giản
; =====================================================

run_terminal:
    call clear_screen           ; Xóa màn hình trước khi bắt đầu
    call draw_header           ; Vẽ header "TERMINAL" ở đầu màn hình
    
    ; Đặt con trỏ tại vị trí dòng 2, cột 2
    mov dh, 2                  ; dh = số dòng (row)
    mov dl, 2                  ; dl = số cột (column)
    call set_cursor            ; Gọi hàm đặt vị trí con trỏ
    
    ; In thông báo chào mừng với màu xanh dương nhạt (0x0B)
    mov si, term_welcome       ; si trỏ đến chuỗi chào mừng
    mov bl, 0x0B              ; bl = màu chữ (cyan)
    call print_colored         ; In chuỗi có màu
    
    ; Đặt con trỏ dòng 3, cột 2 để in hướng dẫn
    mov dh, 3
    mov dl, 2
    call set_cursor
    mov si, term_help          ; si trỏ đến chuỗi hướng dẫn
    call print_string          ; In chuỗi thông thường
    
    mov byte [current_line], 5 ; Bắt đầu nhập lệnh từ dòng 5

.term_loop:
    ; In dấu nhắc lệnh (prompt) "$ "
    mov dh, [current_line]     ; Lấy số dòng hiện tại từ biến
    mov dl, 2                  ; Cột 2
    call set_cursor
    mov si, term_prompt        ; si = "$ "
    mov bl, 0x0E              ; Màu vàng cho prompt
    call print_colored
    
    ; Đọc lệnh từ bàn phím
    call read_line            ; Đọc input vào input_buffer
    
    ; Tăng số dòng lên 1 cho lần nhập tiếp theo
    inc byte [current_line]
    
    ; Kiểm tra lệnh người dùng nhập vào
    ; So sánh với lệnh "help"
    mov si, input_buffer      ; si = lệnh vừa nhập
    mov di, cmd_help          ; di = chuỗi "help"
    call strcmp               ; So sánh 2 chuỗi, ax=0 nếu giống
    test ax, ax               ; Kiểm tra kết quả
    jz .show_help            ; Nhảy nếu ax=0 (lệnh là "help")
    
    ; So sánh với lệnh "clear"
    mov si, input_buffer
    mov di, cmd_clear
    call strcmp
    test ax, ax               ; Kiểm tra kết quả so sánh
    jz .clear_term           ; Nhảy nếu lệnh là "clear"
    
    ; So sánh với lệnh "time"
    mov si, input_buffer
    mov di, cmd_time
    call strcmp
    test ax, ax
    jz .show_time            ; Nhảy nếu lệnh là "time"
    
    ; So sánh với lệnh "date"
    mov si, input_buffer
    mov di, cmd_date
    call strcmp
    test ax, ax
    jz .show_date            ; Nhảy nếu lệnh là "date"
    
    ; So sánh với lệnh "ver"
    mov si, input_buffer
    mov di, cmd_ver
    call strcmp
    test ax, ax
    jz .show_version         ; Nhảy nếu lệnh là "ver"
    
    ; So sánh với lệnh "exit"
    mov si, input_buffer
    mov di, cmd_exit
    call strcmp
    test ax, ax
    jz .exit_term           ; Nhảy nếu lệnh là "exit"
    
    ; Lệnh không hợp lệ - hiển thị thông báo lỗi
    mov dh, [current_line]   ; Lấy dòng hiện tại
    mov dl, 2                ; Cột 2
    call set_cursor
    mov si, term_unknown     ; "Lệnh không tồn tại"
    call print_string
    inc byte [current_line]  ; Tăng dòng
    
    ; Kiểm tra xem màn hình đã đầy chưa (dòng 24)
    cmp byte [current_line], 24  ; So sánh với dòng cuối
    jl .term_loop               ; Nếu < 24 thì tiếp tục
    
    ; Màn hình đầy - xóa và bắt đầu lại từ dòng 5
    mov byte [current_line], 5
    call clear_screen
    call draw_header
    jmp .term_loop

.show_help:
    ; Hiển thị danh sách lệnh
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, term_help_text   ; Chuỗi help
    call print_string
    inc byte [current_line]
    jmp .term_loop          ; Quay lại vòng lặp chính

.clear_term:
    ; Xóa màn hình terminal
    call clear_screen
    call draw_header
    mov byte [current_line], 5  ; Reset về dòng 5
    jmp .term_loop

.show_time:
    ; Hiển thị giờ hiện tại
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, time_label      ; In "Giờ: "
    call print_string
    call get_time_string    ; Lấy giờ từ BIOS vào time_buffer
    mov si, time_buffer     ; In giờ (HH:MM:SS)
    call print_string
    inc byte [current_line]
    jmp .term_loop

.show_date:
    ; Hiển thị ngày hiện tại
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, date_label      ; In "Ngày: "
    call print_string
    call get_date_string    ; Lấy ngày từ BIOS vào date_buffer
    mov si, date_buffer     ; In ngày (DD/MM/YYYY)
    call print_string
    inc byte [current_line]
    jmp .term_loop

.show_version:
    ; Hiển thị phiên bản hệ thống
    mov dh, [current_line]
    mov dl, 2
    call set_cursor
    mov si, version_text    ; "MiniOS v4.0..."
    call print_string
    inc byte [current_line]
    jmp .term_loop

.exit_term:
    ; Thoát terminal, quay về menu chính
    jmp main_menu

