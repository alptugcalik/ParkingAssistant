	
			AREA		main, READONLY, CODE
            THUMB
; Timer channel registers for TIMER1: 
TIMER1_CFG 			EQU 0x40031000 ; Configuration Register 
TIMER1_TAMR 		EQU 0x40031004 ; Mode Register 
TIMER1_CTL 			EQU 0x4003100C ; Control Register 
TIMER1_RIS 			EQU 0x4003101C ; Raw interrupt Status 
TIMER1_ICR 			EQU 0x40031024 ; Interrupt Clear Register 
TIMER1_TAILR		EQU 0x40031028 ; Interval Load Register 
TIMER1_TAMATCHR 	EQU 0x40031030 ; Match Register 
TIMER1_TAPR			EQU 0x40031038 ; Prescaling Divider 
TIMER1_TAR 			EQU 0x40031048 ; Counter Register 

; Timer Gate Control 
SYSCTL_RCGCTIMER	EQU 0x400FE604 ; Timer Clock Gating 

;GPIO Registers for Port B 
;Port B base 0x40005000
GPIO_PORTB_DATA 	EQU 0x400053FC ; Data
GPIO_PORTB_IM 		EQU 0x40005010 ; Interrupt Mask 
GPIO_PORTB_DIR 		EQU 0x40005400 ; Port Direction 
GPIO_PORTB_AFSEL 	EQU 0x40005420 ; Alt Function enable 
GPIO_PORTB_DEN 		EQU 0x4000551C ; Digital Enable 
GPIO_PORTB_AMSEL 	EQU 0x40005528 ; Analog enable 
GPIO_PORTB_PCTL		EQU 0x4000552C ; Alternate Functions 

;GPIO Gate Control Register 
SYSCTL_RCGCGPIO 	EQU 0x400FE608 

MSG1				DCB "Distance(mm):",0x04
MSG2				DCB "Pulse Width(us):",0x04

			EXPORT		WAVE_PROP
			EXTERN      DELAY100
			EXTERN		CONVRT
			EXTERN		OutChar
			EXTERN		OutStr

WAVE_PROP	PROC
		PUSH{LR}
		
		; Need to clear CAERIS bit of TIMER0_RIS. 
AGAIN	LDR R1, = TIMER1_ICR
		MOV R2, #0x04;				 
		STR R2, [R1] 
		
		; CREATE A PULSE ON PB5 TO TRIGGER DISTANCE SENSOR
		LDR R1,=GPIO_PORTB_DATA
		LDR R0,[R1]
		ORR R0,#0x20
		STR R0,[R1]
		BL DELAY100
		LDR R1,=GPIO_PORTB_DATA
		LDR R0,[R1]
		BIC R0,#0x20
		STR R0,[R1]
		
		; SET THE MEMORY FOR POS-NEG EDGE MEMORIZATION
INIT	LDR R3, =0x20000500
		; SET THE MEMORY FOR TIMER VALUES
		LDR R7, =0x20000600
		; MEMORY FOR CAPTURE AMOUNT
		MOV R8, #0

	
		; Await edge capture event 
LOOPY	LDR 	R1, =TIMER1_RIS 
loop 	LDR 	R2, [R1] 
		CMP 	R2 ,#0x4 				; isolate CAERIS bit
		BNE 	loop 					; if no capture, then loop 
				
		ADD 	R8,#1					; INCREMENT CAPTURE AMOUNT

		LDR		R1, =TIMER1_TAR			; address of timer register 
		LDR 	R2, [R1] 				; Get timer register value
		STR 	R2, [R7],#4				; STORE THE VALUE

		LDR 	R1,=GPIO_PORTB_DATA
		LDR		R2, [R1]				; load the input value
		and 	r2,#0x10				; mask the input
		
		MOV 	R4,#0
		MOV 	R5,#1

		CMP 	R2, #0x10 				
		STRBEQ R5,[R3],#1				; STR 1 IF POSEDGE 
		STRBNE R4,[R3],#1				; STR 0 IF NEGEDGE


		CMP 	R8,#2
		BEQ 	OUT
				
		; Need to clear CAERIS bit of TIMER0_RIS. 
		LDR R1, = TIMER1_ICR
		MOV R2, #0x04;				 
		STR R2, [R1] 

		B 	LOOPY

OUT		; SET THE MEMORY FOR POS-NEG EDGE MEMORIZATION
		LDR R3, =0x20000500
		; SET THE MEMORY FOR TIMER VALUES
		LDR R7, =0x20000600
				

		LDRB 	R1,[R3]		; LOOK FOR THE FIRST EDGE
		CMP		R1,#1			; IF POSEDGE
		BEQ 	POS

		; IF FIRST EDGE NEGEDGE 
		; WRONG EDGES ARE DETECTED
		B INIT

		; IF FIRST EDGE IS POSEDGE

POS		LDR R0, [R7],#4		; FIRST TIMER VALUE
		LDR	R1, [R7]		; SECOND TIMER VALUE

		CMP R0,R1
		BLS AGAIN
		
		SUB R7,R0,R1		; PULSE WIDTH IS FOUND
			
		; convert results to seconds and print
		; 1 cycle 62.5 ns = 62.5*10-3 us
		MOV R0,#625
		MOV R1,#10000
		MUL R7,R0
		UDIV R7,R1 ; PULSE WIDTH IS FOUND IN us
		
		; find the distance
		MOV R0,#17
		MOV R1,#100
		MUL R2,R7,R0
		UDIV R2,R2,R1 ; DISTANCE IS FOUND IN mm
		
		;print the distance
		LDR R5,=MSG1
		BL OutStr
		MOV R3,#999
		LDR R5,=0x20000500
		MOV	R4,R2
		; CHECK IF THE DISTANCE IS LARGER THAN 999mm
		CMP R4,R3
		MOVHI R4,R3
		BL CONVRT 
		
		; STORE THE DISTANCE AT A MEMORY LOCATION
		LDR R3,=0x20000400
		STR R4,[R3]
		
		POP{LR}
		BX LR
		ENDP
		END
