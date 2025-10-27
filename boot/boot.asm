; =====================================================
; BOOTLOADER MINI OS (512 bytes)
; -----------------------------------------------------
; - Chạy ở Real Mode 16-bit, BIOS nạp 512 byte đầu vào 0x7C00
; - Mục tiêu: in thông báo, đọc kernel từ đĩa (INT 13h) vào 0x1000,
;   rồi nhảy thực thi vào kernel.
; - Lưu ý mapping tham số INT 13h (CHS) và nơi nạp BX:ES.
; - Giữ mã ngắn gọn để đủ 512 byte và có signature 0xAA55 cuối.
; =====================================================

[BITS 16]           ; We're in 16-bit real mode
[ORG 0x7C00]        ; BIOS loads boot sector at 0x7C00

start:
    ; Thiết lập các thanh ghi segment về 0 để DS/ES/SS nhất quán
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00  ; Stack grows downward from boot sector
    
    ; Xóa màn hình (BIOS video INT 10h, chế độ text 80x25)
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    
    ; In thông báo chào mừng
    mov si, welcome_msg
    call print_string
    
    ; Bắt đầu nạp kernel từ đĩa mềm
    mov si, loading_msg
    call print_string
    
    ; Reset ổ đĩa (INT 13h AH=00h)
    mov ah, 0x00
    mov dl, 0x00    ; First floppy drive
    int 0x13
    
    ; Đọc kernel bằng INT 13h AH=02h (Read Sectors)
    ; Tham số CHS:
    ;   CH = cylinder, DH = head, CL = sector (bit 5..0), DL = drive
    ;   AL = số sector cần đọc, ES:BX = đích nạp
    mov ah, 0x02          ; Read sectors function
    mov al, 64            ; Đọc 64 sector (~32KB kernel)
    mov ch, 0             ; Cylinder 0
    mov cl, 2             ; Sector bắt đầu = 2 (sector 1 là boot)
    mov dh, 0             ; Head 0
    mov dl, 0x00          ; Drive 0 (floppy)
    mov bx, 0x1000        ; Địa chỉ nạp = 0000:1000h
    int 0x13
    
    jc disk_error   ; Jump if carry flag is set (error)
    
    ; Nhảy vào kernel (giữ màn hình sạch, không in thêm)
    jmp 0x0000:0x1000  ; Far jump to loaded kernel
    
disk_error:
    mov si, error_msg
    call print_string
    jmp $           ; Infinite loop

; In chuỗi bằng BIOS teletype (INT 10h AH=0Eh)
; Input: SI = con trỏ đến chuỗi kết thúc bằng 0
print_string:
    pusha
.loop:
    lodsb           ; Load byte from SI into AL
    or al, al       ; Check if zero (end of string)
    jz .done
    mov ah, 0x0E    ; BIOS teletype output
    mov bh, 0       ; Page 0
    int 0x10        ; BIOS video interrupt
    jmp .loop
.done:
    popa
    ret

; Data
welcome_msg:    db '=================================', 13, 10
                db '     Mini OS Bootloader v1.0    ', 13, 10
                db '=================================', 13, 10, 0
loading_msg:    db 'Loading kernel...', 13, 10, 0
error_msg:      db 'ERROR: Disk read failed!', 13, 10, 0

; Padding and boot signature
times 510-($-$$) db 0
dw 0xAA55       ; Boot signature
