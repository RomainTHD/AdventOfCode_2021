%include "part1.asm"
%include "part2.asm"

section .text
    global _start ; for GCC

; open a file
open_file:
    ; open the file for reading
    mov rax, 5 ; open
    mov rbx, file_name ; file name
    mov rcx, 0 ; read only access
    int 0x80 ; kernel call

    mov [fd_in], rax

    ; read the file
    mov rax, 3 ; read
    mov rbx, [fd_in]
    mov rcx, file_content
    mov rdx, [file_content_length]
    int 0x80

    ; close the file
    mov rax, 6
    mov rbx, [fd_in]
    int  0x80

    ret

print_char:
    mov rsi, 1
    call print_string

; print a string of length rsi stored in rdi
print_string:
    push rbx
    mov qword[tmp], rdi
    mov rdi, tmp
    mov rax, 4 ; sys_write
    mov rbx, 1 ; stdout
    mov rcx, rdi ; content to write
    mov rdx, rsi ; length
    int 0x80
    pop rbx
    ret

; log rdi in base rsi is stored in rax
;  will return 1 for log 0
log:
    mov rcx, 0
    mov rax, rdi
    .loop:
        mov rdx, 0 ; avoid SIGFPE
        inc rcx
        div rsi ; rax = rax / rsi
        cmp rax, 0
        jne .loop
    mov rax, rcx
    dec rax ; we're always 1 above our target
    ret

; rdi % rsi is stored in rax
modulo:
    mov rax, rdi
    mov rdx, 0 ; avoid SIGFPE
    div rsi ; rax = rdi / rsi, remainder stored in rdx
    mov rax, rdx
    ret

; print an int stored in rdi
;  careful, the output is reversed ! 135 will be printed as 531
print_int:
    mov rax, rdi
    .loop:
        mov rcx, 10
        mov rdx, 0 ; avoid SIGFPE
        div rcx ; rax = rax / 10, remainder stored in rdx
        mov rdi, rdx
        add rdi, '0'

        push rax
        call print_char
        pop rax

        cmp rax, 0
        jne .loop
    ret

; print a new line
print_new_line:
    mov rdi, 0x0a
    call print_char
    ret

; exit
exit:
    mov rax, 1 ; sys_exit
    int 0x80
    ret

; print the file
print_file:
    mov rcx, 0 ; for rcx = 0
    .loop:
        cmp byte[file_content + rcx], 0
        je .end ; file_content[rcx] != '\0'
            mov rdi, [file_content + rcx]
            call print_char
            inc rcx ; ++rcx
            jmp .loop
    .end:
    ret

; Stores in rax whether rdi is a number or not
is_number:
    mov rax, 0
    cmp rdi, '0'
    jl .end
        cmp rdi, '9'
        jg .end
            mov rax, 1

    .end:
    ret

; program entry point
_start:
    call open_file
    mov rdi, "Part 1:"
    mov rsi, 7
    call print_string
    call print_new_line

    ; we should reset the array between part1 and part2 but I'm lazy,
    ;  so choose your part yourself

    ; call part1

    mov rdi, "Part 2:"
    mov rsi, 7
    call print_string
    call print_new_line

    call part2

    call exit

section .data
    file_name db "./input", 0
    file_content_length dw 10000

section .bss
    tmp resq 1
    fd_out resq 1
    fd_in resq 1
    file_content resb 10000
