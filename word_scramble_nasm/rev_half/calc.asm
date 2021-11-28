%define STDOUT 1
%define STDIN 0
%define SYSCALL_EXIT 1
%define SYSCALL_WRITE 4
%define SYSCALL_READ 3

section .data           ;line 1
        msg     db      "Sum is: "
        len     equ     $ - msg
        msg2    db      "Enter number : "
        len2    equ     $ - msg2
        eol     db      0xA, 0xD
        eol_len equ     $ - eol

section .bss
        input1  resb    2
        input2  resb    2
        sum     resb    4

section .text
global main

;subroutine definitions
print_int:
        mov eax, SYSCALL_WRITE  ;defining routine print_int
        mov ebx, STDOUT         ;file descriptor (stdout)
        int 0x80                ;system call number(sys_write)
        ret                     ;return back

read_int:
        mov eax, SYSCALL_READ
mov ebx, STDIN
        int 0x80
        ret

main:                           ;line 29
        mov ecx, msg2
        mov edx, len2
        call print_int

        mov ecx, input1
        mov edx, 2
        call read_int

        mov ecx, msg2
        mov edx, len2
        call print_int

        mov ecx, input2
        mov edx, 2
        call read_int

        xor     eax,eax
        mov     al, [input1]
        sub     eax, '0'
        xor     ebx,ebx
        mov     bl, [input2]
        sub     ebx, '0'
        add     eax, ebx
        add     eax, '0'

        mov [sum], eax

        mov ecx, msg
        mov edx, len
        call print_int

        mov ecx, sum
        mov edx, 1
        call print_int

        mov ecx, eol
        mov edx, eol_len
        call print_int

        mov eax, SYSCALL_EXIT   ;system call number (sys_exit)
        xor ebx, ebx
        int 0x80                ;line 71

