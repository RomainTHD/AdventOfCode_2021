section .text

; print the values (x1, y1), (x2, y2)
print_values:
    mov rdi, [from_x]
    call print_int

    mov rdi, ' '
    call print_char

    mov rdi, [from_y]
    call print_int

    mov rdi, ' '
    call print_char

    mov rdi, [to_x]
    call print_int

    mov rdi, ' '
    call print_char

    mov rdi, [to_y]
    call print_int

    call print_new_line
    ret

; fill a line, and a diagonal if r15 == 1
fill_line:
    mov rdx, [from_x]
    cmp rdx, [to_x]
    jle .check_y
        push qword[to_x]
        pop qword[from_x]
        mov [to_x], rdx

        ; we flip both coordinates if from_x > to_x, to keep the orientation
        ;  it's only useful for the 2nd part though
        mov rdx, [from_y]
        push qword[to_y]
        pop qword[from_y]
        mov [to_y], rdx

    .check_y:

    cmp r15, 1
    jne .check_diag_finished
        call check_diag
    .check_diag_finished:

    mov rdx, [from_y]
    cmp rdx, [to_y]
    jle .check_ok
        ; here, we don't need to change the x coordinate since the lines are only rows or columns
        push qword[to_y]
        pop qword[from_y]
        mov [to_y], rdx

    .check_ok:

    mov rdx, [from_x]
    cmp rdx, [to_x]
    jne .check_line_y
        mov rcx, [from_y]
        dec rcx
        .loop_y:
            inc rcx

            ; rax = 2 * (1000 * x + y)
            mov rax, [from_x]
            mov r9, 1000
            mul r9
            add rax, rcx
            add rax, rax

            inc word[array + rax]

            cmp rcx, [to_y]
            jne .loop_y

    .check_line_y:
    mov rdx, [from_y]
    cmp rdx, [to_y]
    jne .check_line_finished
        mov rcx, [from_x]
        dec rcx
        .loop_x:
            inc rcx

            ; rax = 2 * (1000 * x + y)
            mov rax, rcx
            mov r9, 1000
            mul r9
            add rax, [from_y]
            add rax, rax

            inc word[array + rax]

            cmp rcx, [to_x]
            jne .loop_x

    .check_line_finished:

    mov qword[from_x], 0
    mov qword[from_y], 0
    mov qword[to_y], 0
    mov qword[to_x], 0

    ret

; save a value
save_value:
    mov rdx, r10

    cmp byte[from_to_mode], 0
    jne .to
        cmp byte[x_y_mode], 0
        jne .from_y
            mov qword[from_x], rdx
            jmp .end
        .from_y:
            mov qword[from_y], rdx
            jmp .end
    .to:
        cmp byte[x_y_mode], 0
        jne .to_y
            mov qword[to_x], rdx
            jmp .end
        .to_y:
            mov qword[to_y], rdx
    .end:

    mov r10, 0
    ret

; fills the array
part1_fill:
    ; r10 = current number
    ; r11 = current char
    ; rcx = char index

    mov r10, 0
    mov rcx, 0 ; for rcx = 0
    .loop:
        mov r11, [file_content + rcx]
        and r11, 0xff

        cmp r11, 0
        je .end ; file_content[rcx] != '\0'
            cmp r11, ','
            je .comma ; if file_content[rcx] != ','
                mov rdi, r11
                call is_number
                cmp rax, 1
                je .number ; if !is_number(file_content[rcx])
                    cmp r11, '-'
                    je .endloop
                        cmp r11, 0x0a
                        je .new_line
                            call save_value
                            xor byte[x_y_mode], 0x01
                            xor byte[from_to_mode], 0x01
                            inc rcx ; ++rcx
                            inc rcx ; ++rcx
                            inc rcx ; ++rcx
                            jmp .endloop
                        .new_line:
                            call save_value
                            push rcx
                            call fill_line
                            pop rcx
                            xor byte[x_y_mode], 0x01
                            xor byte[from_to_mode], 0x01
                            jmp .endloop
                .number:
                    ; r10 *= 10
                    mov rax, 10
                    mul r10

                    ; r10 += file_content[rcx - '0']
                    sub r11, '0'
                    add rax, r11
                    add r11, '0'
                    mov r10, rax

                    jmp .endloop
            .comma:
                call save_value
                xor byte[x_y_mode], 0x01

            .endloop:
            inc rcx ; ++rcx
            jmp .loop
    .end:
    ret

; counts the number of cells >= 2 and store this value in rax
part1_count:
    mov r8, 0

    mov rcx, 1000
    .loop_1:
        dec rcx
        mov rdx, 1000
        .loop_2:
            dec rdx

            ; rax = 2 * (1000 * rcx + rdx)
            mov rax, rcx
            mov r9, 1000
            push rdx ; rdx is an output of mul
            mul r9
            pop rdx
            add rax, rdx
            add rax, rax

            mov r11, [array + rax]
            and r11, 0xffff ; pseudo-cast to word
            cmp r11, 2
            jl .not_a_solution
                inc r8
            .not_a_solution:

            cmp rdx, 0
            jne .loop_2

        cmp rcx, 0
        jne .loop_1

    mov rax, r8
    ret

; part 1, also part 2 if r15 == 1
part1:
    call part1_fill
    call part1_count
    mov rdi, rax
    call print_int
    call print_new_line
    ret

section .data
    array times 1000000 dw 0 ; We assume a 1000 x 1000 grid
    from_to_mode dq 0
    x_y_mode dq 0
    from_x dq 0
    from_y dq 0
    to_x dq 0
    to_y dq 0
