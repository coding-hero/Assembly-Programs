section .data
    num1 dw 80
    num2 dw 18
section .text
    global _start
    _start:
            mov ax ,word [num1]
            mov bx ,word [num2]
        Lp:   
            xor dx ,dx
            div bx
            cmp dx ,0
            jz Exit
            mov ax ,bx
            mov bx ,dx
            jmp Lp
      Exit:
            mov dx ,bx ;moving result to dx
            mov eax ,1
            mov ebx ,0
            int 80h                            
                    
