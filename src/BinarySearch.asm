section .data
	x dd 7
	A dd 3,5,7,9,20
	len equ ($-A)/4
	R dd A+(len-1)*4
	L dd A
	msg db 'Found !',10
	msgLen equ $-msg
	msg2 db 'Not Found !',10
	msg2Len equ $-msg2

section .text
	global _start
_start:
	mov r8d ,dword[L]
	mov r9d ,dword[R]
	mov r10w ,2
	mov r11w ,4
	xor eax ,eax
	call Bsearch
	cmp eax ,0
	je notFound
	mov eax ,4
	mov ebx ,1
	mov ecx ,msg
	mov edx ,msgLen
	int 80h
	mov eax ,1
	mov ebx ,0
	int 80h	

notFound:
	mov eax ,4
	mov ebx ,1
	mov ecx ,msg2
	mov edx ,msg2Len
	int 80h
	mov eax ,1
	mov ebx ,0
	int 80h

Bsearch:
	cmp r8d ,r9d
	jle rec
	mov eax ,0
	ret
rec:
	mov eax ,r9d
	sub eax ,A
	div r11w
	mov ebx ,eax
	mov eax ,r8d
	sub eax ,A
	div r11w
	add eax ,ebx
	div r10w
	mul r11w
	add eax ,A
	mov ebx ,eax
	
	mov edx ,dword[x]
	cmp [ebx] ,	edx
	je find
	jg greater
	add ebx ,4
	mov r8d ,ebx
	call Bsearch
	ret
greater:
	sub ebx ,4
	mov r9d ,ebx
	call Bsearch
	ret
find:
	mov eax ,1
	ret
