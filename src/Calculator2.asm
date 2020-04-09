section .bss
	input resb 100
	input_len equ $-input
section .data
	msg db 'Enter e to exit',10
	msg_len equ $-msg
	ten dd 10.0
	zero dd 0.0
	thousand dd 100.0
	make_Neg db 0
	isNeg db 0
	negSign db '-'
	lenS equ 1
	Ne dd -1.0

section .text
	global _start
_start:
	movss xmm3 ,dword[zero]
	mov eax ,4
	mov ebx ,1
	mov ecx ,msg
	mov edx ,msg_len
	int 80h
Lp:
	mov eax ,3
	mov ebx ,0
	mov ecx ,input
	mov edx ,input_len
	int 80h
	
	mov edi ,0
	cmp byte [input] ,'e'
	je Exit
	cmp byte [input] ,'-'
	jne E
	cmp byte [input+1] ,'-'
	je nn
	mov byte [make_Neg] ,1
	mov edi ,1
	jmp E
nn:
	mov byte [input+1] ,'+'
	mov edi ,1
E:	
	xor eax ,eax
	xor ebx ,ebx
	movss xmm0 ,dword[zero]
	movss xmm1 ,dword[zero]
top:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb next1
	cmp bl ,'9'
	ja next1
	sub bl ,'0'
	mulss xmm0 ,dword[ten]
	cvtsi2ss xmm1 ,ebx
	addss xmm0 ,xmm1
	jmp top
next1:
	cmp bl ,'.'
	jne next2
	movss xmm2 ,dword[ten]
lp1:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb next2
	cmp bl ,'9'
	ja next2
	sub bl ,'0' 
	cvtsi2ss xmm1 ,ebx
	divss xmm1 ,xmm2
	addss xmm0 ,xmm1
	mulss xmm2 ,xmm2
	jmp lp1
next2:
	cmp bl ,'+'
	je add1
	cmp bl ,'*'
	je mul1
	cmp bl ,'/'
	je div1
	cmp bl ,'-'
	je sub1
	cmp bl ,'='
	je sub1
	jmp sub1
;==================================
Print:
	movss xmm3 ,xmm0
	mulss xmm0 ,dword[thousand]
	cvtss2si eax ,xmm0
	mov rcx ,0
	mov ebx ,10
	ucomiss xmm3 ,dword[zero]
	jae isPos
	mov byte [isNeg] ,1
	neg eax
	jmp divLp
isPos:
	mov byte [isNeg] ,0
divLp:
	xor edx ,edx
	div ebx
	push rdx
	inc rcx
	cmp eax ,0
	jne divLp
	mov edi ,0
popLp:
	pop rax
	add al ,'0'
	cmp rcx ,2
	jne nx
	mov byte [input+edi] ,'.'
	inc edi
nx:
	mov byte [input+edi] ,al
	inc edi
	loop popLp
	mov byte [input+edi] ,0
	inc edi

	cmp byte [isNeg] ,1
	jne Prp
	mov eax ,4
	mov ebx ,1
	mov ecx ,negSign
	mov edx ,lenS
	int 80h
Prp:
	mov eax ,4
	mov ebx ,1
	mov ecx ,input
	mov edx ,edi
	int 80h
	jmp Lp
;============================================================
add1:
	addss xmm3 ,xmm0
	cmp byte [make_Neg] ,1
	jne p
	mulss xmm3 ,[Ne]
p:	
	xor eax ,eax
	xor ebx ,ebx
	movss xmm0 ,dword[zero]
	movss xmm1 ,dword[zero]
topA:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb nextA
	cmp bl ,'9'
	ja nextA
	sub bl ,'0'
	mulss xmm0 ,dword[ten]
	cvtsi2ss xmm1 ,ebx
	addss xmm0 ,xmm1
	jmp topA	
nextA:
	cmp bl ,'-'
	je sb1
	cmp bl ,'.'
	je nxtA
next2A:
	addss xmm0 ,xmm3
	jmp Print
nxtA:
	movss xmm2 ,dword[ten]
lpA:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb next2A
	cmp bl ,'9'
	ja next2A
	sub bl ,'0' 
	cvtsi2ss xmm1 ,ebx
	divss xmm1 ,xmm2
	addss xmm0 ,xmm1
	mulss xmm2 ,xmm2
	jmp lpA	
sb1:
	movss xmm0 ,xmm3
	movss xmm3 ,dword[zero]
	jmp sub1
;=========================================================================================
sub1:
	ucomiss xmm3 ,dword[zero]
	je fo
	subss xmm3 ,xmm0
	ucomiss xmm3 ,dword[zero]
	jge mps
	movss xmm0 ,xmm3
	jmp Print
