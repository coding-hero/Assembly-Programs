;the result will be saved in st1 !
section .data
	n	dd 5
	x	dq 2
	temp	dq 0
section .text
	global _start
_start:
	mov ecx ,dword[n]
lp:
	cmp ecx ,1
	jge do
	jmp end	
do:	
	mov ebx ,ecx
	call pow
	
	mov ebx ,ecx
	call fact
	
	mov qword[temp] ,rax
	fdiv qword[temp]
	faddp st1 ,st0
	dec ecx
	jmp lp
;//////////////////////////////////////////////////	
pow:
	cmp ebx ,0
	jg rec
	fld1
	ret
rec:
	dec ebx
	call pow
	inc ebx
	fmul qword[x]
	ret
;//////////////////////////////////
fact:
	cmp ebx ,1
	jg recf
	mov rax ,1
	ret
recf:
	dec ebx
	call fact
	inc ebx
	mul ebx
	ret
;////////////////////
end:
	mov eax ,1
	mov ebx ,0
	int 80h
