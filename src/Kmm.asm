section .data
    num1 dq 80
    num2 dq 18
  
section .text
    global _start
    _start:
            mov rax ,qword [num1]
            mov rbx ,qword [num2]
            push rbx
            push rax
        Lp:   
            xor rdx ,rdx
            div rbx
            cmp rdx ,0
            jz Exit
            mov rax ,rbx
            mov rbx ,rdx
            jmp Lp
      Exit:
            mov rcx ,rbx ;now bmm is in rcx
            pop rax
            pop rbx
            mul rbx
            div rcx 
            mov rdx ,rax ;moving kmm to rdx
            
            mov eax ,1
            mov ebx ,0
            int 80h                            
                    
