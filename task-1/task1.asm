section .text
	global sort
	
sort:
	enter 0, 0

	; Se face initializarea pentru contorul de lungime al vectorului (edi)
	; si pentru registrul ce parcurge elementele de tip struct ale vectorului (esi)
	xor edi, edi
	xor esi, esi 

	selection_sort : 
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
				add edi, dword 1
				jmp selection_sort
	
	
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
	leave
	ret
