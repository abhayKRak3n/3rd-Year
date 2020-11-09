.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive


	.data

	;public bias		;
	;bias DWORD 4		;
.code

;
; t1Test.asm
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

public      poly	               ; int poly (int arg)

poly:		push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp

			
			mov		eax, [ebp + 8]  ; eax = arg

			push	2               ; push parameters 
			push	[ebp+8]
			call	pow             ; call pow function, eax=pow(arg,2)
			add		eax, [ebp+8]	; eax = eax + arg
			add		eax, 1          ; eax = eax(arg) + 1

			mov     esp, ebp        ; restore esp
            pop     ebp             ; restore ebp
            ret     0               ; return


public		pow						; int pow(int arg1, int arg2)

pow:		push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
 
			push	esi				;
			xor		eax, eax		; eax = 0
			mov		ecx, [ebp+12]	; ecx = arg2
			mov		esi, [ebp+8]	; esi = arg1

			mov		eax, 1			; eax = 1
startOfLoop: imul	eax, esi		; eax = eax*arg1
			LOOP	startOfLoop

			pop		esi
			mov     esp, ebp        ; restore esp
            pop     ebp             ; restore ebp
            ret     0              ; return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


public		factorial				; int factorial (int N)

factorial:	push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp

			mov		eax, 0			; clear the registers
			mov		ecx, 0
			mov		ecx, [ebp+8]	; ecx = N

			cmp		ecx, 0			; if(N==0)
			je		end2			; if = then jump to end2 and return 2			
			
		    mov		edx, ecx		; edx = N
			dec		ecx				; ecx = ecx-1 (N--)
			
			push	edx				; push arguments for recursion call
			push	ecx				;
			call    factorial
			pop		ecx
			pop		edx				; pop registers 

			imul	eax, edx		; eax = edx(N) * factorial(N-1) where eax is result
			jmp		end1			;

end2:		mov		eax, 1			; result = 1

end1:		mov     esp, ebp        ; restore esp
            pop     ebp             ; restore ebp
            ret     0               ; return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



public		multiple_k_asm			; void multiple_k(uint16_t N, uint16_t K, uint16_t* array)

multiple_k_asm:	push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp

			push	ebx				; save these volatile registers
			push	edi				;
			push	esi 			;

			xor		ebx, ebx	 	; clear the registers
			xor		edi, edi		;
			xor		esi, esi 		;
			xor		ecx, ecx		; ecx (i) = 0

			mov		esi, [ebp+16] 	; esi = array*
			mov		bx, [ebp+12]	; bx = K
			mov		di, [ebp+8] 	; di = N

loopStart:	xor		eax, eax 		; eax = 0
			xor		edx, edx 		; edx = 0
			mov		eax, ecx 		; eax = i
			
			inc		ax 				; ax = i+1
			idiv	bx 				; (i+1) % k
	
			xor     eax, eax 		; clear eax to store result
			cmp		dx, 0 			; if(remainder == 0?)
			jne		elseCase 		; 
	
			mov		eax, 1 			; ax = 1
			mov		[esi],eax 		; array[i] = 1
			jmp		skip 			; skip over else case
	
elseCase:   mov		eax, 0 			; ax = 0
			mov		[esi], eax  	; array[i] = 0
	
skip:		add		esi, 2			; point to next value in array
			inc		cx 				; i++
			cmp		cx, di 			; i==N
			jl		loopStart 		; jump to loop start
	
			pop		esi				; pop registers used		
			pop		edi				;
			pop		ebx				;
	
			mov		esp, ebp			; epilogue
			pop		ebp
			ret		0



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end			
