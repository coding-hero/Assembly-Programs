section .data
    num dq 28
    pf db 'Perfect !',10
    lenP equ $-pf
    Npf db 'Not Perfect !',10
    lenNp equ $-Npf
  
section .text
    global _start
    _start:
            mov rax ,qword [num]
            xor rbx ,rbx
		xor rdx ,rdx
            mov rcx ,0
        Lp:   
		inc rcx
		xor rdx ,rdx
            cmp rcx ,rax
            jae F
            push rax
            div rcx
            pop rax
            cmp rdx ,0
            jne Lp
            add rbx ,rcx
            jmp Lp
         F:
            cmp rbx ,rax
            je P
            mov eax ,4
            mov ebx ,1
            mov ecx ,Npf
            mov edx ,lenNp
            int 80h   
            jmp Exit   
         P: 
            mov eax ,4
            mov ebx ,1
            mov ecx ,pf
            mov edx ,lenP
            int 80h   
      Exit:
            mov eax ,1
            mov ebx ,0
            int 80h                            
                    
