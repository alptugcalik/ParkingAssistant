SYSCTL_RCGCSSI 		EQU		0x400FE61C	
SSICR0				EQU		0x40008000
SSICR1				EQU		0x40008004
SSICPSR				EQU		0x40008010
SSIDR				EQU		0x40008008
			
			AREA		main, READONLY, CODE
            THUMB

			EXPORT		INIT_SSI0


INIT_SSI0	PROC
					
			; DISABLE SSI AND SET MASTER
			LDR R1,=SSICR1
			LDR R0,[R1]
			BIC R0,#0x06
			STR R0 ,[R1]
			
			; SET BIT RATE AS 1 MBIT
			
			LDR R1,=SSICR0
			LDR R0,[R1]
			BIC R0,#0xFF00 
			ORR R0,#0x300
			STR R0 ,[R1]
			
			LDR R1,=SSICPSR
			LDR R0,[R1]
			BIC R0,#0xFF
			ORR R0,#0x4
			STR R0 ,[R1]
			
			; SET DATA SIZE AS 8 BIT AND FREESCALE MODE
			LDR R1,=SSICR0
			LDR R0,[R1]
			BIC R0,#0x3F
			ORR R0,#0x7
			STR R0 ,[R1]
			
			; ENABEL SSI
			LDR R1,=SSICR1
			LDR R0,[R1]
			ORR R0,#0x02 
			STR R0 ,[R1]
			
			BX LR
			ENDP
			END