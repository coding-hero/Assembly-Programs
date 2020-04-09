section .data
    ten dw 10
    two db 2
    num dw 1995
section .text
    global _start
    _start:
            mov ax ,word [num]
		xor bx ,bx
		xor dx ,dx
		clc
        Lp:   
            cmp ax ,0
            jz Exit
		jc D
		push word dx
	D:
		xor dx ,dx
            idiv word [ten]
            mov cx ,ax
            mov ax ,dx
            push word ax
            div byte [two]
            cmp ah ,0
            jz B
		clc
            pop word ax
		pop word dx
            add dx ,ax
            mov ax ,cx
            jmp Lp
         B:   
            pop word ax
		stc
            add bx ,ax
            mov ax ,cx
            jmp Lp
     Exit:
            mov eax ,1
            mov ebx ,0
            int 80h                            
                    
