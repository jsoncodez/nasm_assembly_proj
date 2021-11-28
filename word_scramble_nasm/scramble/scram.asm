%define STDOUT 1
%define SYSCALL_EXIT 60 
%define SYSCALL_WRITE 1

      extern  printf
        section .data
string_req:     db      "Enter a string: ", 10
len_s:          equ     $-string_req


num_req:        db      "Enter a number (1-99): ", 10
len_n:          equ     $-num_req

char:		db	0, 0
new_line:       db      10
single_num:     db      0
b_ten:          db      10
rand_seed:      db      0

;fmt:            db      "%ld = maxrand(%ld,%ld)",10,0
fmt_s:          db      "%s", 10, 0          ; The printf format, "\n",'0'



       section .bss
string_buff:    resb    255 ;stores input string_req from user
num_buff:       resb    3 ;stores input num_req from user
char_buff:      resb    1
half_buff:      resb    255


        section .text
        global main


print_char:
	mov	[char_buff], al

        mov     rax, 1
        mov     rdi, 1
	mov	rsi, char_buff
	mov	rdx, 1
        syscall
        ret

print_nl:
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, new_line
	syscall
	ret

main:
        xor	r9, r9
        xor	r12, r12	
	xor	rbx, rbx

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
        mov     rdx, 100 ;check to see if this can be changed dyanmically from string_req - len_s
        ;remember enter key counts as a character
        syscall

        ;mov     rdx, rax ;gets length of string
        ;call printf  ;calls print label and prints out string unedited
       ; call    print
        ;mov    r8, string_buff
	mov	rdx, rax
	mov	r9, rdx
        ;mov     r15, rax
	mov	rbx, string_buff
	mov	rdi, string_buff
	mov rcx, 0



FOR_COUNT:
	mov	al, byte [rbx]
	cmp	al, 0
	je	END_COUNT
	
	inc	rbx
	inc	rcx
	;inc	r9
	jmp	FOR_COUNT
	
	
END_COUNT:

	mov	rbx, string_buff
	add	rbx, rcx
	dec	rbx	;puts at tail of the string
	
	;ov	r14, rcx
	;jmp FOR_CHAR
;front:
;	cmp	rdi, 0
;	je	END_FOR_CHAR
;	mov	al, byte[rdi]
;	call	print_char
;	inc	rdi
;	jmp	FOR_CHAR
;	

front_char:
	push	rbp
	cmp	r9, 0
	je	END_FOR_CHAR
	mov	al, byte [rbx]
	call	print_char
	inc	rdi
	;dec	rcx
	dec	r9	
	call	FOR_CHAR

FOR_CHAR:
	cmp	r9, 0  
	je	END_FOR_CHAR
	mov	al, byte [rbx]
	call	print_char
	call	print_nl
	dec	rbx
	dec	rcx
	dec	r9
	ret
	;jmp	front_char
	;jmp	FOR_CHAR
	
	; take a counter from both sides, one subtraction, the other addition, cmp when the = eachother or are opposites


	
	
END_FOR_CHAR:
	call	print_nl	
	jmp	exit
	

	call	print_char
        ;add     r8, r9
        ;add	r8, rdx
	;mov     al, [r8]
        ;mov     [char_buff], al



	;ov	r11b, al
        ;inc    r10
        ;mov    byte[half_buff], al
                ;byte[half_buff]




        ;cmp    r9, rdx
        ;jne    half_loop


        ;mov    rax, 0
        ;mov    rdi, 0
        ;mov    rsi, half_buff
        ;mov    rdx, r15
        ;syscall
;pop_loop:
;       pop     char_buff
;       call    print
;
;       dec     r9
;       cmp     r9, 0

;       jnz     pop_loop


exit:

        mov     rax, 60
        xor     rdi, rdi
        syscall
