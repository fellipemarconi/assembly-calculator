.global _start
.intel_syntax noprefix

.section .text

_start:
    call first_number_print
    call read_first_number

    lea rsi, [rip + buffer1]
    call parse_int
    mov r12, rax

    call second_number_print
    call read_second_number

    lea rsi, [rip + buffer2]
    call parse_int
    mov r13, rax

    call operator_print
    call read_operator

    mov al, byte ptr [rip + operator_buffer]

    cmp al, '+'
    je do_add

    cmp al, '-'
    je do_sub

    cmp al, '*'
    je do_mul

    cmp al, '/'
    je do_div

    jmp exit

do_add:
    mov rax, r12
    add rax, r13
    jmp print_result

do_sub:
    mov rax, r12
    sub rax, r13
    jmp print_result

do_mul:
    mov rax, r12
    imul rax, r13
    jmp print_result

do_div:
    mov rax, r12
    xor rdx, rdx
    div r13
    jmp print_result

print_result:
    mov rdi, rax
    call print_int
    jmp exit

first_number_print:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rip + first_number]
    mov rdx, 22
    syscall
    ret

second_number_print:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rip + second_number]
    mov rdx, 23
    syscall
    ret

operator_print:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rip + operator_text]
    mov rdx, 29
    syscall
    ret

read_first_number:
    mov rax, 0
    mov rdi, 0
    lea rsi, [rip + buffer1]
    mov rdx, 32
    syscall
    ret

read_second_number:
    mov rax, 0
    mov rdi, 0
    lea rsi, [rip + buffer2]
    mov rdx, 32
    syscall
    ret

read_operator:
    mov rax, 0
    mov rdi, 0
    lea rsi, [rip + operator_buffer]
    mov rdx, 2
    syscall
    ret

parse_int:
    xor rax, rax

parse_loop:
    mov bl, [rsi]

    cmp bl, 10
    je parse_done

    cmp bl, 0
    je parse_done

    sub bl, '0'

    imul rax, rax, 10

    movzx rbx, bl
    add rax, rbx

    inc rsi
    jmp parse_loop

parse_done:
    ret

print_int:
    mov rax, rdi
    lea rsi, [rip + print_buffer + 31]

    mov byte ptr [rsi], 10
    dec rsi

    mov rbx, 10

convert_loop:
    xor rdx, rdx
    div rbx

    add dl, '0'
    mov byte ptr [rsi], dl

    dec rsi

    test rax, rax
    jnz convert_loop

    inc rsi

    lea rdx, [rip + print_buffer + 32]
    sub rdx, rsi

    mov rax, 1
    mov rdi, 1
    syscall

    ret

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

.section .bss
    buffer1: .skip 32
    buffer2: .skip 32
    operator_buffer: .skip 2
    print_buffer: .skip 32

.section .data
    first_number: .asciz "Type a first number:\n"
    second_number: .asciz "Type a second number:\n"
    operator_text: .asciz "Type operator (+ - * /):\n"
