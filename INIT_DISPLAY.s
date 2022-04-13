			AREA		main, READONLY, CODE
            THUMB

			EXPORT		INIT_DISPLAY
			EXTERN		WRITE_COMMAND
			EXTERN		WRITE_DISPLAY
			EXTERN 		DELAY100

chars1		DCB 	   0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; 20
chars2		DCB        0x00, 0x00, 0x5f, 0x00, 0x00, 0x00 ; 21 !
chars3		DCB		   0x14, 0x08, 0x3e, 0x08, 0x14, 0x00 ; 2a *
chars4		DCB        0x08, 0x08, 0x08, 0x08, 0x08, 0x00 ; 2d -
chars5		DCB 	   0x00, 0x60, 0x60, 0x00, 0x00, 0x00 ; 2e .
chars6		DCB        0x3e, 0x51, 0x49, 0x45, 0x3e, 0x00 ; 30 0
chars7		DCB        0x00, 0x42, 0x7f, 0x40, 0x00, 0x00 ; 31 1
chars8		DCB        0x42, 0x61, 0x51, 0x49, 0x46, 0x00 ; 32 2
chars9		DCB        0x21, 0x41, 0x45, 0x4b, 0x31, 0x00 ; 33 3
chars10		DCB        0x18, 0x14, 0x12, 0x7f, 0x10, 0x00 ; 34 4
chars11		DCB        0x27, 0x45, 0x45, 0x45, 0x39, 0x00 ; 35 5
chars12		DCB        0x3c, 0x4a, 0x49, 0x49, 0x30, 0x00 ; 36 6
chars13		DCB        0x01, 0x71, 0x09, 0x05, 0x03, 0x00 ; 37 7
chars14		DCB        0x36, 0x49, 0x49, 0x49, 0x36, 0x00 ; 38 8
chars15		DCB        0x06, 0x49, 0x49, 0x29, 0x1e, 0x00 ; 39 9
chars16		DCB        0x00, 0x36, 0x36, 0x00, 0x00, 0x00 ; 3a :
chars17		DCB        0x14, 0x14, 0x14, 0x14, 0x14, 0x00 ; 3d =
chars18		DCB        0x00, 0x41, 0x22, 0x14, 0x08, 0x00 ; 3e >
chars19		DCB        0x7e, 0x11, 0x11, 0x11, 0x7e, 0x00 ; 41 A
chars20		DCB        0x7f, 0x49, 0x49, 0x49, 0x36, 0x00 ; 42 B
chars21		DCB        0x3e, 0x41, 0x41, 0x41, 0x22, 0x00 ; 43 C
chars22		DCB        0x7f, 0x41, 0x41, 0x22, 0x1c, 0x00 ; 44 D
chars23		DCB        0x7f, 0x49, 0x49, 0x49, 0x41, 0x00 ; 45 E
chars24		DCB        0x7f, 0x09, 0x09, 0x09, 0x01, 0x00 ; 46 F
chars25		DCB        0x3e, 0x41, 0x49, 0x49, 0x7a, 0x00 ; 47 G
chars26		DCB        0x7f, 0x08, 0x08, 0x08, 0x7f, 0x00 ; 48 H
chars27		DCB        0x00, 0x41, 0x7f, 0x41, 0x00, 0x00; 49 I
chars28		DCB        0x20, 0x40, 0x41, 0x3f, 0x01, 0x00 ; 4a J
chars29		DCB        0x7f, 0x08, 0x14, 0x22, 0x41, 0x00 ; 4b K
chars30		DCB        0x7f, 0x40, 0x40, 0x40, 0x40, 0x00 ; 4c L
chars31		DCB        0x7f, 0x02, 0x0c, 0x02, 0x7f, 0x00 ; 4d M
chars32		DCB        0x7f, 0x04, 0x08, 0x10, 0x7f, 0x00 ; 4e N
chars33		DCB        0x3e, 0x41, 0x41, 0x41, 0x3e, 0x00 ; 4f O
chars34		DCB        0x7f, 0x09, 0x09, 0x09, 0x06, 0x00 ; 50 P
chars35		DCB        0x3e, 0x41, 0x51, 0x21, 0x5e, 0x00 ; 51 Q
chars36		DCB		   0x7f, 0x09, 0x19, 0x29, 0x46, 0x00 ; 52 R
chars37		DCB        0x46, 0x49, 0x49, 0x49, 0x31, 0x00 ; 53 S
chars38		DCB        0x01, 0x01, 0x7f, 0x01, 0x01, 0x00 ; 54 T
chars39		DCB		   0x3f, 0x40, 0x40, 0x40, 0x3f, 0x00 ; 55 U
chars40		DCB        0x1f, 0x20, 0x40, 0x20, 0x1f, 0x00 ; 56 V
chars41		DCB        0x3f, 0x40, 0x38, 0x40, 0x3f, 0x00 ; 57 W
chars42		DCB        0x63, 0x14, 0x08, 0x14, 0x63, 0x00 ; 58 X
chars43		DCB        0x07, 0x08, 0x70, 0x08, 0x07, 0x00 ; 59 Y
chars44		DCB        0x61, 0x51, 0x49, 0x45, 0x43, 0x00 ; 5a Z
chars45		DCB        0x20, 0x54, 0x54, 0x54, 0x78, 0x00 ; 61 a
chars46		DCB        0x7f, 0x48, 0x44, 0x44, 0x38, 0x00 ; 62 b
chars47		DCB        0x38, 0x44, 0x44, 0x44, 0x20, 0x00 ; 63 c
chars48		DCB        0x38, 0x44, 0x44, 0x48, 0x7f, 0x00 ; 64 d
chars49		DCB        0x38, 0x54, 0x54, 0x54, 0x18, 0x00 ; 65 e
chars50		DCB        0x08, 0x7e, 0x09, 0x01, 0x02, 0x00 ; 66 f
chars51		DCB        0x0c, 0x52, 0x52, 0x52, 0x3e, 0x00 ; 67 g
chars52		DCB        0x7f, 0x08, 0x04, 0x04, 0x78, 0x00 ; 68 h
chars53		DCB        0x00, 0x44, 0x7d, 0x40, 0x00, 0x00 ; 69 i
chars54		DCB        0x20, 0x40, 0x44, 0x3d, 0x00, 0x00 ; 6a j
chars55		DCB        0x7f, 0x10, 0x28, 0x44, 0x00, 0x00 ; 6b k
chars56		DCB        0x00, 0x41, 0x7f, 0x40, 0x00, 0x00 ; 6c l
chars57		DCB        0x7c, 0x04, 0x18, 0x04, 0x78, 0x00 ; 6d m
chars58		DCB        0x7c, 0x08, 0x04, 0x04, 0x78, 0x00 ; 6e n
chars59		DCB        0x38, 0x44, 0x44, 0x44, 0x38, 0x00 ; 6f o
chars60		DCB        0x7c, 0x14, 0x14, 0x14, 0x08, 0x00 ; 70 p
chars61		DCB        0x08, 0x14, 0x14, 0x18, 0x7c, 0x00 ; 71 q
chars62		DCB        0x7c, 0x08, 0x04, 0x04, 0x08, 0x00 ; 72 r
chars63		DCB        0x48, 0x54, 0x54, 0x54, 0x20, 0x00 ; 73 s
chars64		DCB        0x04, 0x3f, 0x44, 0x40, 0x20, 0x00 ; 74 t
chars65		DCB        0x3c, 0x40, 0x40, 0x20, 0x7c, 0x00 ; 75 u
chars66		DCB        0x1c, 0x20, 0x40, 0x20, 0x1c, 0x00 ; 76 v
chars67		DCB        0x3c, 0x40, 0x30, 0x40, 0x3c, 0x00 ; 77 w
chars68		DCB        0x44, 0x28, 0x10, 0x28, 0x44, 0x00 ; 78 x
chars69		DCB        0x0c, 0x50, 0x50, 0x50, 0x3c, 0x00 ; 79 y
chars70		DCB        0x44, 0x64, 0x54, 0x4c, 0x44, 0x00 ; 7a z
 
 ALIGN
