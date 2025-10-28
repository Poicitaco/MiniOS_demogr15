; =====================================================
; MINI OS v3.0 - MODULAR KERNEL
; =====================================================
; Main entry point - includes all modules
; Kiến trúc modular để dễ phát triển và maintain
; =====================================================

[BITS 16]
[ORG 0x1000]

; =====================================================
; KERNEL ENTRY POINT
; =====================================================
start:
    ; Thiết lập segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x9000
    
    ; Chế độ text 80x25
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    
    ; Hiển thị boot screen
    call show_boot_screen
    
    ; Vào main menu
    jmp main_menu

; =====================================================
; INCLUDE UTILITY FUNCTIONS (phải include trước)
; =====================================================
%include "kernel/utils/screen.asm"
%include "kernel/utils/keyboard.asm"
%include "kernel/utils/string.asm"
%include "kernel/utils/time.asm"

; =====================================================
; INCLUDE CORE MODULES
; =====================================================
%include "kernel/core/boot.asm"
%include "kernel/core/menu.asm"
%include "kernel/core/data.asm"

; =====================================================
; INCLUDE APPLICATION MODULES
; =====================================================
%include "kernel/apps/terminal.asm"
%include "kernel/apps/clock.asm"
%include "kernel/apps/editor.asm"
%include "kernel/apps/game.asm"
%include "kernel/apps/calculator.asm"
%include "kernel/apps/about.asm"
%include "kernel/apps/reboot.asm"

; =====================================================
; PADDING TO 16KB
; =====================================================
times 16384-($-$$) db 0
