; =====================================================
; ỨNG DỤNG THÔNG TIN
; =====================================================
; Màn hình hiển thị thông tin hệ thống và team
; =====================================================

run_about:
    call clear_screen              ; Xóa màn hình
    call draw_header              ; Vẽ header "THÔNG TIN"
    
    ; In tiêu đề "MINI OS v4.0" ở giữa màn hình
    mov dh, 4                     ; Dòng 4
    mov dl, 28                    ; Cột 28 (gần giữa)
    call set_cursor
    mov si, about_title           ; SI = chuỗi tiêu đề
    mov bl, 0x0E                  ; Màu vàng
    call print_colored
    
    ; Dòng 1: Version info
    mov dh, 7
    mov dl, 15
    call set_cursor
    mov si, about_line1           ; "MiniOS v4.0 - Hệ điều hành..."
    mov bl, 0x0B                  ; Màu cyan
    call print_colored
    
    ; Dòng 2: Architecture
    mov dh, 9
    mov dl, 15
    call set_cursor
    mov si, about_line2           ; "16-bit Real Mode..."
    call print_string
    
    ; Dòng 3: Features
    mov dh, 10
    mov dl, 15
    call set_cursor
    mov si, about_line3           ; "7 ứng dụng tích hợp"
    call print_string
    
    ; Dòng 4: Memory info
    mov dh, 12
    mov dl, 15
    call set_cursor
    mov si, about_line4           ; "Bootloader: 512 bytes..."
    call print_string
    
    ; Dòng 5: Build info
    mov dh, 14
    mov dl, 15
    call set_cursor
    mov si, about_line5           ; "Build: NASM..."
    call print_string
    
    ; Dòng 6: Team title
    mov dh, 16
    mov dl, 15
    call set_cursor
    mov si, about_line6           ; "Nhóm 15 - HDH 2025"
    mov bl, 0x0E                  ; Màu vàng
    call print_colored
    
    ; Dòng 7: Team leader
    mov dh, 17
    mov dl, 15
    call set_cursor
    mov si, about_line7           ; "Nhóm trưởng: Hoàng Tiến Đạt"
    call print_string
    
    ; Dòng 8: Team members
    mov dh, 19
    mov dl, 15
    call set_cursor
    mov si, about_line8           ; "Thành viên: Khoa, Mạnh, Kiệt, Chiến"
    call print_string
    
    ; In "Nhấn phím bất kỳ để tiếp tục..."
    mov dh, 22
    mov dl, 25
    call set_cursor
    mov si, press_any_key
    call print_string
    
    call read_char               ; Đợi người dùng nhấn phím
    jmp main_menu               ; Quay về menu chính

