SYSCTL_RCGCSSI 		EQU		0x400FE61C	
SSICR0				EQU		0x40008000
SSICR1				EQU		0x40008004
SSICPSR				EQU		0x40008010
SSIDR				EQU		0x40008008
SSISR				EQU		0x4000800C
GPIO_PORTB_DATA 	EQU 	0x400053FC ; Data						
			
			AREA		main, READONLY, CODE
            THUMB

			EXPORT		INIT_SCREEN
			EXTERN		WRITE_COMMAND
			EXTERN 		DELAY100


INIT_SCREEN	PROC
	PUSH{LR}		
	; RESET THE NOKIA SCREEN
			LDR R1 , =GPIO_PORTB_DATA  
			LDR R0 , [R1]
			MOV R0 , #0x0
			STR R0 , [R1]
			BL DELAY100
			LDR R1 , =GPIO_PORTB_DATA  
			LDR R0 , [R1]
			MOV R0 , #0x1
			STR R0 , [R1]
			
	
	; SET H=1 AND V=0
			MOV R2,#0x21
			BL WRITE_COMMAND
	
	; SET VOP
			MOV R2,#0xB5
			BL WRITE_COMMAND
			
	; SET TEMP CONTROL
			MOV R2,#0x05
			BL WRITE_COMMAND
			
	; SET BIAS VOLTAGE
			MOV R2,#0x13
			BL WRITE_COMMAND
	
	; SET H=0 FOR BASIC COMMAND MODE
			MOV R2,#0x20
			BL WRITE_COMMAND
		
	; SET NORMAL DISPLAY MODE
			MOV R2,#0x0C
			BL WRITE_COMMAND
			
	; SET CURSOR TO 0,0	
			MOV R2,#0x40
			BL WRITE_COMMAND
			MOV R2,#0x80
			BL WRITE_COMMAND
			
			POP{LR}	
			BX LR
			ENDP
			END