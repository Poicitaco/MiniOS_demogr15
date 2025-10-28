; =====================================================
; MÁY TÍNH GIẢI PHƯƠNG TRÌNH BẬC 2
; =====================================================
; Giải phương trình: ax² + bx + c = 0
; Giao diện giống máy tính Casio fx-580
; =====================================================

run_calculator:
    call clear_screen
    call draw_header
    
    ; Vẽ khung máy tính
    mov dh, 2
    mov dl, 20
    call set_cursor
    mov si, calc_title
    mov bl, 0x0E
    call print_colored
    
    ; Hiển thị dạng phương trình
    mov dh, 4
    mov dl, 25
    call set_cursor
    mov si, calc_equation
    mov bl, 0x0B
    call print_colored
    
    ; Vẽ khung nhập liệu
    call draw_calc_frame
    
    ; Nhập hệ số a
    mov dh, 7
    mov dl, 23
    call set_cursor
    mov si, calc_input_a
    call print_string
    call read_line
    
    ; Chuyển chuỗi a thành số và lưu vào biến
    mov si, input_buffer
    call string_to_int
    mov [calc_a], ax
    
    ; Kiểm tra nếu a = 0 (không phải phương trình bậc 2)
    cmp ax, 0
    je .invalid_a
    
    ; Nhập hệ số b
    mov dh, 9
    mov dl, 23
    call set_cursor
    mov si, calc_input_b
    call print_string
    call read_line
    
    mov si, input_buffer
    call string_to_int
    mov [calc_b], ax
    
    ; Nhập hệ số c
    mov dh, 11
    mov dl, 23
    call set_cursor
    mov si, calc_input_c
    call print_string
    call read_line
    
    mov si, input_buffer
    call string_to_int
    mov [calc_c], ax
    
    ; Tính Delta (biệt thức): Δ = b² - 4ac
    call calculate_discriminant
    
    ; Hiển thị kết quả
    call display_results
    
    jmp .wait_exit

.invalid_a:
    mov dh, 13
    mov dl, 20
    call set_cursor
    mov si, calc_error_a
    mov bl, 0x0C
    call print_colored
    
.wait_exit:
    mov dh, 22
    mov dl, 25
    call set_cursor
    mov si, press_any_key
    call print_string
    call read_char
    
    ; Hỏi có muốn giải phương trình khác không
    call clear_screen
    call draw_header
    
    mov dh, 10
    mov dl, 20
    call set_cursor
    mov si, calc_solve_again
    call print_string
    
    call read_char
    
    cmp al, 'y'
    je run_calculator
    cmp al, 'Y'
    je run_calculator
    
    jmp main_menu

; =====================================================
; DRAW CALCULATOR FRAME
; =====================================================
draw_calc_frame:
    push ax
    push dx
    
    ; Top border
    mov dh, 6
    mov dl, 20
    call set_cursor
    mov si, calc_frame_top
    call print_string
    
    ; Input rows
    mov dh, 7
    mov dl, 20
    call set_cursor
    mov si, calc_frame_mid
    call print_string
    
    mov dh, 8
    mov dl, 20
    call set_cursor
    mov si, calc_frame_div
    call print_string
    
    mov dh, 9
    mov dl, 20
    call set_cursor
    mov si, calc_frame_mid
    call print_string
    
    mov dh, 10
    mov dl, 20
    call set_cursor
    mov si, calc_frame_div
    call print_string
    
    mov dh, 11
    mov dl, 20
    call set_cursor
    mov si, calc_frame_mid
    call print_string
    
    mov dh, 12
    mov dl, 20
    call set_cursor
    mov si, calc_frame_bot
    call print_string
    
    pop dx
    pop ax
    ret

; =====================================================
; CALCULATE DISCRIMINANT
; =====================================================
calculate_discriminant:
    push bx
    push cx
    push dx
    
    ; Calculate b²
    mov ax, [calc_b]
    imul ax              ; AX = b²
    mov [calc_b_squared], ax
    
    ; Calculate 4ac
    mov ax, [calc_a]
    mov bx, [calc_c]
    imul bx              ; AX = a*c
    mov bx, 4
    imul bx              ; AX = 4*a*c
    mov [calc_4ac], ax
    
    ; Calculate Δ = b² - 4ac
    mov ax, [calc_b_squared]
    sub ax, [calc_4ac]
    mov [calc_delta], ax
    
    pop dx
    pop cx
    pop bx
    ret

; =====================================================
; DISPLAY RESULTS
; =====================================================
display_results:
    push ax
    push bx
    push dx
    
    ; Draw result frame
    mov dh, 14
    mov dl, 18
    call set_cursor
    mov si, calc_result_frame
    call print_string
    
    ; Display discriminant
    mov dh, 15
    mov dl, 20
    call set_cursor
    mov si, calc_delta_label
    mov bl, 0x0E
    call print_colored
    
    mov ax, [calc_delta]
    call print_signed_number
    
    ; Check delta value
    mov ax, [calc_delta]
    cmp ax, 0
    je .one_solution
    jl .no_real_solution
    jg .two_solutions

