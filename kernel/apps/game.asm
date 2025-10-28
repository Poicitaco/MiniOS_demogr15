; =====================================================
; TIC TAC TOE GAME APPLICATION
; =====================================================
; Classic 2-player Tic Tac Toe game
; =====================================================

run_game:
    call clear_screen
    call draw_header
    
    mov dh, 2
    mov dl, 28
    call set_cursor
    mov si, game_title
    mov bl, 0x0E
    call print_colored
    
    ; Show instructions
    mov dh, 4
    mov dl, 15
    call set_cursor
    mov si, game_help1
    mov bl, 0x0B
    call print_colored
    
    mov dh, 5
    mov dl, 15
    call set_cursor
    mov si, game_help2
    call print_string
    
    mov dh, 6
    mov dl, 15
    call set_cursor
    mov si, game_help3
    call print_string
    
    ; Initialize board
    call init_game_board
    
    mov byte [current_player], 'X'
    mov byte [game_over], 0

.game_loop:
    call draw_game_board
    
    ; Check if game over
    cmp byte [game_over], 1
    je .game_end
    
    ; Show current player
    mov dh, 18
    mov dl, 25
    call set_cursor
    mov si, game_player_msg
    call print_string
    mov al, [current_player]
    call print_char
    
    ; Get move
    mov dh, 19
    mov dl, 25
    call set_cursor
    mov si, game_move_msg
    call print_string
    
    call read_char
    
    ; Check ESC to quit
    cmp ah, 0x01      ; ESC key
    je .game_quit
    
    ; Echo the character for visual feedback
    push ax
    call print_char
    pop ax
    
    ; Check valid input (1-9)
    cmp al, '1'
    jl .game_loop
    cmp al, '9'
    jg .game_loop
    
    ; Convert to index (0-8)
    sub al, '1'
    mov bl, al
    xor bh, bh
    
    ; Check if cell empty
    mov si, game_board
    add si, bx
    cmp byte [si], ' '
    jne .game_loop
    
    ; Make move
    mov al, [current_player]
    mov [si], al
    
    ; Check winner
    call check_winner
    cmp al, 1
    je .winner
    
    ; Check draw
    call check_draw
    cmp al, 1
    je .draw
    
    ; Switch player
    cmp byte [current_player], 'X'
    je .switch_to_o
    mov byte [current_player], 'X'
    jmp .game_loop

.switch_to_o:
    mov byte [current_player], 'O'
    jmp .game_loop

.winner:
    mov byte [game_over], 1
    call draw_game_board
    mov dh, 18
    mov dl, 25
    call set_cursor
    mov si, game_winner_msg
    call print_string
    mov al, [current_player]
    call print_char
    mov si, game_wins
    call print_string
    jmp .game_end

.draw:
    mov byte [game_over], 1
    call draw_game_board
    mov dh, 18
    mov dl, 25
    call set_cursor
    mov si, game_draw_msg
    call print_string

.game_quit:
.game_end:
    mov dh, 20
    mov dl, 25
    call set_cursor
    mov si, press_any_key
    call print_string
    call read_char
    jmp main_menu

; Game helper functions
init_game_board:
    mov cx, 9
    mov si, game_board
.init_loop:
    mov byte [si], ' '
    inc si
    loop .init_loop
    ret

draw_game_board:
    mov dh, 8
    mov dl, 30
    call set_cursor
    mov si, game_board_line1
    call print_string
    
    ; Row 1: positions 0, 1, 2
    mov dh, 9
    mov dl, 30
    call set_cursor
    mov si, game_board
    call .print_row
    
    mov dh, 10
    mov dl, 30
    call set_cursor
    mov si, game_board_line2
    call print_string
    
    ; Row 2: positions 3, 4, 5
    mov dh, 11
    mov dl, 30
    call set_cursor
    mov si, game_board
    add si, 3                ; Start at position 3
    call .print_row
    
    mov dh, 12
    mov dl, 30
    call set_cursor
    mov si, game_board_line3
    call print_string
    
    ; Row 3: positions 6, 7, 8
    mov dh, 13
    mov dl, 30
    call set_cursor
    mov si, game_board
    add si, 6                ; Start at position 6
    call .print_row
    
    mov dh, 14
    mov dl, 30
    call set_cursor
    mov si, game_board_line4
    call print_string
    
    mov dh, 16
    mov dl, 28
    call set_cursor
    mov si, game_numbers
    call print_string
    
    ret

.print_row:
    push dx
    mov al, '|'
    call print_char
    mov al, ' '
    call print_char
    mov al, [si]
    call print_char
    mov al, ' '
    call print_char
    mov al, '|'
    call print_char
    mov al, ' '
    call print_char
    inc si
    mov al, [si]
    call print_char
    mov al, ' '
    call print_char
    mov al, '|'
    call print_char
    mov al, ' '
    call print_char
    inc si
    mov al, [si]
    call print_char
    mov al, ' '
    call print_char
    mov al, '|'
    call print_char
    inc si
    pop dx
    ret

check_winner:
    ; Check rows
    mov si, game_board
    call .check_line
    cmp al, 1
    je .won
    
    add si, 3
    call .check_line
    cmp al, 1
    je .won
    
    add si, 3
    call .check_line
    cmp al, 1
    je .won
    
    ; Check columns
    mov si, game_board
    call .check_col
    cmp al, 1
    je .won
    
    inc si
    call .check_col
    cmp al, 1
    je .won
    
    inc si
    call .check_col
    cmp al, 1
    je .won
    
    ; Check diagonals
    mov si, game_board
    mov al, [si]
    cmp al, ' '
    je .check_diag2
    cmp al, [si+4]
    jne .check_diag2
    cmp al, [si+8]
    jne .check_diag2
    mov al, 1
    ret

.check_diag2:
    mov si, game_board + 2
    mov al, [si]
    cmp al, ' '
    je .no_win
    cmp al, [si+2]
    jne .no_win
    cmp al, [si+4]
    jne .no_win
    mov al, 1
    ret

.no_win:
    xor al, al
    ret

.won:
    mov al, 1
    ret

.check_line:
    mov al, [si]
    cmp al, ' '
    je .not_line
    cmp al, [si+1]
    jne .not_line
    cmp al, [si+2]
    jne .not_line
    mov al, 1
    ret
.not_line:
    xor al, al
    ret

.check_col:
    mov al, [si]
    cmp al, ' '
    je .not_col
    cmp al, [si+3]
    jne .not_col
    cmp al, [si+6]
    jne .not_col
    mov al, 1
    ret
.not_col:
    xor al, al
    ret

check_draw:
    mov cx, 9
    mov si, game_board
.check_loop:
    cmp byte [si], ' '
    je .not_draw
    inc si
    loop .check_loop
    mov al, 1
    ret
.not_draw:
    xor al, al
    ret
