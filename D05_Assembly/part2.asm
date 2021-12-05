section .text

; loop though a diagonal, rdi is the direction, 0 for desc, 1 for asc
loop_diag:
    mov rcx, 0
    dec rcx

    .loop_dir:
        inc rcx

        ; rax = 2 * (1000 * (x0 + d) + (y0 + d))
        mov rax, [from_x]
        add rax, rcx
        mov r9, 1000
        push rdx
        mul r9
        pop rdx

        cmp rdi, 0
        je .dec
            add rax, rcx
            jmp .end_inc_dec
        .dec:
            sub rax, rcx
        .end_inc_dec:

        add rax, [from_y]
        add rax, rax

        inc word[array + rax]

        cmp rcx, rdx
        jne .loop_dir
    ret

; check a diagonal in the same context as check_line
check_diag:
    mov rdx, [to_x]
    sub rdx, [from_x]

    mov rcx, [to_y]
    sub rcx, [from_y]

    cmp rdx, rcx
    jne .check_other_direction
        mov rdi, 1
        call loop_diag
        jmp .end

    .check_other_direction:
    mov rcx, [from_y]
    sub rcx, [to_y]

    cmp rdx, rcx
    jne .end
        mov rdi, 0
        call loop_diag
    .end:
    ret

; part 2, spaghetti code yay
part2:
    push r15
    mov r15, 1

    call part1_fill
    call part1_count

    push rax
    call print_new_line
    pop rax
    mov rdi, rax
    call print_int
    call print_new_line

    pop r15
    ret
