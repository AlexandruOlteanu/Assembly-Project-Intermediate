;%include "../../io.mac"
section .text
	global sort
	;extern printf

; struct node {
;     	int val;
;    	struct node* next;
; };


;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0
	mov eax, [ebp + 12] ; dimensiune
	mov ebx, [ebp + 12] ;
	; lea ecx, [ebx + 8]
	; lea edx, [ebx + 4]
	; mov [edx], ecx

	xor edi, edi ; Iteratorul
	xor esi, esi 

	loop : 
		cmp edi, [ebp + 8]
		jge find_head
		xor ecx, ecx
		mov esi, [ebp + 12]
		mov ebx, dword 10000
		loop1 :
			cmp ecx, [ebp + 8]
			jge finish_loop1
			cmp [esi + 0], edi
			jg test1
			continue:
				lea esi, [esi + 8]
				add ecx, dword 1
				jmp loop1 
		finish_loop1:
			cmp edi, dword 0
			je instruction1
			lea eax, [eax + 4]
			mov [eax], edx
			continue_after_instructions:
				lea eax, [edx]
				;PRINTF32`Nr : %d\n\x0`, ebx
				;PRINTF32`U : %d\n\x0`, [eax + 0]
				add edi, dword 1
				jmp loop
	
	
test1:
	cmp [esi + 0], ebx 
	jl test2
	jmp continue

test2:
	lea edx, [esi + 0]
	mov ebx, [esi + 0]
	jmp continue

instruction1:
	lea eax, [edx + 0]
	jmp continue_after_instructions

find_head:
	mov ebx, [ebp + 12]
	mov edx, dword 10000
	xor ecx, ecx 
	loop2:
		;PRINTF32`A : %d\n\x0`, edx  
		cmp ecx, [ebp + 8]
		jge finish 
		cmp [ebx + 0], edx 
		jl change  
		after_change:
		add ecx, dword 1
		lea ebx, [ebx + 8]
		jmp loop2

	change:
		lea eax, [ebx]
		mov edx, [ebx + 0]
		jmp after_change
	
finish:
	mov ebx, [ebp + 12]
	;PRINTF32`Daa : %p\n\x0`, [ebx + 4]
	;PRINTF32`Daa : %p\n\x0`, [ebx + 12]
	leave
	ret
