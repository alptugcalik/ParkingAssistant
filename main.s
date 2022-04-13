SYSCTL_RCGCSSI 		EQU		0x400FE61C	
SSICR0				EQU		0x40008000
SSICR1				EQU		0x40008004
SSICPSR				EQU		0x40008010
SSIDR				EQU		0x40008008
SSISR				EQU		0x4000800C
GPIO_PORTB_DATA 	EQU 	0x400053FC ; Data	
GPIO_PORTF_DATA 	EQU 	0x400253FC ; data address to all pins SPECIFIED WITH REQUIRED MASK
TIMER2_CTL 			EQU 0x4003200C ; Control Register 
	
			AREA		main, READONLY, CODE
            THUMB


			EXTERN GPIOINIT_A
			EXTERN GPIOINIT_B
			EXTERN GPIOINIT_F
			EXTERN INIT_SSI0
			EXTERN DELAY100
			EXTERN WAVE_PROP
			EXTERN INIT_SCREEN
			EXTERN WRITE_DISPLAY
			EXTERN INIT_TIMER1
			EXTERN INIT_TIMER2
			EXTERN INIT_ADC
			EXTERN INIT_DISPLAY
			EXTERN READ_ANALOG
			EXTERN CONVRT_DIGITAL
			EXTERN InitSysTick
			EXTERN UPDATE_MEAS
			EXTERN UPDATE_THRE
			EXTERN UPDATE_OP
			EXTERN UPDATE_BAR
			EXPORT __main
				
__main		PROC
	; INITIALIZATIONS
			BL INIT_TIMER1
			BL INIT_TIMER2
			BL GPIOINIT_F
			BL GPIOINIT_B
			BL GPIOINIT_A
			BL INIT_SSI0
			BL INIT_SCREEN
			BL INIT_ADC
			BL INIT_DISPLAY
			
		; create a memory for state reconition
		; 0 -> normal operation
		; 1 -> threshold setting
		; 2 -> prevenative breaking
			LDR R5,=0x20000550
		; at start, the system is in normal operation
			MOV R4,#0
			STRB R4,[R5]
		; create a memory for threshold value
		; initially the threshold value is 50 cm
			LDR R5,=0x20000560
			MOV R4,#500
			STR R4,[R5]
		; DISPLAY THE THRESHOLD
			BL UPDATE_THRE
			BL UPDATE_BAR
DENE		; FIND THE STATE
			LDR R3,=0x20000550
			LDRB R3,[R3]
;---------------------------------------------------------------------------------------------			
			; NORMAL STATE
			CMP R3,#0
			BNE OTHER
			; MEASURE THE DISTANCE
			BL WAVE_PROP
			; UPDATE THE DISPLAY
			BL UPDATE_MEAS
			; CHECK THE MEASURED DISTANCE
			LDR R5,=0x20000560
			LDR R5,[R5]
			; R4 CONTAINS THE CURRENT DISTANCE AND R5 CONTAINS THE THRESHOLD
			; UPDATE BAR
			BL UPDATE_BAR
			CMP R4,R5
			; IF THE THRESHOLD IS NOT EXCEED
			BHI DENE
			; IF THE THRESHOLD IS EXCEED
			; GO TO PREVEVNTATVE BREAKING STATE AND WAIT FOR A RESET
			LDR R5,=0x20000550
			MOV R4,#2
			STRB R4,[R5]
			; UPDATE DISPLAY
			BL UPDATE_OP
			; IN ORDER TO STOP THE MOTOR, DISABLE  TIMER2A
			LDR R1, =TIMER2_CTL 
			LDR R2, [R1] 
			BIC R2, R2, #0x01 			; clear bit 0 to disable Timer 2
			STR R2, [R1] 
			B DENE
;---------------------------------------------------------------------------------------------
			; THRESHOLD SETTING
OTHER		CMP R3,#1
			BNE OTHER2
			; LOOP UNTIL THE SYSTEM GOES INTO NORMAL OPERATION
			; IN THE LOOP, READ VALUES FROM POTENTIOMETER AND ARRANGE THRESHOLD FOR DISPLAY
			BL READ_ANALOG
			BL CONVRT_DIGITAL
			BL UPDATE_THRE
			B DENE
;---------------------------------------------------------------------------------------------
			; PREVENTATIVE BREAKING
OTHER2		; LOOP TO DENE WHILE WAITING A RESET
			B DENE
			
		ENDP
		END