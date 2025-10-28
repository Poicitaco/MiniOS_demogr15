; =====================================================
; TIỆN ÍCH SCREEN (MÀN HÌNH)
; =====================================================
; Các hàm xử lý màn hình: xóa, di chuyển con trỏ, in chữ
; =====================================================

clear_screen:
    ; Xóa toàn bộ màn hình
    ; Sử dụng: INT 10h, AH=00h (Set video mode)
    mov ah, 0x00            ; Chức năng 00h: đặt chế độ video
    mov al, 0x03            ; Chế độ 03h: Text mode 80x25
    int 0x10               ; Gọi BIOS interrupt 10h (Video)
    ret                    ; Quay về

set_cursor:
    ; Đặt vị trí con trỏ
    ; Input: DH = số dòng (row), DL = số cột (column)
    ; Ví dụ: DH=5, DL=10 nghĩa là dòng 5, cột 10
    mov ah, 0x02           ; Chức năng 02h: Set cursor position
    mov bh, 0x00           ; BH = page number (trang 0)
    int 0x10              ; Gọi BIOS
    ret

print_string:
    ; In chuỗi ký tự
    ; Input: SI = con trỏ trỏ đến chuỗi (kết thúc bằng byte 0)
    ; Ví dụ: mov si, my_string / call print_string
    pusha                 ; Lưu tất cả thanh ghi (push all)
.loop:
    lodsb                ; Load byte từ [SI] vào AL, tăng SI
    cmp al, 0            ; So sánh với 0 (kết thúc chuỗi)
    je .done             ; Nếu = 0 thì kết thúc
    call print_char      ; In ký tự trong AL
    jmp .loop           ; Lặp lại
.done:
    popa                ; Khôi phục thanh ghi (pop all)
    ret

print_char:
    ; In 1 ký tự
    ; Input: AL = ký tự cần in
    mov ah, 0x0E        ; Chức năng 0Eh: Teletype output
    mov bh, 0x00        ; Page 0
    int 0x10           ; Gọi BIOS - in ký tự trong AL
    ret

print_colored:
    ; In chuỗi có màu
    ; Input: SI = chuỗi, BL = mã màu
    ; Mã màu: 0x07=gray, 0x0E=yellow, 0x0C=red, 0x0A=green
    pusha
.loop:
    lodsb               ; Lấy ký tự từ SI
    cmp al, 0           ; Kiểm tra kết thúc chuỗi
    je .done
    
    ; In ký tự với màu
    mov ah, 0x09        ; Chức năng 09h: Write char with attribute
    mov bh, 0x00        ; Page 0
    mov cx, 1           ; CX = số lần lặp (1 ký tự)
    int 0x10
    
    ; Lấy vị trí con trỏ hiện tại
    mov ah, 0x03        ; Chức năng 03h: Get cursor position
    mov bh, 0x00
    int 0x10            ; Kết quả: DH=row, DL=column
    
    ; Di chuyển con trỏ sang phải 1 cột
    inc dl              ; Tăng cột
    mov ah, 0x02        ; Set cursor position
    int 0x10
    jmp .loop
.done:
    popa
    ret
