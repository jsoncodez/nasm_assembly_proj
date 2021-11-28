        section .data
string_req:     db      "Enter a string: ", 10
len_s           equ     $-string_req

num_req:        db      "Enter a number (1-99): ", 10
len_n           equ     $-num_req

new_line        db      10
single_num      db      0
dbl_num         db      10




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
	;mov	rdx, 3 
	syscall
	
num_convert:
	mov	r8, num_buff
	add	r8, 0 
	mov	al, [r8]
	mov	[decimal_buff], al
	xor	r9, r9
	mov	r9b, [decimal_buff]
	sub	r9b, 48

	mov	rax, 1
	mov	rdi, 1
	mov	rsi, decimal_buff
	mov	rdx, 1
	syscall

        mov     r8, num_buff
        add     r8, 1
        mov     al, [r8]
        mov     [decimal_buff], al
        xor     r10, r10
        mov     r10b, [decimal_buff]
        sub     r10b, 48

        mov     rax, 1
        mov     rdi, 1
        mov     rsi, decimal_buff
        mov     rdx, 1
        syscall


	;mov	rax, 0
	;mov	rdi, 0
	;mov	rsi, num_buff
	;mov	rdx, 1
	;syscall
	
	;xor	r8, r8
	;mov	r8, [decimal_buff]
	;sub	r8, 48


	
	;mov	rax, 0
	;mov	rdi, 0
	;mov	decimal_buff, 
	;xor	r8, r8	
	;mov	r8, num_buff
	;xor	r9, r9
	

	;mov	r9, rdx
	;add	r8, r9
	;mov	al, [r8]
	;mov	[decimal_buff], al
	
	
;	xor	r9, r9
;	mov	r9b, [num_buff]

	;dec	rax
	;xor r10, r10
	;mov	r10b, [num_buff]
exit:
        mov     rax, 60
        xor     rdi, rdi
        syscall