; INIT THE DISPLAY WITH NORMAL OPERATION SCREEN
INIT_DISPLAY	PROC
		PUSH{LR}
	; FIRST LINE: Meas: *** mm
		LDR R3,=chars31
		BL WRITE_DISPLAY
		LDR R3,=chars49
		BL WRITE_DISPLAY
		LDR R3,=chars45
		BL WRITE_DISPLAY
		LDR R3,=chars63
		BL WRITE_DISPLAY
		LDR R3,=chars16
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars57
		BL WRITE_DISPLAY
		LDR R3,=chars57
		BL WRITE_DISPLAY
		
		; GO TO SECOND LINE (X=0,Y=1)
		LDR R2,=0x41
		BL WRITE_COMMAND
		LDR R2,=0x80
		BL WRITE_COMMAND
		
		; SECOND LINE: Thre: *** mm
		LDR R3,=chars38
		BL WRITE_DISPLAY
		LDR R3,=chars52
		BL WRITE_DISPLAY
		LDR R3,=chars62
		BL WRITE_DISPLAY
		LDR R3,=chars49
		BL WRITE_DISPLAY
		LDR R3,=chars16
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars57
		BL WRITE_DISPLAY
		LDR R3,=chars57
		BL WRITE_DISPLAY
		
		; GO TO THIRD LINE (X=0,Y=2)
		LDR R2,=0x42
		BL WRITE_COMMAND
		LDR R2,=0x80
		BL WRITE_COMMAND
		
		; THIRD LINE: -> Normal Op.
		LDR R3,=chars4
		BL WRITE_DISPLAY
		LDR R3,=chars18
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars32
		BL WRITE_DISPLAY
		LDR R3,=chars59
		BL WRITE_DISPLAY
		LDR R3,=chars62
		BL WRITE_DISPLAY
		LDR R3,=chars57
		BL WRITE_DISPLAY
		LDR R3,=chars45
		BL WRITE_DISPLAY
		LDR R3,=chars56
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars33
		BL WRITE_DISPLAY
		LDR R3,=chars60
		BL WRITE_DISPLAY
		LDR R3,=chars5
		BL WRITE_DISPLAY
		
		; GO TO FIFTH LINE (Y=4,X=0)
		LDR R2,=0x44
		BL WRITE_COMMAND
		LDR R2,=0x80
		BL WRITE_COMMAND
		
		; FIFTH LINE: CAR **********
		LDR R3,=chars21
		BL WRITE_DISPLAY
		LDR R3,=chars19
		BL WRITE_DISPLAY
		LDR R3,=chars36
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		LDR R3,=chars3
		BL WRITE_DISPLAY
		
		; GO TO FIFTH LINE (Y=4,X=0)
		LDR R2,=0x43
		BL WRITE_COMMAND
		LDR R2,=0x80
		BL WRITE_COMMAND
		
		; FIFTH LINE: CAR **********
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY


		; GO TO FIFTH LINE (Y=4,X=0)
		LDR R2,=0x45
		BL WRITE_COMMAND
		LDR R2,=0x80
		BL WRITE_COMMAND
		
		; FIFTH LINE: CAR **********
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		LDR R3,=chars1
		BL WRITE_DISPLAY
		POP{LR}
		BX LR
		ENDP
		END