section .data
	A	dq 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
		dq 11.2, 12.5, 13.6, 14.2, 15.9, 16.8, 17.3, 18.1, 19.8, 20
		dq 15, 21, 35, 4.3, 5, 65, 71, 8, 91, 10
		dq 11.2, 12.5, 13.6, 14.2, 15.9, 16.58, 17.3, 18.1, 19.8, 2.3
		dq 1.9, 12.5, 13.6, 14.2, 15.9, 16, 1.7, 18.1, 19.8, 2
		dq 15, 23, 23, 4.5, 5, 6, 7, 8, 9, 10
		dq 19.2, 12.5, 13.6, 14.2, 15.9, 16.8, 17.3, 18.1, 19.8, 20
		dq 14, 21, 35, 4.3, 5, 65, 71, 8, 91, 10
		dq 17.2, 12.5, 13.6, 14.2, 15.9, 16.58, 17.3, 18.1, 19.8, 2.3
		dq 1.19, 12.5, 13.6, 14.2, 15.9, 16, 1.7, 18.1, 19.8, 2
	len 	dd 100
	sum	dq 0
	ave	dq 0
section .text
	global _start
_start:
	mov ecx, dword[len]
	mov rbx, A
	mov rsi, 0
lp:
	fadd qword[rbx+rsi*8]
	inc rsi
	loop lp
	fst qword[sum]
	fdiv dword[len]
	fstp qword[ave]
	
	mov eax ,1
	mov ebx ,0
	int 80h
	
