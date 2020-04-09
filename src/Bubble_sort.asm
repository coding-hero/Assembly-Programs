    section .data
        d1 dd 50,25,1,118,17
        len equ (($-d1)/4)-1
    section .text
        global _start
        _start:
             mov ecx ,len
         Lp1:   
             cmp ecx ,0
             jz Exit
             mov edi ,0
             mov esi,0
         Lp2:   
            cmp edi ,ecx
            jae L1
            mov eax ,dword [d1+edi*4]
            add esi ,4
            cmp eax ,dword [d1+esi]
            jl L2
		mov ebx ,dword [d1+esi]
            mov dword [d1+edi*4] ,ebx
            mov dword [d1+esi] ,eax
         L2:
            inc edi
            jmp Lp2
         L1:
            dec ecx
            jmp Lp1
         Exit:
            mov eax ,1
            mov ebx ,0
            int 80h                            
            
