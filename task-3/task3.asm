%include "../../io.mac"
global get_words
global compare_func
global sort

section .data
    delimiters dd 32, 44, 46, 10 

section .text
    extern printf

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0
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
