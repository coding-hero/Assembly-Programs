;this program is going to count the numbers of 1 bits in rax

section .data
	num dq 100

section .text
	global _start
_start:
	mov rax ,[num]
	xor rbx ,rbx
	call count
	mov eax ,1
	mov ebx ,0
	int 80h
count:
do:
	bsf rcx ,rax
	jz return
	inc bl
	btc rax ,rcx
	jmp do	
return:
	ret
