; =====================================================
; DATA SECTION
; =====================================================
; Tất cả strings và variables
; =====================================================

; Boot screen
logo_line1:      db "     ___      ___   ___   ___   _   ___    ___ ", 0
logo_line2:      db "    |  _\/  \  |  _|   _| | | / _ \  / __| ", 0
logo_line3:      db "    | | | | | | | | | | | | | | (_) | \__ \ ", 0
logo_line4:      db "    |_| |_| |_|_| |_| |_| |_|  \___/  |___/ ", 0
logo_line5:      db "                                                      ", 0
boot_version:    db "                    Phien ban 4.0                     ", 0
boot_team:       db "                Phat trien boi Nhom 15                     ", 0
boot_members:    db "        HDH - He Dieu Hanh - Operating System            ", 0
boot_msg:        db "           Dang tai cac thanh phan he thong...        ", 0
boot_progress:   db "[                    ]", 0

; Header
header_line:     db "                                     MINI OS v4.0 - NHOM 15                                ", 0
header_title:    db "MINI OS v4.0", 0

; Main menu
menu_title:      db "=== MENU CHINH ===", 0
menu_item1:      db "1. Terminal", 0
menu_item2:      db "2. Dong Ho & Lich", 0
menu_item3:      db "3. File Editor", 0
menu_item4:      db "4. Tic Tac Toe", 0
menu_item5:      db "5. Calculator (Phuong Trinh Bac 2)", 0
menu_item6:      db "6. Thong Tin", 0
menu_item7:      db "7. Khoi Dong Lai", 0

; Terminal strings
term_welcome:    db "Chao mung den voi MiniOS Terminal!", 0
term_help:       db "Nhap 'help' de xem cac lenh kha dung", 0
term_prompt:     db "$ ", 0
term_unknown:    db "Lenh khong hop le. Nhap 'help' de xem danh sach.", 0
term_help_text:  db "Cac lenh: help, clear, time, date, ver, exit", 0
cmd_help:        db "help", 0
cmd_clear:       db "clear", 0
cmd_time:        db "time", 0
cmd_date:        db "date", 0
cmd_ver:         db "ver", 0
cmd_exit:        db "exit", 0
version_text:    db "MiniOS v4.0 - He dieu hanh x86 Assembly modular", 0

; Clock strings
clock_title:     db "=== DONG HO & LICH ===", 0
clock_help:      db "Nhan ESC de quay lai menu", 0
time_label:      db "Gio:  ", 0
date_label:      db "Ngay: ", 0
day_label:       db "Thu:  ", 0
days_of_week:    db "Chu Nhat ", "Thu Hai  ", "Thu Ba   ", "Thu Tu   ", "Thu Nam  ", "Thu Sau  ", "Thu Bay  ", 0

; File Editor strings
editor_title:            db "=== FILE EDITOR ===", 0
editor_menu1:            db "1. Tao File Moi", 0
editor_menu2:            db "2. Xem & Chinh Sua File", 0
editor_menu3:            db "3. Thoat", 0
editor_prompt:           db "Chon tuy chon: ", 0
editor_create_msg:       db "Nhap ten file: ", 0
editor_file_created:     db "Tao file thanh cong!", 0
editor_file_list_title:  db "=== DANH SACH FILE ===", 0
editor_no_files:         db "Chua co file nao. Tao file moi!", 0
editor_select_file_msg:  db "Nhap ten file can chinh sua: ", 0
editor_file_not_found:   db "Khong tim thay file!", 0
editor_list_full:        db "Danh sach day! (Toi da 5 file)", 0
editor_editing_msg:      db "=== DANG CHINH SUA FILE ===", 0
editor_filename_label:   db "Ten file: ", 0
editor_current_content_label: db "Noi dung hien tai: ", 0
editor_new_content_msg:  db "Noi dung moi (Enter de giu nguyen): ", 0
editor_saved_msg:        db "Luu file thanh cong!", 0

