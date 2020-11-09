includelib legacy_stdio_definitions.lib
extrn printf:near, scanf:near


;; Data segment
.data
	public inp_int
	inp_int qword 0
	print_string BYTE "Sum of i: %I64d and j: %lld is: %I64d", 0Ah, 00h
	print_string2 BYTE "Sum of i: %I64d, j: %lld and bias: %lld is: %I64d", 0Ah, 00h
	print_string3 BYTE "Please Enter an integer ", 00h
	print_string4 BYTE "The sum of proc. and user inputs(%lld, %lld, %lld, %lld): %lld", 0Ah, 00h
	;readInt db "%lld", 0
	format BYTE "%lld", 00h
	bias QWORD 50
	sum2 QWORD 0

;; Code segment
.code


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

public fibX64				;fibonacci_recursion (long long fin)
fibX64:							
					mov rax, rcx			; rax = fin
					cmp rax, 0				; if(fin <= 0)
					jg clause1				; jump if greater than
					ret						; return fin 

clause1:			cmp rax, 1				; if(fin == 1)
					jne clause2				; jump if not equal to
					mov rax, 1				; return value = 1
					ret 0					; return 

clause2:			;mov rdx, rax			; saving fin in rdx
					mov [rsp+8], rax		; save fin in stack
					mov rcx, rax			; rcx = fin
					sub rsp, 32				; create shadow space
					sub rcx, 1				; rcx = rcx - 1 (fin-1)			
					call fibX64				; call fibonacci_recursion(fib-1)								
					mov [rsp+16], rax		; [rsp+16] = fibonacci_recursion(fib-1)
					mov rcx, [rsp+40]		; rcx = fin
					sub rcx, 2				; rcx = rcx - 2 (fin - 2)
					call fibX64				; call fibonacci_recursion(fib-2)	
					add rax, [rsp+16]				; rax = rax + r8
					add rsp, 32				; de allocate shadow space
					ret 					; return 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



public use_scanf							; long long use_scanf(long long a, long long b, long long c)
use_scanf:		
					xor rbx, rbx			; clear rbx
					add rbx, rcx			; sum += a
					add rbx, rdx			; sum = a + b 
					add rbx, r8				; sum = a + b + c
					
					; preserving registers					
					mov [rsp+24], rcx		; save a
					mov [rsp+16], rdx		; save b
					mov [rsp+8], r8			; save c
					sub rsp, 48				; the shadow space

					; calling  printf
					lea rcx, print_string3	; argument: string
					call printf				; calling printf
					
					; calling scanf
					xor rax, rax			; clear rax
					lea rdx, inp_int		; load argument
					lea rcx, format			;
					call scanf				;
					
					add rbx, [inp_int]		; sum += inp_int
					mov r10, [inp_int]		; r10 = input

					;reload registers
					mov rcx, [rsp+24+48]	; since we subbed 48 from stack
					mov rdx, [rsp+16+48]
					mov r8, [rsp+8+48]

					;calling 2nd printf
					mov[rsp+40], rbx		; loading 6th argument i.e sum
					mov[rsp+32], r10		; loading 5th argument inp_int
					mov r9, r8
					mov r8, rdx
					mov rdx, rcx
					lea rcx, print_string4 
					call printf

					mov rax, rbx			; result = sum
					add rsp, 48				; restore shadow space
					ret						; return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



public max									; _int64 max(_int64 a, _int64 b, _int64 c)
max:				
					mov r10, rcx			; v = a
					cmp rdx, r10			; if(b > v)
					jle	case1				; jump if <=
					mov r10, rdx			; v = b
					jmp case1				; since its an if-if instead of if-else

case1:				cmp r8, r10				; if(c > v)
					jle case2				; jump if <=
					mov	r10, r8				; v = c
					jmp case2

case2:				mov rax, r10			; result = v
					ret						; return v




public max5									; _int64 max5(_int64 i, _int64 j, _int64 k, _int64 l)
max5:
					sub rsp, 48				; shadow space
					mov [rsp+32], rcx		; preserving arguments
					mov [rsp+24], rdx
					mov [rsp+16], r8
					mov [rsp+8], r9
					
					; calling 1st max function
					mov r8, rdx				; j in argument 3
					mov rdx, rcx			; i in argument 2
					mov rcx, inp_int		; inp_int in argument 1												
					call max				; call func

					; calling 2nd max function

					mov r8, [rsp+8]		    ; l in argument 3
					mov rdx, [rsp+16]		; k in argument 2
					mov rcx, rax			; mov result of max as first argument
					call max				; call func

					add rsp, 48				; restore shadow space
					ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end