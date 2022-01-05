;%include "../../io.mac"
section .text
	global par
	;extern printf

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	

	; eax al doilea parametru
	; edx primul parametru
	; ( = 40
	; ) = 41

	push 0
	pop ecx
	push 0
	pop edi

	traverse:
		cmp ecx, edx 
		je end_traverse 
		push 40
		pop ebx 
		cmp bl, [eax + ecx]
		je adding
		jmp substracting
		continue:
			cmp edi, dword 0
			jl wrong
			add ecx, dword 1
			jmp traverse
	
	end_traverse:
		cmp edi, dword 0
		jg wrong
		jmp right

adding:
	add edi, dword 1
	jmp continue

substracting:
	sub edi, dword 1
	jmp continue

wrong:
	push 0
	pop eax 
	jmp finish

right:
	push 1
	pop eax 
	jmp finish

finish:
	ret
