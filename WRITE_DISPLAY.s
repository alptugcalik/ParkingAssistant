SYSCTL_RCGCSSI 		EQU		0x400FE61C	
SSICR0				EQU		0x40008000
SSICR1				EQU		0x40008004
SSICPSR				EQU		0x40008010
SSIDR				EQU		0x40008008
SSISR				EQU		0x4000800C
GPIO_PORTB_DATA 	EQU 	0x400053FC ; Data						
			
			AREA		main, READONLY, CODE
            THUMB

			EXPORT		WRITE_DISPLAY


; THIS SUBROUTINE SENDS DISPLAY TO SCREEN
; DISPLAYED CHAR ADDRESS IS IN THE REGISTER R3

WRITE_DISPLAY	PROC
	PUSH{LR}
	PUSH{R0,R1,R2,R3,R6}		
	; SET DISPLAY MODE BY SETTING PB1
			LDR R1 , =GPIO_PORTB_DATA  
			LDR R0 , [R1]
			ORR R0, #0x2
			STR R0 , [R1]
			
			MOV R6,#0 ; COUNTER
			
LOOP		LDRB R2,[R3]
			ADD R3,#1
			ADD R6,#1
			
			LDR R1,=SSISR
DON1		LDR R0 , [R1]
			AND R0,#0x02 ; MASK TNF
			CMP R0,#0x02
			BEQ DVM1
			B DON1	
DVM1
	; WRITE THE DATA
			LDR R1,=SSIDR
			STR R2 ,[R1]
	
	; WAIT FOR TRANSMISSION	
			LDR R1,=SSISR
DON2		LDR R0 , [R1]
			AND R0,#0x11 ; MASK BSY AND TEF
			CMP R0,#0x01
			BEQ DVM2
			B DON2	
DVM2	
			
			CMP R6,#6
			BNE LOOP
	POP{R0,R1,R2,R3,R6}		
			POP{LR}	
			BX LR
			ENDP
			END