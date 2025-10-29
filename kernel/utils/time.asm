; =====================================================
; TIME UTILITIES
; =====================================================
; Các hàm xử lý thời gian: lấy giờ, ngày, chuyển đổi
; =====================================================

get_time_string:
    ; Output: time_buffer chứa "HH:MM:SS"
    push ax
    push bx
    push cx
    push dx
    
    ; Get time from BIOS
    mov ah, 0x02
    int 0x1A
    
    ; Hours
    mov al, ch
    call bcd_to_ascii
    mov [time_buffer], ah
    mov [time_buffer+1], al
    
    mov byte [time_buffer+2], ':'
    
    ; Minutes
    mov al, cl
    call bcd_to_ascii
    mov [time_buffer+3], ah
    mov [time_buffer+4], al
    
    mov byte [time_buffer+5], ':'
    
    ; Seconds
    mov al, dh
    call bcd_to_ascii
    mov [time_buffer+6], ah
    mov [time_buffer+7], al
    
    mov byte [time_buffer+8], 0
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret

get_date_string:
    ; Output: date_buffer chứa "DD/MM/YYYY"
    push ax
    push bx
    push cx
    push dx
    
    ; Get date from BIOS RTC
    mov ah, 0x04
    int 0x1A
    
    ; Day
    mov al, dl
    call bcd_to_ascii
    mov [date_buffer], ah
    mov [date_buffer+1], al
    
    mov byte [date_buffer+2], '/'
    
    ; Month
    mov al, dh
    call bcd_to_ascii
    mov [date_buffer+3], ah
    mov [date_buffer+4], al
    
    mov byte [date_buffer+5], '/'
    
    ; Year (century in CH, year in CL)
    mov al, ch
    call bcd_to_ascii
    mov [date_buffer+6], ah
    mov [date_buffer+7], al
    
    mov al, cl
    call bcd_to_ascii
    mov [date_buffer+8], ah
    mov [date_buffer+9], al
    
    mov byte [date_buffer+10], 0
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret

get_day_of_week:
    ; Output: day_buffer chứa tên ngày
    push ax
    push bx
    push cx
    push dx
    
    ; Get day of week from BIOS RTC
    mov ah, 0x04
    int 0x1A
    and al, 0x07    ; AL = day of week (0=Sunday, 1=Monday, ...)
    
    ; Calculate offset in days_of_week string (each day name is 10 chars)
    mov bl, 10
    mul bl
    mov si, days_of_week
    add si, ax
    mov di, day_buffer
    mov cx, 9
.copy:
    lodsb
    stosb
    loop .copy
    mov byte [di], 0
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret

bcd_to_ascii:
    ; Input: AL = BCD value
    ; Output: AH = tens digit, AL = ones digit (ASCII)
    push bx
    mov bl, al
    and al, 0x0F
    add al, '0'
    mov ah, bl
    shr ah, 4
    add ah, '0'
    pop bx
    ret

init_rtc:
    ; Initialize Real Time Clock
    push ax
    push bx
    
    ; Check if RTC exists and is working
    mov ah, 0x02
    int 0x1A
    jc .rtc_not_available
    
    ; Enable RTC updates
    mov al, 0x0A
    out 0x70, al
    mov al, 0x26    ; 32.768kHz, normal operation
    out 0x71, al
    
    ; Set status register B
    mov al, 0x0B
    out 0x70, al
    mov al, 0x02    ; 24-hour format, BCD mode
    out 0x71, al
    
.rtc_not_available:
    pop bx
    pop ax
    ret
