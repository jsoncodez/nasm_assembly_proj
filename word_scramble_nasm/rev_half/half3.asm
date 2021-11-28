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


print_nl:
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, new_line
        syscall
        ret


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
	

	sub	rax, 1
        xor     rdx, rdx
        
	;sub		rax, 1
    mov     rdx, rax ;gets length of string
    xor     r13, r13
    mov     r13, rax
    xor     r9, r9
    xor     r15,r15

    xor     rdx, rdx
    mov     r15, 2
    div     r15
    mov     r15, rax
		
   	;ov     rdi, string_buff
	;call	print
	
	xor	r8, r8
	mov	r8, string_buff
	
	mov	rdx, r15
	call	recurse

	mov	rdx, r15 
	test	r13, 1
	jne	shift
	jmp	recurse	

	syscall

	
	;mov	rdi, r8
	
	;call 	count
	;dec	rdx
	;call	recurse
	call	print_nl
	call	exit



exit:
	mov	rax, SYSCALL_EXIT
	xor	rdi, rdi
	syscall

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
	;ov	rdi, string_buff
	;add	rdi, rdx
	;dec	rdi
	;dec	rdx
	mov	rsi, rax
	mov	rax, SYSCALL_WRITE
	mov	rdi, STDOUT	
	syscall
	ret
	;jmp exit
;odd_char:

	
	;mov	rax, SYSCALL_WRITE
	;mov	rdi, STDOUT
	;syscall
	;ret
shift:
	sub	rdx, 1	
recurse:
	cmp	rdx, 0
	jge	rcont
	ret


rcont:
	;add	r8,   
	mov	al, byte[r8]	
	push	rax
	;dec	rdi
	inc	r8
	dec	rdx
	call	recurse
	xor	rax, rax
	pop	rax
	mov	[char],al
	mov	rdi, char	
	call	print
	ret