; Game strings
game_title:      db "=== TIC TAC TOE ===", 0
game_help1:      db "Huong dan: Nhan 1-9 de danh dau | ESC de thoat", 0
game_help2:      db "Xep 3 o lien tiep (ngang, doc, cheo) de thang!", 0
game_help3:      db "Nguoi choi X di truoc. Chuc may man!", 0
game_player_msg: db "Nguoi choi hien tai: ", 0
game_move_msg:   db "Nhap vi tri (1-9) hoac ESC: ", 0
game_winner_msg: db "Nguoi thang: ", 0
game_wins:       db " chien thang!", 0
game_draw_msg:   db "Hoa!", 0
game_board_line1: db "+---+---+---+", 0
game_board_line2: db "+---+---+---+", 0
game_board_line3: db "+---+---+---+", 0
game_board_line4: db "+---+---+---+", 0
game_numbers:    db "1 2 3  |  4 5 6  |  7 8 9", 0

; About strings
about_title:     db "=== THONG TIN HE THONG ===", 0
about_line1:     db "MINI OS v4.0 - He dieu hanh modular", 0
about_line2:     db "Xay dung bang x86 Assembly (NASM)", 0
about_line3:     db "16-bit Real Mode | Kien truc modular", 0
about_line4:     db "Tinh nang: Terminal, Clock, Editor, Game, Calculator", 0
about_line5:     db "Phat trien boi Nhom 15 - Mon HDH", 0
about_line6:     db "Nhom truong: Hoang Tien Dat", 0
about_line7:     db "Thanh vien: Khoa, Manh, Kiet, Chien", 0
about_line8:     db "Bo nho: Real Mode 1MB | Text Mode 80x25", 0

; Calculator strings
calc_title:         db "=== GIAI PHUONG TRINH BAC 2 ===", 0
calc_equation:      db "ax^2 + bx + c = 0", 0
calc_input_a:       db "a = ", 0
calc_input_b:       db "b = ", 0
calc_input_c:       db "c = ", 0
calc_delta_label:   db "Delta = ", 0
calc_x_label:       db "x = ", 0
calc_x1_label:      db "x1 = ", 0
calc_x2_label:      db "x2 = ", 0
calc_two_roots:     db "Hai nghiem phan biet:", 0
calc_one_root:      db "Nghiem kep:", 0
calc_no_real:       db "Vo nghiem thuc (Nghiem phuc)", 0
calc_complex_note:  db "Delta < 0: Nghiem la so phuc", 0
calc_error_a:       db "LOI: He so 'a' phai khac 0!", 0
calc_solve_again:   db "Giai phuong trinh khac? (Y/N): ", 0
calc_x1_formula:    db "(-b + sqrt(delta)) / 2a", 0
calc_x2_formula:    db "(-b - sqrt(delta)) / 2a", 0
calc_frame_top:     db "+====================================+", 0
calc_frame_mid:     db "|                                    |", 0
calc_frame_div:     db "+------------------------------------+", 0
calc_frame_bot:     db "+====================================+", 0
calc_result_frame:  db "+-------- KET QUA --------+", 0

; Reboot strings
reboot_msg:      db "Dang khoi dong lai he thong...", 0

; Common strings
press_any_key:   db "Nhan phim bat ky de tiep tuc...", 0

; Variables
menu_selection:      db 0
current_line:        db 0
current_player:      db 'X'
game_over:           db 0
file_count:          db 0
selected_file_index: dw 0

; Calculator variables
calc_a:              dw 0
calc_b:              dw 0
calc_c:              dw 0
calc_delta:          dw 0
calc_b_squared:      dw 0
calc_4ac:            dw 0
calc_sqrt_delta:     dw 0

; Buffers
input_buffer:        times 80 db 0
time_buffer:         times 10 db 0
date_buffer:         times 12 db 0
day_buffer:          times 10 db 0
game_board:          times 9 db ' '

; File storage (5 files max)
; Each file: 80 bytes filename + 256 bytes content = 336 bytes
; Total: 5 × 336 = 1680 bytes
file_storage:        times 1680 db 0
