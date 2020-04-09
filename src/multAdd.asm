;this program is going to multiply using addition

section .data
	num1 dw 10
	num2 dw 5

section .text
	global _start
_start:
	mov ax ,[num1]
	mov bx ,[num2]
	call mult
	mov eax ,1
	mov ebx ,0
	int 80h
mult:
	mov cx ,bx
do:
	add ax ,ax
	loop do
	ret
