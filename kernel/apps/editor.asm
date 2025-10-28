; =====================================================
; FILE EDITOR APPLICATION
; =====================================================
; File management system with virtual file storage
; Supports up to 5 files in memory
; =====================================================

run_file_editor:
    call clear_screen
    call draw_header
    
    mov dh, 2
    mov dl, 25
    call set_cursor
    mov si, editor_title
    mov bl, 0x0E
    call print_colored
    
    ; Show menu
    mov dh, 4
    mov dl, 5
    call set_cursor
    mov si, editor_menu1
    call print_string
    
    mov dh, 5
    mov dl, 5
    call set_cursor
    mov si, editor_menu2
    call print_string
    
    mov dh, 6
    mov dl, 5
    call set_cursor
    mov si, editor_menu3
    call print_string

    mov dh, 8
    mov dl, 5
    call set_cursor
    mov si, editor_prompt
    call print_string
    
    call read_char
    
    ; Echo the character
    push ax
    call print_char
    pop ax
    
    cmp al, '1'
    je .create_file
    cmp al, '2'
    je .view_files
    cmp al, '3'
    je .exit_editor
    jmp run_file_editor

.create_file:
    ; Check if file list is full
    mov al, [file_count]
    cmp al, 5
    jge .file_list_full
    
    call clear_screen
    call draw_header
    
    mov dh, 2
    mov dl, 2
    call set_cursor
    mov si, editor_create_msg
    call print_string
    call read_line
    
    ; Check if filename is empty
    cmp byte [input_buffer], 0
    je run_file_editor
    
    ; Find free slot
    mov al, [file_count]
    xor ah, ah                ; Clear AH for 16-bit multiply
    mov bx, 336              ; Size per file (80 + 256)
    mul bx                   ; AX = file_count × 336
    mov di, file_storage
    add di, ax
    
    ; Copy filename to storage
    mov si, input_buffer
    push di
    call strcpy
    pop di
    
    ; Initialize empty content
    add di, 80
    mov byte [di], 0
    
    ; Increment file count
    inc byte [file_count]
    
    ; Show success
    mov dh, 4
    mov dl, 2
    call set_cursor
    mov si, editor_file_created
    mov bl, 0x0A
    call print_colored
    
    mov dh, 5
    mov dl, 2
    call set_cursor
    mov si, press_any_key
    call print_string
    call read_char
    
    jmp run_file_editor

.view_files:
    call clear_screen
    call draw_header
    
    mov dh, 2
    mov dl, 2
    call set_cursor
    mov si, editor_file_list_title
    mov bl, 0x0B
    call print_colored
    
    ; Check if any files exist
    cmp byte [file_count], 0
    je .no_files_exist
    
    ; Display file list
    mov byte [current_line], 0
    mov cx, 0
    
.display_file_loop:
    mov al, [file_count]
    cmp cl, al
    jge .end_file_list
    
    ; Calculate file position
    mov al, cl
    xor ah, ah
    mov bx, 336
    mul bx
    mov si, file_storage
    add si, ax
    
    ; Display file number and name
    mov al, [current_line]
    add al, 4
    mov dh, al
    mov dl, 5
    call set_cursor
    
    ; Print file number
    mov al, cl
    add al, '1'
    call print_char
    mov al, '.'
    call print_char
    mov al, ' '
    call print_char
    
    ; Print filename
    mov bl, 0x0E
    call print_colored
    
    inc byte [current_line]
    inc cl
    jmp .display_file_loop

.end_file_list:
    ; Show edit prompt
    mov al, [current_line]
    add al, 6
    mov dh, al
    mov dl, 5
    call set_cursor
    mov si, editor_select_file_msg
    call print_string
    call read_line
    
    ; Check if input is empty
    cmp byte [input_buffer], 0
    je run_file_editor
    
    ; Find file by name
    call find_file_by_name
    cmp ax, 0xFFFF
    je .file_not_found
    
    ; File found, go to edit
    jmp .edit_file_content

.no_files_exist:
    mov dh, 4
    mov dl, 5
    call set_cursor
    mov si, editor_no_files
    mov bl, 0x0C
    call print_colored
    
    mov dh, 6
    mov dl, 5
    call set_cursor
    mov si, press_any_key
    call print_string
    call read_char
    jmp run_file_editor

.file_not_found:
    call clear_screen
    call draw_header
    
    mov dh, 3
    mov dl, 2
    call set_cursor
    mov si, editor_file_not_found
    mov bl, 0x0C
    call print_colored
    
    mov dh, 5
    mov dl, 2
    call set_cursor
    mov si, press_any_key
    call print_string
    call read_char
    jmp run_file_editor

.file_list_full:
    call clear_screen
    call draw_header
    
    mov dh, 3
    mov dl, 2
    call set_cursor
    mov si, editor_list_full
    mov bl, 0x0C
    call print_colored
    
    mov dh, 5
    mov dl, 2
    call set_cursor
    mov si, press_any_key
    call print_string
    call read_char
    jmp run_file_editor


.edit_file_content:
    ; AX contains file index
    mov [selected_file_index], ax
    
    ; Calculate file position
    xor ah, ah
    mov bx, 336
    mul bx
    mov si, file_storage
    add si, ax
    
    ; Display file info
    call clear_screen
    call draw_header
    
    mov dh, 2
    mov dl, 2
    call set_cursor
    mov si, editor_editing_msg
    mov bl, 0x0E
    call print_colored
    
    mov dh, 3
    mov dl, 2
    call set_cursor
    mov si, editor_filename_label
    call print_string
    
    ; Display filename
    push si
    mov bl, 0x0A
    call print_colored
    pop si
    
    ; Get content pointer (filename + 80 bytes)
    add si, 80
    push si
    
    ; Show current content
    mov dh, 5
    mov dl, 2
    call set_cursor
    mov si, editor_current_content_label
    call print_string
    
    mov dh, 6
    mov dl, 2
    call set_cursor
    pop si
    push si
    
    cmp byte [si], 0
    je .no_content_yet
    
    mov bl, 0x08
    call print_colored
    
.no_content_yet:
    ; Get new content
    mov dh, 8
    mov dl, 2
    call set_cursor
    mov si, editor_new_content_msg
    call print_string
    
    mov dh, 9
    mov dl, 2
    call set_cursor
    call read_line
    
    ; Copy new content to file
    pop di
    mov si, input_buffer
    call strcpy
    
    ; Show success
    mov dh, 11
    mov dl, 2
    call set_cursor
    mov si, editor_saved_msg
    mov bl, 0x0A
    call print_colored
    
    mov dh, 13
    mov dl, 2
    call set_cursor
    mov si, press_any_key
    call print_string
    call read_char
    
    jmp run_file_editor

.exit_editor:
    jmp main_menu

; =====================================================
; HELPER FUNCTIONS
; =====================================================

; Find file by name
; Input: input_buffer contains filename to search
; Output: AX = file index (0-4), or 0xFFFF if not found
find_file_by_name:
    push bx
    push cx
    push si
    push di
    
    mov cx, 0
    
.find_loop:
    mov al, [file_count]
    cmp cl, al
    jge .not_found
    
    ; Calculate file position
    mov al, cl
    xor ah, ah
    mov bx, 336
    mul bx
    mov si, file_storage
    add si, ax
    
    ; Compare filenames
    push cx
    mov di, input_buffer
    call strcmp
    pop cx
    
    cmp ax, 1
    je .found
    
    inc cl
    jmp .find_loop

.found:
    mov ax, cx
    jmp .find_done

.not_found:
    mov ax, 0xFFFF

.find_done:
    pop di
    pop si
    pop cx
    pop bx
    ret
