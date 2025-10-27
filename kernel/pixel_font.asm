; =====================================================
; PIXEL FONT 8x8 - FONT CHỮ PIXEL ĐẦY ĐỦ
; =====================================================
; Font bitmap 8x8 cho tất cả ký tự ASCII từ 32-126
; Mỗi ký tự = 8 bytes (8 hàng x 8 pixel)
; Bit 1 = pixel sáng, Bit 0 = pixel tối
; =====================================================

[BITS 16]

; =====================================================
; BẢNG FONT 8x8 - ASCII 32-126 (95 ký tự)
; =====================================================
pixel_font_8x8:

; ASCII 32 - Space (Khoảng trắng)
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000

; ASCII 33 - ! (Chấm than)
db 0b00011000
db 0b00111100
db 0b00111100
db 0b00011000
db 0b00011000
db 0b00000000
db 0b00011000
db 0b00000000

; ASCII 34 - " (Ngoặc kép)
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000

; ASCII 35 - # (Dấu thăng)
db 0b01100110
db 0b01100110
db 0b11111111
db 0b01100110
db 0b11111111
db 0b01100110
db 0b01100110
db 0b00000000

; ASCII 36 - $ (Ký hiệu đô la)
db 0b00011000
db 0b00111110
db 0b01100000
db 0b00111100
db 0b00000110
db 0b01111100
db 0b00011000
db 0b00000000

; ASCII 37 - % (Phần trăm)
db 0b01100010
db 0b01100110
db 0b00001100
db 0b00011000
db 0b00110000
db 0b01100110
db 0b01000110
db 0b00000000

; ASCII 38 - & (Và)
db 0b00111100
db 0b01100110
db 0b00111100
db 0b00111000
db 0b01100111
db 0b01100110
db 0b00111111
db 0b00000000

; ASCII 39 - ' (Dấu nháy đơn)
db 0b00000110
db 0b00001100
db 0b00011000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000

; ASCII 40 - ( (Ngoặc mở)
db 0b00001100
db 0b00011000
db 0b00110000
db 0b00110000
db 0b00110000
db 0b00011000
db 0b00001100
db 0b00000000

; ASCII 41 - ) (Ngoặc đóng)
db 0b00110000
db 0b00011000
db 0b00001100
db 0b00001100
db 0b00001100
db 0b00011000
db 0b00110000
db 0b00000000

; ASCII 42 - * (Dấu sao)
db 0b00000000
db 0b01100110
db 0b00111100
db 0b11111111
db 0b00111100
db 0b01100110
db 0b00000000
db 0b00000000

; ASCII 43 - + (Cộng)
db 0b00000000
db 0b00011000
db 0b00011000
db 0b01111110
db 0b00011000
db 0b00011000
db 0b00000000
db 0b00000000

; ASCII 44 - , (Phấy)
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00011000
db 0b00011000
db 0b00110000

; ASCII 45 - - (Trừ/Gạch ngang)
db 0b00000000
db 0b00000000
db 0b00000000
db 0b01111110
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000

; ASCII 46 - . (Chấm)
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00011000
db 0b00011000
db 0b00000000

; ASCII 47 - / (Gạch chéo)
db 0b00000000
db 0b00000011
db 0b00000110
db 0b00001100
db 0b00011000
db 0b00110000
db 0b01100000
db 0b00000000

; ASCII 48 - 0 (Số 0)
db 0b00111100
db 0b01100110
db 0b01101110
db 0b01110110
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 49 - 1 (Số 1)
db 0b00011000
db 0b00111000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b01111110
db 0b00000000

; ASCII 50 - 2 (Số 2)
db 0b00111100
db 0b01100110
db 0b00000110
db 0b00001100
db 0b00110000
db 0b01100000
db 0b01111110
db 0b00000000

; ASCII 51 - 3 (Số 3)
db 0b00111100
db 0b01100110
db 0b00000110
db 0b00011100
db 0b00000110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 52 - 4 (Số 4)
db 0b00001100
db 0b00011100
db 0b00111100
db 0b01101100
db 0b01111110
db 0b00001100
db 0b00001100
db 0b00000000

