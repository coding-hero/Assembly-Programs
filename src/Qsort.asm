%macro swap 2
	push %1
	push %2
	pop %1
	pop %2
%endmacro
section .data
	A dq 3,7,5,1
	len equ ($-A)/8
	R dq $-8
	L dq A
section .text
	global _start
_start:
	push qword[L]
	push qword[R]
	call Qsort
	mov eax ,1
	int 80h
Qsort:
	enter 16,0
lp:
	mov rsi ,[rbp+24]
	mov rdi ,[rbp+16]
	cmp rsi ,rdi
	jge end
	mov rax ,[rdi]
	mov [rbp-16] ,rax
	sub rsi ,8
	mov [rbp-8],rsi
	mov rcx ,[rbp+24]
do:
	cmp rcx ,[rbp+16]
	jge next
	mov rbx ,[rcx]
	cmp rbx ,[rbp-16]
	jg greater
	add qword[rbp-8] ,8
	mov rdx ,qword[rbp-8]
	swap qword[rdx] ,qword[rcx]
greater:
	add rcx ,8
	jmp do
next:
	add qword[rbp-8] ,8
	mov rdx ,[rbp-8]
	swap qword[rdx] ,qword[rdi]
	mov qword[rbp-8] ,rdx
	push qword[rbp+24]
	sub qword[rbp-8] ,8
	push qword[rbp-8]
	call Qsort
	add qword[rbp-8] ,8
	push qword[rbp-8]
	push qword[rbp+24]
	call Qsort
end:
	leave
	ret 16
	
