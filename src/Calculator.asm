section .bss
	input resb 100
	input_len equ $-input

section .data
	msg db 'Enter e to exit :',10
	msg_len equ $-msg
	result dd 0
	isNeg db 0
	negSign db '-'
	lenS equ 1

section .text
	global _start
_start:
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
	
	xor edi ,edi
	cmp byte [input] ,'e'
	je Exit
	cmp byte [input] ,'-'
	jne E
	cmp byte [input+1] ,'-'
	je nn
	mov byte [isNeg] ,1
	mov edi ,1
	jmp E
nn:
	mov byte [input+1] ,'+'
	mov edi ,1
E:
	xor eax ,eax
	xor ebx ,ebx
	mov esi ,10
top:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb next1
	cmp bl ,'9'
	ja next1
	sub bl ,'0' ;ascii to decimal
	mul esi
	add eax ,ebx
	jmp top
next1:
	cmp bl ,'+'
	je add1
	cmp bl ,'*'
	je mul1
	cmp bl ,'/'
	je div1
	cmp bl ,'-'
	je sub1
	;je ub1
;ub1:
	;cmp byte [isNeg] ,1
	;jne sub1
	;mov byte [isNeg] ,0
	;jmp add1
	cmp bl ,'='
	je sub1
;=========================================
end:
	mov eax ,dword [result]
	mov rcx ,0
	mov ebx ,10
	jns divLp
	neg eax
	mov byte [isNeg] ,1
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
	mov byte [isNeg] ,0
	jmp Lp
;============================================================
add1:
	add [result] ,eax
	cmp byte [isNeg] ,1
	jne p
	neg dword [result]
p:	
	xor eax ,eax
	xor ebx ,ebx
	mov esi ,10
topA:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb nextA
	cmp bl ,'9'
	ja nextA
	sub bl ,'0' ;ascii to decimal
	mul esi
	add eax ,ebx
	jmp topA
nextA:
	cmp bl ,'-'
	je sb1
	add [result] ,eax
	jmp end
sb1:
	mov eax ,dword[result]
	mov dword[result] ,0
	jmp sub1
;===================================================================
mul1:
	add [result] ,eax
	cmp byte [isNeg] ,1
	jne pm
	neg dword [result]
	mov byte[isNeg] ,0	
pm:
	xor eax ,eax
	xor ebx ,ebx
	mov esi ,10
topM:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb nextM
	cmp bl ,'9'
	ja nextM
	sub bl ,'0' ;ascii to decimal
	mul esi
	add eax ,ebx
	jmp topM
nextM:
	cmp bl ,'-'
	jne M
	mov byte [isNeg] ,1
	jmp pm
M:
	cmp byte [isNeg] ,1
	jne m
	neg eax
m:
	imul dword [result]
	mov dword [result] ,eax
	cmp dword [result] ,0
	jge mp
	jmp end
mp:
	mov byte [isNeg] ,0
	jmp end
;===========================================================================
div1:
	add [result] ,eax
pd:
	xor eax ,eax
	xor ebx ,ebx
	mov esi ,10
topD:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb nextD
	cmp bl ,'9'
	ja nextD
	sub bl ,'0' ;ascii to decimal
	mul esi
	add eax ,ebx
	jmp topD
nextD:
	cmp bl ,'-'
	jne Md
	cmp byte [isNeg] ,1
	jne ne
	mov byte [isNeg] ,0
ne:	
	mov byte [isNeg] ,1
	jmp pd
Md:
	cmp byte [isNeg] ,1
	jne md
	neg eax
md:
	cmp dword [result] ,0
	jge ge
	neg dword [result]
	neg eax
ge:
	mov edx ,eax
	mov eax ,dword [result]
	mov dword [result] ,edx
	xor edx ,edx
	idiv dword [result]
	mov dword [result] ,eax
	cmp dword [result] ,0
	jge mpd
	jmp end
mpd:
	mov byte [isNeg] ,0
	jmp end
	
;=========================================================================================
sub1:
	cmp dword [result] ,0
	je fo
	sub dword[result] ,eax
	cmp dword [result] ,0
	jge mps
	jmp end
mps:
	mov byte [isNeg] ,0
	jmp end
fo:
	add dword[result] ,eax
	cmp byte[isNeg] ,1
	jne ps
	neg dword [result]
	mov byte[isNeg] ,0
ps:
	xor eax ,eax
	xor ebx ,ebx
	mov esi ,10
topS:
	mov bl ,byte [input+edi]
	inc edi
	cmp bl ,'0'
	jb nextS
	cmp bl ,'9'
	ja nextS
	sub bl ,'0' ;ascii to decimal
	mul esi
	add eax ,ebx
	jmp topS
nextS:
	cmp bl ,'-'
	je ad1
	sub dword[result] ,eax
	jmp end
ad1:
	mov eax ,dword[result]
	mov dword[result] ,0
	jmp add1

Exit:	
	mov eax ,1
	mov ebx ,0
	int 80h
