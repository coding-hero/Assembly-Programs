;this program is going to count numbers of 1 bits  from esi to edi

section .text
	global _start
_start:
	xor eax ,eax
lp:
	cmp esi ,edi
	ja end
	call count
	inc esi
	jmp lp
end:
	mov eax ,1
	mov ebx ,0
	int 80h
count:
do:
	bsf ecx ,[esi]
	jz return
	inc eax
	btc [esi] ,ecx
	jmp do	
return:
	ret
