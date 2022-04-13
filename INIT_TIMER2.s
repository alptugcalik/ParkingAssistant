	
			AREA		main, READONLY, CODE
            THUMB
; Timer channel registers for TIMER2: 
TIMER2_CFG 			EQU 0x40032000 ; Configuration Register 
TIMER2_TAMR 		EQU 0x40032004 ; Mode Register 
TIMER2_CTL 			EQU 0x4003200C ; Control Register 
TIMER2_RIS 			EQU 0x4003201C ; Raw interrupt Status 
TIMER2_ICR 			EQU 0x40032024 ; Interrupt Clear Register 
TIMER2_TAILR		EQU 0x40032028 ; Interval Load Register 
TIMER2_TAMATCHR 	EQU 0x40032030 ; Match Register 
TIMER2_TAPR			EQU 0x40032038 ; Prescaling Divider 
TIMER2_TAR 			EQU 0x40032048 ; Counter Register 
TIMER2_IMR 			EQU 0x40032018 ; IMR Register
NVIC_EN0			EQU		0xE000E100

; Timer Gate Control 
SYSCTL_RCGCTIMER	EQU 0x400FE604 ; Timer Clock Gating 

;GPIO Gate Control Register 
SYSCTL_RCGCGPIO 	EQU 0x400FE608 

			EXPORT		INIT_TIMER2

INIT_TIMER2	PROC
		
		; Start Timer 2 clock 
		LDR R1, =SYSCTL_RCGCTIMER 
		LDR R2, [R1] ; Start timer 2 
		ORR R2, R2, #0x04			; Timer module = bit position (2) 
		STR R2, [R1] 
		NOP 
		NOP 
		NOP 					; allow clock to settle 

		; disable timer during setup 
		LDR R1, =TIMER2_CTL 
		LDR R2, [R1] 
		BIC R2, R2, #0x01 			; clear bit 0 to disable Timer 2
		STR R2, [R1] 

		; set to 16bit Timer Mode 
		LDR R1, =TIMER2_CFG 
		MOV R2, #0x04			; set bits 2:0 to 0x04 for 16bit timer 
		STR R2, [R1] 
		
		LDR R1, =TIMER2_TAMR 
		MOV R2, #0x02 			 ; periodic mode
		STR R2, [R1] 				
		
		; set start value 
		LDR R1, =TIMER2_TAILR 			; counter counts down, 
		LDR R0, =0x0000FFFF 			; so start counter at max value 
		STR R0, [R1] 
			
		LDR R1, =TIMER2_TAPR
		MOV R2, #3 ; divide clock by 4 to
		STR R2, [R1] 		
		
		;enable interrupt
		; Enable timer 
		LDR R1, =TIMER2_IMR ; 
		LDR R2, [R1] ; 
		ORR R2, R2, #0x01				 ; set bit 0 to enable INTERRUPT
		STR R2, [R1]
		
		; Enable timer 
		LDR R1, =TIMER2_CTL ; 
		LDR R2, [R1] ; 
		ORR R2, R2, #0x01				 ; set bit 0 to enable 
		STR R2, [R1] 

		; Need to clear CAERIS bit of TIMER0_RIS. 
		LDR R1, = TIMER2_ICR
		MOV R2, #0x01 ;				 
		STR R2, [R1] 
		
		; enable interrupt 
		LDR R1, =NVIC_EN0 
		LDR R0,[R1]
		ORR R0,#0x00800000 ; ENABLE INTERRUPT FOR timer 2a
		STR R0 ,[R1]
		
		BX LR
		ENDP
		END
