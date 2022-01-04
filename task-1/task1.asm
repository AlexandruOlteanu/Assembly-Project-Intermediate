section .text
	global sort
	
sort:
	enter 0, 0

	; Se face initializarea pentru contorul de lungime al vectorului (edi)
	; si pentru registrul ce parcurge elementele de tip struct ale vectorului (esi)
	xor edi, edi
	xor esi, esi 

	selection_sort: 
		cmp edi, [ebp + 8] 
		;Se face jump la partea de cautare a nodului din varful listei
		;dupa incheierea procesului de sortare
		jge find_head  			
		;Se initializeaza registrulecx cu 0 pentru a constitui un iterator, registrul esi 
		;cu vectorul primit ca parametru de structuri pentru a putea fi parcurs si registrul 
		;ebx cu o valoare mare pentru a putea calcula minimul
		;la fiecare pas
		xor ecx, ecx
		mov esi, [ebp + 12] 
		mov ebx, dword 10000
		;Se traverseaza fiecare nod in parte si se verifica daca nodul curent are valoarea mai 
		;mare decat minimul deja gasit anterior si mai mica decat cel mai mica valoare gasita
		;in traversarea curenta. In cazul satisfacerii ambelor conditii, nodul minim din iteratia
		;curenta se schimba. Pentru traversarea si schimbarea acestor noduri m-am folosit de 
		;"lea", operator ce copiaza atat valoarea cat si adresa sursei in destinatie
		traverse_nodes:
			cmp ecx, [ebp + 8]
			jge end_traverse_nodes
			cmp [esi + 0], edi
			jg test
			continue:
				lea esi, [esi + 8]
				add ecx, dword 1
				jmp traverse_nodes 
		end_traverse_nodes:
			cmp edi, dword 0	;In cazul primei iteratii se gaseste doar nodul minim (instruction1)
			je instruction1		;iar in caz contrar se face legatura intre penultimul nod si cel gasit curent
			jmp instruction2	;astfel fiind necesari do registri pentru mentinerea constanta a ultimelor 2
			continue_after_instructions: ;valori
				lea eax, [edx]
				add edi, dword 1
				jmp selection_sort

test:
	cmp [esi + 0], ebx ;Daca nodul curent este mai mic decat minimul de pana acum, il updatam,
	jl update_node	   ;in caz contrar ne intoarcem in loop
	jmp continue

;Cazul in care trebuie modificat minimul
update_node:
	lea edx, [esi + 0]
	mov ebx, [esi + 0]
	jmp continue

;Registrului eax ii este asignata valoarea de minim gasita la prima iteratie
instruction1:
	lea eax, [edx + 0]
	jmp continue_after_instructions

;Se modifica campul NEXT al nodului stocat in registrul eax, acesta fiind acum legatura la nodul
;stocat in registrul edx
instruction2:
	lea eax, [eax + 4]
	mov [eax], edx
	jmp continue_after_instructions

;Proces de gasire al elementului minim din tot vectorul ce va fi head-ul transmis ca parametru
;Acest nod va fi stocat in eax deoarece acesta este registrul ce reprezinta return-ul functiei sort
;Procesul de gasire al acestui minim este asemanator cu cel de sortare anterior.
find_head:
	mov ebx, [ebp + 12]
	mov edx, dword 10000
	xor ecx, ecx 
	traverse_nodes1:  
		cmp ecx, [ebp + 8]
		jge finish 
		cmp [ebx + 0], edx 
		jl change_head  
		after_change:
			add ecx, dword 1
			lea ebx, [ebx + 8]
			jmp traverse_nodes1

	change_head:
		lea eax, [ebx]
		mov edx, [ebx + 0]
		jmp after_change
	
finish:
	leave
	ret