; ASCII 53 - 5 (Số 5)
db 0b01111110
db 0b01100000
db 0b01111100
db 0b00000110
db 0b00000110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 54 - 6 (Số 6)
db 0b00111100
db 0b01100000
db 0b01111100
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 55 - 7 (Số 7)
db 0b01111110
db 0b00000110
db 0b00001100
db 0b00011000
db 0b00110000
db 0b00110000
db 0b00110000
db 0b00000000

; ASCII 56 - 8 (Số 8)
db 0b00111100
db 0b01100110
db 0b01100110
db 0b00111100
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 57 - 9 (Số 9)
db 0b00111100
db 0b01100110
db 0b01100110
db 0b00111110
db 0b00000110
db 0b00001100
db 0b00111000
db 0b00000000

; ASCII 58 - : (Hai chấm)
db 0b00000000
db 0b00011000
db 0b00011000
db 0b00000000
db 0b00000000
db 0b00011000
db 0b00011000
db 0b00000000

; ASCII 59 - ; (Chấm phẩy)
db 0b00000000
db 0b00011000
db 0b00011000
db 0b00000000
db 0b00011000
db 0b00011000
db 0b00110000
db 0b00000000

; ASCII 60 - < (Nhỏ hơn)
db 0b00001100
db 0b00011000
db 0b00110000
db 0b01100000
db 0b00110000
db 0b00011000
db 0b00001100
db 0b00000000

; ASCII 61 - = (Bằng)
db 0b00000000
db 0b00000000
db 0b01111110
db 0b00000000
db 0b01111110
db 0b00000000
db 0b00000000
db 0b00000000

; ASCII 62 - > (Lớn hơn)
db 0b00110000
db 0b00011000
db 0b00001100
db 0b00000110
db 0b00001100
db 0b00011000
db 0b00110000
db 0b00000000

; ASCII 63 - ? (Dấu hỏi)
db 0b00111100
db 0b01100110
db 0b00000110
db 0b00001100
db 0b00011000
db 0b00000000
db 0b00011000
db 0b00000000

; ASCII 64 - @ (A còng)
db 0b00111100
db 0b01100110
db 0b01101110
db 0b01101110
db 0b01100000
db 0b01100010
db 0b00111100
db 0b00000000

; ASCII 65 - A
db 0b00111100
db 0b01100110
db 0b01100110
db 0b01111110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00000000

; ASCII 66 - B
db 0b01111100
db 0b01100110
db 0b01100110
db 0b01111100
db 0b01100110
db 0b01100110
db 0b01111100
db 0b00000000

; ASCII 67 - C
db 0b00111100
db 0b01100110
db 0b01100000
db 0b01100000
db 0b01100000
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 68 - D
db 0b01111000
db 0b01101100
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01101100
db 0b01111000
db 0b00000000

; ASCII 69 - E
db 0b01111110
db 0b01100000
db 0b01100000
db 0b01111100
db 0b01100000
db 0b01100000
db 0b01111110
db 0b00000000

; ASCII 70 - F
db 0b01111110
db 0b01100000
db 0b01100000
db 0b01111100
db 0b01100000
db 0b01100000
db 0b01100000
db 0b00000000

; ASCII 71 - G
db 0b00111100
db 0b01100110
db 0b01100000
db 0b01101110
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 72 - H
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01111110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00000000

; ASCII 73 - I
db 0b01111110
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b01111110
db 0b00000000

; ASCII 74 - J
db 0b00011110
db 0b00001100
db 0b00001100
db 0b00001100
db 0b01101100
db 0b01101100
db 0b00111000
db 0b00000000

; ASCII 75 - K
db 0b01100110
db 0b01101100
db 0b01111000
db 0b01110000
db 0b01111000
db 0b01101100
db 0b01100110
db 0b00000000

; ASCII 76 - L
db 0b01100000
db 0b01100000
db 0b01100000
db 0b01100000
db 0b01100000
db 0b01100000
db 0b01111110
db 0b00000000

; ASCII 77 - M
db 0b01100011
db 0b01110111
db 0b01111111
db 0b01101011
db 0b01100011
db 0b01100011
db 0b01100011
db 0b00000000

