;;;;;Author: Jason Song
;;;;;User ID: FB79801
;;;;;Description:  This program prompts the user foor number and string input.  Based on user integer input 1-99, converts ascii to decimal and RNG
;;;;;to randomly determine transformation of the user inputted string using the moethod of Reverse Halves and predetermined Scrambling
;;;;;
;;;;
;;;;;
;;;;
;;;;;
;;;;



%define STDOUT 1
%define SYSCALL_EXIT 60 
%define SYSCALL_WRITE 1

        section .data

string_req:     db      "Enter a string: ", 10
len_s:          equ     $-string_req


num_req:        db      "Enter a number (1-99): ", 10
len_n:          equ     $-num_req

char:		db	0, 0
new_line:       db      10
single_num:     db      0
rand_seed:      db      0
randnum:	db	0

       section .bss
string_buff:    resb    255 ;stores input string_req from user
num_buff:       resb    3 ;stores input num_req from user
char_buff:      resb    1
char2_buff:	resb	1
half_buff:      resb    255
decimal_buff:	resb	1
        section .text
        global main


main:
	xor	rsi, rsi


;USER INT INPUT PROMPT
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

;CONVERTS #'S FROM ASCII TO DECIMAL	
num_convert:
	; calculates the 2 numbers seperately, will be switching this loop provide flexibility and prevent higher/lower numbers and edge cases
        mov     r8, num_buff
        add     r8, 0
        mov     al, [r8]
        mov     [decimal_buff], al
        xor     r9, r9
        mov     r9b, [decimal_buff]
        sub     r9b, 48
        imul    r9, 10

        mov     r8, num_buff
        inc     r8
        mov     al, [r8]
        mov     [decimal_buff], al
        xor     r10, r10
        mov     r10b, [decimal_buff]
        sub     r10b, 48
        add     r9, r10
	
		 
	;starting maxrand gen rng
	xor	rsi, rsi
	xor	rdi, rdi
	mov	rdi, r9

	mov	rsi, 99	;max number 

	call	maxrand
	
	mov	[randnum], rax	;stores the rng for use to determine scramble selection
	
	jmp user_string

;RNG
maxrand:
	mov	rax, rdi
	mov	rcx, 1103515245
	mul	rcx
	
	add	rax, 12345
	
	;xor	rdx, rdx
	mov	rbx, 65536
	div	rbx 			;rax dividend and quotient, rdx remainder
	
	push	rax	;save value to be subtracted later		
	
	add	rsi, 1	;rsi = max number + 1
	xor	rdx, rdx

	div	rsi	
	mul	rsi
	
	mov	rdi, rax
	pop	rax
	sub	rax, rdi
			
	ret	


;USER STRING INPUT PROMPTS

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

	xor     r14, r14
        mov     r14, rax
        sub     r14, 1 
	sub	rax, 1 ;num of char - 1 to reflect range w/o  newline
	
	mov     rdx, rax ;gets length of string
        xor     r13, r13
        mov     r13, rax
        xor     r9, r9
 	xor     rdx, rdx
        
	;halfway point of string calc
	mov     r15, 2
        div     r15
        mov     r15, rax
	xor	r8, r8
	mov	r8, string_buff


;DETERMINE METHOD - chooses string augment based on even odd
;test - logical comparison, checking to see if lower bit is 1, therefor determining it's NOT divisible by 2 (AND) without affecting original value
transform_select:	
	test	byte[randnum], 1
	jne	select_halfRev
	jmp	select_scramble	

;SCRAMBLE PRIMER

select_scramble:
	add     r8, r15
        mov     r9, string_buff
	mov     rbx, r8
	mov     r14, 0 
	call	char_count


;HALFREVERSE PRIMER
select_halfRev:
   	mov     rdi, string_buff
	call	print
	

	mov	rdx, r15
	call	base_stack

	
	mov	rdx, r15
	test	r13, 1
	jne	shift	;subtracts 1 from rdx counter to forgo /n
	;jmp	base_stack
	
	syscall
	jmp	exit


;FROM HALF REVERSE MAIN BODY

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
	mov	rsi, rax
	mov	rax, SYSCALL_WRITE
	mov	rdi, STDOUT	
	syscall
	ret

shift:	;shifts string by one character in even number instances
	sub	rdx, 1	

base_stack:
	cmp	rdx, 0
	jge	char_stack
	ret


char_stack:
	mov	al, byte[r8]	
	push	rax	;pushes character in rax- when popped placing them in reverse order
	inc	r8
	dec	rdx
	call	base_stack
	xor	rax, rax
	pop	rax
	mov	[char],al ;stores address into char data, will be used to print
	mov	rdi, char	
	call	print
	ret

;SCRAMBLE MAIN BODY
	
print_char:	;converts and stores char into buffer for print use
        mov     [char_buff], al
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

char_count:
	mov	al, byte [rbx]
	cmp	al, 0
	je	end_char
	;call	print_char	;due to how loop setup, output only 2nd half of unedited string - will need to adjust/modify to output whole string at some point
	inc	rbx
	inc	r14
	jmp	char_count
end_char:
	mov	rdi, r8
	mov	rbx, r8
	add	rbx, r14 ;rbx points at last char in string "/n"
	dec	rbx	;puts rbx pointer at first end char  of the string
	dec	rbx
scramble:
	mov	al, byte[r9]
	inc	r9
	call	print_char
	dec	r13	
	cmp	r13, 0
	je	exit

	mov     al, byte[rbx]     ;save value of last marker into a temp register\
	push	rsi	;pushes rsi and rdi data onto stack for restoration after print call
	push	rdi	
	call	print_char
	dec	r13	;counter

	pop	rdi
	pop	rsi
		
	dec	rbx
	
	cmp	r13,0
	ja 	scramble
	
	call	print_nl
	jmp exit	

;EXIT
exit:
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, new_line
	syscall

        mov     rax, 60
        xor     rdi, rdi
        syscall
