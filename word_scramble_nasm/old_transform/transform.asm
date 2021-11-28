;Name: Jason Song
;Class: cmsc313
;Project name: Project 3 - transform.asm
;Date: 11/5/2021
;Description:
;
;
;
;
;


	section .data
string_req:	db	"Enter a string: ", 10
len_s		equ	$-string_req

num_req:	db	"Enter a number (1-99): ", 10
len_n		equ	$-num_req

new_line	db	10
single_num	db	0
b_ten		db	10




	section .bss
string_buff	resb	255 ;stores input string_req from user
num_buff	resb	3 ;stores input num_req from user
char_buff	resb	1 
decimal_buff	resb	1

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

num_convert:
        mov     r8, num_buff
        add     r8, 0
        mov     al, [r8]
        mov     [decimal_buff], al
        xor     r9, r9
        mov     r9b, [decimal_buff]
        sub     r9b, 48
        imul    r9, 10

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

        mov     rax, 1
        mov     rdi, 1
        syscall
	
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
	mov	rax, 60
	xor	rdi, rdi
	syscall