.two_solutions:
    mov dh, 17
    mov dl, 20
    call set_cursor
    mov si, calc_two_roots
    mov bl, 0x0A
    call print_colored
    
    ; Calculate sqrt(delta) using Newton-Raphson
    mov ax, [calc_delta]
    call sqrt_newton
    mov [calc_sqrt_delta], ax
    
    ; Calculate x1 = (-b + sqrt(delta)) / 2a
    mov dh, 18
    mov dl, 22
    call set_cursor
    mov si, calc_x1_label
    call print_string
    
    mov ax, [calc_b]
    neg ax                      ; -b
    add ax, [calc_sqrt_delta]   ; -b + sqrt(delta)
    mov bx, [calc_a]
    shl bx, 1                   ; 2a
    cwd
    idiv bx                     ; x1 = (-b + sqrt(delta)) / 2a
    
    call print_signed_number
    
    ; Calculate x2 = (-b - sqrt(delta)) / 2a
    mov dh, 19
    mov dl, 22
    call set_cursor
    mov si, calc_x2_label
    call print_string
    
    mov ax, [calc_b]
    neg ax                      ; -b
    sub ax, [calc_sqrt_delta]   ; -b - sqrt(delta)
    mov bx, [calc_a]
    shl bx, 1                   ; 2a
    cwd
    idiv bx                     ; x2 = (-b - sqrt(delta)) / 2a
    
    call print_signed_number
    
    jmp .display_done

.one_solution:
    mov dh, 17
    mov dl, 20
    call set_cursor
    mov si, calc_one_root
    mov bl, 0x0A
    call print_colored
    
    ; x = -b / 2a
    mov dh, 18
    mov dl, 22
    call set_cursor
    mov si, calc_x_label
    call print_string
    
    ; Calculate x = -b / 2a
    mov ax, [calc_b]
    neg ax               ; -b
    mov bx, [calc_a]
    shl bx, 1            ; 2a
    cwd
    idiv bx              ; AX = -b / 2a
    
    call print_signed_number
    
    jmp .display_done

.no_real_solution:
    mov dh, 17
    mov dl, 20
    call set_cursor
    mov si, calc_no_real
    mov bl, 0x0C
    call print_colored
    
    mov dh, 18
    mov dl, 20
    call set_cursor
    mov si, calc_complex_note
    mov bl, 0x08
    call print_colored

.display_done:
    pop dx
    pop bx
    pop ax
    ret

; =====================================================
; STRING TO INTEGER CONVERSION
; =====================================================
; Input: SI = pointer to string
; Output: AX = integer value
string_to_int:
    push bx
    push cx
    push dx
    
    xor ax, ax           ; Result = 0
    xor cx, cx           ; Sign flag = positive
    xor bx, bx
    
    ; Check for negative sign
    cmp byte [si], '-'
    jne .parse_digits
    inc si
    mov cx, 1            ; Sign = negative

.parse_digits:
    mov bl, [si]
    cmp bl, 0
    je .done
    cmp bl, '0'
    jl .done
    cmp bl, '9'
    jg .done
    
    ; Multiply current result by 10
    mov dx, 10
    imul dx
    
    ; Add new digit
    sub bl, '0'
    add ax, bx
    
    inc si
    jmp .parse_digits

.done:
    ; Apply sign
    cmp cx, 1
    jne .positive
    neg ax

.positive:
    pop dx
    pop cx
    pop bx
    ret

; =====================================================
; PRINT SIGNED NUMBER
; =====================================================
; Input: AX = number to print
print_signed_number:
    push ax
    push bx
    push cx
    push dx
    
    ; Check if negative
    test ax, ax
    jns .positive_num
    
    ; Print minus sign
    push ax
    mov al, '-'
    call print_char
    pop ax
    neg ax

.positive_num:
    ; Convert to decimal
    xor cx, cx           ; Digit counter
    mov bx, 10

.divide_loop:
    xor dx, dx
    div bx               ; AX = quotient, DX = remainder
    push dx
    inc cx
    test ax, ax
    jnz .divide_loop

.print_digits:
    pop ax
    add al, '0'
    call print_char
    loop .print_digits
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; =====================================================
; SQUARE ROOT USING NEWTON-RAPHSON METHOD
; =====================================================
; Input: AX = number to find square root
; Output: AX = integer square root
sqrt_newton:
    push bx
    push cx
    push dx
    
    ; Handle special cases
    cmp ax, 0
    je .sqrt_done
    cmp ax, 1
    je .sqrt_done
    
    ; Initial guess: x0 = n / 2
    mov bx, ax          ; Save original number
    shr ax, 1           ; x = n / 2
    
    ; If guess is 0, set to 1
    cmp ax, 0
    jne .newton_loop
    mov ax, 1
    
.newton_loop:
    ; Store current guess
    mov cx, ax          ; cx = current x
    
    ; Calculate x_new = (x + n/x) / 2
    mov ax, bx          ; ax = n
    xor dx, dx
    div cx              ; ax = n / x
    add ax, cx          ; ax = x + n/x
    shr ax, 1           ; ax = (x + n/x) / 2
    
    ; Check convergence: if |x_new - x| <= 1, stop
    mov dx, ax          ; dx = x_new
    sub dx, cx          ; dx = x_new - x
    
    ; Get absolute value
    cmp dx, 0
    jge .check_convergence
    neg dx
    
.check_convergence:
    cmp dx, 1
    jg .newton_loop     ; Continue if difference > 1
    
.sqrt_done:
    pop dx
    pop cx
    pop bx
    ret
