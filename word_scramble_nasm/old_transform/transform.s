	.file	"transform.c"
	.text
	.globl	maxrand
	.type	maxrand, @function
maxrand:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$0, -4(%rbp)
	movl	-20(%rbp), %eax
	imull	$1103515245, %eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	addl	$12345, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	leal	65535(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$16, %eax
	movl	%eax, %edx
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %ecx
	movl	%edx, %eax
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	maxrand, .-maxrand
	.ident	"GCC: (GNU) 11.2.1 20210728 (Red Hat 11.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
