;%include "../../io.mac"
section .text
	global cmmmc
	;extern printf

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:


	;eax = primul parametru
	;edx = al doilea parametru

	push eax
	push edx
	pop ecx
	pop edi
	push eax 
	push edx
	imul eax, edx
	push eax 
	pop ebx ;x * y

	pop ecx ;y
	pop edx ;x

	gcd:
		cmp ecx, dword 0
		je finish 
		cmp edx, ecx 
		jl swap_values
		continue:
			sub edx, ecx
			jmp gcd 

	swap_values:
		push edx 
		push ecx 
		pop edx 
		pop ecx 
		jmp continue


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
