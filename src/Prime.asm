section .data
    num dq 18
    fix equ (18/2)
    prime db 'Prime !',10
    lenP equ $-prime
    Nprime db 'Not Prime !',10
    lenNp equ $-Nprime
  
section .text
    global _start
    _start:
            mov rax ,qword [num]
            mov rcx ,1
        Lp:   
            inc rcx
            xor rdx ,rdx
            cmp rcx ,fix
            ja P
            mov rbx ,rax
            div rcx
            mov rax ,rbx
            cmp rdx ,0
            jne Lp
            mov eax ,4
            mov ebx ,1
            mov ecx ,Nprime
            mov edx ,lenNp
            int 80h
            jmp Exit  
         P: 
            mov eax ,4
            mov ebx ,1
            mov ecx ,prime
            mov edx ,lenP
            int 80h  
      Exit:
            mov eax ,1
            mov ebx ,0
            int 80h                            
                    
