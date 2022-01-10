global expression
global term
global factor
global number 

number:
        push ebp
        mov ebp, esp


        mov edx, [ebp + 8]
        mov ecx, [ebp + 12]

        xor esi, esi 

        traverse_digits:
                mov edi, [ecx]
                cmp [edx + edi], byte 48
                jge test
                jmp finish_number
                continue:
                        xor ebx, ebx 
                        mov bl, [edx + edi]
                        sub bl, byte 48
                        imul esi, dword 10
                        add esi, ebx 
                        add [ecx], dword 1
                        jmp traverse_digits
        test:
                cmp [edx + edi], byte 57
                jle continue
                jmp finish_number

finish_number:
        leave 
        ret ; esi va fi returnat

factor:
        push    ebp
        mov     ebp, esp

        mov edx, [ebp + 8]
        mov ecx, [ebp + 12]

        xor edi, edi 

        mov esi, [ecx]
        cmp [edx + esi], byte 48
        jge case1
        jmp case_parenthesis

        case1:
                cmp [edx + esi], byte 57
                jle case_number
                jmp case_parenthesis

        case_number:
                push ecx
                push edx
                call number
                mov edi, esi
                jmp finish_factor
        
        case_parenthesis:
                add [ecx], dword 1
                push ecx 
                push edx 
                call expression
                add [ecx], dword 1
                mov edi, eax

finish_factor:
        leave
        ret ;edi va fi returnat


term:
        push    ebp
        mov     ebp, esp
        
        mov edx, [ebp + 8]
        mov ecx, [ebp + 12]

        xor ebx, ebx 

        push ecx 
        push edx 
        call factor

        mov ebx, edi 

        traverse1:
                mov esi, [ecx]
                cmp [edx + esi], byte 42
                je multiply
                cmp [edx + esi], byte 47
                je divide
                jmp finish_term

        multiply:
                add [ecx], dword 1
                push ebx 
                push ecx 
                push edx 
                call factor
                pop ebx 
                pop ebx 
                pop ebx
                imul ebx, edi
                jmp traverse1
        divide:
                add [ecx], dword 1
                push ebx
                push ecx 
                push edx 
                call factor
                pop ebx 
                pop ebx 
                pop ebx 

                push edx 
                xor edx, edx 

                push ebx
                push dword 1
                pop ebx 
                

                push edi
                pop esi
                
                pop eax 
                imul ebx
                idiv esi 
                pop edx 
                mov ebx, eax 
                jmp traverse1

finish_term:
        leave
        ret ;ebx va fi returnat


expression:
        push    ebp
        mov     ebp, esp
        
        mov edx, [ebp + 8]
        mov ecx, [ebp + 12]

        xor eax, eax 

        push ecx 
        push edx 
        call term

        mov eax, ebx 
        
        traverse:
                 mov esi, [ecx]
                 cmp [edx + esi], byte 43
                 je adding
                 cmp [edx + esi], byte 45
                 je substracting
                 jmp finish_expression

        adding:
                add [ecx], dword 1
                push eax 
                push ecx
                push edx 
                call term
                pop eax 
                pop eax 
                pop eax  
                add eax, ebx 
                jmp traverse

        substracting:
                add [ecx], dword 1 
                push eax
                push ecx 
                push edx 
                call term
                pop eax
                pop eax 
                pop eax 
                sub eax, ebx 
                jmp traverse

finish_expression: 
        leave
        ret
