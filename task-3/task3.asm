%include "../../io.mac"
global get_words
global compare_func
global sort

section .data
    delimiters dd 32, 44, 46, 10 

section .text
    extern printf
    extern qsort
    extern strlen
    extern strcmp



compare_func:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov eax, [eax]
    
    push eax 
    call strlen
    push edi 
    mov edi, eax

    mov ecx, [ebp + 12]
    mov ecx, [ecx]

    
    push ecx 
    call strlen

    mov edx, edi
    mov edi, eax

    cmp edx, edi 
    jg instruction1
    cmp edx, edi 
    jl instruction2

    mov eax, [ebp + 8]
    mov eax, [eax]
    mov ecx, [ebp + 12]
    mov ecx, [ecx]
    
    push ecx 
    push eax 
    call strcmp
    pop ecx 
    pop ecx
    jmp finish_cmp

instruction1:
    mov eax, dword 1
    jmp finish_cmp

instruction2:
    mov eax, dword 0
    jmp finish_cmp

finish_cmp:
    pop edi 
    pop edi
    leave 
    ret

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0

    mov ebx, [ebp + 8]
    mov eax, [ebp + 12]
    mov ecx, [ebp + 16]
    push compare_func
    push ecx 
    push eax 
    push ebx 
    call qsort

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]

    xor ecx, ecx 
    traverse:
        cmp [eax + ecx], byte 0x00
        je end_traverse
        xor edx, edx 
        mov edx, [eax + ecx]
        cmp dl, [delimiters + 0]
        je make_null
        cmp dl, [delimiters + 4]
        je make_null
        cmp dl, [delimiters + 8]
        je make_null
        cmp dl, [delimiters + 12]
        je make_null
        continue:
            add ecx, dword 1
            jmp traverse

    make_null:
        mov [eax + ecx], byte 0x00
        jmp continue

    end_traverse:
        xor ecx, ecx
        xor edi, edi 
        xor esi, esi 
        lea edx, [eax]
        loop:
            cmp ecx, [ebp + 16]
            je finish
            cmp [eax + esi], byte 0x00
            je try_word
            continue1:
                add esi, dword 1
                jmp loop 

        try_word:
            cmp [edx + 0], byte 0x00
            je instruction
            mov [ebx + edi], edx
            add ecx, dword 1
            add edi, dword 4
            lea edx, [eax + esi + 1]
            jmp continue1

        instruction:
            lea edx, [eax + esi + 1]
            jmp continue1

finish:
    leave
    ret
