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
two_buff:      resb    2


        section .text
        global main


main:
	xor	r8, r8


	
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





 ;       xor     r9, r9
;
;
 ;       xor     r8, r8
	

	
        xor     rdx, rdx
        
	mov     r15, 2
        div     r15
        mov     r15, rax


	
	xor	r8, r8
	mov	r8, string_buff
	;call	print
	
;	mov	rdx, r15
	
	add	r8, r15
		
	mov	rdi, r8
	;mov	r9, rdi
	call 	count
	call	recurse

	call	exit

exit:
	mov	rax, SYSCALL_EXIT
	xor	rdi, rdi
	syscall
print_char:
		
	mov	rax, rdi
	xor	rdx, rdx

	mov	rsi, rax 
	mov	rax, SYSCALL_WRITE
	mov	rdi, STDOUT

	syscall
	ret
print:
	
	mov	rax, rdi
	xor	rdx, rdx


count:
	cmp	[rdi], byte 0
	je	end_count
	inc	rdx
	inc	rdi
	jmp	count

end_count:
	;mov	rdi, string_buff
	;add	rdi, rdx
	;dec	rdi

	mov	rsi, rax	
	mov	rax, SYSCALL_WRITE
	mov	rdi, STDOUT
	syscall
	ret

recurse:
	cmp	rdx, 0
	jge	rcont
	ret


rcont:
	mov	al, byte[r8]	; was byte r8
	push	rax
	inc	r8	;was r8
	dec	rdx
	call	recurse
	xor	rax, rax
	pop	rax
	;mov	[char], al
	mov	[char], al
	;mov	rdi, char
	mov	rdi, char
	call	print

	ret



	
	;need some kind of
	
	;add	r9, rdx
	;mov	bl, byte[r9] ;using rdx as counter	
	
	;mov	al, byte[r9]
	;call	print_char
	;mov	char	
	;inc	r9
	;mov	[char], al	;change char to 2 byte
	;mov	rdi, char
	;call	print
	;ret
	
	;add	r8,   
	;mov	al, byte[r8]	
	;push	rax
	;;dec	rdi
	;inc	r8
	;dec	rdx
	;call	recurse
	;xor	rax, rax
	;pop	rax
	;mov	[char],al
	;mov	rdi, char	
	;call	print
	;ret


