;the BCD number(245) is in ax ,we will move binary form into al
section .text
	global _start
_start:
	call bcdToBinary

bcdToBinary:
	
	xor bx ,bx
	mov bl ,al
	mov bh ,0xf
	and bl ,bh
	mov dl,ah
	mov ah ,0
	shr al,4
	mov cl ,10
	mul cl
	mov bh ,al
	mov al ,dl
	mov cl ,100
	mul cl
	add al ,bh
	or al ,bl
ret.
	
