; =====================================================
; REBOOT APPLICATION
; =====================================================
; System reboot function
; =====================================================

run_reboot:
    call clear_screen
    
    mov dh, 10
    mov dl, 25
    call set_cursor
    mov si, reboot_msg
    mov bl, 0x0C
    call print_colored
    
    ; Wait a bit
    mov cx, 0x10
    mov dx, 0x0000
    mov ah, 0x86
    int 0x15
    
    ; Triple fault to reboot
    int 0x19
    
    ; If that fails, jump to BIOS reset vector
    jmp 0xFFFF:0x0000
