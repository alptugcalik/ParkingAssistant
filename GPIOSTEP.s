GPIO_PORTB_DATA 	EQU 	0x400053FC
GPIO_PORTF_DATA 	EQU 	0x400253FC
NVIC_ST_RELOAD 		EQU 	0xE000E014
TIMER2_ICR 			EQU 	0x40032024 ; Interrupt Clear Register
TIMER2_TAILR		EQU 	0x40032028 ; Interval Load Register 
			AREA		main, READONLY, CODE
            THUMB

			EXPORT		GPIOSTEP
			EXTERN		DELAY

; In this subroutine, the inputs are changed both in ascending and descending order according to a 
; variable in the memory. 
; STEP MOTOR INPUTS ARE CONNECTED TO PB2 PB3 PB6 AND PB7 PINS
GPIOSTEP	PROC
	PUSH{R4,R5,R6,R7,R8,R9}
			LDR R4,=GPIO_PORTB_DATA
			LDR R4,[R4]
			; MASK THE MOTOR PINS ONLY
			AND R1,R4,#0xCC
			
			;THE OUTPUTS ARE CHANGED SEQUENTIALLY 
GO			CMP R1,#0x00
			MOVEQ R1,#0x04
			BEQ OUT
			;CLOCKWISE
			CMP R1,#0x04
			MOVEQ R1,#0x08
			BEQ OUT
			CMP R1,#0x08
			MOVEQ R1,#0x40
			BEQ OUT
			CMP R1,#0x40
			MOVEQ R1,#0x80
			BEQ OUT
			CMP R1,#0x80
			MOVEQ R1,#0x04
			BEQ OUT
			
			;CHANGE THE OUTPUT FOR STEP MOTOR ACCORDINGLY
OUT			BIC R4,#0xCC
			ORR R4,R4,R1
			LDR R0,=GPIO_PORTB_DATA
			STR R4,[R0]
			
			
			; Need to clear CAERIS bit of TIMER0_RIS. 
			LDR R1, = TIMER2_ICR
			MOV R2, #0x01 ;				 
			STR R2, [R1] 
			
			; LASTLY, arrange the speed of the motor according to the distance btw threshold and measured
			; set start value 
			; GET THRESHOLD
			LDR R2,=0x20000560
			LDR R2,[R2]
			; GET MEASURED VALUE
			LDR R3,=0x20000400
			LDR R3,[R3]
			; SUBTRACT THEM
			SUB R3,R2
			; MAKE THE PROPORTIONS
			MOV R2,#45
			MUL R3,R2
			LDR R2,=0xFFFF
			SUB R2,R3
			; LOAD THE NEW VALUE
			LDR R1, =TIMER2_TAILR 			; counter counts down, 
			STR R2, [R1] 
			
			
			POP{R4,R5,R6,R7,R8,R9}		
			BX LR
			ENDP
			END