; ASCII 78 - N
db 0b01100110
db 0b01110110
db 0b01111110
db 0b01111110
db 0b01101110
db 0b01100110
db 0b01100110
db 0b00000000

; ASCII 79 - O
db 0b00111100
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 80 - P
db 0b01111100
db 0b01100110
db 0b01100110
db 0b01111100
db 0b01100000
db 0b01100000
db 0b01100000
db 0b00000000

; ASCII 81 - Q
db 0b00111100
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01101110
db 0b00111100
db 0b00000110
db 0b00000000

; ASCII 82 - R
db 0b01111100
db 0b01100110
db 0b01100110
db 0b01111100
db 0b01111000
db 0b01101100
db 0b01100110
db 0b00000000

; ASCII 83 - S
db 0b00111100
db 0b01100110
db 0b01100000
db 0b00111100
db 0b00000110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 84 - T
db 0b01111110
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00000000

; ASCII 85 - U
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 86 - V
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00011000
db 0b00000000

; ASCII 87 - W
db 0b01100011
db 0b01100011
db 0b01100011
db 0b01101011
db 0b01111111
db 0b01110111
db 0b01100011
db 0b00000000

; ASCII 88 - X
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00011000
db 0b00111100
db 0b01100110
db 0b01100110
db 0b00000000

; ASCII 89 - Y
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00000000

; ASCII 90 - Z
db 0b01111110
db 0b00000110
db 0b00001100
db 0b00011000
db 0b00110000
db 0b01100000
db 0b01111110
db 0b00000000

; ASCII 91 - [ (Ngoặc vuông mở)
db 0b00111100
db 0b00110000
db 0b00110000
db 0b00110000
db 0b00110000
db 0b00110000
db 0b00111100
db 0b00000000

; ASCII 92 - \ (Gạch chéo ngược)
db 0b00000000
db 0b01100000
db 0b00110000
db 0b00011000
db 0b00001100
db 0b00000110
db 0b00000011
db 0b00000000

; ASCII 93 - ] (Ngoặc vuông đóng)
db 0b00111100
db 0b00001100
db 0b00001100
db 0b00001100
db 0b00001100
db 0b00001100
db 0b00111100
db 0b00000000

; ASCII 94 - ^ (Mũ)
db 0b00011000
db 0b00111100
db 0b01100110
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000

; ASCII 95 - _ (Gạch dưới)
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b11111111

