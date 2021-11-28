;REVERSE HALF PART OF PROJ3 - TRANSFORM.ASM

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

;fmt:            db      "%ld = maxrand(%ld,%ld)",10,0
fmt_s:    	db 	"%s", 10, 0          ; The printf format, "\n",'0'



       section .bss
string_buff:    resb    255 ;stores input string_req from user
num_buff:       resb    3 ;stores input num_req from user
char_buff:      resb    1
decimal_buff:   resb    1
result:         resb    255
half_buff:	resb	255


        section .text
        global main

print:
	mov	rax, 1
	mov	rdi, 1
	syscall
	ret	

main:
        xor rax, rax
        xor r9, r9
	xor r12, r12
        xor rsi, rsi

user_string:
        ;prints out enter a string prompt from section.data
        mov	rax, 1 
        mov	rdi, 1
        mov	rsi, string_req
        mov 	rdx, len_s
        syscall
        
        ;what's reading in from stdin input - keyboard
        mov 	rax, 0
        mov 	rdi, 0
        mov 	rsi, string_buff ;stores input into string_buff
        mov 	rdx, 255 ;check to see if this can be changed dyanmically from string_req - len_s
        ;remember enter key counts as a character
        syscall
        
	mov 	rdx, rax ;gets length of string
        ;call printf  ;calls print label and prints out string unedited
	call	print
        ;mov 	r8, string_buff
        xor 	r9, r9
	

half:
	;getting the 1st half tester area

	xor	r11, r11
	xor	r12, r12
	xor	r13, r13
	xor	r14, r14
	xor	r15, r15

	xor	rdx, rdx
	mov	r11, 2
	div	r11
	mov	r11, rax

	
	xor	r8, r8	
	mov	r8, string_buff
	add	r8, r11
	
	;mov	r12, [r8]
	;mov	[half_buff], r12

	
	
	mov	rax, 1 
	mov	rdi, 1
	mov	rsi, r8
	;mov	rsi, half_buff
	mov	rdx, r11 
	syscall
	
	;mov	rdx, r11
	mov	r9, string_buff	
	mov	rbx, 0		
	mov	rcx, 2
	
	mov	rsi, r9
	
	mov	rax, 1
	mov	rdi, 1
	mov	rsi,r9
	syscall

	;mov	rax, 1
	;mov	rdi, 1
	;mov	rsi, r13
	;mov	rdx, 255
	;syscall
	
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, new_line
	mov	rdx, 1
	syscall 

	jmp	exit
;half_string:
	
	;push
exit:
        mov     rax, 60
        xor     rdi, rdi
        syscall

