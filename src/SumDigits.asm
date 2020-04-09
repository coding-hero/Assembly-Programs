section .data
    ten db 10
    num dw 1995
section .text
    global _start
    _start:
            mov ax ,word [num]
            mov dx ,0
            mov cx ,0
        Lp:   
            cmp ax ,0
            jz Exit
            idiv word [ten]
            add cx ,dx
            xor dx ,dx
            jmp Lp
      Exit:
            mov dx ,cx ;moving result to dx
            mov eax ,1
            mov ebx ,0
            int 80h                            
                    
