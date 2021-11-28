;Name: Jason Song
;Class: cmsc313
;Project name: Project 3 - transform.asm
;Date: 11/5/2021
;Description:
;
;
;  TRANSFORM1.ASM
;
;




       extern  printf
        section .data
string_req:     db      "Enter a string: ", 10
len_s:          equ     $-string_req


num_req:        db      "Enter a number (1-99): ", 10
len_n:          equ     $-num_req

new_line:       db      10
single_num:     db      0
b_ten:          db      10
rand_seed:      db      0
randnum:        dq      0

fmt:            db      "%ld = maxrand(%ld,%ld)",10,0




       section .bss
string_buff:    resb    255 ;stores input string_req from user
num_buff:       resb    3 ;stores input num_req from user
char_buff:      resb    1
decimal_buff:   resb    1
result:         resb    255



        section .text
        global main

print:
        mov rax, 1
        mov rdi, 1
        syscall
        ret


main:
        ;prints out enter a number prompt
        ;mov rax, 1 ;put 1 in rax to write
        ;mov rdi, 1 ;put 1 for rdi to write to standard out stdout
        ;mov rsi, num_req ;rsi is a pointer to the buffer we are reading from
        ;mov rdx, len_n ;prints out how many characters are in len_n
        ;syscall
        xor rax, rax
        xor r9, r9
        xor rsi, rsi

user_num:
        mov rax, 1 ;put 1 in rax to write
        mov rdi, 1 ;put 1 for rdi to write to standard out stdout
        mov rsi, num_req ;rsi is a pointer to the buffer we are reading from
        mov rdx, len_n ;prints out how many characters are in len_n
        syscall

        mov     rax, 0
        mov     rdi, 0
        mov     rsi, num_buff
        ;mov    rdx, 3
        syscall
        ;include loop jcc for #'s outside of 1-99 - probably do a call to convert #'s
        ;mov    rdi, rax        ; probably use for indexing for loop for integer conversion

num_convert:
        ;can remove r8 most likely already stored in rsi

        mov     r8, num_buff
        add     r8, 0
        mov     al, [r8]
        mov     [decimal_buff], al
        xor     r9, r9
        mov     r9b, [decimal_buff]
        sub     r9b, 48
        imul    r9, [b_ten]

        ;mov    rax, 1
        ;mov    rdi, 1
        ;mov    rsi, decimal_buff
        ;mov    rdx, 1
        ;syscall

        mov     r8, num_buff
        add     r8, 1
        mov     al, [r8]
        mov     [decimal_buff], al
        xor     r10, r10
        mov     r10b, [decimal_buff]
        sub     r10b, 48
        add     r9, r10



        ;starting maxrand gen rng
        xor     rsi, rsi
        xor     rdi, rdi
        mov     rdi, r9
        ;mov    rsi, [max_num] ;rsi stores address probably?

        mov     rsi, 99 ;rsi stores address probably?

        call    maxrand

        mov     [randnum], rax

        mov     rdi, fmt
        mov     rsi, [randnum]
        mov     rdx, r9
        mov     rcx, 99
        mov     rax, 0
        call    printf

  jmp exit
        ;mov     rax, 1
        ;mov     rdi, 1
        ;syscall

maxrand:
        ;parameters: int seed, int max
        ; is random_seed recursive?????? ask


        ;mov    random_seed, 0
        ;mov    rdi     ;rdi = user int input-> due to equation, will be acting as random_seed

        mov     rax, rdi
        mov     rcx, 1103515245
        mul     rcx

        add     rax, 12345
        add     rax, [rand_seed]        ;future proofing?

        ;xor    rdx, rdx

        xor     rdi, rdi
        mov     rdi, 65536
        div     rdi                     ;rax dividend and quotient, rdx remainder

        push    rax

        add     rsi, 1  ;rsi = max number + 1
        xor     rdx, rdx

        ;mov    rdx, rax
        ;mov    rdi, rsi        ;divide by max+1
        ;div    rdx
        div     rsi
        mul     rsi

        mov     rdi, rax
        pop     rax
        sub     rax, rdi

        ;mov    rdi, rsi
        ;mul    rax


        ret

user_string:
        ;prints out enter a string prompt from section.data
        mov rax, 1 
        mov rdi, 1
        mov rsi, string_req
        mov rdx, len_s
        syscall
        
        ;what's reading in from stdin input - keyboard
        mov rax, 0
        mov rdi, 0
        mov rsi, string_buff ;stores input into string_buff
        mov rdx, 255 ;check to see if this can be changed dyanmically from string_req - len_s
        ;remember enter key counts as a character
        syscall
        
        call print ;calls print label and prints out string unedited

        mov r8, string_buff
        xor r9, r9

        mov r9, [num_buff]
        sub r9, 48
        add r8, r9
        mov al, [r8]
        mov [char_buff], al

        mov rax, 1
        mov rdi, 1
        mov rsi, char_buff
        mov rdx, 1
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall


exit:
        mov     rax, 60
        xor     rdi, rdi
        syscall

