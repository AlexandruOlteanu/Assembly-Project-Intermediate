section .text
	global par

par:
	;Registrul edx stocheaza primul parametru (dimensiunea sirului) iar
	;registrul eax stocheaza cel de al doilea parametru, sirul de caractere

	push 0
	pop ecx
	push 0
	pop edi

	;Se parcurge intreg sirul de caractere si se monitorizeaza cu ajutorul
	;registrului edi parantezarea la fiecare pas. Conditiile pentru ca 
	;parantezarea sa fie corecta este ca pe tot parcursul trecerii prin sir, numarul de
	;paranteze ( sa nu fie mai mic decat numarul de paranteze ). De asemenea, la final trebuie
	;verificat daca numarul de paranteze ( nu este diferit de 0.
	traverse:
		cmp ecx, edx 	
		je end_traverse 
		push 40 			; 40 reprezinta codul Ascii pentru caracterul '(', acesta fiind impins pe stack
		pop ebx 			; Se stocheaza caracterul '(' in subregistrul bl care este comparat cu caracterul 
		cmp bl, [eax + ecx] ; curent. Daca acestea sunt egale, valoarea lui edi creste, in caz contrar, scade
		je adding
		jmp substracting
		continue:
			cmp edi, dword 0 ;Se face comparatia intre edi si 0, daca edi este mai mic decat 0, procesul se termina 
			jl wrong		 ;returnand valoarea 0
			add ecx, dword 1 ;In caz contrar se continua parcurgerea
			jmp traverse
	;La sfarsitul traversarii prin sirul de caractere se verifica daca edi este egal cu 0, daca da, 
	;parantezarea este corecta
	end_traverse:
		cmp edi, dword 0
		jg wrong
		jmp right
;Adaugarea unei paranteze '('
adding:
	add edi, dword 1
	jmp continue
;"Adaugarea" unei paranteze ')'
substracting:
	sub edi, dword 1
	jmp continue
;Cazul in care parantezarea este gresita
wrong:
	push 0
	pop eax 
	jmp finish
;Cazul in care parantezarea este corecta
right:
	push 1
	pop eax 
	jmp finish

finish:
	ret
