			AREA		main, READONLY, CODE
            THUMB

			EXPORT		DELAY1
				
DELAY1		PROC
			
			LDR R0,=5333
			
			; 1msec delay
			;3 cycles are spend per loop
loop		SUBS R0,#1 ; COUNT DOWN
			BNE loop   ; loop if the count is not equal to zero
			
			BX LR
			ENDP
			ALIGN
			END