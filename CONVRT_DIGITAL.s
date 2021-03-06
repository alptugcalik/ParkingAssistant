			AREA		main, READONLY, CODE
            THUMB
				
TIMER0_MATCH		EQU 0x40030030
	
			EXPORT		CONVRT_DIGITAL
			EXTERN		OutChar
			EXTERN 		OutStr
			EXTERN 		CONVRT

MSG			DCB "Threshold Distance(mm):",0x04

CONVRT_DIGITAL	PROC
			PUSH{LR}
			; FFF->3.3V 000->0V 
			; 3.3/2^12 = RESOULUTION
			; RESOULUTON IS 0.806 mV
			
			; MAX MATCH VALUE IS 4000
			; USE PROPORTIONS TO ARRANGE MATCH VALUE
			MOV R1,#806 ; LOAD THE FRACTIONAL PART
			MUL R5,R0,R1 
			MUL R5,R0,R1 
			MOV R6,#1000
			UDIV R4,R5,R6
			MOV R6,#4000
			MUL R4,R6
			MOV R6,#3300
			UDIV R4,R6
					
			MOV R1,#10000 ; PREPARE FOR DIVISION
			
			
			UDIV R5,R1 ; THE NUMBER IS OBTAINED IN 3 digits XYZ
			MOV R6,R5
			
			MOV R1,#3
			MUL R6,R1 ; FIND THE THRESHOLD DISTANCE
			; STORE IT TO ANOTHER MEMORY
			LDR R5,=0x20000560
			STR R6,[R5]
						
;			MOV R1,#10 ; IT IS INTENDED TO FIND X.YZ IN BCD
;			UDIV R2,R5,R1 ; DIVIDE BY 10
;			MUL R3,R2,R1 ; MUL BY 10
;			SUB R3,R5,R3 ; Z IS OBTAINED
;			UDIV R4,R2,R1 
;			MUL R4,R4,R1
;			SUB R4,R2,R4 ; Y IS OBTAINED
;			UDIV R2,R1 ; X IS OBTAINED
;			; NOW OBTAIN BCD EQUIVALENT
;			LSL R2,#8
;			LSL R4,#4
;			ADD R2,R4
;			ADD R3,R2 ; THE NUMBER IS IN R3
;			
;			
;			; PRINT OPERATION IS CHECKED
;PRINT		MOV R1,#0xF00
;			AND R5,R3,R1 ; MASK FIRST DIGIT
;			LSR R5,#8 ; SHIFT BY 8
;			ADD R5,#48 ; DIGIT TO ASCII
;			BL OutChar
;			; print a dot
;			MOV R5,#46
;			BL OutChar
;			MOV R1,#0x0f0
;			AND R5,R3,R1 ; MASK second DIGIT
;			LSR R5,#4 ; SHIFT BY 4
;			ADD R5,#48 ; DIGIT TO ASCII
;			BL OutChar
;			MOV R1,#0x00f
;			AND R5,R3,R1 ; MASK third DIGIT
;			ADD R5,#48 ; DIGIT TO ASCII
;			BL OutChar
;			MOV r5,#10
;			BL OutChar ;new line
			
			LDR R5,=MSG
			BL OutStr
			; PRINT THE THRESHOLD DISTANCE
			LDR R5,=0x20000500
			MOV R4,R6
			BL CONVRT
			
OUT			POP{LR}
			BX LR
			ENDP
			END