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
fmt_s:          db      "%s", 10, 0          ; The printf format, "\n",'0'



       section .bss
string_buff:    resb    255 ;stores input string_req from user
num_buff:       resb    3 ;stores input num_req from user
char_buff:      resb    1
decimal_buff:   resb    1
result:         resb    255
half_buff:      resb    255


        section .text
        global main

print:
        mov     rax, 1
        mov     rdi, 1
	mov	rsi, half_buff
	mov	rdx, 1 
        syscall
        ret

main:
        xor rax, rax
        xor r9, r9
        xor r12, r12
        xor rsi, rsi

user_string:
        ;prints out enter a string prompt from section.data
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, string_req
        mov     rdx, len_s
        syscall

        ;what's reading in from stdin input - keyboard
        mov     rax, 0
        mov     rdi, 0
        mov     rsi, string_buff ;stores input into string_buff
        mov     rdx, 255 ;check to see if this can be changed dyanmically from string_req - len_s
        ;remember enter key counts as a character
        syscall

        mov     rdx, rax ;gets length of string
	xor     r9, r9
	xor	r15,r15
        
	xor     rdx, rdx
        mov     r15, 2
        div     r15
        mov     r15, rax
	mov	rdx, rax	


	xor	r8, r8
	mov	r8, string_buff
	mov	r9, 0
	mov	r10, 0
	xor	r11, r11	
base_loop:
	cmp	r9, r15
	jne	half_loop
	;call	print
	ret
	

	
half_loop:
	add	r8, r9
	mov	al, [r8]
	;mov	[char_buff], al
	push	rax
	;call	print
	
	inc	r9
	call	base_loop	

	;cmp	r9, r15 
	;jne	half_loop
	
	pop	rax
	
	mov	[char_buff], al
	;dd	r11, r10
	;mov	[r11], al
	;inc	r10	
	;mov	byte[half_buff], al
		;byte[half_buff]
	call	print
	ret

	


;add	r8, r9
	;inc	r9
;
;	mov	al, [r8]
;	mov	[char_buff], al
;	mov	byte [half_buff], al 
	;push	char_buff
	;xor	r11, r11
	
	

	;cmp	r9, rdx
	;jne	half_loop


	;mov	rax, 0
	;mov	rdi, 0
	;mov	rsi, half_buff
	;mov	rdx, r15 
	;syscall
;pop_loop:
;	pop	char_buff
;	call	print
;	
;	dec	r9
;	cmp	r9, 0
	
;	jnz	pop_loop
	
	
exit:

        mov     rax, 60
        xor     rdi, rdi
        syscall	
