#i386 assembly
.section .data
n:
	.int 20
.section .text
.global _start
_start:
	nop
	pushl $0
	pushl n			
	call fibonnaci
	popl %eax		#ignore value
	popl %eax		#f(n) :)
	movl $1, %eax
	movl $0, %ebx
	int $0x80
#recursive function implements fibonnaci of n stored at %eax
#caller must push two arguments before calling fibonnaci
#n, and a space for result
fibonnaci:
	pushl %eax
	pushl %ebx
	pushl %ebp
	movl %esp, %ebp	
	movl 16(%ebp), %eax	#get n value
	cmp $1, %eax 		#if n <= 1
	jg fib_recursive
	movl $1, %eax		
	jmp fib_done
fib_recursive:			#else if n > 1
	pushl $0
	addl $-1, %eax
	pushl %eax
	call fibonnaci	
	popl %eax
	popl %ebx		#f(n-1)
	pushl $0
	addl $-1, %eax
	pushl %eax
	call fibonnaci
	popl %eax		#ignore value
	popl %eax		#f(n-2)
	addl %ebx, %eax		#f(n) = f(n-2) + f(n-1)
fib_done:			#fi
	movl %eax, 20(%ebp)	#return f(n)
	movl %ebp, %esp
	popl %ebp
	popl %ebx
	popl %eax
	ret
