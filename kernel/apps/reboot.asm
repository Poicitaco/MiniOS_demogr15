; =====================================================
; ỨNG DỤNG KHỞI ĐỘNG LẠI
; =====================================================
; Chức năng khởi động lại hệ thống
; =====================================================

run_reboot:
    call clear_screen              ; Xóa màn hình
    
    ; In thông báo "Đang khởi động lại..." ở giữa màn hình
    mov dh, 10                     ; Dòng 10 (giữa màn hình)
    mov dl, 25                     ; Cột 25
    call set_cursor
    mov si, reboot_msg             ; SI = "Đang khởi động lại..."
    mov bl, 0x0C                   ; Màu đỏ nhạt
    call print_colored
    
    ; Đợi một chút trước khi reboot (để người dùng thấy thông báo)
    mov cx, 0x10                   ; CX:DX = số microseconds
    mov dx, 0x0000
    mov ah, 0x86                   ; Chức năng 86h: Wait
    int 0x15                       ; BIOS interrupt 15h
    
    ; Khởi động lại bằng BIOS interrupt
    int 0x19                       ; INT 19h: Bootstrap loader
    
    ; Nếu INT 19h không hoạt động, nhảy đến địa chỉ reset của BIOS
    ; Đây là cách thứ 2 để reboot (jump đến BIOS reset vector)
    jmp 0xFFFF:0x0000              ; Far jump đến BIOS ROM

