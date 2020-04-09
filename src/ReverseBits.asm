;this program is going to reverse bits of rax and put it in rdx

section .data
	num dq 100

section .text
	global _start
_start:
	mov rax ,[num]
	xor rdx ,rdx
	call reverse
	mov eax ,1
	mov ebx ,0
	int 80h
reverse:
do:
	mov rbx ,63
	bsf rcx ,rax
	jz return
	sub rbx ,rcx
	bts rdx ,rbx
	btc rax ,rcx
	jmp do	
return:
	ret
	
