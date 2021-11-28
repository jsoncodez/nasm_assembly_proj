        section .data
string_req:     db      "Enter a string: ", 10
len_s           equ     $-string_req

num_req:        db      "Enter a number (1-99): ", 10
len_n           equ     $-num_req

new_line        db      10
single_num      db      0
b_ten 	        db      10




        section .bss
string_buff     resb    255 ;stores input string_req from user
num_buff        resb    3 ;stores input num_req from user
decimal_buff    resb    1


        section .text
        global main




main:
	xor	rax, rax
	

user_num:
        mov rax, 1 ;put 1 in rax to write
        mov rdi, 1 ;put 1 for rdi to write to standard out stdout
        mov rsi, num_req ;rsi is a pointer to the buffer we are reading from
        mov rdx, len_n ;prints out how many characters are in len_n
        syscall

	mov	rax, 0
	mov	rdi, 0
	mov	rsi, num_buff
	syscall
	
num_convert:
	mov	r8, num_buff
	add	r8, 0 
	mov	al, [r8]
	mov	[decimal_buff], al
	xor	r9, r9
	mov	r9b, [decimal_buff]
	sub	r9b, 48
	imul	r9, 10


        mov     r8, num_buff
        add     r8, 1
        mov     al, [r8]
        mov     [decimal_buff], al
        xor     r10, r10
        mov     r10b, [decimal_buff]
        sub     r10b, 48
	add	r9, r10

	mov	rax, 1
	mov	rdi, 1	
	syscall

	
exit:
        mov     rax, 60
        xor     rdi, rdi
        syscall
