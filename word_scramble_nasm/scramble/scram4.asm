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
fmt_s:          db      "0x%x", 10, 0          ; The printf format, "\n",'0'



       section .bss
string_buff:    resb    255 ;stores input string_req from user
num_buff:       resb    3 ;stores input num_req from user
char_buff:      resb    1
decimal_buff:   resb    1
result:         resb    255
half_buff:      resb    255


        section .text
        global main

print_char:
        mov     [char_buff], al
	;mov	rsi, al
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, char_buff
        mov     rdx, 1
        syscall
        ret

print_nl:
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, new_line
        syscall
        ret

main:
        xor r9, r9
        xor r12, r12

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


        xor     r14, r14
        mov     r14, rax
        sub     r14,1 
	sub	rax, 1
        mov     rdx, rax ;gets length of string
        xor     r13, r13
        mov     r13, rax
        xor     r9, r9
        xor     r15,r15

        xor     rdx, rdx
        mov     r15, 2
        div     r15
        mov     r15, rax

        mov     rdx, rax


        xor     r8, r8
        mov     r8, string_buff

        add     r8, r15
        mov     r9, string_buff
        ;mov     r9, 0
        ;xor     r10, r10
        ;xor     r11, r11


        mov     rbx, r8
        ;mov    rbx,r8
        mov     r14, 0 

FOR_COUNT:
	mov	al, byte [rbx]
	cmp	al, 0
	;cmp	r9, r15
	je	END_COUNT
	
	;call	print_char
	;call	print_nl
	inc	rbx
	inc	r14
	;inc	r14
	jmp	FOR_COUNT
END_COUNT:
	mov	rdi, r8
	mov	rbx, r8
	;mov	rbx, r8
	add	rbx, r14
	dec	rbx	;puts at tail of the string
	dec	rbx
	;ov	r14, rcx
 whileReverse:
	mov	al, byte[r9]
	inc	r9
	call	print_char
	dec	r13	
	cmp	r13, 0
	je	exit

	mov     al, byte[rbx]              ;save value of last marker into a temp register\
	push	rsi
	push	rdi	
	call	print_char
	dec	r13

	pop	rdi
	pop	rsi
		
	dec	rbx
	
	cmp	r13,0
	ja 	whileReverse
 

	;call	whileStart
	;xor	rax, rax
	;mov	al, byte[rbx]
	;call	print_char

;hileStart:
;	xor	rax, rax
;	mov	al, byte[rdi]
;1	call	print_char
	
	;call	print_char
	;mov	dl, al
	;call	print_char
	
	;mov	al, byte[rbx]

	
	call	print_nl
	jmp exit		
	



	;mov     dl,byte[rdi]              ;save value of first marker into a temp register
	;mov     [ebx], ecx              ;save value in ecx to the memory location pointed by ecx
	;mov     [eax], edx              ;save value in edx to the memory location pointed by eax
	;inc     ebx                     ;increment first marker, i.e,move closer to the centre
	;dec     eax                     ;decrement last marker
	;cmp     eax, ebx                ;if first marker is larger then the second marker, then swapping is done
	;ja      whileReverse

    ;whileReverseEnd:

;    pop
    

exit:
	call	print_nl
        mov     rax, 60
        xor     rdi, rdi
        syscall