; ASCII 96 - ` (Dấu huyền)
db 0b00110000
db 0b00011000
db 0b00001100
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000

; ASCII 97 - a (chữ thường)
db 0b00000000
db 0b00000000
db 0b00111100
db 0b00000110
db 0b00111110
db 0b01100110
db 0b00111110
db 0b00000000

; ASCII 98 - b
db 0b01100000
db 0b01100000
db 0b01111100
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01111100
db 0b00000000

; ASCII 99 - c
db 0b00000000
db 0b00000000
db 0b00111100
db 0b01100000
db 0b01100000
db 0b01100000
db 0b00111100
db 0b00000000

; ASCII 100 - d
db 0b00000110
db 0b00000110
db 0b00111110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111110
db 0b00000000

; ASCII 101 - e
db 0b00000000
db 0b00000000
db 0b00111100
db 0b01100110
db 0b01111110
db 0b01100000
db 0b00111100
db 0b00000000

; ASCII 102 - f
db 0b00011100
db 0b00110110
db 0b00110000
db 0b01111100
db 0b00110000
db 0b00110000
db 0b00110000
db 0b00000000

; ASCII 103 - g
db 0b00000000
db 0b00000000
db 0b00111110
db 0b01100110
db 0b01100110
db 0b00111110
db 0b00000110
db 0b00111100

; ASCII 104 - h
db 0b01100000
db 0b01100000
db 0b01111100
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00000000

; ASCII 105 - i
db 0b00011000
db 0b00000000
db 0b00111000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00111100
db 0b00000000

; ASCII 106 - j
db 0b00000110
db 0b00000000
db 0b00000110
db 0b00000110
db 0b00000110
db 0b01100110
db 0b01100110
db 0b00111100

; ASCII 107 - k
db 0b01100000
db 0b01100000
db 0b01100110
db 0b01101100
db 0b01111000
db 0b01101100
db 0b01100110
db 0b00000000

; ASCII 108 - l
db 0b00111000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00111100
db 0b00000000

; ASCII 109 - m
db 0b00000000
db 0b00000000
db 0b01100110
db 0b01111111
db 0b01111111
db 0b01101011
db 0b01100011
db 0b00000000

; ASCII 110 - n
db 0b00000000
db 0b00000000
db 0b01111100
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00000000

; ASCII 111 - o
db 0b00000000
db 0b00000000
db 0b00111100
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00000000

; ASCII 112 - p
db 0b00000000
db 0b00000000
db 0b01111100
db 0b01100110
db 0b01100110
db 0b01111100
db 0b01100000
db 0b01100000

; ASCII 113 - q
db 0b00000000
db 0b00000000
db 0b00111110
db 0b01100110
db 0b01100110
db 0b00111110
db 0b00000110
db 0b00000110

; ASCII 114 - r
db 0b00000000
db 0b00000000
db 0b01111100
db 0b01100110
db 0b01100000
db 0b01100000
db 0b01100000
db 0b00000000

; ASCII 115 - s
db 0b00000000
db 0b00000000
db 0b00111110
db 0b01100000
db 0b00111100
db 0b00000110
db 0b01111100
db 0b00000000

; ASCII 116 - t
db 0b00110000
db 0b00110000
db 0b01111100
db 0b00110000
db 0b00110000
db 0b00110110
db 0b00011100
db 0b00000000

; ASCII 117 - u
db 0b00000000
db 0b00000000
db 0b01100110
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111110
db 0b00000000

; ASCII 118 - v
db 0b00000000
db 0b00000000
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111100
db 0b00011000
db 0b00000000

; ASCII 119 - w
db 0b00000000
db 0b00000000
db 0b01100011
db 0b01101011
db 0b01111111
db 0b00111110
db 0b00110110
db 0b00000000

; ASCII 120 - x
db 0b00000000
db 0b00000000
db 0b01100110
db 0b00111100
db 0b00011000
db 0b00111100
db 0b01100110
db 0b00000000

; ASCII 121 - y
db 0b00000000
db 0b00000000
db 0b01100110
db 0b01100110
db 0b01100110
db 0b00111110
db 0b00000110
db 0b00111100

; ASCII 122 - z
db 0b00000000
db 0b00000000
db 0b01111110
db 0b00001100
db 0b00011000
db 0b00110000
db 0b01111110
db 0b00000000

; ASCII 123 - { (Ngoặc nhọn mở)
db 0b00001110
db 0b00011000
db 0b00011000
db 0b01110000
db 0b00011000
db 0b00011000
db 0b00001110
db 0b00000000

; ASCII 124 - | (Đường thẳng đứng)
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00011000
db 0b00000000

; ASCII 125 - } (Ngoặc nhọn đóng)
db 0b01110000
db 0b00011000
db 0b00011000
db 0b00001110
db 0b00011000
db 0b00011000
db 0b01110000
db 0b00000000

; ASCII 126 - ~ (Dấu ngã)
db 0b00000000
db 0b00000000
db 0b01110110
db 0b11011100
db 0b00000000
db 0b00000000
db 0b00000000
db 0b00000000

; =====================================================
; HÀM VẼ KÝ TỰ PIXEL LÊN MÀN HÌNH
; Input: AL = ký tự ASCII cần vẽ
;        DH = hàng (row)
;        DL = cột (column)
;        BL = màu sắc (VGA color attribute)
; =====================================================
draw_pixel_char:
    pusha
    
    ; Kiểm tra ký tự có nằm trong khoảng 32-126 không
    cmp al, 32
    jl .exit                ; Nếu < 32 → bỏ qua
    cmp al, 126
    jg .exit                ; Nếu > 126 → bỏ qua
    
    ; Tính offset trong bảng font
    sub al, 32              ; AL = ASCII - 32
    mov ah, 0
    mov cl, 8
    mul cl                  ; AX = (ASCII-32) * 8
    
    ; SI trỏ đến font data
    mov si, pixel_font_8x8
    add si, ax
    
    ; Lưu vị trí ban đầu
    push dx
    mov byte [temp_color], bl
    
    ; Vẽ 8 hàng
    mov cx, 8
.draw_row:
    push cx
    
    ; Lấy 1 byte font data (8 pixel)
    lodsb                   ; AL = [SI], SI++
    mov bl, al
    
    ; Lưu hàng hiện tại
    push dx
    
    ; Vẽ 8 cột
    mov cx, 8
.draw_pixel:
    push cx
    
    ; Kiểm tra bit cao nhất
    test bl, 0b10000000
    jz .skip_pixel
    
    ; Vẽ pixel
    call set_cursor
    mov ah, 0x09            ; BIOS function: Write char+attr
    mov al, 0xDB            ; Ký tự block █
    mov bh, 0               ; Page 0
    mov cx, 1               ; 1 ký tự
    mov bl, [temp_color]    ; Màu
    int 0x10
    
.skip_pixel:
    ; Shift byte sang trái để kiểm tra bit tiếp theo
    shl byte [si-1], 1
    
    ; Di chuyển sang cột tiếp theo
    inc dl
    
    pop cx
    loop .draw_pixel
    
    ; Khôi phục cột, xuống hàng tiếp theo
    pop dx
    inc dh
    
    pop cx
    loop .draw_row
    
    ; Khôi phục vị trí ban đầu
    pop dx
    
.exit:
    popa
    ret

; =====================================================
; HÀM VẼ CHUỖI PIXEL
; Input: SI = con trỏ đến chuỗi
;        DH = hàng
;        DL = cột
;        BL = màu
; =====================================================
draw_pixel_string:
    pusha
    mov byte [temp_color], bl
    
.loop:
    lodsb                   ; AL = [SI], SI++
    test al, al             ; Kiểm tra null terminator
    jz .done
    
    ; Vẽ ký tự
    mov bl, [temp_color]
    call draw_pixel_char
    
    ; Di chuyển sang vị trí tiếp theo (mỗi ký tự rộng 8 pixel)
    add dl, 8
    
    jmp .loop
    
.done:
    popa
    ret

; =====================================================
; HÀM VẼ SỐ PIXEL (Hỗ trợ số có dấu)
; Input: AX = số cần vẽ
;        DH = hàng
;        DL = cột
;        BL = màu
; =====================================================
draw_pixel_number:
    pusha
    
    mov byte [temp_color], bl
    
    ; Kiểm tra số âm
    test ax, 0x8000
    jz .positive
    
    ; Vẽ dấu '-'
    push ax
    mov al, '-'
    mov bl, [temp_color]
    call draw_pixel_char
    add dl, 8
    pop ax
    neg ax
    
.positive:
    ; Chuyển số thành chuỗi
    mov di, pixel_number_buffer
    call number_to_string_pixel
    
    ; Vẽ chuỗi
    mov si, pixel_number_buffer
    mov bl, [temp_color]
    call draw_pixel_string
    
    popa
    ret

; =====================================================
; HÀM CHUYỂN SỐ THÀNH CHUỖI
; Input: AX = số
;        DI = buffer đích
; =====================================================
number_to_string_pixel:
    push ax
    push bx
    push cx
    push dx
    push di
    
    xor cx, cx              ; CX = số chữ số
    mov bx, 10
    
.divide:
    xor dx, dx
    div bx                  ; AX = AX/10, DX = dư
    push dx                 ; Lưu chữ số
    inc cx
    test ax, ax
    jnz .divide
    
.convert:
    pop ax
    add al, '0'             ; Chuyển số thành ASCII
    stosb                   ; [DI] = AL, DI++
    loop .convert
    
    mov byte [di], 0        ; Null terminator
    
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; =====================================================
; BIẾN TẠM
; =====================================================
temp_color: db 0
pixel_number_buffer: times 12 db 0
