section .text
	global cmmmc

cmmmc:
	;Registrul eax stocheaza primul parametru iar registrul 
	;edx cel de al doilea parametru
	
	;Cele doua numere sunt impinse pe stack
	push eax
	push edx
	;Se stocheaza valoarea lui edx in ecx si valoarea lui eax in edi, stiva
	;devenind in acest moment goala
	pop ecx
	pop edi
	;Cele doua numere sunt din nou impinse pe stiva si se stocheaza apoi in registrul
	;eax inmultirea dintre acesta si edx cu ajutorul lui imul
	push eax 
	push edx
	imul eax, edx
	;Se impinge produsul celor doua numere pe stiva si apoi se scoate in registrul ebx
	push eax 
	pop ebx

	;Se salveaza in continuare valoarea celor doua numere in registrele ecx si edx
	pop ecx
	pop edx 

	;Se calculeaza cel mai mare divizor comun folosind algoritmul deja cunoscut 
	;prin scaderi repetate ale numarului mai mic din cel mai mare. In momentul in 
	;care cel mai mic a ajuns la valoarea 0, cel mai mare divizor comun este constituit
	;de numarul mare
	gcd:
		cmp ecx, dword 0
		je finish 
		cmp edx, ecx 
		jl swap_values
		continue:
			sub edx, ecx
			jmp gcd 
	;Se interschimba valorile celor doua numere cu ajutorul stivei
	swap_values:
		push edx 
		push ecx 
		pop edx 
		pop ecx 
		jmp continue

;La final rezultatul celui mai mare divizor comun este stocat in ecx. Cel mai mic 
;multiplu comun reprezinta produsul numerelor impartit la cel mai mare divizor comun al acestora,
;mai exact ebx / edx. Se va stoca valoarea lui ebx in eax si valoarea lui edx in ecx pentru a
;putea face divizia cu ajutorul lui idiv. In final, rezultatul se afla in eax, registru ce este
;returnat de catre functie
finish:
	push ebx 
	push dword 1
	pop ebx
		
	push edx 
	pop ecx
	
	pop eax
	imul ebx
	idiv ecx
	
	ret