mps:
	mov byte [make_Neg] ,0
	movss xmm0 ,xmm3
	jmp Print
fo:
	addss xmm3 ,xmm0
	cmp byte[make_Neg] ,1
	jne ps
	mulss xmm3 ,[Ne]
	mov byte[make_Neg] ,0
ps:
	xor eax ,eax
	xor ebx ,ebx
	movss xmm0 ,dword[zero]
	movss xmm1 ,dword[zero]
topS:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb nextS
	cmp bl ,'9'
	ja nextS
	sub bl ,'0'
	mulss xmm0 ,dword[ten]
	cvtsi2ss xmm1 ,ebx
	addss xmm0 ,xmm1
	jmp topS
nextS:
	cmp bl ,'-'
	je ad1
	cmp bl ,'.'
	je nxtS
next2S:
	subss xmm3 ,xmm0
	movss xmm0 ,xmm3
	jmp Print
nxtS:
	movss xmm2 ,dword[ten]
lpS:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb next2S
	cmp bl ,'9'
	ja next2S
	sub bl ,'0' 
	cvtsi2ss xmm1 ,ebx
	divss xmm1 ,xmm2
	addss xmm0 ,xmm1
	mulss xmm2 ,xmm2
	jmp lpS	
ad1:
	movss xmm0 ,xmm3
	movss xmm3 ,dword[zero]
	jmp add1
;===================================================================
mul1:
	addss xmm3 ,xmm0
	cmp byte [make_Neg] ,1
	jne pm
	mov byte[make_Neg] ,0	
pm:
	xor eax ,eax
	xor ebx ,ebx
	movss xmm0 ,dword[zero]
	movss xmm1 ,dword[zero]
topM:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb nextM
	cmp bl ,'9'
	ja nextM
	sub bl ,'0'
	mulss xmm0 ,dword[ten]
	cvtsi2ss xmm1 ,ebx
	addss xmm0 ,xmm1
	jmp topM
nextM:
	cmp bl ,'-'
	jne M
	mov byte [make_Neg] ,1
	jmp pm
M:
	cmp bl ,'.'
	je nxtM
next2M:
	cmp byte [make_Neg] ,1
	jne m
	mulss xmm0 ,[Ne]
m:
	mulss xmm0 ,xmm3
	movss xmm3 ,xmm0
	ucomiss xmm3 ,dword[zero]
	jae mp
	jmp Print
mp:
	mov byte [make_Neg] ,0
	jmp Print
nxtM:
	movss xmm2 ,dword[ten]
lpM:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb next2M
	cmp bl ,'9'
	ja next2M
	sub bl ,'0' 
	cvtsi2ss xmm1 ,ebx
	divss xmm1 ,xmm2
	addss xmm0 ,xmm1
	mulss xmm2 ,xmm2
	jmp lpM	
;===========================================================================
div1:
	addss xmm3 ,xmm0
pd:
	xor eax ,eax
	xor ebx ,ebx
	movss xmm0 ,dword[zero]
	movss xmm1 ,dword[zero]
topD:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb nextD
	cmp bl ,'9'
	ja nextD
	sub bl ,'0'
	mulss xmm0 ,dword[ten]
	cvtsi2ss xmm1 ,ebx
	addss xmm0 ,xmm1
	jmp topD
nextD:
	cmp bl ,'-'
	jne Md
	cmp byte [make_Neg] ,1
	jne ne
	mov byte [make_Neg] ,0
ne:	
	mov byte [make_Neg] ,1
	jmp pd
Md:
	cmp bl ,'.'
	je nxtD	
next2D:
	cmp byte [make_Neg] ,1
	jne md
	mulss xmm0 ,[Ne]
md:
	ucomiss xmm3 ,dword[zero]
	jae ge
	;mulss xmm3 ,[Ne]
	;mulss xmm0 ,[Ne]
ge:
	divss xmm3 ,xmm0
	movss xmm0 ,xmm3
	ucomiss xmm3 ,dword[zero]
	jae mpd
	jmp Print
mpd:
	mov byte [make_Neg] ,0
	jmp Print
nxtD:
	movss xmm2 ,dword[ten]
lpD:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb next2D
	cmp bl ,'9'
	ja next2D
	sub bl ,'0' 
	cvtsi2ss xmm1 ,ebx
	divss xmm1 ,xmm2
	addss xmm0 ,xmm1
	mulss xmm2 ,xmm2
	jmp lpD	
;=========================================================================================
Exit:
	mov eax ,1
	mov ebx ,0
	int 80h

