0000: bd 78        MOV     D,#78H
0002: a7 78        CLR1    0FE78H.7
0004: ff           CALLT   [007EH]
0005: ff           CALLT   [007EH]
0006: 1a 79        MOVW    0FE79H,AX
0008: ff           CALLT   [007EH]
0009: ff           CALLT   [007EH]
000a: 0d           DB      0DH
000b: 79 ff ff     ADDC    0FEFFH,0FEFFH
000e: e2           CALLT   [0044H]
000f: 78 ff ff     ADD     0FEFFH,0FEFFH
0012: ff           CALLT   [007EH]
0013: ff           CALLT   [007EH]
0014: ff           CALLT   [007EH]
0015: ff           CALLT   [007EH]
0016: 17           DB      17H
0017: 79 ff ff     ADDC    0FEFFH,0FEFFH
001a: ff           CALLT   [007EH]
001b: ff           CALLT   [007EH]
001c: ff           CALLT   [007EH]
001d: ff           CALLT   [007EH]
001e: ff           CALLT   [007EH]
001f: ff           CALLT   [007EH]
0020: ff           CALLT   [007EH]
0021: ff           CALLT   [007EH]
0022: 2b 77 70     MOV     0FF77H,#70H
0025: 78 ff ff     ADD     0FEFFH,0FEFFH
0028: ff           CALLT   [007EH]
0029: ff           CALLT   [007EH]
002a: ff           CALLT   [007EH]
002b: ff           CALLT   [007EH]
002c: ff           CALLT   [007EH]
002d: ff           CALLT   [007EH]
002e: ff           CALLT   [007EH]
002f: ff           CALLT   [007EH]
0030: ff           CALLT   [007EH]
0031: ff           CALLT   [007EH]
0032: ff           CALLT   [007EH]
0033: ff           CALLT   [007EH]
0034: ff           CALLT   [007EH]
0035: ff           CALLT   [007EH]
0036: ff           CALLT   [007EH]
0037: ff           CALLT   [007EH]
0038: ff           CALLT   [007EH]
0039: ff           CALLT   [007EH]
003a: ff           CALLT   [007EH]
003b: ff           CALLT   [007EH]
003c: ff           CALLT   [007EH]
003d: ff           CALLT   [007EH]
003e: 23           DB      23H
003f: 79 ff ff     ADDC    0FEFFH,0FEFFH

; 0400..07ff   Empty EPROM (FF)


I2C_Output:
0800: 20 b2        MOV     A,I2C_OutputBuffer
0802: 9c b3        AND     A,I2C_OutputMask   ; how many bits remain, as a mask
0804: af 00        CMP     A,#00H
0806: 81 04        BZ      $080CH
0808: b7 06        SET1    P6.7               ; set DATA high
080a: 14 02        BR      $080EH
080c: a7 06        CLR1    P6.7               ; set DATA low
080e: 20 b3        MOV     A,I2C_OutputMask
0810: 30 89        SHR     A,1
0812: 22 b3        MOV     I2C_OutputMask,A
0814: b6 06        SET1    P6.6               ; set the CLOCK high
0816: 28 4b 60     CALL    Empty_Debug
0819: a6 06        CLR1    P6.6               ; set the CLOCK low
081b: 6f b3 00     CMP     I2C_OutputMask,#00H
081e: 80 e0        BNZ     I2C_Output
0820: a7 06        CLR1    P6.7
0822: 56           RET
Set_HiBit:
0823: 64 2f fd     MOVW    DE,#0FD2FH
0826: 5c           MOV     A,[DE]
0827: ae 80        OR      A,#80H
0829: 54           MOV     [DE],A
082a: 64 d4 ff     MOVW    DE,#0FFD4H
082d: 54           MOV     [DE],A
082e: 56           RET
Clear_HiBit:
082f: 64 2f fd     MOVW    DE,#0FD2FH
0832: 5c           MOV     A,[DE]
0833: ac 7f        AND     A,#7FH
0835: 54           MOV     [DE],A
0836: 64 d4 ff     MOVW    DE,#0FFD4H
0839: 54           MOV     [DE],A
083a: 56           RET
Weird_Stack_Thing:
083b: 3f           PUSH    HL
083c: 05 c9        DECW    SP
083e: 05 c9        DECW    SP
0840: 11 fc        MOVW    AX,SP
0842: 24 68        MOVW    HL,AX
0844: 60 ff ff     MOVW    AX,#0FFFFH
0847: 06 a0 01     MOV     [HL+01H],A
084a: d8           XCH     A,X
084b: 55           MOV     [HL],A
084c: 05 e3        MOVW    AX,[HL]
084e: 4c           DECW    AX
084f: 06 a0 01     MOV     [HL+01H],A
0852: d8           XCH     A,X
0853: 55           MOV     [HL],A
0854: d8           XCH     A,X
0855: 24 28        MOVW    BC,AX
0857: 8a 08        SUBW    AX,AX
0859: 8f 0a        CMPW    AX,BC
085b: 82 08        BNC     $0865H
085d: 64 d7 ff     MOVW    DE,#0FFD7H
0860: 5c           MOV     A,[DE]
0861: ac 40        AND     A,#40H
0863: 81 e7        BZ      $084CH
0865: 06 20 06     MOV     A,[HL+06H]
0868: 22 a6        MOV     0FEA6H,A
086a: 91 5e        CALLF   Serial_Output_Thing
086c: 60 14 00     MOVW    AX,#0014H
086f: 3c           PUSH    AX
0870: 28 6d 8b     CALL    Delay_Loop
0873: 34           POP     AX
0874: 60 ff ff     MOVW    AX,#0FFFFH
0877: 06 a0 01     MOV     [HL+01H],A
087a: d8           XCH     A,X
087b: 55           MOV     [HL],A
087c: 05 e3        MOVW    AX,[HL]
087e: 4c           DECW    AX
087f: 06 a0 01     MOV     [HL+01H],A
0882: d8           XCH     A,X
0883: 55           MOV     [HL],A
0884: d8           XCH     A,X
0885: 24 28        MOVW    BC,AX
0887: 8a 08        SUBW    AX,AX
0889: 8f 0a        CMPW    AX,BC
088b: 82 08        BNC     $0895H
088d: 64 d7 ff     MOVW    DE,#0FFD7H
0890: 5c           MOV     A,[DE]
0891: ac 40        AND     A,#40H
0893: 81 e7        BZ      $087CH
0895: 34           POP     AX
0896: 37           POP     HL
0897: 56           RET
Interpret_Thing:
0898: 3f           PUSH    HL
0899: 05 c9        DECW    SP
089b: 05 c9        DECW    SP
089d: 11 fc        MOVW    AX,SP
089f: 24 68        MOVW    HL,AX
08a1: 06 20 06     MOV     A,[HL+06H]
08a4: 55           MOV     [HL],A
08a5: d8           XCH     A,X
08a6: 06 20 07     MOV     A,[HL+07H]
08a9: 06 a0 01     MOV     [HL+01H],A
08ac: b8 00        MOV     X,#00H
08ae: d8           XCH     A,X
08af: 3c           PUSH    AX
08b0: 90 3b        CALLF   !Weird_Stack_Thing
08b2: 34           POP     AX
08b3: 5d           MOV     A,[HL]
08b4: b8 00        MOV     X,#00H
08b6: d8           XCH     A,X
08b7: 3c           PUSH    AX
08b8: 90 3b        CALLF   !Weird_Stack_Thing
08ba: 34           POP     AX
08bb: 34           POP     AX
08bc: 37           POP     HL
08bd: 56           RET
Puzzle_Piece1:
08be: 3f           PUSH    HL
08bf: 11 fc        MOVW    AX,SP
08c1: 24 68        MOVW    HL,AX
08c3: 90 23        CALLF   !Set_HiBit
08c5: 28 7c 60     CALL    LCD1_Activate
08c8: b9 e0        MOV     A,#0E0H
08ca: 06 2e 04     OR      A,[HL+04H]
08cd: b8 00        MOV     X,#00H
08cf: d8           XCH     A,X
08d0: 3c           PUSH    AX
08d1: 90 3b        CALLF   !Weird_Stack_Thing
08d3: 34           POP     AX
08d4: 90 2f        CALLF   !Clear_HiBit
08d6: 37           POP     HL
08d7: 56           RET
08d8: 3f           PUSH    HL
08d9: 11 fc        MOVW    AX,SP
08db: 24 68        MOVW    HL,AX
08dd: 90 23        CALLF   !Set_HiBit
08df: 28 85 60     CALL    LCD2_Activate
08e2: b9 e0        MOV     A,#0E0H
08e4: 06 2e 04     OR      A,[HL+04H]
08e7: b8 00        MOV     X,#00H
08e9: d8           XCH     A,X
08ea: 3c           PUSH    AX
08eb: 90 3b        CALLF   !Weird_Stack_Thing
08ed: 34           POP     AX
08ee: 90 2f        CALLF   !Clear_HiBit
08f0: 37           POP     HL
08f1: 56           RET
08f2: 3f           PUSH    HL
08f3: 11 fc        MOVW    AX,SP
08f5: 24 68        MOVW    HL,AX
08f7: 06 20 04     MOV     A,[HL+04H]
08fa: ac 0f        AND     A,#0FH
08fc: b8 00        MOV     X,#00H
08fe: d8           XCH     A,X
08ff: 88 08        ADDW    AX,AX
0901: 2d 49 11     ADDW    AX,#1149H
0904: 24 48        MOVW    DE,AX
0906: 05 e2        MOVW    AX,[DE]
0908: 3c           PUSH    AX
0909: 90 98        CALLF   !Interpret_Thing
090b: 34           POP     AX
090c: 37           POP     HL
090d: 56           RET
090e: 3f           PUSH    HL
090f: 11 fc        MOVW    AX,SP
0911: 24 68        MOVW    HL,AX
0913: 06 20 04     MOV     A,[HL+04H]
0916: ac 0f        AND     A,#0FH
0918: b8 00        MOV     X,#00H
091a: d8           XCH     A,X
091b: 88 08        ADDW    AX,AX
091d: 2d 49 11     ADDW    AX,#1149H
0920: 24 48        MOVW    DE,AX
0922: 05 e2        MOVW    AX,[DE]
0924: 3c           PUSH    AX
0925: 28 2d 6f     CALL    !6F2DH
0928: 34           POP     AX
0929: 3d           PUSH    BC
092a: 90 98        CALLF   !Interpret_Thing
092c: 34           POP     AX
092d: 37           POP     HL
092e: 56           RET
092f: 20 6a        MOV     A,0FE6AH
0931: b8 00        MOV     X,#00H
0933: d8           XCH     A,X
0934: 3c           PUSH    AX
0935: 90 d8        CALLF   !08D8H
0937: 34           POP     AX
0938: 90 23        CALLF   !Set_HiBit
093a: 20 7e        MOV     A,0FE7EH
093c: ac 10        AND     A,#10H
093e: 80 0d        BNZ     $094DH
0940: b9 b0        MOV     A,#0B0H
0942: 9e 6b        OR      A,0FE6BH
0944: b8 00        MOV     X,#00H
0946: d8           XCH     A,X
0947: 3c           PUSH    AX
0948: 90 3b        CALLF   !Weird_Stack_Thing
094a: 34           POP     AX
094b: 14 0d        BR      $095AH
094d: 20 6b        MOV     A,0FE6BH
094f: ad 0f        XOR     A,#0FH
0951: ae 90        OR      A,#90H
0953: b8 00        MOV     X,#00H
0955: d8           XCH     A,X
0956: 3c           PUSH    AX
0957: 90 3b        CALLF   !Weird_Stack_Thing
0959: 34           POP     AX
095a: 6c 06 f8     AND     P6,#0F8H
095d: 56           RET
Serial_Output_Thing:
095e: 1c ac        MOVW    AX,0FEACH
0960: 3c           PUSH    AX
0961: 3a ac 80     MOV     0FEACH,#80H
0964: 20 a6        MOV     A,0FEA6H
0966: 9c ac        AND     A,0FEACH
0968: af 00        CMP     A,#00H
096a: 81 04        BZ      $0970H
096c: b7 06        SET1    P6.7
096e: 14 02        BR      $0972H
0970: a7 06        CLR1    P6.7
0972: 20 ac        MOV     A,0FEACH
0974: 30 89        SHR     A,1
0976: 22 ac        MOV     0FEACH,A
0978: 28 84 8b     CALL    Cycle_Serial_Clock
097b: 6f ac 00     CMP     0FEACH,#00H
097e: 80 e4        BNZ     $0964H
0980: 34           POP     AX
0981: 1a ac        MOVW    0FEACH,AX
0983: 56           RET
0984: 20 b2        MOV     A,I2C_OutputBuffer
0986: 9c b3        AND     A,I2C_OutputMask
0988: af 00        CMP     A,#00H
098a: 81 04        BZ      $0990H
098c: b7 06        SET1    P6.7
098e: 14 02        BR      $0992H
0990: a7 06        CLR1    P6.7
0992: 20 b3        MOV     A,I2C_OutputMask
0994: 30 89        SHR     A,1
0996: 22 b3        MOV     I2C_OutputMask,A
0998: 28 84 8b     CALL    Cycle_Serial_Clock
099b: 6f b3 00     CMP     I2C_OutputMask,#00H
099e: 80 e4        BNZ     $0984H
09a0: 56           RET
; 09a1-0fff  - Empty EPROM (ff)

1000: 1a 07        MOVW    0FF07H,AX
1002: 08 09 0d     MOV1    CY,0FF0DH.1
1005: 0e           ADJBA
1006: 0f           ADJBS
1007: 13 14        MOVW    0FF14H,AX
1009: 15           DB      15H
100a: 0d           DB      0DH
100b: 0a 00 2d 00  MOV     A,2DH[DE]
100f: 0d           DB      0DH
1010: 0a 00 0d 0a  MOV     A,0A0DH[DE]
1014: 00           NOP
1015: 0d           DB      0DH
1016: 0a 45        DB      0AH,45H
1018: 41           SET1    CY
1019: 3f           PUSH    HL
101a: 00           NOP
101b: 0d           DB      0DH
101c: 0a 00 52 38  MOV     A,3852H[DE]
1020: 00           NOP
1021: 41           SET1    CY
1022: 2e 00 0d     SUBW    AX,#0D00H
1025: 0a 00 0d 0a  MOV     A,0A0DH[DE]
1029: 4c           DECW    AX
102a: 44           INCW    AX
102b: 3f           PUSH    HL
102c: 00           NOP
102d: 0d           DB      0DH
102e: 0a 00 53 63  MOV     A,6353H[DE]
1032: 61           DB      61H
1033: 6e 20 45     OR      0FE20H,#45H
1036: 72 72 6f     BT      0FE72H.2,$10A8H
1039: 72 0a 0d     BT      P0L.2,$1049H
103c: 00           NOP
103d: 0a 0d 00 0a  XOR     A,0A00H[DE]
1041: 0d           DB      0DH
1042: 4e           DECW    DE
1043: 6f 74 20     CMP     0FE74H,#20H
1046: 72 65 63     BT      0FE65H.2,$10ACH
1049: 6f 67 6e     CMP     0FE67H,#6EH
104c: 69 7a 65     ADDC    0FE7AH,#65H
104f: 64 0a 0d     MOVW    DE,#0D0AH
1052: 00           NOP
1053: 0a 0d 00 0d  XOR     A,0D00H[DE]
1057: 0a 00 00 00  MOV     A,0[DE]
105b: 60 05 00     MOVW    AX,#0005H
105e: 00           NOP
105f: 00           NOP
1060: 11 00        MOVW    AX,0FF00H
1062: 00           NOP
1063: 30 11        RORC    A,2
1065: 00           NOP
1066: 00           NOP
1067: 60 11 00     MOVW    AX,#0011H
106a: 00           NOP
106b: 00           NOP
106c: 12 00        MOV     P0,A
106e: 00           NOP
106f: 40           CLR1    CY
1070: 12 00        MOV     P0,A
1072: 00           NOP
1073: 50           MOV     [DE+],A
1074: 12 00        MOV     P0,A
1076: 00           NOP
1077: 80 12        BNZ     $108BH
1079: 00           NOP
107a: 00           NOP
107b: 20 13        MOV     A,0FF13H
107d: 00           NOP
107e: 00           NOP
107f: 60 13 00     MOVW    AX,#0013H
1082: 00           NOP
1083: 90 13        CALLF   !0813H
1085: 00           NOP
1086: 00           NOP
1087: 00           NOP
1088: 14 00        BR      $108AH
108a: 00           NOP
108b: 50           MOV     [DE+],A
108c: 14 00        BR      $108EH
108e: 00           NOP
108f: 00           NOP
1090: 15           DB      15H
1091: 00           NOP
1092: 00           NOP
1093: 20 15        MOV     A,CR20
1095: 00           NOP
1096: 00           NOP
1097: 50           MOV     [DE+],A
1098: 15           DB      15H
1099: 00           NOP
109a: 00           NOP
109b: 00           NOP
109c: 16 00        MOV     A,[DE+]
109e: 00           NOP
109f: 40           CLR1    CY
10a0: 16 00        MOV     A,[DE+]
10a2: 00           NOP
10a3: 70 16 00     BT      CR21.0,$10A6H
10a6: 00           NOP
10a7: 50           MOV     [DE+],A
10a8: 17           DB      17H
10a9: 00           NOP
10aa: 00           NOP
10ab: 10 06        MOV     A,P6
10ad: 00           NOP
10ae: 00           NOP
10af: 80 13        BNZ     $10C4H
10b1: 00           NOP
10b2: 00           NOP
10b3: 80 13        BNZ     $10C8H
10b5: 00           NOP
10b6: 00           NOP
10b7: 80 13        BNZ     $10CCH
10b9: 00           NOP
10ba: 00           NOP
10bb: 80 13        BNZ     $10D0H
10bd: 00           NOP
10be: 00           NOP
10bf: 80 13        BNZ     $10D4H
10c1: 00           NOP
10c2: 00           NOP
10c3: 80 13        BNZ     $10D8H
10c5: 00           NOP
10c6: 00           NOP
10c7: 50           MOV     [DE+],A
10c8: 15           DB      15H
10c9: 00           NOP
10ca: 00           NOP
10cb: 50           MOV     [DE+],A
10cc: 15           DB      15H
10cd: 00           NOP
10ce: 00           NOP
10cf: 50           MOV     [DE+],A
10d0: 15           DB      15H
10d1: 00           NOP
10d2: 00           NOP
10d3: 50           MOV     [DE+],A
10d4: 15           DB      15H
10d5: 00           NOP
10d6: 00           NOP
10d7: 90 16        CALLF   !0816H
10d9: 00           NOP
10da: 00           NOP
10db: 90 16        CALLF   !0816H
10dd: 00           NOP
10de: 00           NOP
10df: 90 16        CALLF   !0816H
10e1: 00           NOP
10e2: 00           NOP
10e3: 90 16        CALLF   !0816H
10e5: 00           NOP
10e6: 00           NOP
10e7: 20 18        MOV     A,0FF18H
10e9: 00           NOP
10ea: 00           NOP
10eb: 20 18        MOV     A,0FF18H
10ed: 00           NOP
10ee: 00           NOP
10ef: 20 18        MOV     A,0FF18H
10f1: 00           NOP
10f2: 00           NOP
10f3: 40           CLR1    CY
10f4: 19           DB      19H
10f5: 00           NOP
10f6: 00           NOP
10f7: 40           CLR1    CY
10f8: 19           DB      19H
10f9: 13 2b        MOVW    0FF2BH,AX
10fb: 2b 2b 2b     MOV     0FF2BH,#2BH
10fe: 2b 2b 30     MOV     0FF2BH,#30H
1101: 30 30        RORC    X,6
1103: 30 34        RORC    E,6
1105: 34           POP     AX
1106: 34           POP     AX
1107: 34           POP     AX
1108: 38 38 38     MOV     0FE38H,0FE38H
110b: 3c           PUSH    AX
110c: 3c           PUSH    AX
110d: 04           DB      04H
110e: 08 08 08     MOV1    CY,0FF08H.0
1111: 08 08 08     MOV1    CY,0FF08H.0
1114: 1c 1c        MOVW    AX,0FF1CH
1116: 1c 1c        MOVW    AX,0FF1CH
1118: 34           POP     AX
1119: 34           POP     AX
111a: 34           POP     AX
111b: 34           POP     AX
111c: 38 38 38     MOV     0FE38H,0FE38H
111f: 28 28 e2     CALL    !0E228H
1122: d1           MOV     A,A
1123: d1           MOV     A,A
1124: d1           MOV     A,A
1125: d1           MOV     A,A
1126: d1           MOV     A,A
1127: d1           MOV     A,A
1128: b1 b1        SET1    0FEB1H.1
112a: b1 b1        SET1    0FEB1H.1
112c: b1 b1        SET1    0FEB1H.1
112e: b1 b1        SET1    0FEB1H.1
1130: 71 71 71     BT      0FE71H.1,$11A4H
1133: 71 71 14     BT      0FE71H.1,$114AH
1136: 29 2e        PUSH    0FF2EH
1138: 30 35        RORC    D,6
113a: 42           NOT1    CY
113b: 4f           DECW    HL
113c: 4f           DECW    HL
113d: 60 6f 80     MOVW    AX,#806FH
1140: 80 99        BNZ     $10DBH
1142: ab c5        SUBC    A,#0C5H
1144: c5           INC     D
1145: d5           MOV     A,D
1146: f0           CALLT   [0060H]
1147: f0           CALLT   [0060H]
1148: ff           CALLT   [007EH]
1149: 91 9d        CALLF   !099DH
114b: 90 00        CALLF   I2C_Output
114d: 50           MOV     [DE+],A
114e: 9a d0        SUB     A,0FED0H
1150: 92 d0        CALLF   !0AD0H
1152: 03 c0        DB      03H,0C0H
1154: 93 c0        CALLF   !0BC0H
1156: 9b 90        SUBC    A,0FE90H
1158: 10 d0        MOV     A,0FFD0H
115a: 9b d0        SUBC    A,0FED0H
115c: 93 40        CALLF   !0B40H
115e: 02 00        MOV1    CY,CY
1160: 00           NOP
1161: d0           MOV     A,X
1162: 1b           DB      1BH
1163: d2           MOV     A,C
1164: d0           MOV     A,X
1165: 00           NOP
1166: 99 92        ADDC    A,0FE92H
1168: d0           MOV     A,X
1169: 00           NOP
116a: 9b 00        SUBC    A,P0
116c: 1b           DB      1BH
116d: c0           INC     X
116e: 99 d0        ADDC    A,0FED0H
1170: 0b 02 d0 90  MOVW    0FF02H,#90D0H
1174: 88 05        ADD     X,D
117a: 29 94        PUSH    0FF94H
117c: 29 90        PUSH    BRGC
117e: 99 50        ADDC    A,0FE50H
1180: 1b           DB      1BH
1181: 94 99        CALLF   !0C99H
1183: 54           MOV     [DE],A
1184: 1b           DB      1BH
1185: c0           INC     X
1186: 93 02        CALLF   !0B02H
1188: 50           MOV     [DE+],A
1189: 90 89        CALLF   !0889H
118b: 01 0d        DB      01H,0DH
118d: 94 0d        CALLF   !0C0DH
118f: 05 24        DB      05H,24H
1191: 01 60        DB      01H,60H
1193: 01 94        DB      01H,94H
1195: de           XCH     A,L
1196: 50           MOV     [DE+],A
1197: 97 d3        CALLF   !0FD3H
1199: 59           MOV     A,[HL+]
119a: cb           DEC     B
119b: cf           DEC     H
119c: d0           MOV     A,X
119d: df           XCH     A,H
119e: db           XCH     A,B
119f: 01 00        DB      01H,00H
11a1: 0f           ADJBS
11a2: 00           NOP
11a3: 0f           ADJBS
11a4: 00           NOP
11a5: 05 00        DB      05H,00H
11a7: 05 00        DB      05H,00H
11a9: 01 00        DB      01H,00H
11ab: 05 00        DB      05H,00H
11ad: 20 00        MOV     A,P0
11af: 20 00        MOV     A,P0
11b1: 20 00        MOV     A,P0
11b3: 20 00        MOV     A,P0
11b5: 01 00        DB      01H,00H
11b7: 08 00 38     MOV1    CY,0FE38H.0
11ba: 00           NOP
11bb: 38 00 38     MOV     0FE38H,P0
11be: 00           NOP
11bf: 68 00 00     ADD     P0,#00H
11c2: 00           NOP
11c3: 20 00        MOV     A,P0
11c5: 3f           PUSH    HL
11c6: 05 c9        DECW    SP
11c8: 05 c9        DECW    SP
11ca: 11 fc        MOVW    AX,SP
11cc: 24 68        MOVW    HL,AX
11ce: 08 a6 65 33  BF      0FE65H.6,$1205H
11d2: 14 07        BR      $11DBH
11d4: 14 2f        BR      $1205H
11d6: 3a 74 00     MOV     0FE74H,#00H
11d9: 14 2a        BR      $1205H
11db: 6f 74 02     CMP     0FE74H,#02H
11de: 81 f4        BZ      $11D4H
11e0: 6f 74 11     CMP     0FE74H,#11H
11e3: 81 ef        BZ      $11D4H
11e5: 6f 74 0b     CMP     0FE74H,#0BH
11e8: 81 ea        BZ      $11D4H
11ea: 6f 74 06     CMP     0FE74H,#06H
11ed: 81 e5        BZ      $11D4H
11ef: 6f 74 34     CMP     0FE74H,#34H
11f2: 81 e0        BZ      $11D4H
11f4: 6f 74 35     CMP     0FE74H,#35H
11f7: 81 db        BZ      $11D4H
11f9: 6f 74 0a     CMP     0FE74H,#0AH
11fc: 81 d6        BZ      $11D4H
11fe: 6f 74 19     CMP     0FE74H,#19H
1201: 81 d1        BZ      $11D4H
1203: 14 d1        BR      $11D6H
1205: 6f 74 37     CMP     0FE74H,#37H
1208: 81 05        BZ      $120FH
120a: 6f 74 39     CMP     0FE74H,#39H
120d: 80 04        BNZ     $1213H
120f: a3 67        CLR1    0FE67H.3
1211: b2 68        SET1    0FE68H.2
1213: 6f 74 37     CMP     0FE74H,#37H
1216: 81 05        BZ      $121DH
1218: 6f 74 38     CMP     0FE74H,#38H
121b: 80 2e        BNZ     $124BH
121d: 08 a2 73 23  BF      0FE73H.2,$1244H
1221: 73 73 11     BT      0FE73H.3,$1235H
1224: 1c 63        MOVW    AX,0FE63H
1226: 24 08        MOVW    AX,AX
1228: 44           INCW    AX
1229: 3c           PUSH    AX
122a: 64 02 fd     MOVW    DE,#0FD02H
122d: 3e           PUSH    DE
122e: 28 7b 2b     CALL    !2B7BH
1231: 34           POP     AX
1232: 34           POP     AX
1233: 14 0f        BR      $1244H
1235: 1c 63        MOVW    AX,0FE63H
1237: 24 08        MOVW    AX,AX
1239: 44           INCW    AX
123a: 3c           PUSH    AX
123b: 64 06 fd     MOVW    DE,#0FD06H
123e: 3e           PUSH    DE
123f: 28 7b 2b     CALL    !2B7BH
1242: 34           POP     AX
1243: 34           POP     AX
1244: 28 50 91     CALL    !9150H
1247: a2 73        CLR1    0FE73H.2
1249: b2 68        SET1    0FE68H.2
124b: 6f 74 06     CMP     0FE74H,#06H
124e: 80 03        BNZ     $1253H
1250: 3a 7d 00     MOV     0FE7DH,#00H
1253: b9 00        MOV     A,#00H
1255: 9f 88        CMP     A,0FE88H
1257: 82 03        BNC     $125CH
1259: 3a 88 01     MOV     0FE88H,#01H
125c: 08 a7 66 14  BF      0FE66H.7,$1274H
1260: 6f 74 07     CMP     0FE74H,#07H
1263: 81 0f        BZ      $1274H
1265: 6f 74 08     CMP     0FE74H,#08H
1268: 81 0a        BZ      $1274H
126a: 6f 74 05     CMP     0FE74H,#05H
126d: 81 05        BZ      $1274H
126f: a7 66        CLR1    0FE66H.7
1271: 3a 86 01     MOV     0FE86H,#01H
1274: 2c 25 1d     BR      !1D25H
1277: 2c 95 1e     BR      !1E95H
127a: 77 02 06     BT      P2.7,$1283H
127d: b2 7d        SET1    0FE7DH.2
127f: 14 42        BR      $12C3H
1281: 14 50        BR      $12D3H
1283: 08 a5 65 20  BF      0FE65H.5,$12A7H
1287: a5 65        CLR1    0FE65H.5
1289: 60 0f 00     MOVW    AX,#000FH
128c: 3c           PUSH    AX
128d: 28 6d 8b     CALL    Delay_Loop
1290: 34           POP     AX
1291: 28 ce 7a     CALL    Query_DFBE
1294: 1c 63        MOVW    AX,0FE63H
1296: 3c           PUSH    AX
1297: 60 80 df     MOVW    AX,#0DF80H
129a: 3c           PUSH    AX
129b: 28 a8 9a     CALL    !9AA8H
129e: 34           POP     AX
129f: 34           POP     AX
12a0: 28 2b 92     CALL    !922BH
12a3: 14 1b        BR      $12C0H
12a5: 14 2c        BR      $12D3H
12a7: 1c 63        MOVW    AX,0FE63H
12a9: 2f 55 fe     CMPW    AX,#0FE55H
12ac: 80 05        BNZ     $12B3H
12ae: 64 5c fe     MOVW    DE,#0FE5CH
12b1: 14 03        BR      $12B6H
12b3: 64 55 fe     MOVW    DE,#0FE55H
12b6: 24 0c        MOVW    AX,DE
12b8: 1a 63        MOVW    0FE63H,AX
12ba: 28 ec 94     CALL    !94ECH
12bd: 28 2b 92     CALL    !922BH
12c0: 28 16 20     CALL    !2016H
12c3: 72 67 0b     BT      0FE67H.2,$12D1H
12c6: 74 67 08     BT      0FE67H.4,$12D1H
12c9: 6f 7f 00     CMP     0FE7FH,#00H
12cc: 81 03        BZ      $12D1H
12ce: 3a 7f 90     MOV     0FE7FH,#90H
12d1: b0 69        SET1    0FE69H.0
12d3: 2c 95 1e     BR      !1E95H
12d6: 28 a5 25     CALL    !25A5H
12d9: 8a 08        SUBW    AX,AX
12db: 8f 0a        CMPW    AX,BC
12dd: 80 3c        BNZ     $131BH
12df: 1c 63        MOVW    AX,0FE63H
12e1: 24 48        MOVW    DE,AX
12e3: 06 00 05     MOV     A,[DE+05H]
12e6: 30 b1        SHR     A,6
12e8: ac 03        AND     A,#03H
12ea: b8 00        MOV     X,#00H
12ec: d8           XCH     A,X
12ed: 44           INCW    AX
12ee: d0           MOV     A,X
12ef: 06 a0 01     MOV     [HL+01H],A
12f2: af 02        CMP     A,#02H
12f4: 80 07        BNZ     $12FDH
12f6: 06 20 01     MOV     A,[HL+01H]
12f9: c1           INC     A
12fa: 06 a0 01     MOV     [HL+01H],A
12fd: 1c 63        MOVW    AX,0FE63H
12ff: 24 48        MOVW    DE,AX
1301: 06 20 01     MOV     A,[HL+01H]
1304: bb 00        MOV     B,#00H
1306: da           XCH     A,C
1307: 06 00 05     MOV     A,[DE+05H]
130a: 31 b2        SHL     C,6
130c: ac 3f        AND     A,#3FH
130e: 8e 12        OR      A,C
1310: 06 80 05     MOV     [DE+05H],A
1313: a5 65        CLR1    0FE65H.5
1315: b4 68        SET1    0FE68H.4
1317: b1 68        SET1    0FE68H.1
1319: 14 a8        BR      $12C3H
131b: 2c 95 1e     BR      !1E95H
131e: 1c 63        MOVW    AX,0FE63H
1320: 24 48        MOVW    DE,AX
1322: 06 00 06     MOV     A,[DE+06H]
1325: 30 b1        SHR     A,6
1327: ac 03        AND     A,#03H
1329: b8 00        MOV     X,#00H
132b: d8           XCH     A,X
132c: 2f 01 00     CMPW    AX,#0001H
132f: 80 05        BNZ     $1336H
1331: 28 d2 6b     CALL    !6BD2H
1334: 14 5c        BR      $1392H
1336: 1c 63        MOVW    AX,0FE63H
1338: 24 48        MOVW    DE,AX
133a: 06 00 05     MOV     A,[DE+05H]
133d: 30 91        SHR     A,2
133f: ac 01        AND     A,#01H
1341: b8 00        MOV     X,#00H
1343: d8           XCH     A,X
1344: 2f 00 00     CMPW    AX,#0000H
1347: 81 1a        BZ      $1363H
1349: 1c 63        MOVW    AX,0FE63H
134b: 24 48        MOVW    DE,AX
134d: 06 00 05     MOV     A,[DE+05H]
1350: 03 9a        CLR1    A.2
1352: 06 80 05     MOV     [DE+05H],A
1355: 1c 63        MOVW    AX,0FE63H
1357: 24 48        MOVW    DE,AX
1359: 06 00 05     MOV     A,[DE+05H]
135c: 03 8b        SET1    A.3
135e: 06 80 05     MOV     [DE+05H],A
1361: 14 2d        BR      $1390H
1363: 1c 63        MOVW    AX,0FE63H
1365: 24 48        MOVW    DE,AX
1367: 06 00 05     MOV     A,[DE+05H]
136a: 30 99        SHR     A,3
136c: ac 01        AND     A,#01H
136e: b8 00        MOV     X,#00H
1370: d8           XCH     A,X
1371: 2f 00 00     CMPW    AX,#0000H
1374: 81 0e        BZ      $1384H
1376: 1c 63        MOVW    AX,0FE63H
1378: 24 48        MOVW    DE,AX
137a: 06 00 05     MOV     A,[DE+05H]
137d: 03 9b        CLR1    A.3
137f: 06 80 05     MOV     [DE+05H],A
1382: 14 0c        BR      $1390H
1384: 1c 63        MOVW    AX,0FE63H
1386: 24 48        MOVW    DE,AX
1388: 06 00 05     MOV     A,[DE+05H]
138b: 03 8a        SET1    A.2
138d: 06 80 05     MOV     [DE+05H],A
1390: a5 65        CLR1    0FE65H.5
1392: 14 81        BR      $1315H
1394: 77 02 04     BT      P2.7,$139BH
1397: b1 7d        SET1    0FE7DH.1
1399: 14 50        BR      $13EBH
139b: 28 a5 25     CALL    !25A5H
139e: 8a 08        SUBW    AX,AX
13a0: 8f 0a        CMPW    AX,BC
13a2: 80 47        BNZ     $13EBH
13a4: 1c 63        MOVW    AX,0FE63H
13a6: 24 48        MOVW    DE,AX
13a8: 06 00 05     MOV     A,[DE+05H]
13ab: 30 a1        SHR     A,4
13ad: ac 03        AND     A,#03H
13af: b8 00        MOV     X,#00H
13b1: d8           XCH     A,X
13b2: 4c           DECW    AX
13b3: d0           MOV     A,X
13b4: 06 a0 01     MOV     [HL+01H],A
13b7: af 01        CMP     A,#01H
13b9: 80 0f        BNZ     $13CAH
13bb: 08 a5 73 04  BF      0FE73H.5,$13C3H
13bf: 8a 08        SUBW    AX,AX
13c1: 14 03        BR      $13C6H
13c3: 60 03 00     MOVW    AX,#0003H
13c6: d0           MOV     A,X
13c7: 06 a0 01     MOV     [HL+01H],A
13ca: 06 20 01     MOV     A,[HL+01H]
13cd: ac 03        AND     A,#03H
13cf: da           XCH     A,C
13d0: 1c 63        MOVW    AX,0FE63H
13d2: 24 48        MOVW    DE,AX
13d4: bb 00        MOV     B,#00H
13d6: 06 00 05     MOV     A,[DE+05H]
13d9: 31 a2        SHL     C,4
13db: ac cf        AND     A,#0CFH
13dd: 8e 12        OR      A,C
13df: 06 80 05     MOV     [DE+05H],A
13e2: a5 65        CLR1    0FE65H.5
13e4: 0c 80 c8 00  MOVW    0FE80H,#00C8H
13e8: 2c 15 13     BR      !1315H
13eb: 2c 95 1e     BR      !1E95H
13ee: 72 67 0e     BT      0FE67H.2,$13FFH
13f1: 74 67 0b     BT      0FE67H.4,$13FFH
13f4: 08 72 65     NOT1    0FE65H.2
13f7: 0c 80 c8 00  MOVW    0FE80H,#00C8H
13fb: b1 68        SET1    0FE68H.1
13fd: 14 09        BR      $1408H
13ff: 2c 95 1e     BR      !1E95H
1402: 08 73 65     NOT1    0FE65H.3
1405: 3a 86 05     MOV     0FE86H,#05H
1408: b2 68        SET1    0FE68H.2
140a: 2c c3 12     BR      !12C3H
140d: 08 a3 67 05  BF      0FE67H.3,$1416H
1411: 60 01 00     MOVW    AX,#0001H
1414: 14 02        BR      $1418H
1416: 8a 08        SUBW    AX,AX
1418: d0           MOV     A,X
1419: 06 a0 01     MOV     [HL+01H],A
141c: 28 40 2d     CALL    !2D40H
141f: 08 a1 72 04  BF      0FE72H.1,$1427H
1423: a1 72        CLR1    0FE72H.1
1425: 14 e1        BR      $1408H
1427: 08 a6 65 0f  BF      0FE65H.6,$143AH
142b: a6 65        CLR1    0FE65H.6
142d: 3a 82 00     MOV     0FE82H,#00H
1430: 28 b3 2c     CALL    !2CB3H
1433: b2 68        SET1    0FE68H.2
1435: 2c 17 13     BR      !1317H
1438: 14 3b        BR      $1475H
143a: 06 20 01     MOV     A,[HL+01H]
143d: af 01        CMP     A,#01H
143f: 80 16        BNZ     $1457H
1441: 6f 8c 44     CMP     0FE8CH,#44H
1444: 82 11        BNC     $1457H
1446: 09 f0 98 fd  MOV     A,!0FD98H
144a: ac 0f        AND     A,#0FH
144c: b8 00        MOV     X,#00H
144e: d8           XCH     A,X
144f: 2d 99 fd     ADDW    AX,#0FD99H
1452: 24 48        MOVW    DE,AX
1454: 20 8c        MOV     A,0FE8CH
1456: 54           MOV     [DE],A
1457: 28 d4 29     CALL    !29D4H
145a: 8a 08        SUBW    AX,AX
145c: 8f 0a        CMPW    AX,BC
145e: 80 0f        BNZ     $146FH
1460: 64 1e fd     MOVW    DE,#0FD1EH
1463: 05 e2        MOVW    AX,[DE]
1465: 1a 90        MOVW    0FE90H,AX
1467: 28 d2 6b     CALL    !6BD2H
146a: b1 68        SET1    0FE68H.1
146c: 2c c3 12     BR      !12C3H
146f: 28 b3 2c     CALL    !2CB3H
1472: 2c c0 12     BR      !12C0H
1475: 2c 95 1e     BR      !1E95H
1478: 08 a5 67 18  BF      0FE67H.5,$1494H
147c: 64 a9 fd     MOVW    DE,#0FDA9H
147f: 5c           MOV     A,[DE]
1480: c1           INC     A
1481: 54           MOV     [DE],A
1482: b8 00        MOV     X,#00H
1484: ba 07        MOV     C,#07H
1486: d8           XCH     A,X
1487: 05 1a        DIVUW   C
1489: d2           MOV     A,C
148a: 09 f1 a9 fd  MOV     !0FDA9H,A
148e: 2c 08 14     BR      !1408H
1491: 2c 22 15     BR      !1522H
1494: 08 a1 72 09  BF      0FE72H.1,$14A1H
1498: 28 5e 2d     CALL    !2D5EH
149b: 2c 08 14     BR      !1408H
149e: 2c 22 15     BR      !1522H
14a1: 08 a3 67 5a  BF      0FE67H.3,$14FFH
14a5: 6f 8c 44     CMP     0FE8CH,#44H
14a8: 83 05        BC      $14AFH
14aa: 6f 8c aa     CMP     0FE8CH,#0AAH
14ad: 80 4b        BNZ     $14FAH
14af: 09 f0 98 fd  MOV     A,!0FD98H
14b3: ac 0f        AND     A,#0FH
14b5: b8 00        MOV     X,#00H
14b7: d8           XCH     A,X
14b8: 2d 99 fd     ADDW    AX,#0FD99H
14bb: 24 48        MOVW    DE,AX
14bd: 20 8c        MOV     A,0FE8CH
14bf: 54           MOV     [DE],A
14c0: 09 f0 98 fd  MOV     A,!0FD98H
14c4: ac 0f        AND     A,#0FH
14c6: b8 00        MOV     X,#00H
14c8: d8           XCH     A,X
14c9: d0           MOV     A,X
14ca: 06 a0 01     MOV     [HL+01H],A
14cd: c1           INC     A
14ce: 06 a0 01     MOV     [HL+01H],A
14d1: b8 00        MOV     X,#00H
14d3: ba 0a        MOV     C,#0AH
14d5: d8           XCH     A,X
14d6: 05 1a        DIVUW   C
14d8: d2           MOV     A,C
14d9: 06 a0 01     MOV     [HL+01H],A
14dc: bb 00        MOV     B,#00H
14de: da           XCH     A,C
14df: 09 f0 98 fd  MOV     A,!0FD98H
14e3: ac f0        AND     A,#0F0H
14e5: 8e 12        OR      A,C
14e7: 09 f1 98 fd  MOV     !0FD98H,A
14eb: ac 0f        AND     A,#0FH
14ed: b8 00        MOV     X,#00H
14ef: d8           XCH     A,X
14f0: 2d 99 fd     ADDW    AX,#0FD99H
14f3: 24 48        MOVW    DE,AX
14f5: 5c           MOV     A,[DE]
14f6: 22 8c        MOV     0FE8CH,A
14f8: 14 03        BR      $14FDH
14fa: 2c 67 14     BR      !1467H
14fd: 14 23        BR      $1522H
14ff: 08 a2 73 05  BF      0FE73H.2,$1508H
1503: 28 6a 2c     CALL    !2C6AH
1506: 14 1a        BR      $1522H
1508: 08 a6 65 0c  BF      0FE65H.6,$1518H
150c: 09 f0 98 fd  MOV     A,!0FD98H
1510: 03 8c        SET1    A.4
1512: 09 f1 98 fd  MOV     !0FD98H,A
1516: 14 0a        BR      $1522H
1518: 28 c2 96     CALL    !96C2H
151b: 0c 80 32 00  MOVW    0FE80H,#0032H
151f: 2c c0 12     BR      !12C0H
1522: b2 68        SET1    0FE68H.2
1524: 2c 17 13     BR      !1317H
1527: 28 40 2d     CALL    !2D40H
152a: 1c 90        MOVW    AX,0FE90H
152c: 2f ab 0b     CMPW    AX,#0BABH
152f: 81 1b        BZ      $154CH
1531: 75 65 0c     BT      0FE65H.5,$1540H
1534: 60 80 df     MOVW    AX,#0DF80H
1537: 3c           PUSH    AX
1538: 1c 63        MOVW    AX,0FE63H
153a: 3c           PUSH    AX
153b: 28 3f 9a     CALL    !9A3FH
153e: 34           POP     AX
153f: 34           POP     AX
1540: b5 65        SET1    0FE65H.5
1542: 0c 80 c8 00  MOVW    0FE80H,#00C8H
1546: 28 43 7d     CALL    !7D43H
1549: 2c c0 12     BR      !12C0H
154c: 28 d2 6b     CALL    !6BD2H
154f: 2c 95 1e     BR      !1E95H
1552: 08 a5 67 18  BF      0FE67H.5,$156EH
1556: 64 a9 fd     MOVW    DE,#0FDA9H
1559: 5c           MOV     A,[DE]
155a: c9           DEC     A
155b: 54           MOV     [DE],A
155c: af 06        CMP     A,#06H
155e: 83 08        BC      $1568H
1560: 81 06        BZ      $1568H
1562: b9 06        MOV     A,#06H
1564: 09 f1 a9 fd  MOV     !0FDA9H,A
1568: 2c 08 14     BR      !1408H
156b: 2c f3 15     BR      !15F3H
156e: 08 a1 72 08  BF      0FE72H.1,$157AH
1572: 28 5e 2d     CALL    !2D5EH
1575: 2c 08 14     BR      !1408H
1578: 14 79        BR      $15F3H
157a: 08 a3 67 52  BF      0FE67H.3,$15D0H
157e: 09 f0 98 fd  MOV     A,!0FD98H
1582: ac 0f        AND     A,#0FH
1584: b8 00        MOV     X,#00H
1586: d8           XCH     A,X
1587: 2d 99 fd     ADDW    AX,#0FD99H
158a: 24 48        MOVW    DE,AX
158c: 20 8c        MOV     A,0FE8CH
158e: 54           MOV     [DE],A
158f: 09 f0 98 fd  MOV     A,!0FD98H
1593: ac 0f        AND     A,#0FH
1595: b8 00        MOV     X,#00H
1597: d8           XCH     A,X
1598: 2f 00 00     CMPW    AX,#0000H
159b: 80 0c        BNZ     $15A9H
159d: 09 f0 98 fd  MOV     A,!0FD98H
15a1: ac f0        AND     A,#0F0H
15a3: ae 0a        OR      A,#0AH
15a5: 09 f1 98 fd  MOV     !0FD98H,A
15a9: 09 f0 98 fd  MOV     A,!0FD98H
15ad: ac 0f        AND     A,#0FH
15af: b8 00        MOV     X,#00H
15b1: d8           XCH     A,X
15b2: 4c           DECW    AX
15b3: 24 28        MOVW    BC,AX
15b5: 09 f0 98 fd  MOV     A,!0FD98H
15b9: ac f0        AND     A,#0F0H
15bb: 8e 12        OR      A,C
15bd: 09 f1 98 fd  MOV     !0FD98H,A
15c1: ac 0f        AND     A,#0FH
15c3: b8 00        MOV     X,#00H
15c5: d8           XCH     A,X
15c6: 2d 99 fd     ADDW    AX,#0FD99H
15c9: 24 48        MOVW    DE,AX
15cb: 5c           MOV     A,[DE]
15cc: 22 8c        MOV     0FE8CH,A
15ce: 14 23        BR      $15F3H
15d0: 08 a2 73 05  BF      0FE73H.2,$15D9H
15d4: 28 6a 2c     CALL    !2C6AH
15d7: 14 1a        BR      $15F3H
15d9: 08 a6 65 0c  BF      0FE65H.6,$15E9H
15dd: 09 f0 98 fd  MOV     A,!0FD98H
15e1: 03 9c        CLR1    A.4
15e3: 09 f1 98 fd  MOV     !0FD98H,A
15e7: 14 0a        BR      $15F3H
15e9: 28 84 96     CALL    !9684H
15ec: 0c 80 32 00  MOVW    0FE80H,#0032H
15f0: 2c c0 12     BR      !12C0H
15f3: b2 68        SET1    0FE68H.2
15f5: 2c 17 13     BR      !1317H
15f8: 08 a5 67 42  BF      0FE67H.5,$163EH
15fc: 09 f0 ab fd  MOV     A,!0FDABH
1600: 09 f1 0f fd  MOV     !0FD0FH,A
1604: 09 f0 ac fd  MOV     A,!0FDACH
1608: 09 f1 10 fd  MOV     !0FD10H,A
160c: 09 f0 ad fd  MOV     A,!0FDADH
1610: 09 f1 11 fd  MOV     !0FD11H,A
1614: 09 f0 ae fd  MOV     A,!0FDAEH
1618: 09 f1 12 fd  MOV     !0FD12H,A
161c: 09 f0 af fd  MOV     A,!0FDAFH
1620: 09 f1 13 fd  MOV     !0FD13H,A
1624: 09 f0 b0 fd  MOV     A,!0FDB0H
1628: 09 f1 14 fd  MOV     !0FD14H,A
162c: 09 f0 b1 fd  MOV     A,!0FDB1H
1630: 09 f1 15 fd  MOV     !0FD15H,A
1634: 28 7b 7c     CALL    !7C7BH
1637: 28 40 2d     CALL    !2D40H
163a: b1 69        SET1    0FE69H.1
163c: 14 32        BR      $1670H
163e: 28 40 2d     CALL    !2D40H
1641: 08 a2 7d 23  BF      0FE7DH.2,$1668H
1645: 1c 63        MOVW    AX,0FE63H
1647: 24 48        MOVW    DE,AX
1649: 06 00 06     MOV     A,[DE+06H]
164c: 30 99        SHR     A,3
164e: ac 07        AND     A,#07H
1650: b8 00        MOV     X,#00H
1652: d8           XCH     A,X
1653: 62 b0 df     MOVW    BC,#0DFB0H
1656: 88 0a        ADDW    AX,BC
1658: 3c           PUSH    AX
1659: 09 f0 0b fd  MOV     A,!0FD0BH
165d: b8 00        MOV     X,#00H
165f: d8           XCH     A,X
1660: 3c           PUSH    AX
1661: 28 18 7b     CALL    !7B18H
1664: 34           POP     AX
1665: 34           POP     AX
1666: 14 08        BR      $1670H
1668: b7 65        SET1    0FE65H.7
166a: 3a 85 96     MOV     0FE85H,#96H
166d: 28 37 8b     CALL    !8B37H
1670: 2c 08 14     BR      !1408H
1673: 08 a2 67 2b  BF      0FE67H.2,$16A2H
1677: a2 67        CLR1    0FE67H.2
1679: 20 8d        MOV     A,0FE8DH
167b: 09 f1 2b fd  MOV     !0FD2BH,A
167f: 20 8e        MOV     A,0FE8EH
1681: 09 f1 2c fd  MOV     !0FD2CH,A
1685: 20 8f        MOV     A,0FE8FH
1687: 09 f1 2d fd  MOV     !0FD2DH,A
168b: 28 23 5c     CALL    !5C23H
168e: 3a 86 05     MOV     0FE86H,#05H
1691: 3a 88 96     MOV     0FE88H,#96H
1694: 09 f0 0d fd  MOV     A,!0FD0DH
1698: ac f0        AND     A,#0F0H
169a: ae 0f        OR      A,#0FH
169c: 09 f1 0d fd  MOV     !0FD0DH,A
16a0: 14 0e        BR      $16B0H
16a2: b9 00        MOV     A,#00H
16a4: 9f 7f        CMP     A,0FE7FH
16a6: 82 05        BNC     $16ADH
16a8: 28 37 8b     CALL    !8B37H
16ab: 14 03        BR      $16B0H
16ad: 28 3d 8b     CALL    !8B3DH
16b0: 0c 80 c8 00  MOVW    0FE80H,#00C8H
16b4: 2c 08 14     BR      !1408H
16b7: 08 a3 67 19  BF      0FE67H.3,$16D4H
16bb: 09 f0 98 fd  MOV     A,!0FD98H
16bf: ac 0f        AND     A,#0FH
16c1: b8 00        MOV     X,#00H
16c3: d8           XCH     A,X
16c4: 2d 99 fd     ADDW    AX,#0FD99H
16c7: 24 48        MOVW    DE,AX
16c9: b9 aa        MOV     A,#0AAH
16cb: 54           MOV     [DE],A
16cc: 3a 8c aa     MOV     0FE8CH,#0AAH
16cf: b2 68        SET1    0FE68H.2
16d1: 2c 17 13     BR      !1317H
16d4: 72 67 4d     BT      0FE67H.2,$1724H
16d7: 74 67 4a     BT      0FE67H.4,$1724H
16da: 08 a5 65 05  BF      0FE65H.5,$16E3H
16de: 28 d2 6b     CALL    !6BD2H
16e1: 14 41        BR      $1724H
16e3: 08 a4 72 05  BF      0FE72H.4,$16ECH
16e7: 3a 85 01     MOV     0FE85H,#01H
16ea: 14 38        BR      $1724H
16ec: 09 f0 0d fd  MOV     A,!0FD0DH
16f0: ac 0f        AND     A,#0FH
16f2: b8 00        MOV     X,#00H
16f4: d8           XCH     A,X
16f5: 2f 0f 00     CMPW    AX,#000FH
16f8: 80 0b        BNZ     $1705H
16fa: 28 8f 24     CALL    !248FH
16fd: 60 00 00     MOVW    AX,#0000H
1700: 3c           PUSH    AX
1701: 28 72 25     CALL    !2572H
1704: 34           POP     AX
1705: 09 f0 0d fd  MOV     A,!0FD0DH
1709: 30 a1        SHR     A,4
170b: ac 0f        AND     A,#0FH
170d: b8 00        MOV     X,#00H
170f: d8           XCH     A,X
1710: 44           INCW    AX
1711: 24 28        MOVW    BC,AX
1713: 09 f0 0d fd  MOV     A,!0FD0DH
1717: ac f0        AND     A,#0F0H
1719: 8e 12        OR      A,C
171b: 09 f1 0d fd  MOV     !0FD0DH,A
171f: b4 72        SET1    0FE72H.4
1721: 3a 85 96     MOV     0FE85H,#96H
1724: 2c 08 14     BR      !1408H
1727: 28 40 2d     CALL    !2D40H
172a: a5 65        CLR1    0FE65H.5
172c: b2 68        SET1    0FE68H.2
172e: 2c 17 13     BR      !1317H
1731: 08 71 65     NOT1    0FE65H.1
1734: 28 ec 94     CALL    !94ECH
1737: b2 68        SET1    0FE68H.2
1739: 2c 15 13     BR      !1315H
173c: 3a ba 04     MOV     0FEBAH,#04H
173f: 1c b2        MOVW    AX,I2C_OutputBuffer
1741: 3c           PUSH    AX
1742: 1c ba        MOVW    AX,0FEBAH
1744: 1a b2        MOVW    I2C_OutputBuffer,AX
1746: 28 3e 20     CALL    !203EH
1749: 34           POP     AX
174a: 1a b2        MOVW    I2C_OutputBuffer,AX
174c: 2c c3 12     BR      !12C3H
174f: 3a ba 03     MOV     0FEBAH,#03H
1752: 1c b2        MOVW    AX,I2C_OutputBuffer
1754: 3c           PUSH    AX
1755: 1c ba        MOVW    AX,0FEBAH
1757: 1a b2        MOVW    I2C_OutputBuffer,AX
1759: 28 3e 20     CALL    !203EH
175c: 34           POP     AX
175d: 1a b2        MOVW    I2C_OutputBuffer,AX
175f: 2c c3 12     BR      !12C3H
1762: 3a ba 01     MOV     0FEBAH,#01H
1765: 1c b2        MOVW    AX,I2C_OutputBuffer
1767: 3c           PUSH    AX
1768: 1c ba        MOVW    AX,0FEBAH
176a: 1a b2        MOVW    I2C_OutputBuffer,AX
176c: 28 3e 20     CALL    !203EH
176f: 34           POP     AX
1770: 1a b2        MOVW    I2C_OutputBuffer,AX
1772: 2c c3 12     BR      !12C3H
1775: 3a ba 02     MOV     0FEBAH,#02H
1778: 1c b2        MOVW    AX,I2C_OutputBuffer
177a: 3c           PUSH    AX
177b: 1c ba        MOVW    AX,0FEBAH
177d: 1a b2        MOVW    I2C_OutputBuffer,AX
177f: 28 3e 20     CALL    !203EH
1782: 34           POP     AX
1783: 1a b2        MOVW    I2C_OutputBuffer,AX
1785: 2c c3 12     BR      !12C3H
1788: 3a ba 00     MOV     0FEBAH,#00H
178b: 1c b2        MOVW    AX,I2C_OutputBuffer
178d: 3c           PUSH    AX
178e: 1c ba        MOVW    AX,0FEBAH
1790: 1a b2        MOVW    I2C_OutputBuffer,AX
1792: 28 3e 20     CALL    !203EH
1795: 34           POP     AX
1796: 1a b2        MOVW    I2C_OutputBuffer,AX
1798: 2c c3 12     BR      !12C3H
179b: 1c 63        MOVW    AX,0FE63H
179d: 24 48        MOVW    DE,AX
179f: 06 00 06     MOV     A,[DE+06H]
17a2: 30 99        SHR     A,3
17a4: ac 07        AND     A,#07H
17a6: b8 00        MOV     X,#00H
17a8: d8           XCH     A,X
17a9: 2f 05 00     CMPW    AX,#0005H
17ac: 81 12        BZ      $17C0H
17ae: 3a ba 05     MOV     0FEBAH,#05H
17b1: 1c b2        MOVW    AX,I2C_OutputBuffer
17b3: 3c           PUSH    AX
17b4: 1c ba        MOVW    AX,0FEBAH
17b6: 1a b2        MOVW    I2C_OutputBuffer,AX
17b8: 28 61 20     CALL    !2061H
17bb: 34           POP     AX
17bc: 1a b2        MOVW    I2C_OutputBuffer,AX
17be: 14 20        BR      $17E0H
17c0: 1c 63        MOVW    AX,0FE63H
17c2: 24 48        MOVW    DE,AX
17c4: 05 e2        MOVW    AX,[DE]
17c6: 03 02        MOV1    CY,X.2
17c8: 60 00 00     MOVW    AX,#0000H
17cb: 03 10        MOV1    X.0,CY
17cd: d8           XCH     A,X
17ce: ad 01        XOR     A,#01H
17d0: d8           XCH     A,X
17d1: 24 28        MOVW    BC,AX
17d3: 5c           MOV     A,[DE]
17d4: 30 8a        SHR     C,1
17d6: 03 1a        MOV1    A.2,CY
17d8: 54           MOV     [DE],A
17d9: 28 2b 92     CALL    !922BH
17dc: 0c 80 c8 00  MOVW    0FE80H,#00C8H
17e0: a5 65        CLR1    0FE65H.5
17e2: b1 68        SET1    0FE68H.1
17e4: 2c 15 13     BR      !1315H
17e7: 14 2e        BR      $1817H
17e9: 28 2b 92     CALL    !922BH
17ec: 3a ba 00     MOV     0FEBAH,#00H
17ef: 1c b2        MOVW    AX,I2C_OutputBuffer
17f1: 3c           PUSH    AX
17f2: 1c ba        MOVW    AX,0FEBAH
17f4: 1a b2        MOVW    I2C_OutputBuffer,AX
17f6: 28 61 20     CALL    !2061H
17f9: 34           POP     AX
17fa: 1a b2        MOVW    I2C_OutputBuffer,AX
17fc: 2c 15 13     BR      !1315H
17ff: 28 2b 92     CALL    !922BH
1802: 3a ba 01     MOV     0FEBAH,#01H
1805: 1c b2        MOVW    AX,I2C_OutputBuffer
1807: 3c           PUSH    AX
1808: 1c ba        MOVW    AX,0FEBAH
180a: 1a b2        MOVW    I2C_OutputBuffer,AX
180c: 28 61 20     CALL    !2061H
180f: 34           POP     AX
1810: 1a b2        MOVW    I2C_OutputBuffer,AX
1812: 2c 15 13     BR      !1315H
1815: 14 1d        BR      $1834H
1817: 1c 63        MOVW    AX,0FE63H
1819: 24 48        MOVW    DE,AX
181b: 06 00 06     MOV     A,[DE+06H]
181e: 30 b1        SHR     A,6
1820: ac 03        AND     A,#03H
1822: b8 00        MOV     X,#00H
1824: d8           XCH     A,X
1825: 2f 01 00     CMPW    AX,#0001H
1828: 81 d5        BZ      $17FFH
182a: 2f 02 00     CMPW    AX,#0002H
182d: 81 ba        BZ      $17E9H
182f: 2f 00 00     CMPW    AX,#0000H
1832: 81 b5        BZ      $17E9H
1834: 3a ba 03     MOV     0FEBAH,#03H
1837: 1c b2        MOVW    AX,I2C_OutputBuffer
1839: 3c           PUSH    AX
183a: 1c ba        MOVW    AX,0FEBAH
183c: 1a b2        MOVW    I2C_OutputBuffer,AX
183e: 28 61 20     CALL    !2061H
1841: 34           POP     AX
1842: 1a b2        MOVW    I2C_OutputBuffer,AX
1844: 2c 15 13     BR      !1315H
1847: 3a ba 04     MOV     0FEBAH,#04H
184a: 1c b2        MOVW    AX,I2C_OutputBuffer
184c: 3c           PUSH    AX
184d: 1c ba        MOVW    AX,0FEBAH
184f: 1a b2        MOVW    I2C_OutputBuffer,AX
1851: 28 61 20     CALL    !2061H
1854: 34           POP     AX
1855: 1a b2        MOVW    I2C_OutputBuffer,AX
1857: 1c 63        MOVW    AX,0FE63H
1859: 24 48        MOVW    DE,AX
185b: 06 00 06     MOV     A,[DE+06H]
185e: 30 b1        SHR     A,6
1860: ac 03        AND     A,#03H
1862: b8 00        MOV     X,#00H
1864: d8           XCH     A,X
1865: 2f 01 00     CMPW    AX,#0001H
1868: 81 1a        BZ      $1884H
186a: 1c 63        MOVW    AX,0FE63H
186c: 24 48        MOVW    DE,AX
186e: 06 00 05     MOV     A,[DE+05H]
1871: 03 9a        CLR1    A.2
1873: 06 80 05     MOV     [DE+05H],A
1876: 1c 63        MOVW    AX,0FE63H
1878: 24 48        MOVW    DE,AX
187a: 06 00 05     MOV     A,[DE+05H]
187d: 03 8b        SET1    A.3
187f: 06 80 05     MOV     [DE+05H],A
1882: 14 0c        BR      $1890H
1884: 1c 63        MOVW    AX,0FE63H
1886: 24 48        MOVW    DE,AX
1888: 06 00 05     MOV     A,[DE+05H]
188b: 03 9b        CLR1    A.3
188d: 06 80 05     MOV     [DE+05H],A
1890: 2c 15 13     BR      !1315H
1893: 14 2e        BR      $18C3H
1895: 28 2b 92     CALL    !922BH
1898: 3a ba 01     MOV     0FEBAH,#01H
189b: 1c b2        MOVW    AX,I2C_OutputBuffer
189d: 3c           PUSH    AX
189e: 1c ba        MOVW    AX,0FEBAH
18a0: 1a b2        MOVW    I2C_OutputBuffer,AX
18a2: 28 61 20     CALL    !2061H
18a5: 34           POP     AX
18a6: 1a b2        MOVW    I2C_OutputBuffer,AX
18a8: 2c 15 13     BR      !1315H
18ab: 28 2b 92     CALL    !922BH
18ae: 3a ba 00     MOV     0FEBAH,#00H
18b1: 1c b2        MOVW    AX,I2C_OutputBuffer
18b3: 3c           PUSH    AX
18b4: 1c ba        MOVW    AX,0FEBAH
18b6: 1a b2        MOVW    I2C_OutputBuffer,AX
18b8: 28 61 20     CALL    !2061H
18bb: 34           POP     AX
18bc: 1a b2        MOVW    I2C_OutputBuffer,AX
18be: 2c 15 13     BR      !1315H
18c1: 14 1d        BR      $18E0H
18c3: 1c 63        MOVW    AX,0FE63H
18c5: 24 48        MOVW    DE,AX
18c7: 06 00 06     MOV     A,[DE+06H]
18ca: 30 b1        SHR     A,6
18cc: ac 03        AND     A,#03H
18ce: b8 00        MOV     X,#00H
18d0: d8           XCH     A,X
18d1: 2f 01 00     CMPW    AX,#0001H
18d4: 81 d5        BZ      $18ABH
18d6: 2f 02 00     CMPW    AX,#0002H
18d9: 81 ba        BZ      $1895H
18db: 2f 00 00     CMPW    AX,#0000H
18de: 81 b5        BZ      $1895H
18e0: 3a ba 02     MOV     0FEBAH,#02H
18e3: 1c b2        MOVW    AX,I2C_OutputBuffer
18e5: 3c           PUSH    AX
18e6: 1c ba        MOVW    AX,0FEBAH
18e8: 1a b2        MOVW    I2C_OutputBuffer,AX
18ea: 28 61 20     CALL    !2061H
18ed: 34           POP     AX
18ee: 1a b2        MOVW    I2C_OutputBuffer,AX
18f0: 2c 15 13     BR      !1315H
18f3: 75 65 28     BT      0FE65H.5,$191EH
18f6: 1c 63        MOVW    AX,0FE63H
18f8: 2f 55 fe     CMPW    AX,#0FE55H
18fb: 80 10        BNZ     $190DH
18fd: 3f           PUSH    HL
18fe: 64 5c fe     MOVW    DE,#0FE5CH
1901: 66 55 fe     MOVW    HL,#0FE55H
1904: ba 07        MOV     C,#07H
1906: 59           MOV     A,[HL+]
1907: 50           MOV     [DE+],A
1908: 32 fc        DBNZ    C,$1906H
190a: 37           POP     HL
190b: 14 0e        BR      $191BH
190d: 3f           PUSH    HL
190e: 64 55 fe     MOVW    DE,#0FE55H
1911: 66 5c fe     MOVW    HL,#0FE5CH
1914: ba 07        MOV     C,#07H
1916: 59           MOV     A,[HL+]
1917: 50           MOV     [DE+],A
1918: 32 fc        DBNZ    C,$1916H
191a: 37           POP     HL
191b: 2c c3 12     BR      !12C3H
191e: 2c 95 1e     BR      !1E95H
1921: 14 41        BR      $1964H
1923: b9 02        MOV     A,#02H
1925: 06 a0 01     MOV     [HL+01H],A
1928: 28 2b 92     CALL    !922BH
192b: 14 54        BR      $1981H
192d: 64 d7 ff     MOVW    DE,#0FFD7H
1930: 5c           MOV     A,[DE]
1931: ac 80        AND     A,#80H
1933: 80 07        BNZ     $193CH
1935: b9 00        MOV     A,#00H
1937: 06 a0 01     MOV     [HL+01H],A
193a: 14 17        BR      $1953H
193c: b9 01        MOV     A,#01H
193e: 06 a0 01     MOV     [HL+01H],A
1941: 28 2b 92     CALL    !922BH
1944: 28 9b 9b     CALL    !9B9BH
1947: 1c 63        MOVW    AX,0FE63H
1949: 24 48        MOVW    DE,AX
194b: 06 00 05     MOV     A,[DE+05H]
194e: 03 9b        CLR1    A.3
1950: 06 80 05     MOV     [DE+05H],A
1953: 14 2c        BR      $1981H
1955: 28 4e 9b     CALL    !9B4EH
1958: 28 2b 92     CALL    !922BH
195b: b9 00        MOV     A,#00H
195d: 06 a0 01     MOV     [HL+01H],A
1960: 14 1f        BR      $1981H
1962: 14 1d        BR      $1981H
1964: 1c 63        MOVW    AX,0FE63H
1966: 24 48        MOVW    DE,AX
1968: 06 00 06     MOV     A,[DE+06H]
196b: 30 b1        SHR     A,6
196d: ac 03        AND     A,#03H
196f: b8 00        MOV     X,#00H
1971: d8           XCH     A,X
1972: 2f 01 00     CMPW    AX,#0001H
1975: 81 de        BZ      $1955H
1977: 2f 02 00     CMPW    AX,#0002H
197a: 81 b1        BZ      $192DH
197c: 2f 00 00     CMPW    AX,#0000H
197f: 81 a2        BZ      $1923H
1981: 1c 63        MOVW    AX,0FE63H
1983: 24 48        MOVW    DE,AX
1985: 06 20 01     MOV     A,[HL+01H]
1988: bb 00        MOV     B,#00H
198a: da           XCH     A,C
198b: 06 00 06     MOV     A,[DE+06H]
198e: 31 b2        SHL     C,6
1990: ac 3f        AND     A,#3FH
1992: 8e 12        OR      A,C
1994: 06 80 06     MOV     [DE+06H],A
1997: a5 65        CLR1    0FE65H.5
1999: 2c c0 12     BR      !12C0H
199c: 08 a4 67 29  BF      0FE67H.4,$19C9H
19a0: 28 42 26     CALL    !2642H
19a3: 08 a3 a1 15  BF      0FEA1H.3,$19BCH
19a7: 08 a2 a1 0b  BF      0FEA1H.2,$19B6H
19ab: a4 67        CLR1    0FE67H.4
19ad: 08 a3 65 03  BF      0FE65H.3,$19B4H
19b1: 3a 86 05     MOV     0FE86H,#05H
19b4: 14 04        BR      $19BAH
19b6: b2 a1        SET1    0FEA1H.2
19b8: a3 a1        CLR1    0FEA1H.3
19ba: 14 02        BR      $19BEH
19bc: b3 a1        SET1    0FEA1H.3
19be: 08 a4 67 03  BF      0FE67H.4,$19C5H
19c2: 28 c4 25     CALL    !25C4H
19c5: b1 68        SET1    0FE68H.1
19c7: 14 09        BR      $19D2H
19c9: 28 40 2d     CALL    !2D40H
19cc: 0c 80 c8 00  MOVW    0FE80H,#00C8H
19d0: b7 66        SET1    0FE66H.7
19d2: 2c 08 14     BR      !1408H
19d5: 28 a5 25     CALL    !25A5H
19d8: 8a 08        SUBW    AX,AX
19da: 8f 0a        CMPW    AX,BC
19dc: 80 27        BNZ     $1A05H
19de: a5 65        CLR1    0FE65H.5
19e0: 1c 63        MOVW    AX,0FE63H
19e2: 24 48        MOVW    DE,AX
19e4: 06 00 05     MOV     A,[DE+05H]
19e7: d8           XCH     A,X
19e8: 06 00 06     MOV     A,[DE+06H]
19eb: 03 01        MOV1    CY,X.1
19ed: 60 00 00     MOVW    AX,#0000H
19f0: 03 10        MOV1    X.0,CY
19f2: d8           XCH     A,X
19f3: ad 01        XOR     A,#01H
19f5: d8           XCH     A,X
19f6: 24 28        MOVW    BC,AX
19f8: 06 00 05     MOV     A,[DE+05H]
19fb: 30 8a        SHR     C,1
19fd: 03 19        MOV1    A.1,CY
19ff: 06 80 05     MOV     [DE+05H],A
1a02: 2c 15 13     BR      !1315H
1a05: 2c 95 1e     BR      !1E95H
1a08: 28 d3 26     CALL    !26D3H
1a0b: 2c 08 14     BR      !1408H
1a0e: 08 a5 65 25  BF      0FE65H.5,$1A37H
1a12: 09 f0 90 fe  MOV     A,!0FE90H
1a16: d8           XCH     A,X
1a17: 09 f0 91 fe  MOV     A,!0FE91H
1a1b: 3c           PUSH    AX
1a1c: 28 e8 7d     CALL    !7DE8H
1a1f: 34           POP     AX
1a20: 1c 6a        MOVW    AX,0FE6AH
1a22: 3c           PUSH    AX
1a23: 1c 63        MOVW    AX,0FE63H
1a25: 24 48        MOVW    DE,AX
1a27: b9 02        MOV     A,#02H
1a29: 16 4d        XOR     A,[DE]
1a2b: 54           MOV     [DE],A
1a2c: b8 00        MOV     X,#00H
1a2e: d8           XCH     A,X
1a2f: 3c           PUSH    AX
1a30: 28 18 7b     CALL    !7B18H
1a33: 34           POP     AX
1a34: 34           POP     AX
1a35: b1 69        SET1    0FE69H.1
1a37: 2c 17 13     BR      !1317H
1a3a: 09 f0 97 fd  MOV     A,!0FD97H
1a3e: ac f0        AND     A,#0F0H
1a40: ae 02        OR      A,#02H
1a42: 09 f1 97 fd  MOV     !0FD97H,A
1a46: 2c 17 13     BR      !1317H
1a49: 20 67        MOV     A,0FE67H
1a4b: ac 37        AND     A,#37H
1a4d: 80 4d        BNZ     $1A9CH
1a4f: 73 67 2d     BT      0FE67H.3,$1A7FH
1a52: 09 f0 97 fd  MOV     A,!0FD97H
1a56: ac f0        AND     A,#0F0H
1a58: ae 04        OR      A,#04H
1a5a: 09 f1 97 fd  MOV     !0FD97H,A
1a5e: b3 67        SET1    0FE67H.3
1a60: 3a 7f 00     MOV     0FE7FH,#00H
1a63: 3a 85 00     MOV     0FE85H,#00H
1a66: 09 f0 98 fd  MOV     A,!0FD98H
1a6a: ac 0f        AND     A,#0FH
1a6c: b8 00        MOV     X,#00H
1a6e: d8           XCH     A,X
1a6f: 2d 99 fd     ADDW    AX,#0FD99H
1a72: 24 48        MOVW    DE,AX
1a74: 5c           MOV     A,[DE]
1a75: 22 8c        MOV     0FE8CH,A
1a77: b9 08        MOV     A,#08H
1a79: 09 f1 0a fd  MOV     !0FD0AH,A
1a7d: 14 18        BR      $1A97H
1a7f: 6f 8c 44     CMP     0FE8CH,#44H
1a82: 82 11        BNC     $1A95H
1a84: 09 f0 98 fd  MOV     A,!0FD98H
1a88: ac 0f        AND     A,#0FH
1a8a: b8 00        MOV     X,#00H
1a8c: d8           XCH     A,X
1a8d: 2d 99 fd     ADDW    AX,#0FD99H
1a90: 24 48        MOVW    DE,AX
1a92: 20 8c        MOV     A,0FE8CH
1a94: 54           MOV     [DE],A
1a95: a3 67        CLR1    0FE67H.3
1a97: b2 68        SET1    0FE68H.2
1a99: 2c 17 13     BR      !1317H
1a9c: 2c 95 1e     BR      !1E95H
1a9f: 20 67        MOV     A,0FE67H
1aa1: ac 3f        AND     A,#3FH
1aa3: 80 62        BNZ     $1B07H
1aa5: 72 73 32     BT      0FE73H.2,$1ADAH
1aa8: 09 f0 97 fd  MOV     A,!0FD97H
1aac: ac f0        AND     A,#0F0H
1aae: ae 08        OR      A,#08H
1ab0: 09 f1 97 fd  MOV     !0FD97H,A
1ab4: b2 73        SET1    0FE73H.2
1ab6: a3 73        CLR1    0FE73H.3
1ab8: 64 02 fd     MOVW    DE,#0FD02H
1abb: 3e           PUSH    DE
1abc: 1c 63        MOVW    AX,0FE63H
1abe: 24 08        MOVW    AX,AX
1ac0: 44           INCW    AX
1ac1: 3c           PUSH    AX
1ac2: 28 7b 2b     CALL    !2B7BH
1ac5: 34           POP     AX
1ac6: 34           POP     AX
1ac7: 28 50 91     CALL    !9150H
1aca: 3a 85 00     MOV     0FE85H,#00H
1acd: 3a 7f 00     MOV     0FE7FH,#00H
1ad0: b9 09        MOV     A,#09H
1ad2: 09 f1 0a fd  MOV     !0FD0AH,A
1ad6: b2 68        SET1    0FE68H.2
1ad8: 14 28        BR      $1B02H
1ada: 73 73 11     BT      0FE73H.3,$1AEEH
1add: 1c 63        MOVW    AX,0FE63H
1adf: 24 08        MOVW    AX,AX
1ae1: 44           INCW    AX
1ae2: 3c           PUSH    AX
1ae3: 64 02 fd     MOVW    DE,#0FD02H
1ae6: 3e           PUSH    DE
1ae7: 28 7b 2b     CALL    !2B7BH
1aea: 34           POP     AX
1aeb: 34           POP     AX
1aec: 14 0f        BR      $1AFDH
1aee: 1c 63        MOVW    AX,0FE63H
1af0: 24 08        MOVW    AX,AX
1af2: 44           INCW    AX
1af3: 3c           PUSH    AX
1af4: 64 06 fd     MOVW    DE,#0FD06H
1af7: 3e           PUSH    DE
1af8: 28 7b 2b     CALL    !2B7BH
1afb: 34           POP     AX
1afc: 34           POP     AX
1afd: 28 50 91     CALL    !9150H
1b00: a2 73        CLR1    0FE73H.2
1b02: b2 68        SET1    0FE68H.2
1b04: 2c 17 13     BR      !1317H
1b07: 2c 95 1e     BR      !1E95H
1b0a: 09 f0 97 fd  MOV     A,!0FD97H
1b0e: ac 0f        AND     A,#0FH
1b10: ae 20        OR      A,#20H
1b12: 09 f1 97 fd  MOV     !0FD97H,A
1b16: 2c 17 13     BR      !1317H
1b19: 09 f0 97 fd  MOV     A,!0FD97H
1b1d: ac 0f        AND     A,#0FH
1b1f: ae 40        OR      A,#40H
1b21: 09 f1 97 fd  MOV     !0FD97H,A
1b25: 2c 17 13     BR      !1317H
1b28: 09 f0 97 fd  MOV     A,!0FD97H
1b2c: ac 0f        AND     A,#0FH
1b2e: ae 80        OR      A,#80H
1b30: 09 f1 97 fd  MOV     !0FD97H,A
1b34: 2c 17 13     BR      !1317H
1b37: 28 40 2d     CALL    !2D40H
1b3a: 73 65 05     BT      0FE65H.3,$1B42H
1b3d: 6f 88 00     CMP     0FE88H,#00H
1b40: 81 03        BZ      $1B45H
1b42: 08 70 a1     NOT1    0FEA1H.0
1b45: 0c 80 c8 00  MOVW    0FE80H,#00C8H
1b49: 3a 88 96     MOV     0FE88H,#96H
1b4c: 3a 86 05     MOV     0FE86H,#05H
1b4f: 2c 08 14     BR      !1408H
1b52: 14 0f        BR      $1B63H
1b54: 6e 66 04     OR      0FE66H,#04H
1b57: 14 18        BR      $1B71H
1b59: 6e 66 08     OR      0FE66H,#08H
1b5c: 14 13        BR      $1B71H
1b5e: 6c 66 f3     AND     0FE66H,#0F3H
1b61: 14 0e        BR      $1B71H
1b63: 20 66        MOV     A,0FE66H
1b65: ac 0c        AND     A,#0CH
1b67: af 04        CMP     A,#04H
1b69: 81 ee        BZ      $1B59H
1b6b: af 00        CMP     A,#00H
1b6d: 81 e5        BZ      $1B54H
1b6f: 14 ed        BR      $1B5EH
1b71: 2c 15 13     BR      !1315H
1b74: 08 75 66     NOT1    0FE66H.5
1b77: 2c 15 13     BR      !1315H
1b7a: 08 a5 65 21  BF      0FE65H.5,$1B9FH
1b7e: 28 5d 7f     CALL    !7F5DH
1b81: 28 17 7e     CALL    !7E17H
1b84: 64 1e fd     MOVW    DE,#0FD1EH
1b87: 05 e2        MOVW    AX,[DE]
1b89: 1f 90        CMPW    AX,0FE90H
1b8b: 80 08        BNZ     $1B95H
1b8d: 0c 90 ab 0b  MOVW    0FE90H,#0BABH
1b91: a5 65        CLR1    0FE65H.5
1b93: 14 03        BR      $1B98H
1b95: 28 43 7d     CALL    !7D43H
1b98: b1 69        SET1    0FE69H.1
1b9a: 2c c0 12     BR      !12C0H
1b9d: 14 03        BR      $1BA2H
1b9f: 28 d2 6b     CALL    !6BD2H
1ba2: 2c 95 1e     BR      !1E95H
1ba5: 08 a3 67 69  BF      0FE67H.3,$1C12H
1ba9: b9 00        MOV     A,#00H
1bab: 06 a0 01     MOV     [HL+01H],A
1bae: 3a 6a 00     MOV     0FE6AH,#00H
1bb1: 6f 6a 0a     CMP     0FE6AH,#0AH
1bb4: 82 15        BNC     $1BCBH
1bb6: 20 6a        MOV     A,0FE6AH
1bb8: b8 00        MOV     X,#00H
1bba: d8           XCH     A,X
1bbb: 2d 99 fd     ADDW    AX,#0FD99H
1bbe: 24 48        MOVW    DE,AX
1bc0: 5c           MOV     A,[DE]
1bc1: 06 28 01     ADD     A,[HL+01H]
1bc4: 06 a0 01     MOV     [HL+01H],A
1bc7: 26 6a        INC     0FE6AH
1bc9: 14 e6        BR      $1BB1H
1bcb: 06 20 01     MOV     A,[HL+01H]
1bce: af a4        CMP     A,#0A4H
1bd0: 80 09        BNZ     $1BDBH
1bd2: 6f 8c aa     CMP     0FE8CH,#0AAH
1bd5: 80 04        BNZ     $1BDBH
1bd7: a3 67        CLR1    0FE67H.3
1bd9: 14 23        BR      $1BFEH
1bdb: 64 98 fd     MOVW    DE,#0FD98H
1bde: 5c           MOV     A,[DE]
1bdf: ac f0        AND     A,#0F0H
1be1: 54           MOV     [DE],A
1be2: 3a 6a 00     MOV     0FE6AH,#00H
1be5: 6f 6a 0a     CMP     0FE6AH,#0AH
1be8: 82 11        BNC     $1BFBH
1bea: 20 6a        MOV     A,0FE6AH
1bec: b8 00        MOV     X,#00H
1bee: d8           XCH     A,X
1bef: 2d 99 fd     ADDW    AX,#0FD99H
1bf2: 24 48        MOVW    DE,AX
1bf4: b9 aa        MOV     A,#0AAH
1bf6: 54           MOV     [DE],A
1bf7: 26 6a        INC     0FE6AH
1bf9: 14 ea        BR      $1BE5H
1bfb: 3a 8c aa     MOV     0FE8CH,#0AAH
1bfe: 09 f0 0d fd  MOV     A,!0FD0DH
1c02: ac f0        AND     A,#0F0H
1c04: ae 0f        OR      A,#0FH
1c06: 09 f1 0d fd  MOV     !0FD0DH,A
1c0a: 3a 85 00     MOV     0FE85H,#00H
1c0d: b2 68        SET1    0FE68H.2
1c0f: 2c 17 13     BR      !1317H
1c12: 08 a1 67 04  BF      0FE67H.1,$1C1AH
1c16: a1 67        CLR1    0FE67H.1
1c18: 14 e4        BR      $1BFEH
1c1a: 70 67 04     BT      0FE67H.0,$1C21H
1c1d: 08 a7 65 0d  BF      0FE65H.7,$1C2EH
1c21: a7 65        CLR1    0FE65H.7
1c23: a0 67        CLR1    0FE67H.0
1c25: 64 1e fd     MOVW    DE,#0FD1EH
1c28: 05 e2        MOVW    AX,[DE]
1c2a: 1a 90        MOVW    0FE90H,AX
1c2c: 14 d0        BR      $1BFEH
1c2e: 08 a4 67 25  BF      0FE67H.4,$1C57H
1c32: 6f 8e aa     CMP     0FE8EH,#0AAH
1c35: 81 14        BZ      $1C4BH
1c37: 3a 8f aa     MOV     0FE8FH,#0AAH
1c3a: 3a 8e aa     MOV     0FE8EH,#0AAH
1c3d: 09 f0 0d fd  MOV     A,!0FD0DH
1c41: ac f0        AND     A,#0F0H
1c43: ae 0f        OR      A,#0FH
1c45: 09 f1 0d fd  MOV     !0FD0DH,A
1c49: 14 0a        BR      $1C55H
1c4b: 28 40 2d     CALL    !2D40H
1c4e: 08 a3 65 03  BF      0FE65H.3,$1C55H
1c52: 3a 86 01     MOV     0FE86H,#01H
1c55: 14 a7        BR      $1BFEH
1c57: 08 a5 67 5e  BF      0FE67H.5,$1CB9H
1c5b: 09 f0 ab fd  MOV     A,!0FDABH
1c5f: d8           XCH     A,X
1c60: 09 f0 ac fd  MOV     A,!0FDACH
1c64: 8c 10        AND     A,X
1c66: d8           XCH     A,X
1c67: 09 f0 ad fd  MOV     A,!0FDADH
1c6b: 8c 10        AND     A,X
1c6d: d8           XCH     A,X
1c6e: 09 f0 ae fd  MOV     A,!0FDAEH
1c72: 8c 10        AND     A,X
1c74: d8           XCH     A,X
1c75: 09 f0 af fd  MOV     A,!0FDAFH
1c79: 8c 10        AND     A,X
1c7b: d8           XCH     A,X
1c7c: 09 f0 b0 fd  MOV     A,!0FDB0H
1c80: 8c 10        AND     A,X
1c82: d8           XCH     A,X
1c83: 09 f0 b1 fd  MOV     A,!0FDB1H
1c87: 8c 01        AND     X,A
1c89: d0           MOV     A,X
1c8a: af ff        CMP     A,#0FFH
1c8c: 81 26        BZ      $1CB4H
1c8e: b9 ff        MOV     A,#0FFH
1c90: 09 f1 b1 fd  MOV     !0FDB1H,A
1c94: 09 f1 b0 fd  MOV     !0FDB0H,A
1c98: 09 f1 af fd  MOV     !0FDAFH,A
1c9c: 09 f1 ae fd  MOV     !0FDAEH,A
1ca0: 09 f1 ad fd  MOV     !0FDADH,A
1ca4: 09 f1 ac fd  MOV     !0FDACH,A
1ca8: 09 f1 ab fd  MOV     !0FDABH,A
1cac: b9 00        MOV     A,#00H
1cae: 09 f1 a9 fd  MOV     !0FDA9H,A
1cb2: 14 02        BR      $1CB6H
1cb4: a5 67        CLR1    0FE67H.5
1cb6: 2c fe 1b     BR      !1BFEH
1cb9: 08 a7 66 15  BF      0FE66H.7,$1CD2H
1cbd: 77 a1 04     BT      0FEA1H.7,$1CC4H
1cc0: 08 a6 a1 09  BF      0FEA1H.6,$1CCDH
1cc4: a6 a1        CLR1    0FEA1H.6
1cc6: a7 a1        CLR1    0FEA1H.7
1cc8: 28 ae 67     CALL    !67AEH
1ccb: 14 02        BR      $1CCFH
1ccd: a7 66        CLR1    0FE66H.7
1ccf: 2c fe 1b     BR      !1BFEH
1cd2: 08 a2 73 00  BF      0FE73H.2,$1CD6H
1cd6: 2c 95 1e     BR      !1E95H
1cd9: 1c 63        MOVW    AX,0FE63H
1cdb: 24 48        MOVW    DE,AX
1cdd: 06 00 06     MOV     A,[DE+06H]
1ce0: 30 b1        SHR     A,6
1ce2: ac 03        AND     A,#03H
1ce4: b8 00        MOV     X,#00H
1ce6: d8           XCH     A,X
1ce7: 2f 01 00     CMPW    AX,#0001H
1cea: 80 05        BNZ     $1CF1H
1cec: 28 d2 6b     CALL    !6BD2H
1cef: 14 1f        BR      $1D10H
1cf1: 1c 63        MOVW    AX,0FE63H
1cf3: 24 48        MOVW    DE,AX
1cf5: 05 e2        MOVW    AX,[DE]
1cf7: 03 04        MOV1    CY,X.4
1cf9: 60 00 00     MOVW    AX,#0000H
1cfc: 03 10        MOV1    X.0,CY
1cfe: d8           XCH     A,X
1cff: ad 01        XOR     A,#01H
1d01: d8           XCH     A,X
1d02: 24 28        MOVW    BC,AX
1d04: 5c           MOV     A,[DE]
1d05: 30 8a        SHR     C,1
1d07: 03 1c        MOV1    A.4,CY
1d09: 54           MOV     [DE],A
1d0a: 3a 7f 00     MOV     0FE7FH,#00H
1d0d: 2c 08 14     BR      !1408H
1d10: 2c 95 1e     BR      !1E95H
1d13: 28 98 1e     CALL    Send_Table_2a   ; !1E98H
1d16: 8a 08        SUBW    AX,AX
1d18: 8f 0a        CMPW    AX,BC
1d1a: 81 06        BZ      $1D22H
1d1c: 28 22 21     CALL    !2122H
1d1f: 2c 08 14     BR      !1408H
1d22: 2c 95 1e     BR      !1E95H
1d25: 6f 74 4c     CMP     0FE74H,#4CH
1d28: 81 af        BZ      $1CD9H
1d2a: 6f 74 4b     CMP     0FE74H,#4BH
1d2d: 80 03        BNZ     $1D32H
1d2f: 2c a5 1b     BR      !1BA5H
1d32: 6f 74 4a     CMP     0FE74H,#4AH
1d35: 80 03        BNZ     $1D3AH
1d37: 2c 7a 1b     BR      !1B7AH
1d3a: 6f 74 45     CMP     0FE74H,#45H
1d3d: 80 03        BNZ     $1D42H
1d3f: 2c 74 1b     BR      !1B74H
1d42: 6f 74 44     CMP     0FE74H,#44H
1d45: 80 03        BNZ     $1D4AH
1d47: 2c 52 1b     BR      !1B52H
1d4a: 6f 74 43     CMP     0FE74H,#43H
1d4d: 80 03        BNZ     $1D52H
1d4f: 2c 37 1b     BR      !1B37H
1d52: 6f 74 3f     CMP     0FE74H,#3FH
1d55: 80 03        BNZ     $1D5AH
1d57: 2c 28 1b     BR      !1B28H
1d5a: 6f 74 3e     CMP     0FE74H,#3EH
1d5d: 80 03        BNZ     $1D62H
1d5f: 2c 19 1b     BR      !1B19H
1d62: 6f 74 3d     CMP     0FE74H,#3DH
1d65: 80 03        BNZ     $1D6AH
1d67: 2c 0a 1b     BR      !1B0AH
1d6a: 6f 74 39     CMP     0FE74H,#39H
1d6d: 80 03        BNZ     $1D72H
1d6f: 2c 9f 1a     BR      !1A9FH
1d72: 6f 74 38     CMP     0FE74H,#38H
1d75: 80 03        BNZ     $1D7AH
1d77: 2c 49 1a     BR      !1A49H
1d7a: 6f 74 37     CMP     0FE74H,#37H
1d7d: 80 03        BNZ     $1D82H
1d7f: 2c 3a 1a     BR      !1A3AH
1d82: 6f 74 36     CMP     0FE74H,#36H
1d85: 80 03        BNZ     $1D8AH
1d87: 2c 0e 1a     BR      !1A0EH
1d8a: 6f 74 35     CMP     0FE74H,#35H
1d8d: 80 03        BNZ     $1D92H
1d8f: 2c 08 1a     BR      !1A08H
1d92: 6f 74 33     CMP     0FE74H,#33H
1d95: 80 03        BNZ     $1D9AH
1d97: 2c d5 19     BR      !19D5H
1d9a: 6f 74 05     CMP     0FE74H,#05H
1d9d: 80 03        BNZ     $1DA2H
1d9f: 2c 9c 19     BR      !199CH
1da2: 6f 74 32     CMP     0FE74H,#32H
1da5: 80 03        BNZ     $1DAAH
1da7: 2c 21 19     BR      !1921H
1daa: 6f 74 31     CMP     0FE74H,#31H
1dad: 80 03        BNZ     $1DB2H
1daf: 2c f3 18     BR      !18F3H
1db2: 6f 74 27     CMP     0FE74H,#27H
1db5: 80 03        BNZ     $1DBAH
1db7: 2c e0 18     BR      !18E0H
1dba: 6f 74 26     CMP     0FE74H,#26H
1dbd: 80 03        BNZ     $1DC2H
1dbf: 2c 93 18     BR      !1893H
1dc2: 6f 74 25     CMP     0FE74H,#25H
1dc5: 80 03        BNZ     $1DCAH
1dc7: 2c 47 18     BR      !1847H
1dca: 6f 74 21     CMP     0FE74H,#21H
1dcd: 80 03        BNZ     $1DD2H
1dcf: 2c 34 18     BR      !1834H
1dd2: 6f 74 20     CMP     0FE74H,#20H
1dd5: 80 03        BNZ     $1DDAH
1dd7: 2c e7 17     BR      !17E7H
1dda: 6f 74 1f     CMP     0FE74H,#1FH
1ddd: 80 03        BNZ     $1DE2H
1ddf: 2c 9b 17     BR      !179BH
1de2: 6f 74 28     CMP     0FE74H,#28H
1de5: 80 03        BNZ     $1DEAH
1de7: 2c 88 17     BR      !1788H
1dea: 6f 74 29     CMP     0FE74H,#29H
1ded: 80 03        BNZ     $1DF2H
1def: 2c 75 17     BR      !1775H
1df2: 6f 74 23     CMP     0FE74H,#23H
1df5: 80 03        BNZ     $1DFAH
1df7: 2c 62 17     BR      !1762H
1dfa: 6f 74 24     CMP     0FE74H,#24H
1dfd: 80 03        BNZ     $1E02H
1dff: 2c 4f 17     BR      !174FH
1e02: 6f 74 2a     CMP     0FE74H,#2AH
1e05: 80 03        BNZ     $1E0AH
1e07: 2c 3c 17     BR      !173CH
1e0a: 6f 74 22     CMP     0FE74H,#22H
1e0d: 80 03        BNZ     $1E12H
1e0f: 2c 31 17     BR      !1731H
1e12: 6f 74 1c     CMP     0FE74H,#1CH
1e15: 80 03        BNZ     $1E1AH
1e17: 2c 27 17     BR      !1727H
1e1a: 6f 74 1b     CMP     0FE74H,#1BH
1e1d: 80 03        BNZ     $1E22H
1e1f: 2c b7 16     BR      !16B7H
1e22: 6f 74 19     CMP     0FE74H,#19H
1e25: 80 03        BNZ     $1E2AH
1e27: 2c 73 16     BR      !1673H
1e2a: 6f 74 16     CMP     0FE74H,#16H
1e2d: 80 03        BNZ     $1E32H
1e2f: 2c f8 15     BR      !15F8H
1e32: 6f 74 11     CMP     0FE74H,#11H
1e35: 80 03        BNZ     $1E3AH
1e37: 2c 52 15     BR      !1552H
1e3a: 6f 74 10     CMP     0FE74H,#10H
1e3d: 80 03        BNZ     $1E42H
1e3f: 2c 27 15     BR      !1527H
1e42: 6f 74 0b     CMP     0FE74H,#0BH
1e45: 80 03        BNZ     $1E4AH
1e47: 2c 78 14     BR      !1478H
1e4a: 6f 74 0a     CMP     0FE74H,#0AH
1e4d: 80 03        BNZ     $1E52H
1e4f: 2c 0d 14     BR      !140DH
1e52: 6f 74 06     CMP     0FE74H,#06H
1e55: 80 03        BNZ     $1E5AH
1e57: 2c 02 14     BR      !1402H
1e5a: 6f 74 34     CMP     0FE74H,#34H
1e5d: 80 03        BNZ     $1E62H
1e5f: 2c ee 13     BR      !13EEH
1e62: 6f 74 03     CMP     0FE74H,#03H
1e65: 80 03        BNZ     $1E6AH
1e67: 2c 94 13     BR      !1394H
1e6a: 6f 74 02     CMP     0FE74H,#02H
1e6d: 80 03        BNZ     $1E72H
1e6f: 2c 1e 13     BR      !131EH
1e72: 6f 74 04     CMP     0FE74H,#04H
1e75: 80 03        BNZ     $1E7AH
1e77: 2c d6 12     BR      !12D6H
1e7a: 6f 74 01     CMP     0FE74H,#01H
1e7d: 80 03        BNZ     $1E82H
1e7f: 2c 7a 12     BR      !127AH
1e82: 6f 74 ff     CMP     0FE74H,#0FFH
1e85: 80 03        BNZ     $1E8AH
1e87: 2c 77 12     BR      !1277H
1e8a: 6f 74 00     CMP     0FE74H,#00H
1e8d: 80 03        BNZ     $1E92H
1e8f: 2c 77 12     BR      !1277H
1e92: 2c 13 1d     BR      !1D13H
1e95: 34           POP     AX
1e96: 37           POP     HL
1e97: 56           RET
Send_Table2a:
1e98: 14 0c        BR      Send_Table2    ; $1EA6H
Send1:
1e9a: 62 01 00     MOVW    BC,#0001H
1e9d: 14 4b        BR      Send_Done
Send0:
1e9f: 62 00 00     MOVW    BC,#0000H
1ea2: 14 46        BR      Send_Done
1ea4: 14 44        BR      Send_Done
Send_Table2:
1ea6: 20 74        MOV     A,0FE74H
1ea8: af 07        CMP     A,#07H
1eaa: 83 f3        BC      $1E9FH
1eac: b8 1a        MOV     X,#1AH
1eae: 8f 01        CMP     X,A
1eb0: 83 ed        BC      $1E9FH
1eb2: aa 07        SUB     A,#07H
1eb4: d8           XCH     A,X
1eb5: b9 00        MOV     A,#00H
1eb7: 88 08        ADDW    AX,AX
1eb9: 2d c2 1e     ADDW    AX,@Table2
1ebc: 24 48        MOVW    DE,AX
1ebe: 05 e2        MOVW    AX,[DE]
1ec0: 05 48        BR      AX
Table2:
      DW           Send1,Send1,Send1,Send0,Send0,Send0
	  DW           Send1,Send1,Send1,Send0,Send0,Send0
	  DW           Send1,Send1,Send1,Send0,Send0,Send0,Send1
1eea: 56           RET
1eeb: 2c b2 1f     BR      !1FB2H
1eee: 08 a5 65 07  BF      0FE65H.5,$1EF9H
1ef2: 28 17 7e     CALL    !7E17H
1ef5: 14 0e        BR      $1F05H
1ef7: 14 05        BR      $1EFEH
1ef9: 28 c2 96     CALL    !96C2H
1efc: 14 13        BR      $1F11H
1efe: 08 a5 65 0c  BF      0FE65H.5,$1F0EH
1f02: 28 54 7e     CALL    !7E54H
1f05: 28 43 7d     CALL    !7D43H
1f08: 0c 80 19 00  MOVW    0FE80H,#0019H
1f0c: 14 07        BR      $1F15H
1f0e: 28 84 96     CALL    !9684H
1f11: 0c 80 0a 00  MOVW    0FE80H,#000AH
1f15: 28 16 20     CALL    !2016H
1f18: 2c 15 20     BR      !2015H
1f1b: 08 a6 67 03  BF      0FE67H.6,$1F22H
1f1f: 28 9b 7e     CALL    !7E9BH
1f22: a6 67        CLR1    0FE67H.6
1f24: 2c 15 20     BR      !2015H
1f27: 28 40 2d     CALL    !2D40H
1f2a: 08 a5 65 05  BF      0FE65H.5,$1F33H
1f2e: 28 71 2d     CALL    !2D71H
1f31: 14 03        BR      $1F36H
1f33: 28 d2 6b     CALL    !6BD2H
1f36: 2c 15 20     BR      !2015H
1f39: 08 73 72     NOT1    0FE72H.3
1f3c: b1 69        SET1    0FE69H.1
1f3e: b1 68        SET1    0FE68H.1
1f40: 2c 15 20     BR      !2015H
1f43: 08 74 65     NOT1    0FE65H.4
1f46: b1 69        SET1    0FE69H.1
1f48: b1 68        SET1    0FE68H.1
1f4a: 2c 15 20     BR      !2015H
1f4d: b2 67        SET1    0FE67H.2
1f4f: b9 13        MOV     A,#13H
1f51: 09 f1 0a fd  MOV     !0FD0AH,A
1f55: 28 37 8b     CALL    !8B37H
1f58: 14 08        BR      $1F62H
1f5a: b4 67        SET1    0FE67H.4
1f5c: a7 66        CLR1    0FE66H.7
1f5e: a3 a1        CLR1    0FEA1H.3
1f60: a2 a1        CLR1    0FEA1H.2
1f62: 28 c4 25     CALL    !25C4H
1f65: 3a 7f 00     MOV     0FE7FH,#00H
1f68: 3a 85 00     MOV     0FE85H,#00H
1f6b: 3a 86 00     MOV     0FE86H,#00H
1f6e: 3a 88 00     MOV     0FE88H,#00H
1f71: b0 69        SET1    0FE69H.0
1f73: b1 68        SET1    0FE68H.1
1f75: b2 68        SET1    0FE68H.2
1f77: 2c 15 20     BR      !2015H
1f7a: 28 32 27     CALL    !2732H
1f7d: 2c 15 20     BR      !2015H
1f80: 08 75 73     NOT1    0FE73H.5
1f83: 75 73 21     BT      0FE73H.5,$1FA7H
1f86: 1c 63        MOVW    AX,0FE63H
1f88: 24 48        MOVW    DE,AX
1f8a: 06 00 05     MOV     A,[DE+05H]
1f8d: 30 a1        SHR     A,4
1f8f: ac 03        AND     A,#03H
1f91: b8 00        MOV     X,#00H
1f93: d8           XCH     A,X
1f94: 2f 00 00     CMPW    AX,#0000H
1f97: 80 0e        BNZ     $1FA7H
1f99: 1c 63        MOVW    AX,0FE63H
1f9b: 24 48        MOVW    DE,AX
1f9d: 06 00 05     MOV     A,[DE+05H]
1fa0: ac cf        AND     A,#0CFH
1fa2: ae 30        OR      A,#30H
1fa4: 06 80 05     MOV     [DE+05H],A
1fa7: b1 69        SET1    0FE69H.1
1fa9: 14 6a        BR      $2015H
1fab: 28 a8 93     CALL    !93A8H
1fae: b1 69        SET1    0FE69H.1
1fb0: 14 63        BR      $2015H
1fb2: 6f 74 1f     CMP     0FE74H,#1FH
1fb5: 81 f4        BZ      $1FABH
1fb7: 6f 74 27     CMP     0FE74H,#27H
1fba: 81 ef        BZ      $1FABH
1fbc: 6f 74 21     CMP     0FE74H,#21H
1fbf: 81 ea        BZ      $1FABH
1fc1: 6f 74 26     CMP     0FE74H,#26H
1fc4: 81 e5        BZ      $1FABH
1fc6: 6f 74 20     CMP     0FE74H,#20H
1fc9: 81 e0        BZ      $1FABH
1fcb: 6f 74 03     CMP     0FE74H,#03H
1fce: 81 b0        BZ      $1F80H
1fd0: 6f 74 1b     CMP     0FE74H,#1BH
1fd3: 81 a5        BZ      $1F7AH
1fd5: 6f 74 05     CMP     0FE74H,#05H
1fd8: 80 03        BNZ     $1FDDH
1fda: 2c 5a 1f     BR      !1F5AH
1fdd: 6f 74 43     CMP     0FE74H,#43H
1fe0: 80 03        BNZ     $1FE5H
1fe2: 2c 4d 1f     BR      !1F4DH
1fe5: 6f 74 10     CMP     0FE74H,#10H
1fe8: 80 03        BNZ     $1FEDH
1fea: 2c 43 1f     BR      !1F43H
1fed: 6f 74 19     CMP     0FE74H,#19H
1ff0: 80 03        BNZ     $1FF5H
1ff2: 2c 39 1f     BR      !1F39H
1ff5: 6f 74 34     CMP     0FE74H,#34H
1ff8: 80 03        BNZ     $1FFDH
1ffa: 2c 27 1f     BR      !1F27H
1ffd: 6f 74 1a     CMP     0FE74H,#1AH
2000: 80 03        BNZ     $2005H
2002: 2c 1b 1f     BR      !1F1BH
2005: 6f 74 11     CMP     0FE74H,#11H
2008: 80 03        BNZ     $200DH
200a: 2c fe 1e     BR      !1EFEH
200d: 6f 74 0b     CMP     0FE74H,#0BH
2010: 80 03        BNZ     $2015H
2012: 2c ee 1e     BR      !1EEEH
2015: 56           RET
2016: b3 68        SET1    0FE68H.3
2018: b4 68        SET1    0FE68H.4
201a: b1 68        SET1    0FE68H.1
201c: b2 68        SET1    0FE68H.2
201e: 1c 63        MOVW    AX,0FE63H
2020: 24 48        MOVW    DE,AX
2022: 06 00 06     MOV     A,[DE+06H]
2025: 30 99        SHR     A,3
2027: ac 07        AND     A,#07H
2029: b8 00        MOV     X,#00H
202b: d8           XCH     A,X
202c: 62 b0 df     MOVW    BC,#0DFB0H
202f: 88 0a        ADDW    AX,BC
2031: 3c           PUSH    AX
2032: 28 2b 7c     CALL    !7C2BH
2035: 34           POP     AX
2036: d2           MOV     A,C
2037: 09 f1 0b fd  MOV     !0FD0BH,A
203b: b6 73        SET1    0FE73H.6
203d: 56           RET
203e: 28 a5 25     CALL    !25A5H
2041: 8a 08        SUBW    AX,AX
2043: 8f 0a        CMPW    AX,BC
2045: 80 19        BNZ     $2060H
2047: a5 65        CLR1    0FE65H.5
2049: 1c 63        MOVW    AX,0FE63H
204b: 24 48        MOVW    DE,AX
204d: 20 b2        MOV     A,I2C_OutputBuffer
204f: bb 00        MOV     B,#00H
2051: da           XCH     A,C
2052: 06 00 06     MOV     A,[DE+06H]
2055: ac f8        AND     A,#0F8H
2057: 8e 12        OR      A,C
2059: 06 80 06     MOV     [DE+06H],A
205c: b1 68        SET1    0FE68H.1
205e: b4 68        SET1    0FE68H.4
2060: 56           RET
2061: 1c 63        MOVW    AX,0FE63H
2063: 24 48        MOVW    DE,AX
2065: 06 00 06     MOV     A,[DE+06H]
2068: 30 99        SHR     A,3
206a: ac 07        AND     A,#07H
206c: b8 00        MOV     X,#00H
206e: d8           XCH     A,X
206f: 2f 04 00     CMPW    AX,#0004H
2072: 80 0c        BNZ     $2080H
2074: 1c 63        MOVW    AX,0FE63H
2076: 24 48        MOVW    DE,AX
2078: 06 00 05     MOV     A,[DE+05H]
207b: 03 9b        CLR1    A.3
207d: 06 80 05     MOV     [DE+05H],A
2080: 1c 63        MOVW    AX,0FE63H
2082: 24 48        MOVW    DE,AX
2084: 20 b2        MOV     A,I2C_OutputBuffer
2086: bb 00        MOV     B,#00H
2088: da           XCH     A,C
2089: 06 00 06     MOV     A,[DE+06H]
208c: 31 9a        SHL     C,3
208e: ac c7        AND     A,#0C7H
2090: 8e 12        OR      A,C
2092: 06 80 06     MOV     [DE+06H],A
2095: 1c 63        MOVW    AX,0FE63H
2097: 24 48        MOVW    DE,AX
2099: 5c           MOV     A,[DE]
209a: 03 9a        CLR1    A.2
209c: 54           MOV     [DE],A
209d: a5 65        CLR1    0FE65H.5
209f: 6f b2 04     CMP     I2C_OutputBuffer,#04H
20a2: 80 0e        BNZ     $20B2H
20a4: 1c 63        MOVW    AX,0FE63H
20a6: 24 48        MOVW    DE,AX
20a8: 06 00 06     MOV     A,[DE+06H]
20ab: ac f8        AND     A,#0F8H
20ad: ae 04        OR      A,#04H
20af: 06 80 06     MOV     [DE+06H],A
20b2: 3a 89 00     MOV     0FE89H,#00H
20b5: 0c 80 c8 00  MOVW    0FE80H,#00C8H
20b9: 28 ec 94     CALL    !94ECH
20bc: 28 16 20     CALL    !2016H
20bf: 56           RET
20c0: 64 63 fe     MOVW    DE,#0FE63H
20c3: 05 e2        MOVW    AX,[DE]
20c5: 44           INCW    AX
20c6: 44           INCW    AX
20c7: 24 48        MOVW    DE,AX
20c9: 5c           MOV     A,[DE]
20ca: 98 6a        ADD     A,0FE6AH
20cc: 0e           ADJBA
20cd: 54           MOV     [DE],A
20ce: 46           INCW    DE
20cf: 5c           MOV     A,[DE]
20d0: a9 00        ADDC    A,#00H
20d2: 0e           ADJBA
20d3: 54           MOV     [DE],A
20d4: 46           INCW    DE
20d5: 5c           MOV     A,[DE]
20d6: a9 00        ADDC    A,#00H
20d8: 0e           ADJBA
20d9: 54           MOV     [DE],A
20da: 56           RET
Decimal_Add:
20db: 64 63 fe     MOVW    DE,#0FE63H
20de: 05 e2        MOVW    AX,[DE]
20e0: 44           INCW    AX
20e1: 44           INCW    AX
20e2: 44           INCW    AX
20e3: 24 48        MOVW    DE,AX
20e5: 5c           MOV     A,[DE]
20e6: a8 01        ADD     A,#01H
20e8: 0e           ADJBA
20e9: 54           MOV     [DE],A
20ea: 46           INCW    DE
20eb: 5c           MOV     A,[DE]
20ec: a9 00        ADDC    A,#00H
20ee: 0e           ADJBA
20ef: 54           MOV     [DE],A
20f0: 56           RET
Decimal_Subtract:
20f1: 64 63 fe     MOVW    DE,#0FE63H
20f4: 05 e2        MOVW    AX,[DE]
20f6: 44           INCW    AX
20f7: 44           INCW    AX
20f8: 24 48        MOVW    DE,AX
20fa: 5c           MOV     A,[DE]
20fb: 9a 6a        SUB     A,0FE6AH
20fd: 0f           ADJBS
20fe: 54           MOV     [DE],A
20ff: 46           INCW    DE
2100: 5c           MOV     A,[DE]
2101: ab 00        SUBC    A,#00H
2103: 0f           ADJBS
2104: 54           MOV     [DE],A
2105: 46           INCW    DE
2106: 5c           MOV     A,[DE]
2107: ab 00        SUBC    A,#00H
2109: 0f           ADJBS
210a: 54           MOV     [DE],A
210b: 56           RET
210c: 64 63 fe     MOVW    DE,#0FE63H
210f: 05 e2        MOVW    AX,[DE]
2111: 44           INCW    AX
2112: 44           INCW    AX
2113: 44           INCW    AX
2114: 24 48        MOVW    DE,AX
2116: 5c           MOV     A,[DE]
2117: aa 01        SUB     A,#01H
2119: 0f           ADJBS
211a: 54           MOV     [DE],A
211b: 46           INCW    DE
211c: 5c           MOV     A,[DE]
211d: ab 00        SUBC    A,#00H
211f: 0f           ADJBS
2120: 54           MOV     [DE],A
2121: 56           RET
2122: 3f           PUSH    HL
2123: 11 fc        MOVW    AX,SP
2125: 2e 04 00     SUBW    AX,#0004H
2128: 24 68        MOVW    HL,AX
212a: 13 fc        MOVW    SP,AX
212c: 75 67 09     BT      0FE67H.5,$2138H
212f: 72 67 06     BT      0FE67H.2,$2138H
2132: 74 67 03     BT      0FE67H.4,$2138H
2135: 3a 85 96     MOV     0FE85H,#96H
2138: b9 00        MOV     A,#00H
213a: 06 a0 03     MOV     [HL+03H],A
213d: 06 20 03     MOV     A,[HL+03H]
2140: b8 00        MOV     X,#00H
2142: d8           XCH     A,X
2143: 2d 00 10     ADDW    AX,#1000H
2146: 24 48        MOVW    DE,AX
2148: 20 74        MOV     A,0FE74H
214a: 16 4f        CMP     A,[DE]
214c: 81 10        BZ      $215EH
214e: 06 20 03     MOV     A,[HL+03H]
2151: af 0a        CMP     A,#0AH
2153: 82 09        BNC     $215EH
2155: 06 20 03     MOV     A,[HL+03H]
2158: c1           INC     A
2159: 06 a0 03     MOV     [HL+03H],A
215c: 14 df        BR      $213DH
215e: 08 a1 7d 1c  BF      0FE7DH.1,$217EH
2162: 06 20 03     MOV     A,[HL+03H]
2165: b8 00        MOV     X,#00H
2167: d8           XCH     A,X
2168: 62 a1 df     MOVW    BC,#0DFA1H
216b: 88 0a        ADDW    AX,BC
216d: 3c           PUSH    AX
216e: 09 f0 a5 fd  MOV     A,!0FDA5H
2172: b8 00        MOV     X,#00H
2174: d8           XCH     A,X
2175: 3c           PUSH    AX
2176: 28 18 7b     CALL    !7B18H
2179: 34           POP     AX
217a: 34           POP     AX
217b: 2c 1b 24     BR      !241BH
217e: 08 a7 66 56  BF      0FE66H.7,$21D8H
2182: 06 20 03     MOV     A,[HL+03H]
2185: af 01        CMP     A,#01H
2187: 80 24        BNZ     $21ADH
2189: 08 77 a1     NOT1    0FEA1H.7
218c: 08 a5 65 04  BF      0FE65H.5,$2194H
2190: 1c 90        MOVW    AX,0FE90H
2192: 14 03        BR      $2197H
2194: 60 ab 0b     MOVW    AX,#0BABH
2197: 06 a0 01     MOV     [HL+01H],A
219a: d8           XCH     A,X
219b: 55           MOV     [HL],A
219c: 60 f8 df     MOVW    AX,#0DFF8H
219f: 3c           PUSH    AX
21a0: 05 e3        MOVW    AX,[HL]
21a2: 3c           PUSH    AX
21a3: 28 63 7b     CALL    !7B63H
21a6: 34           POP     AX
21a7: 34           POP     AX
21a8: 28 ae 67     CALL    !67AEH
21ab: 14 28        BR      $21D5H
21ad: 06 20 03     MOV     A,[HL+03H]
21b0: af 02        CMP     A,#02H
21b2: 80 21        BNZ     $21D5H
21b4: 08 76 a1     NOT1    0FEA1H.6
21b7: 08 a5 65 04  BF      0FE65H.5,$21BFH
21bb: 1c 90        MOVW    AX,0FE90H
21bd: 14 03        BR      $21C2H
21bf: 60 ab 0b     MOVW    AX,#0BABH
21c2: 06 a0 01     MOV     [HL+01H],A
21c5: d8           XCH     A,X
21c6: 55           MOV     [HL],A
21c7: 60 fe df     MOVW    AX,#0DFFEH
21ca: 3c           PUSH    AX
21cb: 05 e3        MOVW    AX,[HL]
21cd: 3c           PUSH    AX
21ce: 28 63 7b     CALL    !7B63H
21d1: 34           POP     AX
21d2: 34           POP     AX
21d3: 14 d3        BR      $21A8H
21d5: 2c 1b 24     BR      !241BH
21d8: 72 67 04     BT      0FE67H.2,$21DFH
21db: 08 a4 67 54  BF      0FE67H.4,$2233H
21df: 09 f0 0d fd  MOV     A,!0FD0DH
21e3: ac 0f        AND     A,#0FH
21e5: b8 00        MOV     X,#00H
21e7: d8           XCH     A,X
21e8: 2f 0f 00     CMPW    AX,#000FH
21eb: 80 10        BNZ     $21FDH
21ed: 64 0d fd     MOVW    DE,#0FD0DH
21f0: 5c           MOV     A,[DE]
21f1: ac f0        AND     A,#0F0H
21f3: 54           MOV     [DE],A
21f4: 3a 8d 00     MOV     0FE8DH,#00H
21f7: 3a 8e 00     MOV     0FE8EH,#00H
21fa: 3a 8f 00     MOV     0FE8FH,#00H
21fd: 28 1f 24     CALL    !241FH
2200: 08 a2 67 05  BF      0FE67H.2,$2209H
2204: 60 01 00     MOVW    AX,#0001H
2207: 14 03        BR      $220CH
2209: 60 02 00     MOVW    AX,#0002H
220c: d0           MOV     A,X
220d: 06 a0 02     MOV     [HL+02H],A
2210: b8 00        MOV     X,#00H
2212: d8           XCH     A,X
2213: 2d 8c fe     ADDW    AX,#0FE8CH
2216: 24 48        MOVW    DE,AX
2218: 5c           MOV     A,[DE]
2219: ac f0        AND     A,#0F0H
221b: 06 2e 03     OR      A,[HL+03H]
221e: d8           XCH     A,X
221f: 06 20 02     MOV     A,[HL+02H]
2222: 24 20        MOV     C,X
2224: b8 00        MOV     X,#00H
2226: d8           XCH     A,X
2227: 2d 8c fe     ADDW    AX,#0FE8CH
222a: 24 48        MOVW    DE,AX
222c: d2           MOV     A,C
222d: 54           MOV     [DE],A
222e: a7 67        CLR1    0FE67H.7
2230: 2c 1b 24     BR      !241BH
2233: 08 a3 67 27  BF      0FE67H.3,$225EH
2237: 20 8c        MOV     A,0FE8CH
2239: 30 a1        SHR     A,4
223b: b8 09        MOV     X,#09H
223d: 8f 01        CMP     X,A
223f: 82 07        BNC     $2248H
2241: 06 20 03     MOV     A,[HL+03H]
2244: 22 8c        MOV     0FE8CH,A
2246: 14 13        BR      $225BH
2248: 20 8c        MOV     A,0FE8CH
224a: 31 a1        SHL     A,4
224c: bb 00        MOV     B,#00H
224e: da           XCH     A,C
224f: 06 20 03     MOV     A,[HL+03H]
2252: b8 00        MOV     X,#00H
2254: 8e 21        OR      C,A
2256: 8e 30        OR      B,X
2258: d2           MOV     A,C
2259: 22 8c        MOV     0FE8CH,A
225b: 2c 1b 24     BR      !241BH
225e: 08 a2 73 06  BF      0FE73H.2,$2268H
2262: 2c f5 22     BR      !22F5H
2265: 2c 1b 24     BR      !241BH
2268: 08 a5 67 25  BF      0FE67H.5,$2291H
226c: 09 f0 a9 fd  MOV     A,!0FDA9H
2270: b8 00        MOV     X,#00H
2272: d8           XCH     A,X
2273: 2d ab fd     ADDW    AX,#0FDABH
2276: 24 48        MOVW    DE,AX
2278: 06 20 03     MOV     A,[HL+03H]
227b: 54           MOV     [DE],A
227c: 64 a9 fd     MOVW    DE,#0FDA9H
227f: 5c           MOV     A,[DE]
2280: c1           INC     A
2281: 54           MOV     [DE],A
2282: b8 00        MOV     X,#00H
2284: ba 07        MOV     C,#07H
2286: d8           XCH     A,X
2287: 05 1a        DIVUW   C
2289: d2           MOV     A,C
228a: 09 f1 a9 fd  MOV     !0FDA9H,A
228e: 2c 1b 24     BR      !241BH
2291: 75 65 04     BT      0FE65H.5,$2298H
2294: 08 a7 65 5d  BF      0FE65H.7,$22F5H
2298: b0 67        SET1    0FE67H.0
229a: 09 f0 0d fd  MOV     A,!0FD0DH
229e: ac 0f        AND     A,#0FH
22a0: b8 00        MOV     X,#00H
22a2: d8           XCH     A,X
22a3: 2f 0f 00     CMPW    AX,#000FH
22a6: 80 11        BNZ     $22B9H
22a8: 64 0d fd     MOVW    DE,#0FD0DH
22ab: 5c           MOV     A,[DE]
22ac: ac f0        AND     A,#0F0H
22ae: 54           MOV     [DE],A
22af: 06 20 03     MOV     A,[HL+03H]
22b2: b8 00        MOV     X,#00H
22b4: d8           XCH     A,X
22b5: 1a 90        MOVW    0FE90H,AX
22b7: 14 39        BR      $22F2H
22b9: 1c 90        MOVW    AX,0FE90H
22bb: 31 e0        SHLW    AX,4
22bd: 24 28        MOVW    BC,AX
22bf: 06 20 03     MOV     A,[HL+03H]
22c2: b8 00        MOV     X,#00H
22c4: d8           XCH     A,X
22c5: 88 0a        ADDW    AX,BC
22c7: 1a 90        MOVW    0FE90H,AX
22c9: 09 f0 0d fd  MOV     A,!0FD0DH
22cd: ac 0f        AND     A,#0FH
22cf: b8 00        MOV     X,#00H
22d1: d8           XCH     A,X
22d2: 44           INCW    AX
22d3: 24 28        MOVW    BC,AX
22d5: 09 f0 0d fd  MOV     A,!0FD0DH
22d9: ac f0        AND     A,#0F0H
22db: 8e 12        OR      A,C
22dd: 09 f1 0d fd  MOV     !0FD0DH,A
22e1: ac 0f        AND     A,#0FH
22e3: b8 00        MOV     X,#00H
22e5: d8           XCH     A,X
22e6: 24 28        MOVW    BC,AX
22e8: 60 01 00     MOVW    AX,#0001H
22eb: 8f 0a        CMPW    AX,BC
22ed: 82 03        BNC     $22F2H
22ef: 3a 85 01     MOV     0FE85H,#01H
22f2: 2c 1b 24     BR      !241BH
22f5: 09 f0 0d fd  MOV     A,!0FD0DH
22f9: ac 0f        AND     A,#0FH
22fb: b8 00        MOV     X,#00H
22fd: d8           XCH     A,X
22fe: 2f 0f 00     CMPW    AX,#000FH
2301: 80 03        BNZ     $2306H
2303: 28 8f 24     CALL    !248FH
2306: 09 f0 0d fd  MOV     A,!0FD0DH
230a: 30 a1        SHR     A,4
230c: ac 0f        AND     A,#0FH
230e: b8 00        MOV     X,#00H
2310: d8           XCH     A,X
2311: 24 28        MOVW    BC,AX
2313: 09 f0 0d fd  MOV     A,!0FD0DH
2317: ac 0f        AND     A,#0FH
2319: b8 00        MOV     X,#00H
231b: d8           XCH     A,X
231c: 8f 0a        CMPW    AX,BC
231e: 83 02        BC      $2322H
2320: 80 58        BNZ     $237AH
2322: 28 1f 24     CALL    !241FH
2325: 06 20 03     MOV     A,[HL+03H]
2328: b8 00        MOV     X,#00H
232a: d8           XCH     A,X
232b: 3c           PUSH    AX
232c: 28 72 25     CALL    !2572H
232f: 34           POP     AX
2330: 09 f0 0d fd  MOV     A,!0FD0DH
2334: ac 0f        AND     A,#0FH
2336: b8 00        MOV     X,#00H
2338: d8           XCH     A,X
2339: 4c           DECW    AX
233a: 24 28        MOVW    BC,AX
233c: 09 f0 0d fd  MOV     A,!0FD0DH
2340: ac f0        AND     A,#0F0H
2342: 8e 12        OR      A,C
2344: 09 f1 0d fd  MOV     !0FD0DH,A
2348: ac 0f        AND     A,#0FH
234a: b8 00        MOV     X,#00H
234c: d8           XCH     A,X
234d: 44           INCW    AX
234e: 24 28        MOVW    BC,AX
2350: 09 f0 0e fd  MOV     A,!0FD0EH
2354: ac 0f        AND     A,#0FH
2356: b8 00        MOV     X,#00H
2358: d8           XCH     A,X
2359: 8f 0a        CMPW    AX,BC
235b: 80 1a        BNZ     $2377H
235d: 09 f0 0d fd  MOV     A,!0FD0DH
2361: 30 a1        SHR     A,4
2363: ac 0f        AND     A,#0FH
2365: b8 00        MOV     X,#00H
2367: d8           XCH     A,X
2368: 44           INCW    AX
2369: 24 28        MOVW    BC,AX
236b: 09 f0 0d fd  MOV     A,!0FD0DH
236f: ac f0        AND     A,#0F0H
2371: 8e 12        OR      A,C
2373: 09 f1 0d fd  MOV     !0FD0DH,A
2377: 2c fc 23     BR      !23FCH
237a: 09 f0 0d fd  MOV     A,!0FD0DH
237e: ac 0f        AND     A,#0FH
2380: b8 00        MOV     X,#00H
2382: d8           XCH     A,X
2383: 24 28        MOVW    BC,AX
2385: 60 08 00     MOVW    AX,#0008H
2388: 8a 0a        SUBW    AX,BC
238a: 30 c8        SHRW    AX,1
238c: 2d 8c fe     ADDW    AX,#0FE8CH
238f: 24 48        MOVW    DE,AX
2391: 5c           MOV     A,[DE]
2392: 06 a0 02     MOV     [HL+02H],A
2395: 09 f0 0d fd  MOV     A,!0FD0DH
2399: ac 0f        AND     A,#0FH
239b: b8 00        MOV     X,#00H
239d: d8           XCH     A,X
239e: ac 00        AND     A,#00H
23a0: d8           XCH     A,X
23a1: ac 01        AND     A,#01H
23a3: d8           XCH     A,X
23a4: 2f 00 00     CMPW    AX,#0000H
23a7: 80 0d        BNZ     $23B6H
23a9: 06 20 02     MOV     A,[HL+02H]
23ac: ac f0        AND     A,#0F0H
23ae: 06 2e 03     OR      A,[HL+03H]
23b1: 06 a0 02     MOV     [HL+02H],A
23b4: 14 13        BR      $23C9H
23b6: 06 20 03     MOV     A,[HL+03H]
23b9: 31 a1        SHL     A,4
23bb: 06 a0 03     MOV     [HL+03H],A
23be: 06 20 02     MOV     A,[HL+02H]
23c1: ac 0f        AND     A,#0FH
23c3: 06 2e 03     OR      A,[HL+03H]
23c6: 06 a0 02     MOV     [HL+02H],A
23c9: 09 f0 0d fd  MOV     A,!0FD0DH
23cd: ac 0f        AND     A,#0FH
23cf: b8 00        MOV     X,#00H
23d1: d8           XCH     A,X
23d2: 24 28        MOVW    BC,AX
23d4: 60 08 00     MOVW    AX,#0008H
23d7: 8a 0a        SUBW    AX,BC
23d9: 30 c8        SHRW    AX,1
23db: 2d 8c fe     ADDW    AX,#0FE8CH
23de: 24 48        MOVW    DE,AX
23e0: 06 20 02     MOV     A,[HL+02H]
23e3: 54           MOV     [DE],A
23e4: 09 f0 0d fd  MOV     A,!0FD0DH
23e8: ac 0f        AND     A,#0FH
23ea: b8 00        MOV     X,#00H
23ec: d8           XCH     A,X
23ed: 44           INCW    AX
23ee: 24 28        MOVW    BC,AX
23f0: 09 f0 0d fd  MOV     A,!0FD0DH
23f4: ac f0        AND     A,#0F0H
23f6: 8e 12        OR      A,C
23f8: 09 f1 0d fd  MOV     !0FD0DH,A
23fc: 09 f0 0e fd  MOV     A,!0FD0EH
2400: 30 a1        SHR     A,4
2402: ac 0f        AND     A,#0FH
2404: b8 00        MOV     X,#00H
2406: d8           XCH     A,X
2407: 24 28        MOVW    BC,AX
2409: 09 f0 0d fd  MOV     A,!0FD0DH
240d: ac 0f        AND     A,#0FH
240f: b8 00        MOV     X,#00H
2411: d8           XCH     A,X
2412: 8f 0a        CMPW    AX,BC
2414: 83 05        BC      $241BH
2416: 81 03        BZ      $241BH
2418: 3a 85 01     MOV     0FE85H,#01H
241b: 34           POP     AX
241c: 34           POP     AX
241d: 37           POP     HL
241e: 56           RET
241f: 3f           PUSH    HL
2420: 05 c9        DECW    SP
2422: 05 c9        DECW    SP
2424: 11 fc        MOVW    AX,SP
2426: 24 68        MOVW    HL,AX
2428: 20 8f        MOV     A,0FE8FH
242a: 31 a1        SHL     A,4
242c: d8           XCH     A,X
242d: 20 8e        MOV     A,0FE8EH
242f: 30 a1        SHR     A,4
2431: da           XCH     A,C
2432: b9 00        MOV     A,#00H
2434: bb 00        MOV     B,#00H
2436: 8e 02        OR      X,C
2438: 8e 13        OR      A,B
243a: d0           MOV     A,X
243b: 22 8f        MOV     0FE8FH,A
243d: 20 8e        MOV     A,0FE8EH
243f: 31 a1        SHL     A,4
2441: d8           XCH     A,X
2442: 20 8d        MOV     A,0FE8DH
2444: 30 a1        SHR     A,4
2446: da           XCH     A,C
2447: b9 00        MOV     A,#00H
2449: bb 00        MOV     B,#00H
244b: 8e 02        OR      X,C
244d: 8e 13        OR      A,B
244f: d0           MOV     A,X
2450: 22 8e        MOV     0FE8EH,A
2452: 20 8d        MOV     A,0FE8DH
2454: 31 a1        SHL     A,4
2456: d8           XCH     A,X
2457: 20 8c        MOV     A,0FE8CH
2459: 30 a1        SHR     A,4
245b: da           XCH     A,C
245c: b9 00        MOV     A,#00H
245e: bb 00        MOV     B,#00H
2460: 8e 02        OR      X,C
2462: 8e 13        OR      A,B
2464: d0           MOV     A,X
2465: 22 8d        MOV     0FE8DH,A
2467: 72 67 04     BT      0FE67H.2,$246EH
246a: 08 a4 67 04  BF      0FE67H.4,$2472H
246e: 8a 08        SUBW    AX,AX
2470: 14 03        BR      $2475H
2472: 60 0b 00     MOVW    AX,#000BH
2475: d0           MOV     A,X
2476: 06 a0 01     MOV     [HL+01H],A
2479: 20 8c        MOV     A,0FE8CH
247b: 31 a1        SHL     A,4
247d: bb 00        MOV     B,#00H
247f: da           XCH     A,C
2480: 06 20 01     MOV     A,[HL+01H]
2483: b8 00        MOV     X,#00H
2485: 8e 21        OR      C,A
2487: 8e 30        OR      B,X
2489: d2           MOV     A,C
248a: 22 8c        MOV     0FE8CH,A
248c: 34           POP     AX
248d: 37           POP     HL
248e: 56           RET
248f: b1 67        SET1    0FE67H.1
2491: 09 f0 0e fd  MOV     A,!0FD0EH
2495: ac f0        AND     A,#0F0H
2497: ae 02        OR      A,#02H
2499: 09 f1 0e fd  MOV     !0FD0EH,A
249d: ac 0f        AND     A,#0FH
249f: ae 60        OR      A,#60H
24a1: 09 f1 0e fd  MOV     !0FD0EH,A
24a5: 1c 63        MOVW    AX,0FE63H
24a7: 24 48        MOVW    DE,AX
24a9: 06 00 06     MOV     A,[DE+06H]
24ac: 30 b1        SHR     A,6
24ae: ac 03        AND     A,#03H
24b0: b8 00        MOV     X,#00H
24b2: d8           XCH     A,X
24b3: 2f 01 00     CMPW    AX,#0001H
24b6: 80 22        BNZ     $24DAH
24b8: 09 f0 0e fd  MOV     A,!0FD0EH
24bc: ac f0        AND     A,#0F0H
24be: ae 01        OR      A,#01H
24c0: 09 f1 0e fd  MOV     !0FD0EH,A
24c4: 09 f0 a3 fd  MOV     A,!0FDA3H
24c8: af 03        CMP     A,#03H
24ca: 82 0c        BNC     $24D8H
24cc: 09 f0 0e fd  MOV     A,!0FD0EH
24d0: ac 0f        AND     A,#0FH
24d2: ae 70        OR      A,#70H
24d4: 09 f1 0e fd  MOV     !0FD0EH,A
24d8: 14 28        BR      $2502H
24da: 09 f0 a3 fd  MOV     A,!0FDA3H
24de: af 02        CMP     A,#02H
24e0: 80 0c        BNZ     $24EEH
24e2: 09 f0 0e fd  MOV     A,!0FD0EH
24e6: ac 0f        AND     A,#0FH
24e8: ae 70        OR      A,#70H
24ea: 09 f1 0e fd  MOV     !0FD0EH,A
24ee: 09 f0 a3 fd  MOV     A,!0FDA3H
24f2: af 01        CMP     A,#01H
24f4: 80 0c        BNZ     $2502H
24f6: 09 f0 0e fd  MOV     A,!0FD0EH
24fa: ac 0f        AND     A,#0FH
24fc: ae 80        OR      A,#80H
24fe: 09 f1 0e fd  MOV     !0FD0EH,A
2502: 1c 63        MOVW    AX,0FE63H
2504: 24 48        MOVW    DE,AX
2506: 5c           MOV     A,[DE]
2507: 30 a1        SHR     A,4
2509: ac 01        AND     A,#01H
250b: b8 00        MOV     X,#00H
250d: d8           XCH     A,X
250e: 2f 00 00     CMPW    AX,#0000H
2511: 80 05        BNZ     $2518H
2513: 60 06 00     MOVW    AX,#0006H
2516: 14 03        BR      $251BH
2518: 60 03 00     MOVW    AX,#0003H
251b: 24 28        MOVW    BC,AX
251d: 09 f0 0d fd  MOV     A,!0FD0DH
2521: 31 a2        SHL     C,4
2523: ac 0f        AND     A,#0FH
2525: 8e 12        OR      A,C
2527: 09 f1 0d fd  MOV     !0FD0DH,A
252b: 1c 63        MOVW    AX,0FE63H
252d: 24 48        MOVW    DE,AX
252f: 06 00 06     MOV     A,[DE+06H]
2532: 30 b1        SHR     A,6
2534: ac 03        AND     A,#03H
2536: b8 00        MOV     X,#00H
2538: d8           XCH     A,X
2539: 2f 01 00     CMPW    AX,#0001H
253c: 80 0c        BNZ     $254AH
253e: 09 f0 0d fd  MOV     A,!0FD0DH
2542: ac 0f        AND     A,#0FH
2544: ae 30        OR      A,#30H
2546: 09 f1 0d fd  MOV     !0FD0DH,A
254a: 3a 8f bb     MOV     0FE8FH,#0BBH
254d: 3a 8e bb     MOV     0FE8EH,#0BBH
2550: 3a 8d bb     MOV     0FE8DH,#0BBH
2553: 3a 8c bb     MOV     0FE8CH,#0BBH
2556: 09 f0 0d fd  MOV     A,!0FD0DH
255a: 30 a1        SHR     A,4
255c: ac 0f        AND     A,#0FH
255e: b8 00        MOV     X,#00H
2560: d8           XCH     A,X
2561: 24 28        MOVW    BC,AX
2563: 09 f0 0d fd  MOV     A,!0FD0DH
2567: ac f0        AND     A,#0F0H
2569: 8e 12        OR      A,C
256b: 09 f1 0d fd  MOV     !0FD0DH,A
256f: a4 72        CLR1    0FE72H.4
2571: 56           RET
2572: 3f           PUSH    HL
2573: 11 fc        MOVW    AX,SP
2575: 24 68        MOVW    HL,AX
2577: 09 f0 0d fd  MOV     A,!0FD0DH
257b: 30 a1        SHR     A,4
257d: ac 0f        AND     A,#0FH
257f: b8 00        MOV     X,#00H
2581: d8           XCH     A,X
2582: 2f 03 00     CMPW    AX,#0003H
2585: 80 13        BNZ     $259AH
2587: 06 20 04     MOV     A,[HL+04H]
258a: 31 a1        SHL     A,4
258c: 06 a0 04     MOV     [HL+04H],A
258f: 20 8e        MOV     A,0FE8EH
2591: ac 0f        AND     A,#0FH
2593: 06 2e 04     OR      A,[HL+04H]
2596: 22 8e        MOV     0FE8EH,A
2598: 14 09        BR      $25A3H
259a: 20 8d        MOV     A,0FE8DH
259c: ac f0        AND     A,#0F0H
259e: 06 2e 04     OR      A,[HL+04H]
25a1: 22 8d        MOV     0FE8DH,A
25a3: 37           POP     HL
25a4: 56           RET
25a5: 1c 63        MOVW    AX,0FE63H
25a7: 24 48        MOVW    DE,AX
25a9: 06 00 06     MOV     A,[DE+06H]
25ac: 30 99        SHR     A,3
25ae: ac 07        AND     A,#07H
25b0: b8 00        MOV     X,#00H
25b2: d8           XCH     A,X
25b3: 2f 04 00     CMPW    AX,#0004H
25b6: 80 08        BNZ     $25C0H
25b8: 28 d2 6b     CALL    !6BD2H
25bb: 62 01 00     MOVW    BC,#0001H
25be: 14 03        BR      $25C3H
25c0: 62 00 00     MOVW    BC,#0000H
25c3: 56           RET
25c4: 3f           PUSH    HL
25c5: 05 c9        DECW    SP
25c7: 05 c9        DECW    SP
25c9: 11 fc        MOVW    AX,SP
25cb: 24 68        MOVW    HL,AX
25cd: 28 7b 26     CALL    !267BH
25d0: 24 0a        MOVW    AX,BC
25d2: 06 a0 01     MOV     [HL+01H],A
25d5: d8           XCH     A,X
25d6: 55           MOV     [HL],A
25d7: 60 0b 00     MOVW    AX,#000BH
25da: 3c           PUSH    AX
25db: 28 6d 8b     CALL    Delay_Loop
25de: 34           POP     AX
25df: 28 ce 7a     CALL    Query_DFBE
25e2: 64 bd df     MOVW    DE,#0DFBDH
25e5: 70 a1 05     BT      0FEA1H.0,$25EDH
25e8: 60 01 00     MOVW    AX,#0001H
25eb: 14 03        BR      $25F0H
25ed: 60 02 00     MOVW    AX,#0002H
25f0: 24 28        MOVW    BC,AX
25f2: 5c           MOV     A,[DE]
25f3: b8 00        MOV     X,#00H
25f5: 8c 03        AND     X,B
25f7: 8c 12        AND     A,C
25f9: d8           XCH     A,X
25fa: 2f 00 00     CMPW    AX,#0000H
25fd: 80 2b        BNZ     $262AH
25ff: 05 e3        MOVW    AX,[HL]
2601: 4c           DECW    AX
2602: 06 a0 01     MOV     [HL+01H],A
2605: d8           XCH     A,X
2606: 55           MOV     [HL],A
2607: d8           XCH     A,X
2608: 44           INCW    AX
2609: 24 48        MOVW    DE,AX
260b: 5c           MOV     A,[DE]
260c: 22 8f        MOV     0FE8FH,A
260e: 05 e3        MOVW    AX,[HL]
2610: 4c           DECW    AX
2611: 06 a0 01     MOV     [HL+01H],A
2614: d8           XCH     A,X
2615: 55           MOV     [HL],A
2616: d8           XCH     A,X
2617: 44           INCW    AX
2618: 24 48        MOVW    DE,AX
261a: 5c           MOV     A,[DE]
261b: 22 8e        MOV     0FE8EH,A
261d: 08 a2 67 07  BF      0FE67H.2,$2628H
2621: 05 e3        MOVW    AX,[HL]
2623: 24 48        MOVW    DE,AX
2625: 5c           MOV     A,[DE]
2626: 22 8d        MOV     0FE8DH,A
2628: 14 09        BR      $2633H
262a: 3a 8d 00     MOV     0FE8DH,#00H
262d: 3a 8e 00     MOV     0FE8EH,#00H
2630: 3a 8f 00     MOV     0FE8FH,#00H
2633: 09 f0 0d fd  MOV     A,!0FD0DH
2637: ac f0        AND     A,#0F0H
2639: ae 0f        OR      A,#0FH
263b: 09 f1 0d fd  MOV     !0FD0DH,A
263f: 34           POP     AX
2640: 37           POP     HL
2641: 56           RET
2642: 3f           PUSH    HL
2643: 05 c9        DECW    SP
2645: 05 c9        DECW    SP
2647: 11 fc        MOVW    AX,SP
2649: 24 68        MOVW    HL,AX
264b: 28 7b 26     CALL    !267BH
264e: 24 0a        MOVW    AX,BC
2650: 06 a0 01     MOV     [HL+01H],A
2653: d8           XCH     A,X
2654: 55           MOV     [HL],A
2655: d8           XCH     A,X
2656: 4c           DECW    AX
2657: 06 a0 01     MOV     [HL+01H],A
265a: d8           XCH     A,X
265b: 55           MOV     [HL],A
265c: d8           XCH     A,X
265d: 44           INCW    AX
265e: 3c           PUSH    AX
265f: 20 8f        MOV     A,0FE8FH
2661: b8 00        MOV     X,#00H
2663: d8           XCH     A,X
2664: 3c           PUSH    AX
2665: 28 18 7b     CALL    !7B18H
2668: 34           POP     AX
2669: 34           POP     AX
266a: 05 e3        MOVW    AX,[HL]
266c: 3c           PUSH    AX
266d: 20 8e        MOV     A,0FE8EH
266f: b8 00        MOV     X,#00H
2671: d8           XCH     A,X
2672: 3c           PUSH    AX
2673: 28 18 7b     CALL    !7B18H
2676: 34           POP     AX
2677: 34           POP     AX
2678: 34           POP     AX
2679: 37           POP     HL
267a: 56           RET
267b: 3f           PUSH    HL
267c: 05 c9        DECW    SP
267e: 05 c9        DECW    SP
2680: 11 fc        MOVW    AX,SP
2682: 24 68        MOVW    HL,AX
2684: 08 a2 67 16  BF      0FE67H.2,$269EH
2688: 60 27 fd     MOVW    AX,#0FD27H
268b: 06 a0 01     MOV     [HL+01H],A
268e: d8           XCH     A,X
268f: 55           MOV     [HL],A
2690: 08 a0 a1 08  BF      0FEA1H.0,$269CH
2694: 60 2a fd     MOVW    AX,#0FD2AH
2697: 06 a0 01     MOV     [HL+01H],A
269a: d8           XCH     A,X
269b: 55           MOV     [HL],A
269c: 14 2e        BR      $26CCH
269e: 60 0f 00     MOVW    AX,#000FH
26a1: 3c           PUSH    AX
26a2: 28 6d 8b     CALL    Delay_Loop
26a5: 34           POP     AX
26a6: 28 ce 7a     CALL    Query_DFBE
26a9: 60 f4 df     MOVW    AX,#0DFF4H
26ac: 44           INCW    AX
26ad: 06 a0 01     MOV     [HL+01H],A
26b0: d8           XCH     A,X
26b1: 55           MOV     [HL],A
26b2: 08 a2 a1 09  BF      0FEA1H.2,$26BFH
26b6: 60 fa df     MOVW    AX,#0DFFAH
26b9: 44           INCW    AX
26ba: 06 a0 01     MOV     [HL+01H],A
26bd: d8           XCH     A,X
26be: 55           MOV     [HL],A
26bf: 08 a3 a1 09  BF      0FEA1H.3,$26CCH
26c3: 05 e3        MOVW    AX,[HL]
26c5: 44           INCW    AX
26c6: 44           INCW    AX
26c7: 06 a0 01     MOV     [HL+01H],A
26ca: d8           XCH     A,X
26cb: 55           MOV     [HL],A
26cc: 05 e3        MOVW    AX,[HL]
26ce: 24 28        MOVW    BC,AX
26d0: 34           POP     AX
26d1: 37           POP     HL
26d2: 56           RET
26d3: 64 a3 fd     MOVW    DE,#0FDA3H
26d6: 5c           MOV     A,[DE]
26d7: c1           INC     A
26d8: 54           MOV     [DE],A
26d9: 08 a6 65 12  BF      0FE65H.6,$26EFH
26dd: 09 f0 a3 fd  MOV     A,!0FDA3H
26e1: af 04        CMP     A,#04H
26e3: 83 08        BC      $26EDH
26e5: 81 06        BZ      $26EDH
26e7: b9 02        MOV     A,#02H
26e9: 09 f1 a3 fd  MOV     !0FDA3H,A
26ed: 14 10        BR      $26FFH
26ef: 09 f0 a3 fd  MOV     A,!0FDA3H
26f3: af 03        CMP     A,#03H
26f5: 83 08        BC      $26FFH
26f7: 81 06        BZ      $26FFH
26f9: b9 01        MOV     A,#01H
26fb: 09 f1 a3 fd  MOV     !0FDA3H,A
26ff: 14 20        BR      $2721H
2701: 1c 63        MOVW    AX,0FE63H
2703: 24 48        MOVW    DE,AX
2705: 60 01 00     MOVW    AX,#0001H
2708: 88 0c        ADDW    AX,DE
270a: 24 48        MOVW    DE,AX
270c: b9 00        MOV     A,#00H
270e: 54           MOV     [DE],A
270f: 1c 63        MOVW    AX,0FE63H
2711: 24 48        MOVW    DE,AX
2713: 60 01 00     MOVW    AX,#0001H
2716: 88 0c        ADDW    AX,DE
2718: 24 48        MOVW    DE,AX
271a: b9 f0        MOV     A,#0F0H
271c: 16 4c        AND     A,[DE]
271e: 54           MOV     [DE],A
271f: 14 10        BR      $2731H
2721: 09 f0 a3 fd  MOV     A,!0FDA3H
2725: af 02        CMP     A,#02H
2727: 81 e6        BZ      $270FH
2729: af 03        CMP     A,#03H
272b: 81 d4        BZ      $2701H
272d: af 04        CMP     A,#04H
272f: 81 d0        BZ      $2701H
2731: 56           RET
2732: 64 c0 df     MOVW    DE,#0DFC0H
2735: 5c           MOV     A,[DE]
2736: b8 00        MOV     X,#00H
2738: d8           XCH     A,X
2739: 3c           PUSH    AX
273a: 60 ff 00     MOVW    AX,#00FFH
273d: 3c           PUSH    AX
273e: 28 18 7b     CALL    !7B18H
2741: 34           POP     AX
2742: 34           POP     AX
2743: 60 be df     MOVW    AX,#0DFBEH
2746: 3c           PUSH    AX
2747: 60 ff 00     MOVW    AX,#00FFH
274a: 3c           PUSH    AX
274b: 28 18 7b     CALL    !7B18H
274e: 34           POP     AX
274f: 34           POP     AX
2750: 64 d7 df     MOVW    DE,#0DFD7H
2753: 05 e2        MOVW    AX,[DE]
2755: 24 28        MOVW    BC,AX
2757: 1c 90        MOVW    AX,0FE90H
2759: 8f 0a        CMPW    AX,BC
275b: 81 0c        BZ      $2769H
275d: 60 d7 df     MOVW    AX,#0DFD7H
2760: 3c           PUSH    AX
2761: 1c 90        MOVW    AX,0FE90H
2763: 3c           PUSH    AX
2764: 28 63 7b     CALL    !7B63H
2767: 34           POP     AX
2768: 34           POP     AX
2769: 5e           BRK
276a: 56           RET
276b: 3f           PUSH    HL
276c: 11 fc        MOVW    AX,SP
276e: 2e 04 00     SUBW    AX,#0004H
2771: 24 68        MOVW    HL,AX
2773: 13 fc        MOVW    SP,AX
2775: b9 00        MOV     A,#00H
2777: 06 a0 03     MOV     [HL+03H],A
277a: 1c 90        MOVW    AX,0FE90H
277c: 30 e0        SHRW    AX,4
277e: d0           MOV     A,X
277f: 06 a0 01     MOV     [HL+01H],A
2782: 09 f0 98 fd  MOV     A,!0FD98H
2786: 30 a1        SHR     A,4
2788: ac 01        AND     A,#01H
278a: b8 00        MOV     X,#00H
278c: d8           XCH     A,X
278d: 2f 01 00     CMPW    AX,#0001H
2790: 80 05        BNZ     $2797H
2792: 28 17 7e     CALL    !7E17H
2795: 14 03        BR      $279AH
2797: 28 54 7e     CALL    !7E54H
279a: 1c 90        MOVW    AX,0FE90H
279c: 30 e0        SHRW    AX,4
279e: d0           MOV     A,X
279f: 06 2f 01     CMP     A,[HL+01H]
27a2: 80 03        BNZ     $27A7H
27a4: 2c 8a 28     BR      !288AH
27a7: 09 f0 98 fd  MOV     A,!0FD98H
27ab: 30 a1        SHR     A,4
27ad: ac 01        AND     A,#01H
27af: b8 00        MOV     X,#00H
27b1: d8           XCH     A,X
27b2: 2f 01 00     CMPW    AX,#0001H
27b5: 80 33        BNZ     $27EAH
27b7: 09 f0 98 fd  MOV     A,!0FD98H
27bb: ac 0f        AND     A,#0FH
27bd: b8 00        MOV     X,#00H
27bf: d8           XCH     A,X
27c0: 44           INCW    AX
27c1: 24 28        MOVW    BC,AX
27c3: 09 f0 98 fd  MOV     A,!0FD98H
27c7: ac f0        AND     A,#0F0H
27c9: 8e 12        OR      A,C
27cb: 09 f1 98 fd  MOV     !0FD98H,A
27cf: ac 0f        AND     A,#0FH
27d1: b8 00        MOV     X,#00H
27d3: d8           XCH     A,X
27d4: b9 00        MOV     A,#00H
27d6: ba 0a        MOV     C,#0AH
27d8: 05 1a        DIVUW   C
27da: bb 00        MOV     B,#00H
27dc: 09 f0 98 fd  MOV     A,!0FD98H
27e0: ac f0        AND     A,#0F0H
27e2: 8e 12        OR      A,C
27e4: 09 f1 98 fd  MOV     !0FD98H,A
27e8: 14 3e        BR      $2828H
27ea: 09 f0 98 fd  MOV     A,!0FD98H
27ee: ac 0f        AND     A,#0FH
27f0: b8 00        MOV     X,#00H
27f2: d8           XCH     A,X
27f3: 2f 00 00     CMPW    AX,#0000H
27f6: 80 05        BNZ     $27FDH
27f8: 60 09 00     MOVW    AX,#0009H
27fb: 14 1d        BR      $281AH
27fd: 09 f0 98 fd  MOV     A,!0FD98H
2801: ac 0f        AND     A,#0FH
2803: b8 00        MOV     X,#00H
2805: d8           XCH     A,X
2806: 4c           DECW    AX
2807: 24 28        MOVW    BC,AX
2809: 09 f0 98 fd  MOV     A,!0FD98H
280d: ac f0        AND     A,#0F0H
280f: 8e 12        OR      A,C
2811: 09 f1 98 fd  MOV     !0FD98H,A
2815: ac 0f        AND     A,#0FH
2817: b8 00        MOV     X,#00H
2819: d8           XCH     A,X
281a: 24 28        MOVW    BC,AX
281c: 09 f0 98 fd  MOV     A,!0FD98H
2820: ac f0        AND     A,#0F0H
2822: 8e 12        OR      A,C
2824: 09 f1 98 fd  MOV     !0FD98H,A
2828: 09 f0 98 fd  MOV     A,!0FD98H
282c: ac 0f        AND     A,#0FH
282e: b8 00        MOV     X,#00H
2830: d8           XCH     A,X
2831: 2d 99 fd     ADDW    AX,#0FD99H
2834: 24 48        MOVW    DE,AX
2836: 5c           MOV     A,[DE]
2837: af aa        CMP     A,#0AAH
2839: 80 03        BNZ     $283EH
283b: 2c a7 27     BR      !27A7H
283e: 09 f0 98 fd  MOV     A,!0FD98H
2842: ac 0f        AND     A,#0FH
2844: b8 00        MOV     X,#00H
2846: d8           XCH     A,X
2847: 2d 99 fd     ADDW    AX,#0FD99H
284a: 24 48        MOVW    DE,AX
284c: 5c           MOV     A,[DE]
284d: 06 a0 01     MOV     [HL+01H],A
2850: 09 f0 98 fd  MOV     A,!0FD98H
2854: 30 a1        SHR     A,4
2856: ac 01        AND     A,#01H
2858: b8 00        MOV     X,#00H
285a: d8           XCH     A,X
285b: 2f 01 00     CMPW    AX,#0001H
285e: 80 13        BNZ     $2873H
2860: 06 20 01     MOV     A,[HL+01H]
2863: b8 00        MOV     X,#00H
2865: d8           XCH     A,X
2866: 31 e0        SHLW    AX,4
2868: 3c           PUSH    AX
2869: 28 d2 82     CALL    !82D2H
286c: 34           POP     AX
286d: 24 0a        MOVW    AX,BC
286f: 1a 90        MOVW    0FE90H,AX
2871: 14 15        BR      $2888H
2873: 06 20 01     MOV     A,[HL+01H]
2876: b8 00        MOV     X,#00H
2878: d8           XCH     A,X
2879: 31 e0        SHLW    AX,4
287b: d8           XCH     A,X
287c: ae 09        OR      A,#09H
287e: d8           XCH     A,X
287f: 3c           PUSH    AX
2880: 28 b0 82     CALL    !82B0H
2883: 34           POP     AX
2884: 24 0a        MOVW    AX,BC
2886: 1a 90        MOVW    0FE90H,AX
2888: 14 05        BR      $288FH
288a: 62 01 00     MOVW    BC,#0001H
288d: 14 11        BR      $28A0H
288f: 06 20 03     MOV     A,[HL+03H]
2892: c1           INC     A
2893: 06 a0 03     MOV     [HL+03H],A
2896: af b8        CMP     A,#0B8H
2898: 82 03        BNC     $289DH
289a: 2c 82 27     BR      !2782H
289d: 62 00 00     MOVW    BC,#0000H
28a0: 34           POP     AX
28a1: 34           POP     AX
28a2: 37           POP     HL
28a3: 56           RET
28a4: 1c ac        MOVW    AX,0FEACH
28a6: 3c           PUSH    AX
28a7: 3a ad ff     MOV     0FEADH,#0FFH
28aa: 3a ac 00     MOV     0FEACH,#00H
28ad: 6f ac 0a     CMP     0FEACH,#0AH
28b0: 82 4b        BNC     $28FDH
28b2: 20 ac        MOV     A,0FEACH
28b4: b8 00        MOV     X,#00H
28b6: d8           XCH     A,X
28b7: 2d 99 fd     ADDW    AX,#0FD99H
28ba: 24 48        MOVW    DE,AX
28bc: 5c           MOV     A,[DE]
28bd: af aa        CMP     A,#0AAH
28bf: 81 38        BZ      $28F9H
28c1: 6f ad ff     CMP     0FEADH,#0FFH
28c4: 80 03        BNZ     $28C9H
28c6: 38 ac ad     MOV     0FEADH,0FEACH
28c9: 20 ac        MOV     A,0FEACH
28cb: b8 00        MOV     X,#00H
28cd: d8           XCH     A,X
28ce: 2d 99 fd     ADDW    AX,#0FD99H
28d1: 24 48        MOVW    DE,AX
28d3: 1c 90        MOVW    AX,0FE90H
28d5: 30 e0        SHRW    AX,4
28d7: 24 28        MOVW    BC,AX
28d9: 5c           MOV     A,[DE]
28da: b8 00        MOV     X,#00H
28dc: d8           XCH     A,X
28dd: 8f 0a        CMPW    AX,BC
28df: 80 18        BNZ     $28F9H
28e1: 20 ac        MOV     A,0FEACH
28e3: bb 00        MOV     B,#00H
28e5: da           XCH     A,C
28e6: 09 f0 98 fd  MOV     A,!0FD98H
28ea: ac f0        AND     A,#0F0H
28ec: 8e 12        OR      A,C
28ee: 09 f1 98 fd  MOV     !0FD98H,A
28f2: 20 ac        MOV     A,0FEACH
28f4: bb 00        MOV     B,#00H
28f6: da           XCH     A,C
28f7: 14 49        BR      $2942H
28f9: 26 ac        INC     0FEACH
28fb: 14 b0        BR      $28ADH
28fd: 6f ad ff     CMP     0FEADH,#0FFH
2900: 81 3b        BZ      $293DH
2902: 20 ad        MOV     A,0FEADH
2904: bb 00        MOV     B,#00H
2906: da           XCH     A,C
2907: 09 f0 98 fd  MOV     A,!0FD98H
290b: ac f0        AND     A,#0F0H
290d: 8e 12        OR      A,C
290f: 09 f1 98 fd  MOV     !0FD98H,A
2913: 20 ad        MOV     A,0FEADH
2915: b8 00        MOV     X,#00H
2917: d8           XCH     A,X
2918: 2d 99 fd     ADDW    AX,#0FD99H
291b: 24 48        MOVW    DE,AX
291d: 5c           MOV     A,[DE]
291e: 31 a1        SHL     A,4
2920: b8 00        MOV     X,#00H
2922: d8           XCH     A,X
2923: 1a 90        MOVW    0FE90H,AX
2925: 09 f0 98 fd  MOV     A,!0FD98H
2929: 30 a1        SHR     A,4
292b: ac 01        AND     A,#01H
292d: b8 00        MOV     X,#00H
292f: d8           XCH     A,X
2930: 2f 01 00     CMPW    AX,#0001H
2933: 81 08        BZ      $293DH
2935: 1c 90        MOVW    AX,0FE90H
2937: d8           XCH     A,X
2938: ae 09        OR      A,#09H
293a: d8           XCH     A,X
293b: 1a 90        MOVW    0FE90H,AX
293d: 20 ad        MOV     A,0FEADH
293f: bb 00        MOV     B,#00H
2941: da           XCH     A,C
2942: 34           POP     AX
2943: 1a ac        MOVW    0FEACH,AX
2945: 56           RET
2946: 3f           PUSH    HL
2947: 11 fc        MOVW    AX,SP
2949: 2e 04 00     SUBW    AX,#0004H
294c: 24 68        MOVW    HL,AX
294e: 13 fc        MOVW    SP,AX
2950: 1c 90        MOVW    AX,0FE90H
2952: 06 a0 03     MOV     [HL+03H],A
2955: d8           XCH     A,X
2956: 06 a0 02     MOV     [HL+02H],A
2959: b6 65        SET1    0FE65H.6
295b: b9 00        MOV     A,#00H
295d: 06 a0 01     MOV     [HL+01H],A
2960: 06 20 01     MOV     A,[HL+01H]
2963: af 0a        CMP     A,#0AH
2965: 82 5b        BNC     $29C2H
2967: 06 20 01     MOV     A,[HL+01H]
296a: b8 00        MOV     X,#00H
296c: d8           XCH     A,X
296d: 2d 99 fd     ADDW    AX,#0FD99H
2970: 24 48        MOVW    DE,AX
2972: 5c           MOV     A,[DE]
2973: af aa        CMP     A,#0AAH
2975: 81 42        BZ      $29B9H
2977: b9 00        MOV     A,#00H
2979: 55           MOV     [HL],A
297a: 5d           MOV     A,[HL]
297b: af 0a        CMP     A,#0AH
297d: 82 3a        BNC     $29B9H
297f: 06 20 01     MOV     A,[HL+01H]
2982: b8 00        MOV     X,#00H
2984: d8           XCH     A,X
2985: 2d 99 fd     ADDW    AX,#0FD99H
2988: 24 48        MOVW    DE,AX
298a: 5c           MOV     A,[DE]
298b: b8 00        MOV     X,#00H
298d: d8           XCH     A,X
298e: 31 e0        SHLW    AX,4
2990: 24 28        MOVW    BC,AX
2992: 5d           MOV     A,[HL]
2993: b8 00        MOV     X,#00H
2995: d8           XCH     A,X
2996: 88 0a        ADDW    AX,BC
2998: 1a 90        MOVW    0FE90H,AX
299a: 28 86 7f     CALL    !7F86H
299d: 24 0a        MOVW    AX,BC
299f: 2f 01 00     CMPW    AX,#0001H
29a2: 80 10        BNZ     $29B4H
29a4: 06 20 02     MOV     A,[HL+02H]
29a7: d8           XCH     A,X
29a8: 06 20 03     MOV     A,[HL+03H]
29ab: 1a 90        MOVW    0FE90H,AX
29ad: a6 65        CLR1    0FE65H.6
29af: 62 00 00     MOVW    BC,#0000H
29b2: 14 1c        BR      $29D0H
29b4: 5d           MOV     A,[HL]
29b5: c1           INC     A
29b6: 55           MOV     [HL],A
29b7: 14 c1        BR      $297AH
29b9: 06 20 01     MOV     A,[HL+01H]
29bc: c1           INC     A
29bd: 06 a0 01     MOV     [HL+01H],A
29c0: 14 9e        BR      $2960H
29c2: 06 20 02     MOV     A,[HL+02H]
29c5: d8           XCH     A,X
29c6: 06 20 03     MOV     A,[HL+03H]
29c9: 1a 90        MOVW    0FE90H,AX
29cb: a6 65        CLR1    0FE65H.6
29cd: 62 01 00     MOVW    BC,#0001H
29d0: 34           POP     AX
29d1: 34           POP     AX
29d2: 37           POP     HL
29d3: 56           RET
29d4: 3f           PUSH    HL
29d5: 05 c9        DECW    SP
29d7: 05 c9        DECW    SP
29d9: 11 fc        MOVW    AX,SP
29db: 24 68        MOVW    HL,AX
29dd: b9 00        MOV     A,#00H
29df: 06 a0 01     MOV     [HL+01H],A
29e2: 2c 51 2b     BR      !2B51H
29e5: 72 73 03     BT      0FE73H.2,$29EBH
29e8: 2c c0 2a     BR      !2AC0H
29eb: 73 73 11     BT      0FE73H.3,$29FFH
29ee: 1c 63        MOVW    AX,0FE63H
29f0: 24 08        MOVW    AX,AX
29f2: 44           INCW    AX
29f3: 3c           PUSH    AX
29f4: 64 02 fd     MOVW    DE,#0FD02H
29f7: 3e           PUSH    DE
29f8: 28 7b 2b     CALL    !2B7BH
29fb: 34           POP     AX
29fc: 34           POP     AX
29fd: 14 0f        BR      $2A0EH
29ff: 1c 63        MOVW    AX,0FE63H
2a01: 24 08        MOVW    AX,AX
2a03: 44           INCW    AX
2a04: 3c           PUSH    AX
2a05: 64 06 fd     MOVW    DE,#0FD06H
2a08: 3e           PUSH    DE
2a09: 28 7b 2b     CALL    !2B7BH
2a0c: 34           POP     AX
2a0d: 34           POP     AX
2a0e: 09 f0 98 fd  MOV     A,!0FD98H
2a12: 30 a1        SHR     A,4
2a14: ac 01        AND     A,#01H
2a16: b8 00        MOV     X,#00H
2a18: d8           XCH     A,X
2a19: 2f 01 00     CMPW    AX,#0001H
2a1c: 80 52        BNZ     $2A70H
2a1e: 64 06 fd     MOVW    DE,#0FD06H
2a21: 58           MOV     A,[DE+]
2a22: d8           XCH     A,X
2a23: 58           MOV     A,[DE+]
2a24: 1a a4        MOVW    0FEA4H,AX
2a26: 05 e2        MOVW    AX,[DE]
2a28: 1a a6        MOVW    0FEA6H,AX
2a2a: 64 02 fd     MOVW    DE,#0FD02H
2a2d: 58           MOV     A,[DE+]
2a2e: d8           XCH     A,X
2a2f: 58           MOV     A,[DE+]
2a30: 1a a8        MOVW    0FEA8H,AX
2a32: 05 e2        MOVW    AX,[DE]
2a34: 1a aa        MOVW    0FEAAH,AX
2a36: 28 ea ab     CALL    Compare_32Bits
2a39: 82 0e        BNC     $2A49H
2a3b: 64 08 fd     MOVW    DE,#0FD08H
2a3e: 05 e2        MOVW    AX,[DE]
2a40: 24 28        MOVW    BC,AX
2a42: 64 06 fd     MOVW    DE,#0FD06H
2a45: 05 e2        MOVW    AX,[DE]
2a47: 14 0c        BR      $2A55H
2a49: 64 04 fd     MOVW    DE,#0FD04H
2a4c: 05 e2        MOVW    AX,[DE]
2a4e: 24 28        MOVW    BC,AX
2a50: 64 02 fd     MOVW    DE,#0FD02H
2a53: 05 e2        MOVW    AX,[DE]
2a55: 3c           PUSH    AX
2a56: 3d           PUSH    BC
2a57: 1c 63        MOVW    AX,0FE63H
2a59: 24 48        MOVW    DE,AX
2a5b: 35           POP     BC
2a5c: 34           POP     AX
2a5d: 06 80 02     MOV     [DE+02H],A
2a60: d8           XCH     A,X
2a61: 06 80 01     MOV     [DE+01H],A
2a64: 25 02        XCH     X,C
2a66: db           XCH     A,B
2a67: 06 80 04     MOV     [DE+04H],A
2a6a: d8           XCH     A,X
2a6b: 06 80 03     MOV     [DE+03H],A
2a6e: 14 50        BR      $2AC0H
2a70: 64 02 fd     MOVW    DE,#0FD02H
2a73: 58           MOV     A,[DE+]
2a74: d8           XCH     A,X
2a75: 58           MOV     A,[DE+]
2a76: 1a a4        MOVW    0FEA4H,AX
2a78: 05 e2        MOVW    AX,[DE]
2a7a: 1a a6        MOVW    0FEA6H,AX
2a7c: 64 06 fd     MOVW    DE,#0FD06H
2a7f: 58           MOV     A,[DE+]
2a80: d8           XCH     A,X
2a81: 58           MOV     A,[DE+]
2a82: 1a a8        MOVW    0FEA8H,AX
2a84: 05 e2        MOVW    AX,[DE]
2a86: 1a aa        MOVW    0FEAAH,AX
2a88: 28 ea ab     CALL    Compare_32Bits
2a8b: 82 0e        BNC     $2A9BH
2a8d: 64 08 fd     MOVW    DE,#0FD08H
2a90: 05 e2        MOVW    AX,[DE]
2a92: 24 28        MOVW    BC,AX
2a94: 64 06 fd     MOVW    DE,#0FD06H
2a97: 05 e2        MOVW    AX,[DE]
2a99: 14 0c        BR      $2AA7H
2a9b: 64 04 fd     MOVW    DE,#0FD04H
2a9e: 05 e2        MOVW    AX,[DE]
2aa0: 24 28        MOVW    BC,AX
2aa2: 64 02 fd     MOVW    DE,#0FD02H
2aa5: 05 e2        MOVW    AX,[DE]
2aa7: 3c           PUSH    AX
2aa8: 3d           PUSH    BC
2aa9: 1c 63        MOVW    AX,0FE63H
2aab: 24 48        MOVW    DE,AX
2aad: 35           POP     BC
2aae: 34           POP     AX
2aaf: 06 80 02     MOV     [DE+02H],A
2ab2: d8           XCH     A,X
2ab3: 06 80 01     MOV     [DE+01H],A
2ab6: 25 02        XCH     X,C
2ab8: db           XCH     A,B
2ab9: 06 80 04     MOV     [DE+04H],A
2abc: d8           XCH     A,X
2abd: 06 80 03     MOV     [DE+03H],A
2ac0: 28 50 91     CALL    !9150H
2ac3: 1c 63        MOVW    AX,0FE63H
2ac5: 24 48        MOVW    DE,AX
2ac7: 06 00 05     MOV     A,[DE+05H]
2aca: ac cf        AND     A,#0CFH
2acc: ae 20        OR      A,#20H
2ace: 06 80 05     MOV     [DE+05H],A
2ad1: a5 65        CLR1    0FE65H.5
2ad3: a2 73        CLR1    0FE73H.2
2ad5: 09 f0 a6 fd  MOV     A,!0FDA6H
2ad9: af 50        CMP     A,#50H
2adb: 83 07        BC      $2AE4H
2add: 81 05        BZ      $2AE4H
2adf: 60 01 00     MOVW    AX,#0001H
2ae2: 14 02        BR      $2AE6H
2ae4: 8a 08        SUBW    AX,AX
2ae6: 24 28        MOVW    BC,AX
2ae8: 09 f0 98 fd  MOV     A,!0FD98H
2aec: 30 8a        SHR     C,1
2aee: 03 1e        MOV1    A.6,CY
2af0: 09 f1 98 fd  MOV     !0FD98H,A
2af4: 14 70        BR      $2B66H
2af6: 1c 90        MOVW    AX,0FE90H
2af8: 2f ab 0b     CMPW    AX,#0BABH
2afb: 80 02        BNZ     $2AFFH
2afd: 14 4b        BR      $2B4AH
2aff: b5 65        SET1    0FE65H.5
2b01: 14 63        BR      $2B66H
2b03: 1c 90        MOVW    AX,0FE90H
2b05: 2f ab 0b     CMPW    AX,#0BABH
2b08: 80 02        BNZ     $2B0CH
2b0a: 14 3e        BR      $2B4AH
2b0c: 28 a4 28     CALL    !28A4H
2b0f: 24 0a        MOVW    AX,BC
2b11: 2f ff 00     CMPW    AX,#00FFH
2b14: 80 02        BNZ     $2B18H
2b16: 14 32        BR      $2B4AH
2b18: 28 46 29     CALL    !2946H
2b1b: 24 0a        MOVW    AX,BC
2b1d: 2f 01 00     CMPW    AX,#0001H
2b20: 80 02        BNZ     $2B24H
2b22: 14 26        BR      $2B4AH
2b24: 1c 90        MOVW    AX,0FE90H
2b26: 64 1e fd     MOVW    DE,#0FD1EH
2b29: 05 e6        MOVW    [DE],AX
2b2b: 28 6b 27     CALL    !276BH
2b2e: 24 0a        MOVW    AX,BC
2b30: 2f 01 00     CMPW    AX,#0001H
2b33: 80 0e        BNZ     $2B43H
2b35: b5 65        SET1    0FE65H.5
2b37: 64 1e fd     MOVW    DE,#0FD1EH
2b3a: 05 e2        MOVW    AX,[DE]
2b3c: 1a 90        MOVW    0FE90H,AX
2b3e: 28 43 7d     CALL    !7D43H
2b41: 14 0c        BR      $2B4FH
2b43: 64 1e fd     MOVW    DE,#0FD1EH
2b46: 05 e2        MOVW    AX,[DE]
2b48: 1a 90        MOVW    0FE90H,AX
2b4a: 62 00 00     MOVW    BC,#0000H
2b4d: 14 29        BR      $2B78H
2b4f: 14 15        BR      $2B66H
2b51: 09 f0 97 fd  MOV     A,!0FD97H
2b55: ac 0e        AND     A,#0EH
2b57: af 04        CMP     A,#04H
2b59: 81 a8        BZ      $2B03H
2b5b: af 02        CMP     A,#02H
2b5d: 81 97        BZ      $2AF6H
2b5f: af 08        CMP     A,#08H
2b61: 80 03        BNZ     $2B66H
2b63: 2c e5 29     BR      !29E5H
2b66: 3a 82 00     MOV     0FE82H,#00H
2b69: 09 f0 98 fd  MOV     A,!0FD98H
2b6d: 03 9d        CLR1    A.5
2b6f: 09 f1 98 fd  MOV     !0FD98H,A
2b73: b6 65        SET1    0FE65H.6
2b75: 62 01 00     MOVW    BC,#0001H
2b78: 34           POP     AX
2b79: 37           POP     HL
2b7a: 56           RET
2b7b: 3f           PUSH    HL
2b7c: 11 fc        MOVW    AX,SP
2b7e: 24 68        MOVW    HL,AX
2b80: 06 20 04     MOV     A,[HL+04H]
2b83: d8           XCH     A,X
2b84: 06 20 05     MOV     A,[HL+05H]
2b87: 24 08        MOVW    AX,AX
2b89: 2d 03 00     ADDW    AX,#0003H
2b8c: 24 48        MOVW    DE,AX
2b8e: 5c           MOV     A,[DE]
2b8f: 22 6d        MOV     0FE6DH,A
2b91: 06 20 04     MOV     A,[HL+04H]
2b94: d8           XCH     A,X
2b95: 06 20 05     MOV     A,[HL+05H]
2b98: 24 08        MOVW    AX,AX
2b9a: 44           INCW    AX
2b9b: 44           INCW    AX
2b9c: 24 48        MOVW    DE,AX
2b9e: 5c           MOV     A,[DE]
2b9f: 22 6c        MOV     0FE6CH,A
2ba1: 06 20 04     MOV     A,[HL+04H]
2ba4: d8           XCH     A,X
2ba5: 06 20 05     MOV     A,[HL+05H]
2ba8: 24 08        MOVW    AX,AX
2baa: 44           INCW    AX
2bab: 24 48        MOVW    DE,AX
2bad: 5c           MOV     A,[DE]
2bae: 22 6b        MOV     0FE6BH,A
2bb0: 06 20 04     MOV     A,[HL+04H]
2bb3: d8           XCH     A,X
2bb4: 06 20 05     MOV     A,[HL+05H]
2bb7: 24 48        MOVW    DE,AX
2bb9: 5c           MOV     A,[DE]
2bba: 22 6a        MOV     0FE6AH,A
2bbc: 06 20 06     MOV     A,[HL+06H]
2bbf: d8           XCH     A,X
2bc0: 06 20 07     MOV     A,[HL+07H]
2bc3: 24 08        MOVW    AX,AX
2bc5: 2d 03 00     ADDW    AX,#0003H
2bc8: 24 48        MOVW    DE,AX
2bca: 5c           MOV     A,[DE]
2bcb: da           XCH     A,C
2bcc: 06 20 04     MOV     A,[HL+04H]
2bcf: d8           XCH     A,X
2bd0: 06 20 05     MOV     A,[HL+05H]
2bd3: 24 08        MOVW    AX,AX
2bd5: 2d 03 00     ADDW    AX,#0003H
2bd8: 24 48        MOVW    DE,AX
2bda: d2           MOV     A,C
2bdb: 54           MOV     [DE],A
2bdc: 06 20 06     MOV     A,[HL+06H]
2bdf: d8           XCH     A,X
2be0: 06 20 07     MOV     A,[HL+07H]
2be3: 24 08        MOVW    AX,AX
2be5: 44           INCW    AX
2be6: 44           INCW    AX
2be7: 24 48        MOVW    DE,AX
2be9: 5c           MOV     A,[DE]
2bea: da           XCH     A,C
2beb: 06 20 04     MOV     A,[HL+04H]
2bee: d8           XCH     A,X
2bef: 06 20 05     MOV     A,[HL+05H]
2bf2: 24 08        MOVW    AX,AX
2bf4: 44           INCW    AX
2bf5: 44           INCW    AX
2bf6: 24 48        MOVW    DE,AX
2bf8: d2           MOV     A,C
2bf9: 54           MOV     [DE],A
2bfa: 06 20 06     MOV     A,[HL+06H]
2bfd: d8           XCH     A,X
2bfe: 06 20 07     MOV     A,[HL+07H]
2c01: 24 08        MOVW    AX,AX
2c03: 44           INCW    AX
2c04: 24 48        MOVW    DE,AX
2c06: 5c           MOV     A,[DE]
2c07: da           XCH     A,C
2c08: 06 20 04     MOV     A,[HL+04H]
2c0b: d8           XCH     A,X
2c0c: 06 20 05     MOV     A,[HL+05H]
2c0f: 24 08        MOVW    AX,AX
2c11: 44           INCW    AX
2c12: 24 48        MOVW    DE,AX
2c14: d2           MOV     A,C
2c15: 54           MOV     [DE],A
2c16: 06 20 06     MOV     A,[HL+06H]
2c19: d8           XCH     A,X
2c1a: 06 20 07     MOV     A,[HL+07H]
2c1d: 24 48        MOVW    DE,AX
2c1f: 5c           MOV     A,[DE]
2c20: da           XCH     A,C
2c21: 06 20 04     MOV     A,[HL+04H]
2c24: d8           XCH     A,X
2c25: 06 20 05     MOV     A,[HL+05H]
2c28: 24 48        MOVW    DE,AX
2c2a: d2           MOV     A,C
2c2b: 54           MOV     [DE],A
2c2c: 06 20 06     MOV     A,[HL+06H]
2c2f: d8           XCH     A,X
2c30: 06 20 07     MOV     A,[HL+07H]
2c33: 24 08        MOVW    AX,AX
2c35: 2d 03 00     ADDW    AX,#0003H
2c38: 24 48        MOVW    DE,AX
2c3a: 20 6d        MOV     A,0FE6DH
2c3c: 54           MOV     [DE],A
2c3d: 06 20 06     MOV     A,[HL+06H]
2c40: d8           XCH     A,X
2c41: 06 20 07     MOV     A,[HL+07H]
2c44: 24 08        MOVW    AX,AX
2c46: 44           INCW    AX
2c47: 44           INCW    AX
2c48: 24 48        MOVW    DE,AX
2c4a: 20 6c        MOV     A,0FE6CH
2c4c: 54           MOV     [DE],A
2c4d: 06 20 06     MOV     A,[HL+06H]
2c50: d8           XCH     A,X
2c51: 06 20 07     MOV     A,[HL+07H]
2c54: 24 08        MOVW    AX,AX
2c56: 44           INCW    AX
2c57: 24 48        MOVW    DE,AX
2c59: 20 6b        MOV     A,0FE6BH
2c5b: 54           MOV     [DE],A
2c5c: 06 20 06     MOV     A,[HL+06H]
2c5f: d8           XCH     A,X
2c60: 06 20 07     MOV     A,[HL+07H]
2c63: 24 48        MOVW    DE,AX
2c65: 20 6a        MOV     A,0FE6AH
2c67: 54           MOV     [DE],A
2c68: 37           POP     HL
2c69: 56           RET
2c6a: 73 73 22     BT      0FE73H.3,$2C8FH
2c6d: 1c 63        MOVW    AX,0FE63H
2c6f: 24 08        MOVW    AX,AX
2c71: 44           INCW    AX
2c72: 3c           PUSH    AX
2c73: 64 02 fd     MOVW    DE,#0FD02H
2c76: 3e           PUSH    DE
2c77: 28 7b 2b     CALL    !2B7BH
2c7a: 34           POP     AX
2c7b: 34           POP     AX
2c7c: 64 06 fd     MOVW    DE,#0FD06H
2c7f: 3e           PUSH    DE
2c80: 1c 63        MOVW    AX,0FE63H
2c82: 24 08        MOVW    AX,AX
2c84: 44           INCW    AX
2c85: 3c           PUSH    AX
2c86: 28 7b 2b     CALL    !2B7BH
2c89: 34           POP     AX
2c8a: 34           POP     AX
2c8b: b3 73        SET1    0FE73H.3
2c8d: 14 20        BR      $2CAFH
2c8f: 1c 63        MOVW    AX,0FE63H
2c91: 24 08        MOVW    AX,AX
2c93: 44           INCW    AX
2c94: 3c           PUSH    AX
2c95: 64 06 fd     MOVW    DE,#0FD06H
2c98: 3e           PUSH    DE
2c99: 28 7b 2b     CALL    !2B7BH
2c9c: 34           POP     AX
2c9d: 34           POP     AX
2c9e: 64 02 fd     MOVW    DE,#0FD02H
2ca1: 3e           PUSH    DE
2ca2: 1c 63        MOVW    AX,0FE63H
2ca4: 24 08        MOVW    AX,AX
2ca6: 44           INCW    AX
2ca7: 3c           PUSH    AX
2ca8: 28 7b 2b     CALL    !2B7BH
2cab: 34           POP     AX
2cac: 34           POP     AX
2cad: a3 73        CLR1    0FE73H.3
2caf: 28 50 91     CALL    !9150H
2cb2: 56           RET
2cb3: 09 f0 a3 fd  MOV     A,!0FDA3H
2cb7: 22 6a        MOV     0FE6AH,A
2cb9: 09 f0 a4 fd  MOV     A,!0FDA4H
2cbd: 09 f1 a3 fd  MOV     !0FDA3H,A
2cc1: 20 6a        MOV     A,0FE6AH
2cc3: 09 f1 a4 fd  MOV     !0FDA4H,A
2cc7: 08 a6 65 2a  BF      0FE65H.6,$2CF5H
2ccb: 09 f0 a3 fd  MOV     A,!0FDA3H
2ccf: af 01        CMP     A,#01H
2cd1: 80 20        BNZ     $2CF3H
2cd3: 1c 63        MOVW    AX,0FE63H
2cd5: 24 48        MOVW    DE,AX
2cd7: 06 00 06     MOV     A,[DE+06H]
2cda: 30 99        SHR     A,3
2cdc: ac 07        AND     A,#07H
2cde: b8 00        MOV     X,#00H
2ce0: d8           XCH     A,X
2ce1: 2f 04 00     CMPW    AX,#0004H
2ce4: 82 05        BNC     $2CEBH
2ce6: 60 02 00     MOVW    AX,#0002H
2ce9: 14 03        BR      $2CEEH
2ceb: 60 03 00     MOVW    AX,#0003H
2cee: d0           MOV     A,X
2cef: 09 f1 a3 fd  MOV     !0FDA3H,A
2cf3: 14 3b        BR      $2D30H
2cf5: 09 f0 a3 fd  MOV     A,!0FDA3H
2cf9: af 04        CMP     A,#04H
2cfb: 80 33        BNZ     $2D30H
2cfd: 1c 63        MOVW    AX,0FE63H
2cff: 24 08        MOVW    AX,AX
2d01: 2d 05 00     ADDW    AX,#0005H
2d04: 24 48        MOVW    DE,AX
2d06: 5c           MOV     A,[DE]
2d07: 22 6a        MOV     0FE6AH,A
2d09: 1c 63        MOVW    AX,0FE63H
2d0b: 24 08        MOVW    AX,AX
2d0d: 2d 06 00     ADDW    AX,#0006H
2d10: 24 48        MOVW    DE,AX
2d12: 5c           MOV     A,[DE]
2d13: 22 6b        MOV     0FE6BH,A
2d15: 28 ec 94     CALL    !94ECH
2d18: 1c 63        MOVW    AX,0FE63H
2d1a: 24 08        MOVW    AX,AX
2d1c: 2d 05 00     ADDW    AX,#0005H
2d1f: 24 48        MOVW    DE,AX
2d21: 20 6a        MOV     A,0FE6AH
2d23: 54           MOV     [DE],A
2d24: 1c 63        MOVW    AX,0FE63H
2d26: 24 08        MOVW    AX,AX
2d28: 2d 06 00     ADDW    AX,#0006H
2d2b: 24 48        MOVW    DE,AX
2d2d: 20 6b        MOV     A,0FE6BH
2d2f: 54           MOV     [DE],A
2d30: 56           RET
2d31: 20 67        MOV     A,0FE67H
2d33: ac 3f        AND     A,#3FH
2d35: 80 05        BNZ     $2D3CH
2d37: 62 01 00     MOVW    BC,#0001H
2d3a: 14 03        BR      $2D3FH
2d3c: 62 00 00     MOVW    BC,#0000H
2d3f: 56           RET
2d40: 08 a0 67 07  BF      0FE67H.0,$2D4BH
2d44: 64 1e fd     MOVW    DE,#0FD1EH
2d47: 05 e2        MOVW    AX,[DE]
2d49: 1a 90        MOVW    0FE90H,AX
2d4b: 6c 67 c0     AND     0FE67H,#0C0H
2d4e: 3a 85 00     MOV     0FE85H,#00H
2d51: 09 f0 0d fd  MOV     A,!0FD0DH
2d55: ac f0        AND     A,#0F0H
2d57: ae 0f        OR      A,#0FH
2d59: 09 f1 0d fd  MOV     !0FD0DH,A
2d5d: 56           RET
2d5e: 08 70 72     NOT1    0FE72H.0
2d61: 08 a0 72 05  BF      0FE72H.0,$2D6AH
2d65: 60 f1 00     MOVW    AX,#00F1H
2d68: 14 03        BR      $2D6DH
2d6a: 60 c9 00     MOVW    AX,#00C9H
2d6d: d0           MOV     A,X
2d6e: 12 88        MOV     ASIM,A
2d70: 56           RET
2d71: b2 65        SET1    0FE65H.2
2d73: b5 67        SET1    0FE67H.5
2d75: b2 68        SET1    0FE68H.2
2d77: b9 00        MOV     A,#00H
2d79: 09 f1 a9 fd  MOV     !0FDA9H,A
2d7d: 09 f0 0f fd  MOV     A,!0FD0FH
2d81: af ff        CMP     A,#0FFH
2d83: 80 20        BNZ     $2DA5H
2d85: b9 ff        MOV     A,#0FFH
2d87: 09 f1 b1 fd  MOV     !0FDB1H,A
2d8b: 09 f1 b0 fd  MOV     !0FDB0H,A
2d8f: 09 f1 af fd  MOV     !0FDAFH,A
2d93: 09 f1 ae fd  MOV     !0FDAEH,A
2d97: 09 f1 ad fd  MOV     !0FDADH,A
2d9b: 09 f1 ac fd  MOV     !0FDACH,A
2d9f: 09 f1 ab fd  MOV     !0FDABH,A
2da3: 14 38        BR      $2DDDH
2da5: 09 f0 0f fd  MOV     A,!0FD0FH
2da9: 09 f1 ab fd  MOV     !0FDABH,A
2dad: 09 f0 10 fd  MOV     A,!0FD10H
2db1: 09 f1 ac fd  MOV     !0FDACH,A
2db5: 09 f0 11 fd  MOV     A,!0FD11H
2db9: 09 f1 ad fd  MOV     !0FDADH,A
2dbd: 09 f0 12 fd  MOV     A,!0FD12H
2dc1: 09 f1 ae fd  MOV     !0FDAEH,A
2dc5: 09 f0 13 fd  MOV     A,!0FD13H
2dc9: 09 f1 af fd  MOV     !0FDAFH,A
2dcd: 09 f0 14 fd  MOV     A,!0FD14H
2dd1: 09 f1 b0 fd  MOV     !0FDB0H,A
2dd5: 09 f0 15 fd  MOV     A,!0FD15H
2dd9: 09 f1 b1 fd  MOV     !0FDB1H,A
2ddd: 56           RET
2dde: 3f           PUSH    HL
2ddf: 11 fc        MOVW    AX,SP
2de1: 2e 32 00     SUBW    AX,#0032H
2de4: 24 68        MOVW    HL,AX
2de6: 13 fc        MOVW    SP,AX
2de8: b9 00        MOV     A,#00H
2dea: 06 a0 09     MOV     [HL+09H],A
2ded: b9 00        MOV     A,#00H
2def: 06 a0 06     MOV     [HL+06H],A
2df2: b9 00        MOV     A,#00H
2df4: 06 a0 0d     MOV     [HL+0DH],A
2df7: 28 e9 4d     CALL    !4DE9H
2dfa: 1c 90        MOVW    AX,0FE90H
2dfc: 06 a0 01     MOV     [HL+01H],A
2dff: d8           XCH     A,X
2e00: 55           MOV     [HL],A
2e01: 28 02 47     CALL    !4702H
2e04: 24 0a        MOVW    AX,BC
2e06: 2f 0d 00     CMPW    AX,#000DH
2e09: 81 03        BZ      $2E0EH
2e0b: 2c 06 33     BR      Power_Pressed
2e0e: 28 f0 8c     CALL    !8CF0H
2e11: 8a 08        SUBW    AX,AX
2e13: 8f 0a        CMPW    AX,BC
2e15: 80 03        BNZ     $2E1AH
2e17: 2c 06 33     BR      Power_Pressed
2e1a: 09 f0 30 fd  MOV     A,!0FD30H
2e1e: 03 8c        SET1    A.4
2e20: 09 f1 30 fd  MOV     !0FD30H,A
2e24: 71 a1 05     BT      0FEA1H.1,$2E2CH
2e27: 28 20 58     CALL    !5820H
2e2a: b1 a1        SET1    0FEA1H.1
2e2c: 11 e4        MOVW    AX,MK0
2e2e: ae 02        OR      A,#02H
2e30: d8           XCH     A,X
2e31: ae 05        OR      A,#05H
2e33: d8           XCH     A,X
2e34: 13 e4        MOVW    MK0,AX
2e36: 60 0a 10     MOVW    AX,#100AH
2e39: 3c           PUSH    AX
2e3a: 28 79 46     CALL    !4679H
2e3d: 34           POP     AX
2e3e: 28 40 6d     CALL    !6D40H
2e41: 09 f0 90 fe  MOV     A,!0FE90H
2e45: d8           XCH     A,X
2e46: 09 f0 91 fe  MOV     A,!0FE91H
2e4a: 3c           PUSH    AX
2e4b: 28 e8 7d     CALL    !7DE8H
2e4e: 34           POP     AX
2e4f: 20 6a        MOV     A,0FE6AH
2e51: ac 1f        AND     A,#1FH
2e53: 06 a0 30     MOV     [HL+30H],A
2e56: 06 a0 31     MOV     [HL+31H],A
2e59: 09 f0 94 fd  MOV     A,!0FD94H
2e5d: d8           XCH     A,X
2e5e: 09 f0 93 fd  MOV     A,!0FD93H
2e62: 8f 10        CMP     A,X
2e64: 80 0a        BNZ     $2E70H
2e66: 72 03 03     BT      P3.2,$2E6CH        ; if power switch NOT pressed, branch
2e69: 2c 06 33     BR      Power_Pressed
2e6c: a4 03        CLR1    P3.4
2e6e: 14 e9        BR      $2E59H
2e70: 28 02 47     CALL    !4702H
2e73: d2           MOV     A,C
2e74: 06 a0 2f     MOV     [HL+2FH],A
2e77: 2b 8e 2a     MOV     TXS,#2AH
2e7a: 06 20 06     MOV     A,[HL+06H]
2e7d: af 00        CMP     A,#00H
2e7f: 81 03        BZ      $2E84H
2e81: 2c 24 2f     BR      !2F24H
2e84: 06 20 2f     MOV     A,[HL+2FH]
2e87: af 7f        CMP     A,#7FH
2e89: 81 03        BZ      $2E8EH
2e8b: 2c 24 2f     BR      !2F24H
2e8e: b9 01        MOV     A,#01H
2e90: 06 a0 0d     MOV     [HL+0DH],A
2e93: 06 20 09     MOV     A,[HL+09H]
2e96: af 12        CMP     A,#12H
2e98: 83 03        BC      $2E9DH
2e9a: 2c 1c 2f     BR      !2F1CH
2e9d: 06 20 30     MOV     A,[HL+30H]
2ea0: c1           INC     A
2ea1: 06 a0 30     MOV     [HL+30H],A
2ea4: c9           DEC     A
2ea5: b8 00        MOV     X,#00H
2ea7: d8           XCH     A,X
2ea8: 88 0e        ADDW    AX,HL
2eaa: 2d 0e 00     ADDW    AX,#000EH
2ead: 24 48        MOVW    DE,AX
2eaf: b9 ff        MOV     A,#0FFH
2eb1: 54           MOV     [DE],A
2eb2: b9 1f        MOV     A,#1FH
2eb4: 06 2f 30     CMP     A,[HL+30H]
2eb7: 82 59        BNC     $2F12H
2eb9: b4 03        SET1    P3.4
2ebb: 60 50 00     MOVW    AX,#0050H
2ebe: 3c           PUSH    AX
2ebf: 28 43 8b     CALL    !8B43H
2ec2: 34           POP     AX
2ec3: 4a           DI
2ec4: 28 ce 7a     CALL    Query_DFBE
2ec7: 64 55 d5     MOVW    DE,#0D555H
2eca: b9 aa        MOV     A,#0AAH
2ecc: 54           MOV     [DE],A
2ecd: 64 aa ca     MOVW    DE,#0CAAAH
2ed0: b9 55        MOV     A,#55H
2ed2: 54           MOV     [DE],A
2ed3: 64 55 d5     MOVW    DE,#0D555H
2ed6: b9 a0        MOV     A,#0A0H
2ed8: 54           MOV     [DE],A
2ed9: 06 20 31     MOV     A,[HL+31H]
2edc: 06 a0 2e     MOV     [HL+2EH],A
2edf: 06 20 2e     MOV     A,[HL+2EH]
2ee2: 06 2f 30     CMP     A,[HL+30H]
2ee5: 82 22        BNC     $2F09H
2ee7: 06 20 2e     MOV     A,[HL+2EH]
2eea: b8 00        MOV     X,#00H
2eec: d8           XCH     A,X
2eed: 88 0e        ADDW    AX,HL
2eef: 2d 0e 00     ADDW    AX,#000EH
2ef2: 24 48        MOVW    DE,AX
2ef4: 5c           MOV     A,[DE]
2ef5: da           XCH     A,C
2ef6: 1c 6a        MOVW    AX,0FE6AH
2ef8: 44           INCW    AX
2ef9: 1a 6a        MOVW    0FE6AH,AX
2efb: 4c           DECW    AX
2efc: 24 48        MOVW    DE,AX
2efe: d2           MOV     A,C
2eff: 54           MOV     [DE],A
2f00: 06 20 2e     MOV     A,[HL+2EH]
2f03: c1           INC     A
2f04: 06 a0 2e     MOV     [HL+2EH],A
2f07: 14 d6        BR      $2EDFH
2f09: 4b           EI
2f0a: b9 00        MOV     A,#00H
2f0c: 06 a0 30     MOV     [HL+30H],A
2f0f: 06 a0 31     MOV     [HL+31H],A
2f12: 06 20 09     MOV     A,[HL+09H]
2f15: c1           INC     A
2f16: 06 a0 09     MOV     [HL+09H],A
2f19: 2c 93 2e     BR      !2E93H
2f1c: b9 00        MOV     A,#00H
2f1e: 06 a0 09     MOV     [HL+09H],A
2f21: 2c 9b 32     BR      !329BH
2f24: 06 20 06     MOV     A,[HL+06H]
2f27: af 01        CMP     A,#01H
2f29: 81 0a        BZ      $2F35H
2f2b: 06 20 2f     MOV     A,[HL+2FH]
2f2e: af 7d        CMP     A,#7DH
2f30: 80 03        BNZ     $2F35H
2f32: 2c 9b 32     BR      !329BH
2f35: b9 01        MOV     A,#01H
2f37: 06 a0 0d     MOV     [HL+0DH],A
2f3a: 2c 4b 31     BR      !314BH
2f3d: 06 20 2f     MOV     A,[HL+2FH]
2f40: ac 01        AND     A,#01H
2f42: 81 0a        BZ      $2F4EH
2f44: b9 01        MOV     A,#01H
2f46: 06 a0 06     MOV     [HL+06H],A
2f49: 2c 82 31     BR      !3182H
2f4c: 14 05        BR      $2F53H
2f4e: b9 00        MOV     A,#00H
2f50: 06 a0 06     MOV     [HL+06H],A
2f53: 06 20 06     MOV     A,[HL+06H]
2f56: af 01        CMP     A,#01H
2f58: 80 03        BNZ     $2F5DH
2f5a: 2c 82 31     BR      !3182H
2f5d: 06 20 2f     MOV     A,[HL+2FH]
2f60: ac 10        AND     A,#10H
2f62: 81 07        BZ      $2F6BH
2f64: b9 01        MOV     A,#01H
2f66: 06 a0 0a     MOV     [HL+0AH],A
2f69: 14 05        BR      $2F70H
2f6b: b9 00        MOV     A,#00H
2f6d: 06 a0 0a     MOV     [HL+0AH],A
2f70: 2c 82 31     BR      !3182H
2f73: 06 20 06     MOV     A,[HL+06H]
2f76: af 01        CMP     A,#01H
2f78: 80 03        BNZ     $2F7DH
2f7a: 2c 82 31     BR      !3182H
2f7d: 06 20 06     MOV     A,[HL+06H]
2f80: af 01        CMP     A,#01H
2f82: 80 03        BNZ     $2F87H
2f84: 2c 82 31     BR      !3182H
2f87: 06 20 06     MOV     A,[HL+06H]
2f8a: af 01        CMP     A,#01H
2f8c: 80 03        BNZ     $2F91H
2f8e: 2c 82 31     BR      !3182H
2f91: 06 20 06     MOV     A,[HL+06H]
2f94: af 01        CMP     A,#01H
2f96: 80 03        BNZ     $2F9BH
2f98: 2c 82 31     BR      !3182H
2f9b: 06 20 2f     MOV     A,[HL+2FH]
2f9e: b8 00        MOV     X,#00H
2fa0: d8           XCH     A,X
2fa1: 3c           PUSH    AX
2fa2: 28 74 9d     CALL    !9D74H
2fa5: 34           POP     AX
2fa6: 8a 08        SUBW    AX,AX
2fa8: 8f 0a        CMPW    AX,BC
2faa: 80 05        BNZ     $2FB1H
2fac: b9 99        MOV     A,#99H
2fae: 06 a0 2f     MOV     [HL+2FH],A
2fb1: 06 20 09     MOV     A,[HL+09H]
2fb4: c9           DEC     A
2fb5: b8 00        MOV     X,#00H
2fb7: d8           XCH     A,X
2fb8: 88 0e        ADDW    AX,HL
2fba: 2d 02 00     ADDW    AX,#0002H
2fbd: 24 48        MOVW    DE,AX
2fbf: 06 20 2f     MOV     A,[HL+2FH]
2fc2: 54           MOV     [DE],A
2fc3: 06 20 09     MOV     A,[HL+09H]
2fc6: af 04        CMP     A,#04H
2fc8: 80 36        BNZ     $3000H
2fca: 24 0e        MOVW    AX,HL
2fcc: 2d 02 00     ADDW    AX,#0002H
2fcf: 3c           PUSH    AX
2fd0: 28 65 8d     CALL    !8D65H
2fd3: 34           POP     AX
2fd4: d2           MOV     A,C
2fd5: 06 a0 0c     MOV     [HL+0CH],A
2fd8: ac 01        AND     A,#01H
2fda: 80 0c        BNZ     $2FE8H
2fdc: b9 01        MOV     A,#01H
2fde: 06 a0 2f     MOV     [HL+2FH],A
2fe1: b9 02        MOV     A,#02H
2fe3: 06 a0 0c     MOV     [HL+0CH],A
2fe6: 14 18        BR      $3000H
2fe8: 06 20 0a     MOV     A,[HL+0AH]
2feb: af 00        CMP     A,#00H
2fed: 80 11        BNZ     $3000H
2fef: b9 02        MOV     A,#02H
2ff1: 06 2f 0c     CMP     A,[HL+0CH]
2ff4: 82 0a        BNC     $3000H
2ff6: b9 01        MOV     A,#01H
2ff8: 06 a0 2f     MOV     [HL+2FH],A
2ffb: b9 02        MOV     A,#02H
2ffd: 06 a0 0c     MOV     [HL+0CH],A
3000: 2c 82 31     BR      !3182H
3003: 06 20 06     MOV     A,[HL+06H]
3006: af 01        CMP     A,#01H
3008: 80 03        BNZ     $300DH
300a: 2c 82 31     BR      !3182H
300d: 06 20 2f     MOV     A,[HL+2FH]
3010: ac 0c        AND     A,#0CH
3012: af 0c        CMP     A,#0CH
3014: 80 08        BNZ     $301EH
3016: b9 f7        MOV     A,#0F7H
3018: 06 2c 2f     AND     A,[HL+2FH]
301b: 06 a0 2f     MOV     [HL+2FH],A
301e: 06 20 2f     MOV     A,[HL+2FH]
3021: ac c0        AND     A,#0C0H
3023: af 80        CMP     A,#80H
3025: 80 08        BNZ     $302FH
3027: b9 3f        MOV     A,#3FH
3029: 06 2c 2f     AND     A,[HL+2FH]
302c: 06 a0 2f     MOV     [HL+2FH],A
302f: 06 20 2f     MOV     A,[HL+2FH]
3032: ac 30        AND     A,#30H
3034: af 10        CMP     A,#10H
3036: 80 08        BNZ     $3040H
3038: b9 cf        MOV     A,#0CFH
303a: 06 2c 2f     AND     A,[HL+2FH]
303d: 06 a0 2f     MOV     [HL+2FH],A
3040: 2c 82 31     BR      !3182H
3043: 06 20 06     MOV     A,[HL+06H]
3046: af 01        CMP     A,#01H
3048: 80 03        BNZ     $304DH
304a: 2c 82 31     BR      !3182H
304d: 06 20 2f     MOV     A,[HL+2FH]
3050: ac c0        AND     A,#0C0H
3052: 06 a0 0b     MOV     [HL+0BH],A
3055: b9 02        MOV     A,#02H
3057: 06 2f 0c     CMP     A,[HL+0CH]
305a: 82 38        BNC     $3094H
305c: 06 20 0b     MOV     A,[HL+0BH]
305f: af 40        CMP     A,#40H
3061: 81 0a        BZ      $306DH
3063: 06 20 2f     MOV     A,[HL+2FH]
3066: ac 3f        AND     A,#3FH
3068: ae 40        OR      A,#40H
306a: 06 a0 2f     MOV     [HL+2FH],A
306d: 14 16        BR      $3085H
306f: b9 08        MOV     A,#08H
3071: 06 2e 2f     OR      A,[HL+2FH]
3074: 06 a0 2f     MOV     [HL+2FH],A
3077: 14 19        BR      $3092H
3079: b9 f7        MOV     A,#0F7H
307b: 06 2c 2f     AND     A,[HL+2FH]
307e: 06 a0 2f     MOV     [HL+2FH],A
3081: 14 0f        BR      $3092H
3083: 14 0d        BR      $3092H
3085: 06 20 2f     MOV     A,[HL+2FH]
3088: ac 38        AND     A,#38H
308a: af 08        CMP     A,#08H
308c: 81 eb        BZ      $3079H
308e: af 00        CMP     A,#00H
3090: 81 dd        BZ      $306FH
3092: 14 0f        BR      $30A3H
3094: 06 20 0b     MOV     A,[HL+0BH]
3097: af 40        CMP     A,#40H
3099: 80 08        BNZ     $30A3H
309b: 06 20 2f     MOV     A,[HL+2FH]
309e: ac 3f        AND     A,#3FH
30a0: 06 a0 2f     MOV     [HL+2FH],A
30a3: 06 20 2f     MOV     A,[HL+2FH]
30a6: ac 30        AND     A,#30H
30a8: af 30        CMP     A,#30H
30aa: 80 08        BNZ     $30B4H
30ac: b9 ef        MOV     A,#0EFH
30ae: 06 2c 2f     AND     A,[HL+2FH]
30b1: 06 a0 2f     MOV     [HL+2FH],A
30b4: 06 20 2f     MOV     A,[HL+2FH]
30b7: ac 07        AND     A,#07H
30b9: b8 04        MOV     X,#04H
30bb: 8f 01        CMP     X,A
30bd: 82 08        BNC     $30C7H
30bf: b9 fb        MOV     A,#0FBH
30c1: 06 2c 2f     AND     A,[HL+2FH]
30c4: 06 a0 2f     MOV     [HL+2FH],A
30c7: 2c 82 31     BR      !3182H
30ca: 06 20 06     MOV     A,[HL+06H]
30cd: af 01        CMP     A,#01H
30cf: 80 03        BNZ     $30D4H
30d1: 2c 82 31     BR      !3182H
30d4: 06 20 06     MOV     A,[HL+06H]
30d7: af 01        CMP     A,#01H
30d9: 80 03        BNZ     $30DEH
30db: 2c 82 31     BR      !3182H
30de: 06 20 06     MOV     A,[HL+06H]
30e1: af 01        CMP     A,#01H
30e3: 80 03        BNZ     $30E8H
30e5: 2c 82 31     BR      !3182H
30e8: 06 20 06     MOV     A,[HL+06H]
30eb: af 01        CMP     A,#01H
30ed: 80 03        BNZ     $30F2H
30ef: 2c 82 31     BR      !3182H
30f2: 06 20 06     MOV     A,[HL+06H]
30f5: af 01        CMP     A,#01H
30f7: 80 03        BNZ     $30FCH
30f9: 2c 82 31     BR      !3182H
30fc: 06 20 06     MOV     A,[HL+06H]
30ff: af 01        CMP     A,#01H
3101: 80 02        BNZ     $3105H
3103: 14 7d        BR      $3182H
3105: 06 20 06     MOV     A,[HL+06H]
3108: af 01        CMP     A,#01H
310a: 80 07        BNZ     $3113H
310c: b9 00        MOV     A,#00H
310e: 06 a0 06     MOV     [HL+06H],A
3111: 14 6f        BR      $3182H
3113: 06 20 2f     MOV     A,[HL+2FH]
3116: af 61        CMP     A,#61H
3118: 83 0f        BC      $3129H
311a: b9 7a        MOV     A,#7AH
311c: 06 2f 2f     CMP     A,[HL+2FH]
311f: 83 08        BC      $3129H
3121: 06 20 2f     MOV     A,[HL+2FH]
3124: aa 20        SUB     A,#20H
3126: 06 a0 2f     MOV     [HL+2FH],A
3129: 06 20 2f     MOV     A,[HL+2FH]
312c: 22 ba        MOV     0FEBAH,A
312e: 1c b2        MOVW    AX,I2C_OutputBuffer
3130: 3c           PUSH    AX
3131: 1c ba        MOVW    AX,0FEBAH
3133: 1a b2        MOVW    I2C_OutputBuffer,AX
3135: 28 e9 9a     CALL    !9AE9H
3138: 34           POP     AX
3139: 1a b2        MOVW    I2C_OutputBuffer,AX
313b: d2           MOV     A,C
313c: 06 a0 2f     MOV     [HL+2FH],A
313f: 14 41        BR      $3182H
3141: 60 0d 10     MOVW    AX,#100DH
3144: 3c           PUSH    AX
3145: 28 79 46     CALL    !4679H
3148: 34           POP     AX
3149: 14 37        BR      $3182H
314b: 06 20 09     MOV     A,[HL+09H]
314e: af 00        CMP     A,#00H
3150: 83 ef        BC      $3141H
3152: b8 0d        MOV     X,#0DH
3154: 8f 01        CMP     X,A
3156: 83 e9        BC      $3141H
3158: d8           XCH     A,X
3159: b9 00        MOV     A,#00H
315b: 88 08        ADDW    AX,AX
315d: 2d 66 31     ADDW    AX,#3166H
3160: 24 48        MOVW    DE,AX
3162: 05 e2        MOVW    AX,[DE]
3164: 05 48        BR      AX
3166: 3d           PUSH    BC
3167: 2f 73 2f     CMPW    AX,#2F73H
316a: 7d 2f 87     XOR     0FE87H,0FE2FH
316d: 2f 91 2f     CMPW    AX,#2F91H
3170: 03 30        AND1    CY,/X.0
3172: 43 30        POP     CRC0
3174: ca           DEC     C
3175: 30 d4        SHRW    DE,2
3177: 30 de        SHRW    HL,3
3179: 30 e8        SHRW    AX,5
317b: 30 f2        SHRW    BC,6
317d: 30 fc        SHRW    DE,7
317f: 30 05        RORC    D,0
3181: 31 06        ROLC    L,0
3183: 20 30        MOV     A,0FE30H
3185: c1           INC     A
3186: 06 a0 30     MOV     [HL+30H],A
3189: c9           DEC     A
318a: b8 00        MOV     X,#00H
318c: d8           XCH     A,X
318d: 88 0e        ADDW    AX,HL
318f: 2d 0e 00     ADDW    AX,#000EH
3192: 24 48        MOVW    DE,AX
3194: 06 20 2f     MOV     A,[HL+2FH]
3197: 54           MOV     [DE],A
3198: 06 20 09     MOV     A,[HL+09H]
319b: c1           INC     A
319c: 06 a0 09     MOV     [HL+09H],A
319f: b9 1f        MOV     A,#1FH
31a1: 06 2f 30     CMP     A,[HL+30H]
31a4: 82 59        BNC     $31FFH
31a6: b4 03        SET1    P3.4
31a8: 60 50 00     MOVW    AX,#0050H
31ab: 3c           PUSH    AX
31ac: 28 43 8b     CALL    !8B43H
31af: 34           POP     AX
31b0: 4a           DI
31b1: 28 ce 7a     CALL    Query_DFBE
31b4: 64 55 d5     MOVW    DE,#0D555H
31b7: b9 aa        MOV     A,#0AAH
31b9: 54           MOV     [DE],A
31ba: 64 aa ca     MOVW    DE,#0CAAAH
31bd: b9 55        MOV     A,#55H
31bf: 54           MOV     [DE],A
31c0: 64 55 d5     MOVW    DE,#0D555H
31c3: b9 a0        MOV     A,#0A0H
31c5: 54           MOV     [DE],A
31c6: 06 20 31     MOV     A,[HL+31H]
31c9: 06 a0 2e     MOV     [HL+2EH],A
31cc: 06 20 2e     MOV     A,[HL+2EH]
31cf: 06 2f 30     CMP     A,[HL+30H]
31d2: 82 22        BNC     $31F6H
31d4: 06 20 2e     MOV     A,[HL+2EH]
31d7: b8 00        MOV     X,#00H
31d9: d8           XCH     A,X
31da: 88 0e        ADDW    AX,HL
31dc: 2d 0e 00     ADDW    AX,#000EH
31df: 24 48        MOVW    DE,AX
31e1: 5c           MOV     A,[DE]
31e2: da           XCH     A,C
31e3: 1c 6a        MOVW    AX,0FE6AH
31e5: 44           INCW    AX
31e6: 1a 6a        MOVW    0FE6AH,AX
31e8: 4c           DECW    AX
31e9: 24 48        MOVW    DE,AX
31eb: d2           MOV     A,C
31ec: 54           MOV     [DE],A
31ed: 06 20 2e     MOV     A,[HL+2EH]
31f0: c1           INC     A
31f1: 06 a0 2e     MOV     [HL+2EH],A
31f4: 14 d6        BR      $31CCH
31f6: 4b           EI
31f7: b9 00        MOV     A,#00H
31f9: 06 a0 30     MOV     [HL+30H],A
31fc: 06 a0 31     MOV     [HL+31H],A
31ff: b9 0d        MOV     A,#0DH
3201: 06 2f 09     CMP     A,[HL+09H]
3204: 83 03        BC      $3209H
3206: 2c 9b 32     BR      !329BH
3209: 06 20 09     MOV     A,[HL+09H]
320c: af 12        CMP     A,#12H
320e: 82 1c        BNC     $322CH
3210: 06 20 30     MOV     A,[HL+30H]
3213: c1           INC     A
3214: 06 a0 30     MOV     [HL+30H],A
3217: c9           DEC     A
3218: b8 00        MOV     X,#00H
321a: d8           XCH     A,X
321b: 88 0e        ADDW    AX,HL
321d: 2d 0e 00     ADDW    AX,#000EH
3220: 24 48        MOVW    DE,AX
3222: b9 ff        MOV     A,#0FFH
3224: 54           MOV     [DE],A
3225: 06 20 09     MOV     A,[HL+09H]
3228: c1           INC     A
3229: 06 a0 09     MOV     [HL+09H],A
322c: 06 20 09     MOV     A,[HL+09H]
322f: af 12        CMP     A,#12H
3231: 80 05        BNZ     $3238H
3233: b9 00        MOV     A,#00H
3235: 06 a0 09     MOV     [HL+09H],A
3238: b9 1f        MOV     A,#1FH
323a: 06 2f 30     CMP     A,[HL+30H]
323d: 82 59        BNC     $3298H
323f: b4 03        SET1    P3.4
3241: 60 50 00     MOVW    AX,#0050H
3244: 3c           PUSH    AX
3245: 28 43 8b     CALL    !8B43H
3248: 34           POP     AX
3249: 4a           DI
324a: 28 ce 7a     CALL    Query_DFBE
324d: 64 55 d5     MOVW    DE,#0D555H
3250: b9 aa        MOV     A,#0AAH
3252: 54           MOV     [DE],A
3253: 64 aa ca     MOVW    DE,#0CAAAH
3256: b9 55        MOV     A,#55H
3258: 54           MOV     [DE],A
3259: 64 55 d5     MOVW    DE,#0D555H
325c: b9 a0        MOV     A,#0A0H
325e: 54           MOV     [DE],A
325f: 06 20 31     MOV     A,[HL+31H]
3262: 06 a0 2e     MOV     [HL+2EH],A
3265: 06 20 2e     MOV     A,[HL+2EH]
3268: 06 2f 30     CMP     A,[HL+30H]
326b: 82 22        BNC     $328FH
326d: 06 20 2e     MOV     A,[HL+2EH]
3270: b8 00        MOV     X,#00H
3272: d8           XCH     A,X
3273: 88 0e        ADDW    AX,HL
3275: 2d 0e 00     ADDW    AX,#000EH
3278: 24 48        MOVW    DE,AX
327a: 5c           MOV     A,[DE]
327b: da           XCH     A,C
327c: 1c 6a        MOVW    AX,0FE6AH
327e: 44           INCW    AX
327f: 1a 6a        MOVW    0FE6AH,AX
3281: 4c           DECW    AX
3282: 24 48        MOVW    DE,AX
3284: d2           MOV     A,C
3285: 54           MOV     [DE],A
3286: 06 20 2e     MOV     A,[HL+2EH]
3289: c1           INC     A
328a: 06 a0 2e     MOV     [HL+2EH],A
328d: 14 d6        BR      $3265H
328f: 4b           EI
3290: b9 00        MOV     A,#00H
3292: 06 a0 30     MOV     [HL+30H],A
3295: 06 a0 31     MOV     [HL+31H],A
3298: 2c ff 31     BR      !31FFH
329b: 06 20 06     MOV     A,[HL+06H]
329e: af 01        CMP     A,#01H
32a0: 80 03        BNZ     $32A5H
32a2: 2c 59 2e     BR      !2E59H
32a5: 06 20 2f     MOV     A,[HL+2FH]
32a8: af 7d        CMP     A,#7DH
32aa: 81 03        BZ      $32AFH
32ac: 2c 59 2e     BR      !2E59H
32af: a4 03        CLR1    P3.4
32b1: 60 0f 00     MOVW    AX,#000FH
32b4: 3c           PUSH    AX
32b5: 28 6d 8b     CALL    Delay_Loop
32b8: 34           POP     AX
32b9: 28 ce 7a     CALL    Query_DFBE
32bc: 64 55 d5     MOVW    DE,#0D555H
32bf: b9 aa        MOV     A,#0AAH
32c1: 54           MOV     [DE],A
32c2: 64 aa ca     MOVW    DE,#0CAAAH
32c5: b9 55        MOV     A,#55H
32c7: 54           MOV     [DE],A
32c8: 64 55 d5     MOVW    DE,#0D555H
32cb: b9 a0        MOV     A,#0A0H
32cd: 54           MOV     [DE],A
32ce: 06 20 31     MOV     A,[HL+31H]
32d1: 06 a0 2e     MOV     [HL+2EH],A
32d4: 06 20 2e     MOV     A,[HL+2EH]
32d7: 06 2f 30     CMP     A,[HL+30H]
32da: 82 27        BNC     $3303H
32dc: 1c 6a        MOVW    AX,0FE6AH
32de: 44           INCW    AX
32df: 1a 6a        MOVW    0FE6AH,AX
32e1: 4c           DECW    AX
32e2: 3c           PUSH    AX
32e3: 06 20 2e     MOV     A,[HL+2EH]
32e6: b8 00        MOV     X,#00H
32e8: d8           XCH     A,X
32e9: 88 0e        ADDW    AX,HL
32eb: 2d 0e 00     ADDW    AX,#000EH
32ee: 24 48        MOVW    DE,AX
32f0: 5c           MOV     A,[DE]
32f1: b8 00        MOV     X,#00H
32f3: d8           XCH     A,X
32f4: 3c           PUSH    AX
32f5: 28 f5 7a     CALL    !7AF5H
32f8: 34           POP     AX
32f9: 34           POP     AX
32fa: 06 20 2e     MOV     A,[HL+2EH]
32fd: c1           INC     A
32fe: 06 a0 2e     MOV     [HL+2EH],A
3301: 14 d1        BR      $32D4H
3303: 28 5c 33     CALL    !335CH
Power_Pressed:
3306: 06 20 0d     MOV     A,[HL+0DH]
3309: af 01        CMP     A,#01H
330b: 80 04        BNZ     $3311H
330d: 05 e3        MOVW    AX,[HL]
330f: 14 05        BR      $3316H
3311: 64 1e fd     MOVW    DE,#0FD1EH
3314: 05 e2        MOVW    AX,[DE]
3316: 1a 90        MOVW    0FE90H,AX
3318: a1 66        CLR1    0FE66H.1
331a: 3a 86 01     MOV     0FE86H,#01H
331d: 11 e4        MOVW    AX,MK0
331f: ac fd        AND     A,#0FDH
3321: d8           XCH     A,X
3322: ac fa        AND     A,#0FAH
3324: d8           XCH     A,X
3325: 13 e4        MOVW    MK0,AX
3327: 3a 9e 00     MOV     0FE9EH,#00H
332a: 3a 9f 00     MOV     0FE9FH,#00H
332d: 28 d6 53     CALL    !53D6H
3330: 60 0f 10     MOVW    AX,#100FH
3333: 3c           PUSH    AX
3334: 28 79 46     CALL    !4679H
3337: 34           POP     AX
3338: 08 a5 65 03  BF      0FE65H.5,$333FH
333c: 28 43 7d     CALL    !7D43H
333f: 28 16 20     CALL    !2016H
3342: 09 f0 30 fd  MOV     A,!0FD30H
3346: 03 9c        CLR1    A.4
3348: 09 f1 30 fd  MOV     !0FD30H,A
334c: 4b           EI
334d: 06 20 0d     MOV     A,[HL+0DH]
3350: bb 00        MOV     B,#00H
3352: da           XCH     A,C
3353: 24 0e        MOVW    AX,HL
3355: 2d 32 00     ADDW    AX,#0032H
3358: 13 fc        MOVW    SP,AX
335a: 37           POP     HL
335b: 56           RET
335c: 3f           PUSH    HL
335d: 05 c9        DECW    SP
335f: 05 c9        DECW    SP
3361: 11 fc        MOVW    AX,SP
3363: 24 68        MOVW    HL,AX
3365: 1c 90        MOVW    AX,0FE90H
3367: 06 a0 01     MOV     [HL+01H],A
336a: d8           XCH     A,X
336b: 55           MOV     [HL],A
336c: 0c 90 00 00  MOVW    0FE90H,#0000H
3370: 1c 90        MOVW    AX,0FE90H
3372: 2f 40 04     CMPW    AX,#0440H
3375: 82 72        BNC     $33E9H
3377: 60 0a 00     MOVW    AX,#000AH
337a: 3c           PUSH    AX
337b: 28 6d 8b     CALL    Delay_Loop
337e: 34           POP     AX
337f: 28 86 7f     CALL    !7F86H
3382: 8a 08        SUBW    AX,AX
3384: 8f 0a        CMPW    AX,BC
3386: 81 54        BZ      $33DCH
3388: 09 f0 90 fe  MOV     A,!0FE90H
338c: d8           XCH     A,X
338d: 09 f0 91 fe  MOV     A,!0FE91H
3391: 3c           PUSH    AX
3392: 28 45 80     CALL    !8045H
3395: 34           POP     AX
3396: 1c 92        MOVW    AX,0FE92H
3398: 2f ab 0b     CMPW    AX,#0BABH
339b: 80 07        BNZ     $33A4H
339d: 1c 90        MOVW    AX,0FE90H
339f: 64 20 fd     MOVW    DE,#0FD20H
33a2: 05 e6        MOVW    [DE],AX
33a4: 1c 94        MOVW    AX,0FE94H
33a6: 2f ab 0b     CMPW    AX,#0BABH
33a9: 80 07        BNZ     $33B2H
33ab: 1c 90        MOVW    AX,0FE90H
33ad: 64 22 fd     MOVW    DE,#0FD22H
33b0: 05 e6        MOVW    [DE],AX
33b2: 09 f0 90 fe  MOV     A,!0FE90H
33b6: d8           XCH     A,X
33b7: 09 f0 91 fe  MOV     A,!0FE91H
33bb: 3c           PUSH    AX
33bc: 28 e8 7d     CALL    !7DE8H
33bf: 34           POP     AX
33c0: 1c 6a        MOVW    AX,0FE6AH
33c2: 2d 0e 00     ADDW    AX,#000EH
33c5: 3c           PUSH    AX
33c6: 1c 92        MOVW    AX,0FE92H
33c8: 3c           PUSH    AX
33c9: 28 63 7b     CALL    !7B63H
33cc: 34           POP     AX
33cd: 34           POP     AX
33ce: 1c 6a        MOVW    AX,0FE6AH
33d0: 2d 10 00     ADDW    AX,#0010H
33d3: 3c           PUSH    AX
33d4: 1c 94        MOVW    AX,0FE94H
33d6: 3c           PUSH    AX
33d7: 28 63 7b     CALL    !7B63H
33da: 34           POP     AX
33db: 34           POP     AX
33dc: 1c 90        MOVW    AX,0FE90H
33de: 3c           PUSH    AX
33df: 28 b0 82     CALL    !82B0H
33e2: 34           POP     AX
33e3: 24 0a        MOVW    AX,BC
33e5: 1a 90        MOVW    0FE90H,AX
33e7: 14 87        BR      $3370H
33e9: 05 e3        MOVW    AX,[HL]
33eb: 1a 90        MOVW    0FE90H,AX
33ed: 28 93 84     CALL    !8493H
33f0: 34           POP     AX
33f1: 37           POP     HL
33f2: 56           RET
33f3: a6 68        CLR1    0FE68H.6
33f5: 56           RET
33f6: 3f           PUSH    HL
33f7: 1c ac        MOVW    AX,0FEACH
33f9: 3c           PUSH    AX
33fa: 1c ae        MOVW    AX,0FEAEH
33fc: 3c           PUSH    AX
33fd: 1c b0        MOVW    AX,0FEB0H
33ff: 3c           PUSH    AX
3400: 05 c9        DECW    SP
3402: 05 c9        DECW    SP
3404: 11 fc        MOVW    AX,SP
3406: 24 68        MOVW    HL,AX
3408: 3a b1 00     MOV     0FEB1H,#00H
340b: a5 68        CLR1    0FE68H.5
340d: 09 f0 30 fd  MOV     A,!0FD30H
3411: 30 89        SHR     A,1
3413: ac 01        AND     A,#01H
3415: b8 00        MOV     X,#00H
3417: d8           XCH     A,X
3418: 2f 01 00     CMPW    AX,#0001H
341b: 80 2c        BNZ     $3449H
341d: 09 f0 93 fd  MOV     A,!0FD93H
3421: b8 00        MOV     X,#00H
3423: d8           XCH     A,X
3424: 2d 31 fd     ADDW    AX,#0FD31H
3427: 24 48        MOVW    DE,AX
3429: 5c           MOV     A,[DE]
342a: af 55        CMP     A,#55H
342c: 81 1b        BZ      $3449H
342e: 09 f0 93 fd  MOV     A,!0FD93H
3432: b8 00        MOV     X,#00H
3434: d8           XCH     A,X
3435: 2d 31 fd     ADDW    AX,#0FD31H
3438: 24 48        MOVW    DE,AX
343a: 5c           MOV     A,[DE]
343b: af 44        CMP     A,#44H
343d: 81 0a        BZ      $3449H
343f: 09 f0 30 fd  MOV     A,!0FD30H
3443: 03 99        CLR1    A.1
3445: 09 f1 30 fd  MOV     !0FD30H,A
3449: 09 f0 30 fd  MOV     A,!0FD30H
344d: ac 01        AND     A,#01H
344f: b8 00        MOV     X,#00H
3451: d8           XCH     A,X
3452: 2f 01 00     CMPW    AX,#0001H
3455: 81 13        BZ      $346AH
3457: 09 f0 30 fd  MOV     A,!0FD30H
345b: 30 89        SHR     A,1
345d: ac 01        AND     A,#01H
345f: b8 00        MOV     X,#00H
3461: d8           XCH     A,X
3462: 2f 01 00     CMPW    AX,#0001H
3465: 81 03        BZ      $346AH
3467: 2c 21 46     BR      !4621H
346a: 09 f0 30 fd  MOV     A,!0FD30H
346e: 03 98        CLR1    A.0
3470: 09 f1 30 fd  MOV     !0FD30H,A
3474: 03 99        CLR1    A.1
3476: 09 f1 30 fd  MOV     !0FD30H,A
347a: 09 f0 93 fd  MOV     A,!0FD93H
347e: b8 00        MOV     X,#00H
3480: d8           XCH     A,X
3481: 2d 31 fd     ADDW    AX,#0FD31H
3484: 24 48        MOVW    DE,AX
3486: 5c           MOV     A,[DE]
3487: af 59        CMP     A,#59H
3489: 81 1f        BZ      $34AAH
348b: 09 f0 30 fd  MOV     A,!0FD30H
348f: 03 9d        CLR1    A.5
3491: 09 f1 30 fd  MOV     !0FD30H,A
3495: 30 a9        SHR     A,5
3497: ac 01        AND     A,#01H
3499: b8 00        MOV     X,#00H
349b: d8           XCH     A,X
349c: 24 28        MOVW    BC,AX
349e: 09 f0 30 fd  MOV     A,!0FD30H
34a2: 30 8a        SHR     C,1
34a4: 03 1a        MOV1    A.2,CY
34a6: 09 f1 30 fd  MOV     !0FD30H,A
34aa: 09 f0 93 fd  MOV     A,!0FD93H
34ae: b8 00        MOV     X,#00H
34b0: d8           XCH     A,X
34b1: 2d 31 fd     ADDW    AX,#0FD31H
34b4: 24 48        MOVW    DE,AX
34b6: 5c           MOV     A,[DE]
34b7: af 30        CMP     A,#30H
34b9: 83 12        BC      $34CDH
34bb: 09 f0 93 fd  MOV     A,!0FD93H
34bf: b8 00        MOV     X,#00H
34c1: d8           XCH     A,X
34c2: 2d 31 fd     ADDW    AX,#0FD31H
34c5: 24 48        MOVW    DE,AX
34c7: b9 39        MOV     A,#39H
34c9: 16 4f        CMP     A,[DE]
34cb: 82 0a        BNC     $34D7H
34cd: 09 f0 30 fd  MOV     A,!0FD30H
34d1: 03 9b        CLR1    A.3
34d3: 09 f1 30 fd  MOV     !0FD30H,A
34d7: 60 12 10     MOVW    AX,#1012H
34da: 64 95 fd     MOVW    DE,#0FD95H
34dd: 05 e6        MOVW    [DE],AX
34df: 28 02 47     CALL    !4702H
34e2: d2           MOV     A,C
34e3: 22 af        MOV     0FEAFH,A
34e5: 70 66 0d     BT      0FE66H.0,$34F5H
34e8: 6f af 50     CMP     0FEAFH,#50H
34eb: 81 08        BZ      $34F5H
34ed: 6f af 49     CMP     0FEAFH,#49H
34f0: 81 03        BZ      $34F5H
34f2: 3a af 00     MOV     0FEAFH,#00H
34f5: 2c 9a 45     BR      !459AH
34f8: 2c cc 35     BR      !35CCH
34fb: 3a af 00     MOV     0FEAFH,#00H
34fe: 28 a5 25     CALL    !25A5H
3501: 8a 08        SUBW    AX,AX
3503: 8f 0a        CMPW    AX,BC
3505: 80 18        BNZ     $351FH
3507: 1c 63        MOVW    AX,0FE63H
3509: 24 48        MOVW    DE,AX
350b: 20 af        MOV     A,0FEAFH
350d: bb 00        MOV     B,#00H
350f: da           XCH     A,C
3510: 06 00 05     MOV     A,[DE+05H]
3513: 31 a2        SHL     C,4
3515: ac cf        AND     A,#0CFH
3517: 8e 12        OR      A,C
3519: 06 80 05     MOV     [DE+05H],A
351c: 2c c7 3d     BR      !3DC7H
351f: 2c 04 36     BR      !3604H
3522: 28 02 47     CALL    !4702H
3525: d2           MOV     A,C
3526: 22 af        MOV     0FEAFH,A
3528: 3a af 42     MOV     0FEAFH,#42H
352b: 75 65 27     BT      0FE65H.5,$3555H
352e: 1c 63        MOVW    AX,0FE63H
3530: 2f 55 fe     CMPW    AX,#0FE55H
3533: 80 10        BNZ     $3545H
3535: 3f           PUSH    HL
3536: 64 5c fe     MOVW    DE,#0FE5CH
3539: 66 55 fe     MOVW    HL,#0FE55H
353c: ba 07        MOV     C,#07H
353e: 59           MOV     A,[HL+]
353f: 50           MOV     [DE+],A
3540: 32 fc        DBNZ    C,$353EH
3542: 37           POP     HL
3543: 14 0e        BR      $3553H
3545: 3f           PUSH    HL
3546: 64 55 fe     MOVW    DE,#0FE55H
3549: 66 5c fe     MOVW    HL,#0FE5CH
354c: ba 07        MOV     C,#07H
354e: 59           MOV     A,[HL+]
354f: 50           MOV     [DE+],A
3550: 32 fc        DBNZ    C,$354EH
3552: 37           POP     HL
3553: b1 69        SET1    0FE69H.1
3555: 2c cb 3d     BR      !3DCBH
3558: 3a af 02     MOV     0FEAFH,#02H
355b: 14 a1        BR      $34FEH
355d: 3a af 03     MOV     0FEAFH,#03H
3560: 14 9c        BR      $34FEH
3562: 1c 63        MOVW    AX,0FE63H
3564: 24 48        MOVW    DE,AX
3566: 06 00 06     MOV     A,[DE+06H]
3569: 30 b1        SHR     A,6
356b: ac 03        AND     A,#03H
356d: b8 00        MOV     X,#00H
356f: d8           XCH     A,X
3570: 2f 01 00     CMPW    AX,#0001H
3573: 80 03        BNZ     $3578H
3575: 28 4e 9b     CALL    !9B4EH
3578: 1c 63        MOVW    AX,0FE63H
357a: 24 48        MOVW    DE,AX
357c: 06 00 06     MOV     A,[DE+06H]
357f: ac 3f        AND     A,#3FH
3581: 06 80 06     MOV     [DE+06H],A
3584: 2c 8b 44     BR      !448BH
3587: 1c 63        MOVW    AX,0FE63H
3589: 24 48        MOVW    DE,AX
358b: 06 00 06     MOV     A,[DE+06H]
358e: 30 b1        SHR     A,6
3590: ac 03        AND     A,#03H
3592: b8 00        MOV     X,#00H
3594: d8           XCH     A,X
3595: 2f 01 00     CMPW    AX,#0001H
3598: 80 03        BNZ     $359DH
359a: 28 4e 9b     CALL    !9B4EH
359d: 1c 63        MOVW    AX,0FE63H
359f: 24 48        MOVW    DE,AX
35a1: 06 00 06     MOV     A,[DE+06H]
35a4: ac 3f        AND     A,#3FH
35a6: ae 80        OR      A,#80H
35a8: 06 80 06     MOV     [DE+06H],A
35ab: 2c 8b 44     BR      !448BH
35ae: 64 d7 ff     MOVW    DE,#0FFD7H
35b1: 5c           MOV     A,[DE]
35b2: ac 80        AND     A,#80H
35b4: 81 14        BZ      $35CAH
35b6: 28 9b 9b     CALL    !9B9BH
35b9: 1c 63        MOVW    AX,0FE63H
35bb: 24 48        MOVW    DE,AX
35bd: 06 00 06     MOV     A,[DE+06H]
35c0: ac 3f        AND     A,#3FH
35c2: ae 40        OR      A,#40H
35c4: 06 80 06     MOV     [DE+06H],A
35c7: 2c 8b 44     BR      !448BH
35ca: 14 38        BR      $3604H
35cc: 09 f0 93 fd  MOV     A,!0FD93H
35d0: b8 00        MOV     X,#00H
35d2: d8           XCH     A,X
35d3: 2d 31 fd     ADDW    AX,#0FD31H
35d6: 24 48        MOVW    DE,AX
35d8: 5c           MOV     A,[DE]
35d9: af 43        CMP     A,#43H
35db: 81 d1        BZ      $35AEH
35dd: af 32        CMP     A,#32H
35df: 81 a6        BZ      $3587H
35e1: af 31        CMP     A,#31H
35e3: 80 03        BNZ     $35E8H
35e5: 2c 62 35     BR      !3562H
35e8: af 53        CMP     A,#53H
35ea: 80 03        BNZ     $35EFH
35ec: 2c 5d 35     BR      !355DH
35ef: af 46        CMP     A,#46H
35f1: 80 03        BNZ     $35F6H
35f3: 2c 58 35     BR      !3558H
35f6: af 45        CMP     A,#45H
35f8: 80 03        BNZ     $35FDH
35fa: 2c 22 35     BR      !3522H
35fd: af 4f        CMP     A,#4FH
35ff: 80 03        BNZ     $3604H
3601: 2c fb 34     BR      !34FBH
3604: 2c 0a 46     BR      !460AH
3607: 2c 42 37     BR      !3742H
360a: 3a af 03     MOV     0FEAFH,#03H
360d: 28 a5 25     CALL    !25A5H
3610: 8a 08        SUBW    AX,AX
3612: 8f 0a        CMPW    AX,BC
3614: 80 18        BNZ     $362EH
3616: 1c 63        MOVW    AX,0FE63H
3618: 24 48        MOVW    DE,AX
361a: 20 af        MOV     A,0FEAFH
361c: bb 00        MOV     B,#00H
361e: da           XCH     A,C
361f: 06 00 05     MOV     A,[DE+05H]
3622: 31 b2        SHL     C,6
3624: ac 3f        AND     A,#3FH
3626: 8e 12        OR      A,C
3628: 06 80 05     MOV     [DE+05H],A
362b: 2c c7 3d     BR      !3DC7H
362e: 2c 72 37     BR      !3772H
3631: 3a af 00     MOV     0FEAFH,#00H
3634: 14 d7        BR      $360DH
3636: 3a af 01     MOV     0FEAFH,#01H
3639: 14 d2        BR      $360DH
363b: 28 02 47     CALL    !4702H
363e: d2           MOV     A,C
363f: 22 af        MOV     0FEAFH,A
3641: 28 de 2d     CALL    !2DDEH
3644: 8a 08        SUBW    AX,AX
3646: 8f 0a        CMPW    AX,BC
3648: 81 03        BZ      $364DH
364a: 2c cb 3d     BR      !3DCBH
364d: 2c 72 37     BR      !3772H
3650: 28 02 47     CALL    !4702H
3653: d2           MOV     A,C
3654: 22 af        MOV     0FEAFH,A
3656: 28 e9 4d     CALL    !4DE9H
3659: 28 f0 8c     CALL    !8CF0H
365c: 8a 08        SUBW    AX,AX
365e: 8f 0a        CMPW    AX,BC
3660: 80 03        BNZ     $3665H
3662: 2c 3b 37     BR      !373BH
3665: 28 02 47     CALL    !4702H
3668: 24 0a        MOVW    AX,BC
366a: 2f 2c 00     CMPW    AX,#002CH
366d: 81 03        BZ      $3672H
366f: 2c 3b 37     BR      !373BH
3672: 1c 90        MOVW    AX,0FE90H
3674: 1a 6c        MOVW    0FE6CH,AX
3676: 28 e9 4d     CALL    !4DE9H
3679: 28 f0 8c     CALL    !8CF0H
367c: 8a 08        SUBW    AX,AX
367e: 8f 0a        CMPW    AX,BC
3680: 80 03        BNZ     $3685H
3682: 2c 3b 37     BR      !373BH
3685: 28 40 6d     CALL    !6D40H
3688: 71 a1 05     BT      0FEA1H.1,$3690H
368b: 28 20 58     CALL    !5820H
368e: b1 a1        SET1    0FEA1H.1
3690: 11 e4        MOVW    AX,MK0
3692: ae 02        OR      A,#02H
3694: d8           XCH     A,X
3695: ae 05        OR      A,#05H
3697: d8           XCH     A,X
3698: 13 e4        MOVW    MK0,AX
369a: 1c 90        MOVW    AX,0FE90H
369c: 1a 6e        MOVW    0FE6EH,AX
369e: 09 f0 6c fe  MOV     A,!0FE6CH
36a2: d8           XCH     A,X
36a3: 09 f0 6d fe  MOV     A,!0FE6DH
36a7: 3c           PUSH    AX
36a8: 28 e8 7d     CALL    !7DE8H
36ab: 34           POP     AX
36ac: 1c 6e        MOVW    AX,0FE6EH
36ae: 1f 6c        CMPW    AX,0FE6CH
36b0: 83 64        BC      $3716H
36b2: 3a af 00     MOV     0FEAFH,#00H
36b5: 6f af 0e     CMP     0FEAFH,#0EH
36b8: 82 49        BNC     $3703H
36ba: 09 f0 92 fd  MOV     A,!0FD92H
36be: c1           INC     A
36bf: ac 1f        AND     A,#1FH
36c1: d8           XCH     A,X
36c2: 09 f0 91 fd  MOV     A,!0FD91H
36c6: 8f 01        CMP     X,A
36c8: 80 02        BNZ     $36CCH
36ca: 14 ee        BR      $36BAH
36cc: b9 06        MOV     A,#06H
36ce: 9f af        CMP     A,0FEAFH
36d0: 82 1b        BNC     $36EDH
36d2: 1c 6a        MOVW    AX,0FE6AH
36d4: 44           INCW    AX
36d5: 1a 6a        MOVW    0FE6AH,AX
36d7: 4c           DECW    AX
36d8: 3c           PUSH    AX
36d9: 28 2b 7c     CALL    !7C2BH
36dc: 34           POP     AX
36dd: bb 00        MOV     B,#00H
36df: 3d           PUSH    BC
36e0: 28 6d 51     CALL    !516DH
36e3: 34           POP     AX
36e4: bb 00        MOV     B,#00H
36e6: 3d           PUSH    BC
36e7: 28 2d 46     CALL    !462DH
36ea: 34           POP     AX
36eb: 14 12        BR      $36FFH
36ed: 1c 6a        MOVW    AX,0FE6AH
36ef: 44           INCW    AX
36f0: 1a 6a        MOVW    0FE6AH,AX
36f2: 4c           DECW    AX
36f3: 3c           PUSH    AX
36f4: 28 2b 7c     CALL    !7C2BH
36f7: 34           POP     AX
36f8: bb 00        MOV     B,#00H
36fa: 3d           PUSH    BC
36fb: 28 2d 46     CALL    !462DH
36fe: 34           POP     AX
36ff: 26 af        INC     0FEAFH
3701: 14 b2        BR      $36B5H
3703: 68 6a 04     ADD     0FE6AH,#04H
3706: 69 6b 00     ADDC    0FE6BH,#00H
3709: 1c 6c        MOVW    AX,0FE6CH
370b: 3c           PUSH    AX
370c: 28 b0 82     CALL    !82B0H
370f: 34           POP     AX
3710: 24 0a        MOVW    AX,BC
3712: 1a 6c        MOVW    0FE6CH,AX
3714: 14 96        BR      $36ACH
3716: 3a 6a 0d     MOV     0FE6AH,#0DH
3719: 3a 6b 00     MOV     0FE6BH,#00H
371c: 28 47 4d     CALL    !4D47H
371f: 64 1e fd     MOVW    DE,#0FD1EH
3722: 05 e2        MOVW    AX,[DE]
3724: 1a 90        MOVW    0FE90H,AX
3726: a1 66        CLR1    0FE66H.1
3728: 3a 86 00     MOV     0FE86H,#00H
372b: 11 e4        MOVW    AX,MK0
372d: ac fd        AND     A,#0FDH
372f: d8           XCH     A,X
3730: ac fa        AND     A,#0FAH
3732: d8           XCH     A,X
3733: 13 e4        MOVW    MK0,AX
3735: 3a 9e 00     MOV     0FE9EH,#00H
3738: 2c 8b 44     BR      !448BH
373b: 14 35        BR      $3772H
373d: 2c cb 3d     BR      !3DCBH
3740: 14 30        BR      $3772H
3742: 09 f0 93 fd  MOV     A,!0FD93H
3746: b8 00        MOV     X,#00H
3748: d8           XCH     A,X
3749: 2d 31 fd     ADDW    AX,#0FD31H
374c: 24 48        MOVW    DE,AX
374e: 5c           MOV     A,[DE]
374f: af 52        CMP     A,#52H
3751: 80 03        BNZ     $3756H
3753: 2c 50 36     BR      !3650H
3756: af 53        CMP     A,#53H
3758: 80 03        BNZ     $375DH
375a: 2c 3b 36     BR      !363BH
375d: af 4e        CMP     A,#4EH
375f: 80 03        BNZ     $3764H
3761: 2c 36 36     BR      !3636H
3764: af 46        CMP     A,#46H
3766: 80 03        BNZ     $376BH
3768: 2c 31 36     BR      !3631H
376b: af 57        CMP     A,#57H
376d: 80 03        BNZ     $3772H
376f: 2c 0a 36     BR      !360AH
3772: 2c 0a 46     BR      !460AH
3775: 28 02 47     CALL    !4702H
3778: d2           MOV     A,C
3779: 22 af        MOV     0FEAFH,A
377b: 6f af 54     CMP     0FEAFH,#54H
377e: 80 24        BNZ     $37A4H
3780: 14 0f        BR      $3791H
3782: a4 65        CLR1    0FE65H.4
3784: 2c c9 3d     BR      !3DC9H
3787: b4 65        SET1    0FE65H.4
3789: 2c c9 3d     BR      !3DC9H
378c: 2c 0a 46     BR      !460AH
378f: 14 13        BR      $37A4H
3791: 28 02 47     CALL    !4702H
3794: 24 0a        MOVW    AX,BC
3796: 2f 4f 00     CMPW    AX,#004FH
3799: 81 ec        BZ      $3787H
379b: 24 0a        MOVW    AX,BC
379d: 2f 46 00     CMPW    AX,#0046H
37a0: 81 e0        BZ      $3782H
37a2: 14 e8        BR      $378CH
37a4: 6f af 0d     CMP     0FEAFH,#0DH
37a7: 80 02        BNZ     $37ABH
37a9: 14 1c        BR      $37C7H
37ab: 6f af 30     CMP     0FEAFH,#30H
37ae: 83 44        BC      $37F4H
37b0: b9 39        MOV     A,#39H
37b2: 9f af        CMP     A,0FEAFH
37b4: 83 3e        BC      $37F4H
37b6: 1c 90        MOVW    AX,0FE90H
37b8: 64 1e fd     MOVW    DE,#0FD1EH
37bb: 05 e6        MOVW    [DE],AX
37bd: 20 af        MOV     A,0FEAFH
37bf: b8 00        MOV     X,#00H
37c1: d8           XCH     A,X
37c2: 3c           PUSH    AX
37c3: 28 b9 47     CALL    !47B9H
37c6: 34           POP     AX
37c7: 28 f0 8c     CALL    !8CF0H
37ca: 8a 08        SUBW    AX,AX
37cc: 8f 0a        CMPW    AX,BC
37ce: 81 1d        BZ      $37EDH
37d0: 28 86 7f     CALL    !7F86H
37d3: 8a 08        SUBW    AX,AX
37d5: 8f 0a        CMPW    AX,BC
37d7: 81 14        BZ      $37EDH
37d9: 60 80 df     MOVW    AX,#0DF80H
37dc: 3c           PUSH    AX
37dd: 1c 63        MOVW    AX,0FE63H
37df: 3c           PUSH    AX
37e0: 28 3f 9a     CALL    !9A3FH
37e3: 34           POP     AX
37e4: 34           POP     AX
37e5: b5 65        SET1    0FE65H.5
37e7: 28 43 7d     CALL    !7D43H
37ea: 2c 8b 44     BR      !448BH
37ed: 64 1e fd     MOVW    DE,#0FD1EH
37f0: 05 e2        MOVW    AX,[DE]
37f2: 1a 90        MOVW    0FE90H,AX
37f4: 2c 0a 46     BR      !460AH
37f7: 08 a6 65 0c  BF      0FE65H.6,$3807H
37fb: 09 f0 98 fd  MOV     A,!0FD98H
37ff: 03 9c        CLR1    A.4
3801: 09 f1 98 fd  MOV     !0FD98H,A
3805: 14 1a        BR      $3821H
3807: 08 a5 65 0b  BF      0FE65H.5,$3816H
380b: 74 65 08     BT      0FE65H.4,$3816H
380e: 28 54 7e     CALL    !7E54H
3811: 28 43 7d     CALL    !7D43H
3814: 14 0b        BR      $3821H
3816: 08 a5 69 03  BF      0FE69H.5,$381DH
381a: 3a 75 00     MOV     Wheel_Count,#00H
381d: a5 69        CLR1    0FE69H.5
381f: 26 75        INC     Wheel_Count
3821: 28 16 20     CALL    !2016H
3824: 2c 0a 46     BR      !460AH
3827: 2c ab 38     BR      !38ABH
382a: 28 02 47     CALL    !4702H
382d: d2           MOV     A,C
382e: 22 af        MOV     0FEAFH,A
3830: 6f af 30     CMP     0FEAFH,#30H
3833: 83 36        BC      $386BH
3835: b9 39        MOV     A,#39H
3837: 9f af        CMP     A,0FEAFH
3839: 83 30        BC      $386BH
383b: 20 af        MOV     A,0FEAFH
383d: b8 00        MOV     X,#00H
383f: d8           XCH     A,X
3840: 3c           PUSH    AX
3841: 28 b9 47     CALL    !47B9H
3844: 34           POP     AX
3845: 28 f0 8c     CALL    !8CF0H
3848: 8a 08        SUBW    AX,AX
384a: 8f 0a        CMPW    AX,BC
384c: 81 1d        BZ      $386BH
384e: 28 5d 7f     CALL    !7F5DH
3851: 28 17 7e     CALL    !7E17H
3854: 64 1e fd     MOVW    DE,#0FD1EH
3857: 05 e2        MOVW    AX,[DE]
3859: 1f 90        CMPW    AX,0FE90H
385b: 80 08        BNZ     $3865H
385d: 0c 90 ab 0b  MOVW    0FE90H,#0BABH
3861: a5 65        CLR1    0FE65H.5
3863: 14 03        BR      $3868H
3865: 28 43 7d     CALL    !7D43H
3868: 2c 8b 44     BR      !448BH
386b: 14 52        BR      $38BFH
386d: 28 02 47     CALL    !4702H
3870: d2           MOV     A,C
3871: 22 af        MOV     0FEAFH,A
3873: 6f af 59     CMP     0FEAFH,#59H
3876: 80 15        BNZ     $388DH
3878: 28 02 47     CALL    !4702H
387b: 24 0a        MOVW    AX,BC
387d: 2f 0d 00     CMPW    AX,#000DH
3880: 80 0b        BNZ     $388DH
3882: 76 65 06     BT      0FE65H.6,$388BH
3885: 28 9b 7e     CALL    !7E9BH
3888: 2c cb 3d     BR      !3DCBH
388b: 14 1a        BR      $38A7H
388d: 6f af 0d     CMP     0FEAFH,#0DH
3890: 80 15        BNZ     $38A7H
3892: 09 f0 30 fd  MOV     A,!0FD30H
3896: 03 8a        SET1    A.2
3898: 09 f1 30 fd  MOV     !0FD30H,A
389c: 60 15 10     MOVW    AX,#1015H
389f: 64 95 fd     MOVW    DE,#0FD95H
38a2: 05 e6        MOVW    [DE],AX
38a4: 2c cb 3d     BR      !3DCBH
38a7: 14 16        BR      $38BFH
38a9: 14 14        BR      $38BFH
38ab: 28 02 47     CALL    !4702H
38ae: 24 0a        MOVW    AX,BC
38b0: 2f 41 00     CMPW    AX,#0041H
38b3: 81 b8        BZ      $386DH
38b5: 24 0a        MOVW    AX,BC
38b7: 2f 43 00     CMPW    AX,#0043H
38ba: 80 03        BNZ     $38BFH
38bc: 2c 2a 38     BR      !382AH
38bf: 2c 0a 46     BR      !460AH
38c2: 28 02 47     CALL    !4702H
38c5: d2           MOV     A,C
38c6: 22 af        MOV     0FEAFH,A
38c8: 6f af 0d     CMP     0FEAFH,#0DH
38cb: 80 07        BNZ     $38D4H
38cd: a5 65        CLR1    0FE65H.5
38cf: 2c c9 3d     BR      !3DC9H
38d2: 14 26        BR      $38FAH
38d4: 6f af 52     CMP     0FEAFH,#52H
38d7: 80 0e        BNZ     $38E7H
38d9: a3 65        CLR1    0FE65H.3
38db: 3a 86 05     MOV     0FE86H,#05H
38de: b2 68        SET1    0FE68H.2
38e0: b1 69        SET1    0FE69H.1
38e2: 2c cb 3d     BR      !3DCBH
38e5: 14 13        BR      $38FAH
38e7: 20 af        MOV     A,0FEAFH
38e9: b8 00        MOV     X,#00H
38eb: d8           XCH     A,X
38ec: 3c           PUSH    AX
38ed: 28 92 4e     CALL    !4E92H
38f0: 34           POP     AX
38f1: 8a 08        SUBW    AX,AX
38f3: 8f 0a        CMPW    AX,BC
38f5: 81 03        BZ      $38FAH
38f7: 2c cb 3d     BR      !3DCBH
38fa: 2c 0a 46     BR      !460AH
38fd: 1c 63        MOVW    AX,0FE63H
38ff: 24 48        MOVW    DE,AX
3901: 06 00 06     MOV     A,[DE+06H]
3904: 30 b1        SHR     A,6
3906: ac 03        AND     A,#03H
3908: b8 00        MOV     X,#00H
390a: d8           XCH     A,X
390b: 2f 01 00     CMPW    AX,#0001H
390e: 81 72        BZ      $3982H
3910: 14 53        BR      $3965H
3912: 1c 63        MOVW    AX,0FE63H
3914: 24 48        MOVW    DE,AX
3916: 06 00 05     MOV     A,[DE+05H]
3919: 03 9a        CLR1    A.2
391b: 06 80 05     MOV     [DE+05H],A
391e: 1c 63        MOVW    AX,0FE63H
3920: 24 48        MOVW    DE,AX
3922: 06 00 05     MOV     A,[DE+05H]
3925: 03 8b        SET1    A.3
3927: 06 80 05     MOV     [DE+05H],A
392a: 14 53        BR      $397FH
392c: 1c 63        MOVW    AX,0FE63H
392e: 24 48        MOVW    DE,AX
3930: 06 00 05     MOV     A,[DE+05H]
3933: 03 8a        SET1    A.2
3935: 06 80 05     MOV     [DE+05H],A
3938: 1c 63        MOVW    AX,0FE63H
393a: 24 48        MOVW    DE,AX
393c: 06 00 05     MOV     A,[DE+05H]
393f: 03 9b        CLR1    A.3
3941: 06 80 05     MOV     [DE+05H],A
3944: 14 39        BR      $397FH
3946: 1c 63        MOVW    AX,0FE63H
3948: 24 48        MOVW    DE,AX
394a: 06 00 05     MOV     A,[DE+05H]
394d: 03 9a        CLR1    A.2
394f: 06 80 05     MOV     [DE+05H],A
3952: 1c 63        MOVW    AX,0FE63H
3954: 24 48        MOVW    DE,AX
3956: 06 00 05     MOV     A,[DE+05H]
3959: 03 9b        CLR1    A.3
395b: 06 80 05     MOV     [DE+05H],A
395e: 14 1f        BR      $397FH
3960: 2c 0a 46     BR      !460AH
3963: 14 1a        BR      $397FH
3965: 28 02 47     CALL    !4702H
3968: 24 0a        MOVW    AX,BC
396a: 2f 30 00     CMPW    AX,#0030H
396d: 81 d7        BZ      $3946H
396f: 24 0a        MOVW    AX,BC
3971: 2f 2d 00     CMPW    AX,#002DH
3974: 81 b6        BZ      $392CH
3976: 24 0a        MOVW    AX,BC
3978: 2f 2b 00     CMPW    AX,#002BH
397b: 81 95        BZ      $3912H
397d: 14 e1        BR      $3960H
397f: 2c c7 3d     BR      !3DC7H
3982: 2c 0a 46     BR      !460AH
3985: 28 02 47     CALL    !4702H
3988: 24 0a        MOVW    AX,BC
398a: 2f 44 00     CMPW    AX,#0044H
398d: 80 3b        BNZ     $39CAH
398f: 28 02 47     CALL    !4702H
3992: 24 0a        MOVW    AX,BC
3994: 2f 0d 00     CMPW    AX,#000DH
3997: 80 31        BNZ     $39CAH
3999: 70 72 08     BT      0FE72H.0,$39A4H
399c: 60 1b 10     MOVW    AX,#101BH
399f: 3c           PUSH    AX
39a0: 28 79 46     CALL    !4679H
39a3: 34           POP     AX
39a4: 60 1e 10     MOVW    AX,#101EH
39a7: 3c           PUSH    AX
39a8: 28 79 46     CALL    !4679H
39ab: 34           POP     AX
39ac: 70 72 10     BT      0FE72H.0,$39BFH
39af: 60 21 10     MOVW    AX,#1021H
39b2: 3c           PUSH    AX
39b3: 28 79 46     CALL    !4679H
39b6: 34           POP     AX
39b7: 60 36 00     MOVW    AX,#0036H
39ba: 3c           PUSH    AX
39bb: 28 2d 46     CALL    !462DH
39be: 34           POP     AX
39bf: 60 24 10     MOVW    AX,#1024H
39c2: 64 95 fd     MOVW    DE,#0FD95H
39c5: 05 e6        MOVW    [DE],AX
39c7: 2c cb 3d     BR      !3DCBH
39ca: 2c 0a 46     BR      !460AH
39cd: 2c 61 3a     BR      !3A61H
39d0: 28 02 47     CALL    !4702H
39d3: d2           MOV     A,C
39d4: 22 af        MOV     0FEAFH,A
39d6: 6f af 59     CMP     0FEAFH,#59H
39d9: 80 0f        BNZ     $39EAH
39db: 28 02 47     CALL    !4702H
39de: 24 0a        MOVW    AX,BC
39e0: 2f 0d 00     CMPW    AX,#000DH
39e3: 80 05        BNZ     $39EAH
39e5: 28 32 27     CALL    !2732H
39e8: 14 1a        BR      $3A04H
39ea: 6f af 0d     CMP     0FEAFH,#0DH
39ed: 80 15        BNZ     $3A04H
39ef: 09 f0 30 fd  MOV     A,!0FD30H
39f3: 03 8d        SET1    A.5
39f5: 09 f1 30 fd  MOV     !0FD30H,A
39f9: 60 27 10     MOVW    AX,#1027H
39fc: 64 95 fd     MOVW    DE,#0FD95H
39ff: 05 e6        MOVW    [DE],AX
3a01: 2c cb 3d     BR      !3DCBH
3a04: 14 7d        BR      $3A83H
3a06: 08 a5 65 27  BF      0FE65H.5,$3A31H
3a0a: 09 f0 90 fe  MOV     A,!0FE90H
3a0e: d8           XCH     A,X
3a0f: 09 f0 91 fe  MOV     A,!0FE91H
3a13: 3c           PUSH    AX
3a14: 28 e8 7d     CALL    !7DE8H
3a17: 34           POP     AX
3a18: 1c 6a        MOVW    AX,0FE6AH
3a1a: 3c           PUSH    AX
3a1b: 1c 63        MOVW    AX,0FE63H
3a1d: 24 48        MOVW    DE,AX
3a1f: b9 02        MOV     A,#02H
3a21: 16 4d        XOR     A,[DE]
3a23: 54           MOV     [DE],A
3a24: b8 00        MOV     X,#00H
3a26: d8           XCH     A,X
3a27: 3c           PUSH    AX
3a28: 28 18 7b     CALL    !7B18H
3a2b: 34           POP     AX
3a2c: 34           POP     AX
3a2d: b1 69        SET1    0FE69H.1
3a2f: 14 02        BR      $3A33H
3a31: b6 66        SET1    0FE66H.6
3a33: 2c c9 3d     BR      !3DC9H
3a36: a6 66        CLR1    0FE66H.6
3a38: 2c c9 3d     BR      !3DC9H
3a3b: 14 0f        BR      $3A4CH
3a3d: 6e 66 04     OR      0FE66H,#04H
3a40: 14 18        BR      $3A5AH
3a42: 6e 66 08     OR      0FE66H,#08H
3a45: 14 13        BR      $3A5AH
3a47: 6c 66 f3     AND     0FE66H,#0F3H
3a4a: 14 0e        BR      $3A5AH
3a4c: 20 66        MOV     A,0FE66H
3a4e: ac 0c        AND     A,#0CH
3a50: af 04        CMP     A,#04H
3a52: 81 ee        BZ      $3A42H
3a54: af 00        CMP     A,#00H
3a56: 81 e5        BZ      $3A3DH
3a58: 14 ed        BR      $3A47H
3a5a: b4 68        SET1    0FE68H.4
3a5c: 2c cb 3d     BR      !3DCBH
3a5f: 14 22        BR      $3A83H
3a61: 28 02 47     CALL    !4702H
3a64: 24 0a        MOVW    AX,BC
3a66: 2f 42 00     CMPW    AX,#0042H
3a69: 81 d0        BZ      $3A3BH
3a6b: 24 0a        MOVW    AX,BC
3a6d: 2f 46 00     CMPW    AX,#0046H
3a70: 81 c4        BZ      $3A36H
3a72: 24 0a        MOVW    AX,BC
3a74: 2f 4f 00     CMPW    AX,#004FH
3a77: 81 8d        BZ      $3A06H
3a79: 24 0a        MOVW    AX,BC
3a7b: 2f 44 00     CMPW    AX,#0044H
3a7e: 80 03        BNZ     $3A83H
3a80: 2c d0 39     BR      !39D0H
3a83: 2c 0a 46     BR      !460AH
3a86: 3a af ff     MOV     0FEAFH,#0FFH
3a89: 2c 56 3c     BR      !3C56H
3a8c: 14 0c        BR      $3A9AH
3a8e: 3a af 01     MOV     0FEAFH,#01H
3a91: 14 61        BR      $3AF4H
3a93: 3a af 00     MOV     0FEAFH,#00H
3a96: 14 5c        BR      $3AF4H
3a98: 14 1d        BR      $3AB7H
3a9a: 1c 63        MOVW    AX,0FE63H
3a9c: 24 48        MOVW    DE,AX
3a9e: 06 00 06     MOV     A,[DE+06H]
3aa1: 30 b1        SHR     A,6
3aa3: ac 03        AND     A,#03H
3aa5: b8 00        MOV     X,#00H
3aa7: d8           XCH     A,X
3aa8: 2f 01 00     CMPW    AX,#0001H
3aab: 81 e6        BZ      $3A93H
3aad: 2f 02 00     CMPW    AX,#0002H
3ab0: 81 dc        BZ      $3A8EH
3ab2: 2f 00 00     CMPW    AX,#0000H
3ab5: 81 d7        BZ      $3A8EH
3ab7: 14 0c        BR      $3AC5H
3ab9: 3a af 00     MOV     0FEAFH,#00H
3abc: 14 36        BR      $3AF4H
3abe: 3a af 01     MOV     0FEAFH,#01H
3ac1: 14 31        BR      $3AF4H
3ac3: 14 1d        BR      $3AE2H
3ac5: 1c 63        MOVW    AX,0FE63H
3ac7: 24 48        MOVW    DE,AX
3ac9: 06 00 06     MOV     A,[DE+06H]
3acc: 30 b1        SHR     A,6
3ace: ac 03        AND     A,#03H
3ad0: b8 00        MOV     X,#00H
3ad2: d8           XCH     A,X
3ad3: 2f 01 00     CMPW    AX,#0001H
3ad6: 81 e6        BZ      $3ABEH
3ad8: 2f 02 00     CMPW    AX,#0002H
3adb: 81 dc        BZ      $3AB9H
3add: 2f 00 00     CMPW    AX,#0000H
3ae0: 81 d7        BZ      $3AB9H
3ae2: 3a af 02     MOV     0FEAFH,#02H
3ae5: 14 0d        BR      $3AF4H
3ae7: 3a af 03     MOV     0FEAFH,#03H
3aea: 14 08        BR      $3AF4H
3aec: 3a af 04     MOV     0FEAFH,#04H
3aef: 14 03        BR      $3AF4H
3af1: 3a af 05     MOV     0FEAFH,#05H
3af4: 6f af ff     CMP     0FEAFH,#0FFH
3af7: 81 13        BZ      $3B0CH
3af9: 38 af ba     MOV     0FEBAH,0FEAFH
3afc: 1c b2        MOVW    AX,I2C_OutputBuffer
3afe: 3c           PUSH    AX
3aff: 1c ba        MOVW    AX,0FEBAH
3b01: 1a b2        MOVW    I2C_OutputBuffer,AX
3b03: 28 61 20     CALL    !2061H
3b06: 34           POP     AX
3b07: 1a b2        MOVW    I2C_OutputBuffer,AX
3b09: 2c cb 3d     BR      !3DCBH
3b0c: 2c b3 3c     BR      !3CB3H
3b0f: 28 f5 9b     CALL    !9BF5H
3b12: 24 0a        MOVW    AX,BC
3b14: 2f 01 00     CMPW    AX,#0001H
3b17: 80 3f        BNZ     $3B58H
3b19: 28 75 50     CALL    !5075H
3b1c: 60 2d 10     MOVW    AX,#102DH
3b1f: 3c           PUSH    AX
3b20: 28 79 46     CALL    !4679H
3b23: 34           POP     AX
3b24: 3a af 00     MOV     0FEAFH,#00H
3b27: 6f af 12     CMP     0FEAFH,#12H
3b2a: 82 22        BNC     $3B4EH
3b2c: 1c 70        MOVW    AX,0FE70H
3b2e: 44           INCW    AX
3b2f: 1a 70        MOVW    0FE70H,AX
3b31: 4c           DECW    AX
3b32: 3c           PUSH    AX
3b33: 28 23 51     CALL    !5123H
3b36: 34           POP     AX
3b37: 24 0a        MOVW    AX,BC
3b39: 1a 6a        MOVW    0FE6AH,AX
3b3b: 0c 6c 20 00  MOVW    0FE6CH,#0020H
3b3f: 28 47 4d     CALL    !4D47H
3b42: 60 01 00     MOVW    AX,#0001H
3b45: 3c           PUSH    AX
3b46: 28 43 8b     CALL    !8B43H
3b49: 34           POP     AX
3b4a: 26 af        INC     0FEAFH
3b4c: 14 d9        BR      $3B27H
3b4e: 0c 6a 0d 0a  MOVW    0FE6AH,#0A0DH
3b52: 3a 6c 00     MOV     0FE6CH,#00H
3b55: 28 47 4d     CALL    !4D47H
3b58: 2c b3 3c     BR      !3CB3H
3b5b: 28 f5 9b     CALL    !9BF5H
3b5e: 24 0a        MOVW    AX,BC
3b60: 2f 01 00     CMPW    AX,#0001H
3b63: 80 29        BNZ     $3B8EH
3b65: 28 02 47     CALL    !4702H
3b68: d2           MOV     A,C
3b69: 22 af        MOV     0FEAFH,A
3b6b: aa 30        SUB     A,#30H
3b6d: af 0a        CMP     A,#0AH
3b6f: 82 1d        BNC     $3B8EH
3b71: 20 af        MOV     A,0FEAFH
3b73: ac 0f        AND     A,#0FH
3b75: b8 00        MOV     X,#00H
3b77: d8           XCH     A,X
3b78: 62 a1 df     MOVW    BC,#0DFA1H
3b7b: 88 0a        ADDW    AX,BC
3b7d: 3c           PUSH    AX
3b7e: 09 f0 a5 fd  MOV     A,!0FDA5H
3b82: b8 00        MOV     X,#00H
3b84: d8           XCH     A,X
3b85: 3c           PUSH    AX
3b86: 28 18 7b     CALL    !7B18H
3b89: 34           POP     AX
3b8a: 34           POP     AX
3b8b: 2c cb 3d     BR      !3DCBH
3b8e: 2c b3 3c     BR      !3CB3H
3b91: 28 f5 9b     CALL    !9BF5H
3b94: 24 0a        MOVW    AX,BC
3b96: 2f 01 00     CMPW    AX,#0001H
3b99: 81 03        BZ      $3B9EH
3b9b: 2c 54 3c     BR      !3C54H
3b9e: 28 75 50     CALL    !5075H
3ba1: 3a 6b 00     MOV     0FE6BH,#00H
3ba4: 3a af 00     MOV     0FEAFH,#00H
3ba7: 28 02 47     CALL    !4702H
3baa: d2           MOV     A,C
3bab: 22 6a        MOV     0FE6AH,A
3bad: af 0d        CMP     A,#0DH
3baf: 80 03        BNZ     $3BB4H
3bb1: 2c 51 3c     BR      !3C51H
3bb4: 6f 6a 30     CMP     0FE6AH,#30H
3bb7: 83 06        BC      $3BBFH
3bb9: b9 39        MOV     A,#39H
3bbb: 9f 6a        CMP     A,0FE6AH
3bbd: 82 0e        BNC     $3BCDH
3bbf: 6f 6a 41     CMP     0FE6AH,#41H
3bc2: 82 03        BNC     $3BC7H
3bc4: 2c 46 3c     BR      !3C46H
3bc7: b9 46        MOV     A,#46H
3bc9: 9f 6a        CMP     A,0FE6AH
3bcb: 83 79        BC      $3C46H
3bcd: 20 af        MOV     A,0FEAFH
3bcf: ac 01        AND     A,#01H
3bd1: 81 06        BZ      $3BD9H
3bd3: 20 6b        MOV     A,0FE6BH
3bd5: 31 a1        SHL     A,4
3bd7: 22 6b        MOV     0FE6BH,A
3bd9: b9 39        MOV     A,#39H
3bdb: 9f 6a        CMP     A,0FE6AH
3bdd: 82 05        BNC     $3BE4H
3bdf: 60 37 00     MOVW    AX,#0037H
3be2: 14 03        BR      $3BE7H
3be4: 60 30 00     MOVW    AX,#0030H
3be7: 24 28        MOVW    BC,AX
3be9: 20 6a        MOV     A,0FE6AH
3beb: b8 00        MOV     X,#00H
3bed: d8           XCH     A,X
3bee: 8a 0a        SUBW    AX,BC
3bf0: d0           MOV     A,X
3bf1: 9e 6b        OR      A,0FE6BH
3bf3: 22 6b        MOV     0FE6BH,A
3bf5: 20 af        MOV     A,0FEAFH
3bf7: ac 01        AND     A,#01H
3bf9: 80 11        BNZ     $3C0CH
3bfb: 09 f0 93 fd  MOV     A,!0FD93H
3bff: b8 00        MOV     X,#00H
3c01: d8           XCH     A,X
3c02: 2d 31 fd     ADDW    AX,#0FD31H
3c05: 24 48        MOVW    DE,AX
3c07: 5c           MOV     A,[DE]
3c08: af 0d        CMP     A,#0DH
3c0a: 80 36        BNZ     $3C42H
3c0c: 60 0b 00     MOVW    AX,#000BH
3c0f: 3c           PUSH    AX
3c10: 28 6d 8b     CALL    Delay_Loop
3c13: 34           POP     AX
3c14: 28 ce 7a     CALL    Query_DFBE
3c17: 64 55 d5     MOVW    DE,#0D555H
3c1a: b9 aa        MOV     A,#0AAH
3c1c: 54           MOV     [DE],A
3c1d: 64 aa ca     MOVW    DE,#0CAAAH
3c20: b9 55        MOV     A,#55H
3c22: 54           MOV     [DE],A
3c23: 64 55 d5     MOVW    DE,#0D555H
3c26: b9 a0        MOV     A,#0A0H
3c28: 54           MOV     [DE],A
3c29: 1c 70        MOVW    AX,0FE70H
3c2b: 44           INCW    AX
3c2c: 1a 70        MOVW    0FE70H,AX
3c2e: 4c           DECW    AX
3c2f: 24 48        MOVW    DE,AX
3c31: 20 6b        MOV     A,0FE6BH
3c33: 54           MOV     [DE],A
3c34: 60 0b 00     MOVW    AX,#000BH
3c37: 3c           PUSH    AX
3c38: 28 6d 8b     CALL    Delay_Loop
3c3b: 34           POP     AX
3c3c: 28 ce 7a     CALL    Query_DFBE
3c3f: 3a 6b 00     MOV     0FE6BH,#00H
3c42: 26 af        INC     0FEAFH
3c44: 14 08        BR      $3C4EH
3c46: 6f 6a ff     CMP     0FE6AH,#0FFH
3c49: 81 03        BZ      $3C4EH
3c4b: 2c 0a 46     BR      !460AH
3c4e: 2c a7 3b     BR      !3BA7H
3c51: 2c cb 3d     BR      !3DCBH
3c54: 14 5d        BR      $3CB3H
3c56: 28 02 47     CALL    !4702H
3c59: 24 0a        MOVW    AX,BC
3c5b: 2f 53 00     CMPW    AX,#0053H
3c5e: 80 03        BNZ     $3C63H
3c60: 2c 91 3b     BR      !3B91H
3c63: 24 0a        MOVW    AX,BC
3c65: 2f 49 00     CMPW    AX,#0049H
3c68: 80 03        BNZ     $3C6DH
3c6a: 2c 5b 3b     BR      !3B5BH
3c6d: 24 0a        MOVW    AX,BC
3c6f: 2f 44 00     CMPW    AX,#0044H
3c72: 80 03        BNZ     $3C77H
3c74: 2c 0f 3b     BR      !3B0FH
3c77: 24 0a        MOVW    AX,BC
3c79: 2f 36 00     CMPW    AX,#0036H
3c7c: 80 03        BNZ     $3C81H
3c7e: 2c f1 3a     BR      !3AF1H
3c81: 24 0a        MOVW    AX,BC
3c83: 2f 35 00     CMPW    AX,#0035H
3c86: 80 03        BNZ     $3C8BH
3c88: 2c ec 3a     BR      !3AECH
3c8b: 24 0a        MOVW    AX,BC
3c8d: 2f 34 00     CMPW    AX,#0034H
3c90: 80 03        BNZ     $3C95H
3c92: 2c e7 3a     BR      !3AE7H
3c95: 24 0a        MOVW    AX,BC
3c97: 2f 33 00     CMPW    AX,#0033H
3c9a: 80 03        BNZ     $3C9FH
3c9c: 2c e2 3a     BR      !3AE2H
3c9f: 24 0a        MOVW    AX,BC
3ca1: 2f 32 00     CMPW    AX,#0032H
3ca4: 80 03        BNZ     $3CA9H
3ca6: 2c b7 3a     BR      !3AB7H
3ca9: 24 0a        MOVW    AX,BC
3cab: 2f 31 00     CMPW    AX,#0031H
3cae: 80 03        BNZ     $3CB3H
3cb0: 2c 8c 3a     BR      !3A8CH
3cb3: 2c 0a 46     BR      !460AH
3cb6: 2c 9c 3d     BR      !3D9CH
3cb9: b2 65        SET1    0FE65H.2
3cbb: b2 68        SET1    0FE68H.2
3cbd: 2c c7 3d     BR      !3DC7H
3cc0: a2 65        CLR1    0FE65H.2
3cc2: b2 68        SET1    0FE68H.2
3cc4: 2c c7 3d     BR      !3DC7H
3cc7: 28 a5 25     CALL    !25A5H
3cca: 8a 08        SUBW    AX,AX
3ccc: 8f 0a        CMPW    AX,BC
3cce: 81 03        BZ      $3CD3H
3cd0: 2c 0a 46     BR      !460AH
3cd3: 1c 63        MOVW    AX,0FE63H
3cd5: 24 48        MOVW    DE,AX
3cd7: 06 00 05     MOV     A,[DE+05H]
3cda: 03 89        SET1    A.1
3cdc: 06 80 05     MOV     [DE+05H],A
3cdf: 2c c7 3d     BR      !3DC7H
3ce2: 28 a5 25     CALL    !25A5H
3ce5: 8a 08        SUBW    AX,AX
3ce7: 8f 0a        CMPW    AX,BC
3ce9: 81 03        BZ      $3CEEH
3ceb: 2c 0a 46     BR      !460AH
3cee: 1c 63        MOVW    AX,0FE63H
3cf0: 24 48        MOVW    DE,AX
3cf2: 06 00 05     MOV     A,[DE+05H]
3cf5: 03 99        CLR1    A.1
3cf7: 06 80 05     MOV     [DE+05H],A
3cfa: 2c c7 3d     BR      !3DC7H
3cfd: 08 a5 67 03  BF      0FE67H.5,$3D04H
3d01: 2c 97 3d     BR      !3D97H
3d04: 75 65 03     BT      0FE65H.5,$3D0AH
3d07: 2c 97 3d     BR      !3D97H
3d0a: 3a b0 00     MOV     0FEB0H,#00H
3d0d: 28 02 47     CALL    !4702H
3d10: d2           MOV     A,C
3d11: 22 af        MOV     0FEAFH,A
3d13: af 0d        CMP     A,#0DH
3d15: 81 26        BZ      $3D3DH
3d17: 6f b0 07     CMP     0FEB0H,#07H
3d1a: 82 21        BNC     $3D3DH
3d1c: 38 af ba     MOV     0FEBAH,0FEAFH
3d1f: 1c b2        MOVW    AX,I2C_OutputBuffer
3d21: 3c           PUSH    AX
3d22: 1c ba        MOVW    AX,0FEBAH
3d24: 1a b2        MOVW    I2C_OutputBuffer,AX
3d26: 28 e9 9a     CALL    !9AE9H
3d29: 34           POP     AX
3d2a: 1a b2        MOVW    I2C_OutputBuffer,AX
3d2c: 26 b0        INC     0FEB0H
3d2e: 20 b0        MOV     A,0FEB0H
3d30: c9           DEC     A
3d31: b8 00        MOV     X,#00H
3d33: d8           XCH     A,X
3d34: 2d ab fd     ADDW    AX,#0FDABH
3d37: 24 48        MOVW    DE,AX
3d39: d2           MOV     A,C
3d3a: 54           MOV     [DE],A
3d3b: 14 d0        BR      $3D0DH
3d3d: 6f b0 07     CMP     0FEB0H,#07H
3d40: 82 12        BNC     $3D54H
3d42: 26 b0        INC     0FEB0H
3d44: 20 b0        MOV     A,0FEB0H
3d46: c9           DEC     A
3d47: b8 00        MOV     X,#00H
3d49: d8           XCH     A,X
3d4a: 2d ab fd     ADDW    AX,#0FDABH
3d4d: 24 48        MOVW    DE,AX
3d4f: b9 ff        MOV     A,#0FFH
3d51: 54           MOV     [DE],A
3d52: 14 e9        BR      $3D3DH
3d54: 6f af 0d     CMP     0FEAFH,#0DH
3d57: 80 3e        BNZ     $3D97H
3d59: 09 f0 ab fd  MOV     A,!0FDABH
3d5d: 09 f1 0f fd  MOV     !0FD0FH,A
3d61: 09 f0 ac fd  MOV     A,!0FDACH
3d65: 09 f1 10 fd  MOV     !0FD10H,A
3d69: 09 f0 ad fd  MOV     A,!0FDADH
3d6d: 09 f1 11 fd  MOV     !0FD11H,A
3d71: 09 f0 ae fd  MOV     A,!0FDAEH
3d75: 09 f1 12 fd  MOV     !0FD12H,A
3d79: 09 f0 af fd  MOV     A,!0FDAFH
3d7d: 09 f1 13 fd  MOV     !0FD13H,A
3d81: 09 f0 b0 fd  MOV     A,!0FDB0H
3d85: 09 f1 14 fd  MOV     !0FD14H,A
3d89: 09 f0 b1 fd  MOV     A,!0FDB1H
3d8d: 09 f1 15 fd  MOV     !0FD15H,A
3d91: 28 7b 7c     CALL    !7C7BH
3d94: 2c 8b 44     BR      !448BH
3d97: 2c 0a 46     BR      !460AH
3d9a: 14 2b        BR      $3DC7H
3d9c: 28 02 47     CALL    !4702H
3d9f: d2           MOV     A,C
3da0: 22 af        MOV     0FEAFH,A
3da2: af 43        CMP     A,#43H
3da4: 80 03        BNZ     $3DA9H
3da6: 2c fd 3c     BR      !3CFDH
3da9: af 46        CMP     A,#46H
3dab: 80 03        BNZ     $3DB0H
3dad: 2c e2 3c     BR      !3CE2H
3db0: af 4f        CMP     A,#4FH
3db2: 80 03        BNZ     $3DB7H
3db4: 2c c7 3c     BR      !3CC7H
3db7: af 49        CMP     A,#49H
3db9: 80 03        BNZ     $3DBEH
3dbb: 2c c0 3c     BR      !3CC0H
3dbe: af 41        CMP     A,#41H
3dc0: 80 03        BNZ     $3DC5H
3dc2: 2c b9 3c     BR      !3CB9H
3dc5: 14 d0        BR      $3D97H
3dc7: b4 68        SET1    0FE68H.4
3dc9: b1 68        SET1    0FE68H.1
3dcb: 3a b1 01     MOV     0FEB1H,#01H
3dce: 2c 0a 46     BR      !460AH
3dd1: 14 16        BR      $3DE9H
3dd3: 70 72 0b     BT      0FE72H.0,$3DE1H
3dd6: b0 73        SET1    0FE73H.0
3dd8: 64 a8 fd     MOVW    DE,#0FDA8H
3ddb: 5c           MOV     A,[DE]
3ddc: ac 7f        AND     A,#7FH
3dde: 54           MOV     [DE],A
3ddf: 14 ea        BR      $3DCBH
3de1: 14 17        BR      $3DFAH
3de3: a0 73        CLR1    0FE73H.0
3de5: 14 e4        BR      $3DCBH
3de7: 14 11        BR      $3DFAH
3de9: 28 02 47     CALL    !4702H
3dec: 24 0a        MOVW    AX,BC
3dee: 2f 46 00     CMPW    AX,#0046H
3df1: 81 f0        BZ      $3DE3H
3df3: 24 0a        MOVW    AX,BC
3df5: 2f 4f 00     CMPW    AX,#004FH
3df8: 81 d9        BZ      $3DD3H
3dfa: 2c 0a 46     BR      !460AH
3dfd: 28 02 47     CALL    !4702H
3e00: d2           MOV     A,C
3e01: 22 af        MOV     0FEAFH,A
3e03: 70 66 0d     BT      0FE66H.0,$3E13H
3e06: 6f af 4f     CMP     0FEAFH,#4FH
3e09: 81 08        BZ      $3E13H
3e0b: 6f af 46     CMP     0FEAFH,#46H
3e0e: 81 03        BZ      $3E13H
3e10: 3a af 00     MOV     0FEAFH,#00H
3e13: 2c d3 3e     BR      !3ED3H
3e16: 28 f5 9b     CALL    !9BF5H
3e19: 24 0a        MOVW    AX,BC
3e1b: 2f 01 00     CMPW    AX,#0001H
3e1e: 80 15        BNZ     $3E35H
3e20: 28 02 47     CALL    !4702H
3e23: d2           MOV     A,C
3e24: 22 af        MOV     0FEAFH,A
3e26: 77 02 0c     BT      P2.7,$3E35H
3e29: 20 af        MOV     A,0FEAFH
3e2b: 09 f1 0b fd  MOV     !0FD0BH,A
3e2f: b2 7d        SET1    0FE7DH.2
3e31: b6 73        SET1    0FE73H.6
3e33: 14 96        BR      $3DCBH
3e35: 2c ff 3e     BR      !3EFFH
3e38: 28 f5 9b     CALL    !9BF5H
3e3b: 24 0a        MOVW    AX,BC
3e3d: 2f 01 00     CMPW    AX,#0001H
3e40: 80 26        BNZ     $3E68H
3e42: 77 02 23     BT      P2.7,$3E68H
3e45: 1c 63        MOVW    AX,0FE63H
3e47: 24 48        MOVW    DE,AX
3e49: 06 00 06     MOV     A,[DE+06H]
3e4c: 30 99        SHR     A,3
3e4e: ac 07        AND     A,#07H
3e50: b8 00        MOV     X,#00H
3e52: d8           XCH     A,X
3e53: 62 b0 df     MOVW    BC,#0DFB0H
3e56: 88 0a        ADDW    AX,BC
3e58: 3c           PUSH    AX
3e59: 09 f0 0b fd  MOV     A,!0FD0BH
3e5d: b8 00        MOV     X,#00H
3e5f: d8           XCH     A,X
3e60: 3c           PUSH    AX
3e61: 28 18 7b     CALL    !7B18H
3e64: 34           POP     AX
3e65: 34           POP     AX
3e66: 14 c7        BR      $3E2FH
3e68: 2c ff 3e     BR      !3EFFH
3e6b: 28 0e 8c     CALL    !8C0EH
3e6e: 2c cb 3d     BR      !3DCBH
3e71: 28 89 8c     CALL    !8C89H
3e74: 2c cb 3d     BR      !3DCBH
3e77: 77 02 08     BT      P2.7,$3E82H
3e7a: 64 0b fd     MOVW    DE,#0FD0BH
3e7d: 5c           MOV     A,[DE]
3e7e: c1           INC     A
3e7f: 54           MOV     [DE],A
3e80: 14 ad        BR      $3E2FH
3e82: 14 7b        BR      $3EFFH
3e84: 77 02 08     BT      P2.7,$3E8FH
3e87: 64 0b fd     MOVW    DE,#0FD0BH
3e8a: 5c           MOV     A,[DE]
3e8b: c9           DEC     A
3e8c: 54           MOV     [DE],A
3e8d: 14 a0        BR      $3E2FH
3e8f: 14 6e        BR      $3EFFH
3e91: 28 02 47     CALL    !4702H
3e94: d2           MOV     A,C
3e95: 22 af        MOV     0FEAFH,A
3e97: 6f af 0d     CMP     0FEAFH,#0DH
3e9a: 80 0f        BNZ     $3EABH
3e9c: 09 f0 30 fd  MOV     A,!0FD30H
3ea0: 03 8b        SET1    A.3
3ea2: 09 f1 30 fd  MOV     !0FD30H,A
3ea6: 2c cb 3d     BR      !3DCBH
3ea9: 14 24        BR      $3ECFH
3eab: 6f af 30     CMP     0FEAFH,#30H
3eae: 83 1f        BC      $3ECFH
3eb0: b9 39        MOV     A,#39H
3eb2: 9f af        CMP     A,0FEAFH
3eb4: 83 19        BC      $3ECFH
3eb6: 20 af        MOV     A,0FEAFH
3eb8: b8 00        MOV     X,#00H
3eba: d8           XCH     A,X
3ebb: 3c           PUSH    AX
3ebc: 28 b9 47     CALL    !47B9H
3ebf: 34           POP     AX
3ec0: 28 f0 8c     CALL    !8CF0H
3ec3: 8a 08        SUBW    AX,AX
3ec5: 8f 0a        CMPW    AX,BC
3ec7: 81 06        BZ      $3ECFH
3ec9: 28 7b 7c     CALL    !7C7BH
3ecc: 2c cb 3d     BR      !3DCBH
3ecf: 14 2e        BR      $3EFFH
3ed1: 14 2c        BR      $3EFFH
3ed3: 6f af 52     CMP     0FEAFH,#52H
3ed6: 81 b9        BZ      $3E91H
3ed8: 6f af 2d     CMP     0FEAFH,#2DH
3edb: 81 a7        BZ      $3E84H
3edd: 6f af 2b     CMP     0FEAFH,#2BH
3ee0: 81 95        BZ      $3E77H
3ee2: 6f af 46     CMP     0FEAFH,#46H
3ee5: 81 8a        BZ      $3E71H
3ee7: 6f af 4f     CMP     0FEAFH,#4FH
3eea: 80 03        BNZ     $3EEFH
3eec: 2c 6b 3e     BR      !3E6BH
3eef: 6f af 53     CMP     0FEAFH,#53H
3ef2: 80 03        BNZ     $3EF7H
3ef4: 2c 38 3e     BR      !3E38H
3ef7: 6f af 41     CMP     0FEAFH,#41H
3efa: 80 03        BNZ     $3EFFH
3efc: 2c 16 3e     BR      !3E16H
3eff: 2c 0a 46     BR      !460AH
3f02: 28 50 4d     CALL    !4D50H
3f05: 60 07 00     MOVW    AX,#0007H
3f08: 8f 0a        CMPW    AX,BC
3f0a: 83 03        BC      $3F0FH
3f0c: 2c c0 3f     BR      !3FC0H
3f0f: 1c 63        MOVW    AX,0FE63H
3f11: 24 28        MOVW    BC,AX
3f13: 05 e3        MOVW    AX,[HL]
3f15: 24 48        MOVW    DE,AX
3f17: 3f           PUSH    HL
3f18: 24 6a        MOVW    HL,BC
3f1a: 3d           PUSH    BC
3f1b: ba 07        MOV     C,#07H
3f1d: 59           MOV     A,[HL+]
3f1e: 50           MOV     [DE+],A
3f1f: 32 fc        DBNZ    C,$3F1DH
3f21: 35           POP     BC
3f22: 37           POP     HL
3f23: 28 02 47     CALL    !4702H
3f26: 1c 63        MOVW    AX,0FE63H
3f28: 24 48        MOVW    DE,AX
3f2a: d2           MOV     A,C
3f2b: 54           MOV     [DE],A
3f2c: 3a ac 01     MOV     0FEACH,#01H
3f2f: 3a ae 01     MOV     0FEAEH,#01H
3f32: b9 04        MOV     A,#04H
3f34: 9f ae        CMP     A,0FEAEH
3f36: 83 2d        BC      $3F65H
3f38: 28 02 47     CALL    !4702H
3f3b: d2           MOV     A,C
3f3c: 22 ad        MOV     0FEADH,A
3f3e: b8 00        MOV     X,#00H
3f40: d8           XCH     A,X
3f41: 3c           PUSH    AX
3f42: 28 74 9d     CALL    !9D74H
3f45: 34           POP     AX
3f46: 8a 08        SUBW    AX,AX
3f48: 8f 0a        CMPW    AX,BC
3f4a: 81 12        BZ      $3F5EH
3f4c: 1c 63        MOVW    AX,0FE63H
3f4e: 24 48        MOVW    DE,AX
3f50: 20 ae        MOV     A,0FEAEH
3f52: b8 00        MOV     X,#00H
3f54: d8           XCH     A,X
3f55: 88 0c        ADDW    AX,DE
3f57: 24 48        MOVW    DE,AX
3f59: 20 ad        MOV     A,0FEADH
3f5b: 54           MOV     [DE],A
3f5c: 14 03        BR      $3F61H
3f5e: 3a ac 00     MOV     0FEACH,#00H
3f61: 26 ae        INC     0FEAEH
3f63: 14 cd        BR      $3F32H
3f65: 28 02 47     CALL    !4702H
3f68: 1c 63        MOVW    AX,0FE63H
3f6a: 24 08        MOVW    AX,AX
3f6c: 2d 05 00     ADDW    AX,#0005H
3f6f: 24 48        MOVW    DE,AX
3f71: d2           MOV     A,C
3f72: 54           MOV     [DE],A
3f73: 28 02 47     CALL    !4702H
3f76: 1c 63        MOVW    AX,0FE63H
3f78: 24 08        MOVW    AX,AX
3f7a: 2d 06 00     ADDW    AX,#0006H
3f7d: 24 48        MOVW    DE,AX
3f7f: d2           MOV     A,C
3f80: 54           MOV     [DE],A
3f81: 6f ac 00     CMP     0FEACH,#00H
3f84: 81 26        BZ      $3FACH
3f86: 1c 63        MOVW    AX,0FE63H
3f88: 24 08        MOVW    AX,AX
3f8a: 44           INCW    AX
3f8b: 3c           PUSH    AX
3f8c: 28 65 8d     CALL    !8D65H
3f8f: 34           POP     AX
3f90: d2           MOV     A,C
3f91: 22 ad        MOV     0FEADH,A
3f93: ac 01        AND     A,#01H
3f95: 81 15        BZ      $3FACH
3f97: 20 ad        MOV     A,0FEADH
3f99: b8 00        MOV     X,#00H
3f9b: d8           XCH     A,X
3f9c: 3c           PUSH    AX
3f9d: 28 03 9c     CALL    !9C03H
3fa0: 34           POP     AX
3fa1: 8a 08        SUBW    AX,AX
3fa3: 8f 0a        CMPW    AX,BC
3fa5: 81 05        BZ      $3FACH
3fa7: a5 65        CLR1    0FE65H.5
3fa9: 2c 8b 44     BR      !448BH
3fac: 05 e3        MOVW    AX,[HL]
3fae: 24 28        MOVW    BC,AX
3fb0: 1c 63        MOVW    AX,0FE63H
3fb2: 24 48        MOVW    DE,AX
3fb4: 3f           PUSH    HL
3fb5: 24 6a        MOVW    HL,BC
3fb7: 3d           PUSH    BC
3fb8: ba 07        MOV     C,#07H
3fba: 59           MOV     A,[HL+]
3fbb: 50           MOV     [DE+],A
3fbc: 32 fc        DBNZ    C,$3FBAH
3fbe: 35           POP     BC
3fbf: 37           POP     HL
3fc0: 2c 0a 46     BR      !460AH
3fc3: b9 00        MOV     A,#00H
3fc5: 09 f1 a8 fd  MOV     !0FDA8H,A
3fc9: 28 02 47     CALL    !4702H
3fcc: d2           MOV     A,C
3fcd: 22 af        MOV     0FEAFH,A
3fcf: 14 7d        BR      $404EH
3fd1: b9 1f        MOV     A,#1FH
3fd3: 09 f1 a8 fd  MOV     !0FDA8H,A
3fd7: 14 f0        BR      $3FC9H
3fd9: 64 a8 fd     MOVW    DE,#0FDA8H
3fdc: 5c           MOV     A,[DE]
3fdd: ae 02        OR      A,#02H
3fdf: 54           MOV     [DE],A
3fe0: 14 e7        BR      $3FC9H
3fe2: 64 a8 fd     MOVW    DE,#0FDA8H
3fe5: 5c           MOV     A,[DE]
3fe6: ae 01        OR      A,#01H
3fe8: 54           MOV     [DE],A
3fe9: 14 de        BR      $3FC9H
3feb: 64 a8 fd     MOVW    DE,#0FDA8H
3fee: 5c           MOV     A,[DE]
3fef: ae 04        OR      A,#04H
3ff1: 54           MOV     [DE],A
3ff2: 14 d5        BR      $3FC9H
3ff4: 64 a8 fd     MOVW    DE,#0FDA8H
3ff7: 5c           MOV     A,[DE]
3ff8: ae 08        OR      A,#08H
3ffa: 54           MOV     [DE],A
3ffb: 14 cc        BR      $3FC9H
3ffd: 70 73 07     BT      0FE73H.0,$4007H
4000: 64 a8 fd     MOVW    DE,#0FDA8H
4003: 5c           MOV     A,[DE]
4004: ae 80        OR      A,#80H
4006: 54           MOV     [DE],A
4007: 14 c0        BR      $3FC9H
4009: 14 14        BR      $401FH
400b: 64 a8 fd     MOVW    DE,#0FDA8H
400e: 5c           MOV     A,[DE]
400f: ae 10        OR      A,#10H
4011: 54           MOV     [DE],A
4012: 14 b5        BR      $3FC9H
4014: 3a 8a 00     MOV     0FE8AH,#00H
4017: b9 00        MOV     A,#00H
4019: 09 f1 a8 fd  MOV     !0FDA8H,A
401d: 14 0c        BR      $402BH
401f: 28 02 47     CALL    !4702H
4022: d2           MOV     A,C
4023: 22 af        MOV     0FEAFH,A
4025: af 53        CMP     A,#53H
4027: 81 e2        BZ      $400BH
4029: 14 e9        BR      $4014H
402b: 2c 0a 46     BR      !460AH
402e: 09 f0 a8 fd  MOV     A,!0FDA8H
4032: af 80        CMP     A,#80H
4034: 80 0b        BNZ     $4041H
4036: 3a 8a 00     MOV     0FE8AH,#00H
4039: b9 00        MOV     A,#00H
403b: 09 f1 a8 fd  MOV     !0FDA8H,A
403f: 14 06        BR      $4047H
4041: 3a 8a 01     MOV     0FE8AH,#01H
4044: 2c 0a 46     BR      !460AH
4047: 14 38        BR      $4081H
4049: 2c c9 3f     BR      !3FC9H
404c: 14 33        BR      $4081H
404e: 6f af 0d     CMP     0FEAFH,#0DH
4051: 81 db        BZ      $402EH
4053: 6f af 53     CMP     0FEAFH,#53H
4056: 81 b1        BZ      $4009H
4058: 6f af 52     CMP     0FEAFH,#52H
405b: 81 a0        BZ      $3FFDH
405d: 6f af 4e     CMP     0FEAFH,#4EH
4060: 81 92        BZ      $3FF4H
4062: 6f af 4d     CMP     0FEAFH,#4DH
4065: 81 84        BZ      $3FEBH
4067: 6f af 46     CMP     0FEAFH,#46H
406a: 80 03        BNZ     $406FH
406c: 2c e2 3f     BR      !3FE2H
406f: 6f af 43     CMP     0FEAFH,#43H
4072: 80 03        BNZ     $4077H
4074: 2c d9 3f     BR      !3FD9H
4077: 6f af 41     CMP     0FEAFH,#41H
407a: 80 03        BNZ     $407FH
407c: 2c d1 3f     BR      !3FD1H
407f: 14 c8        BR      $4049H
4081: 2c 0a 46     BR      !460AH
4084: 2c 4e 42     BR      !424EH
4087: 09 f0 97 fd  MOV     A,!0FD97H
408b: ac f1        AND     A,#0F1H
408d: ae 02        OR      A,#02H
408f: 09 f1 97 fd  MOV     !0FD97H,A
4093: 2c cd 42     BR      !42CDH
4096: 09 f0 97 fd  MOV     A,!0FD97H
409a: ac f1        AND     A,#0F1H
409c: ae 04        OR      A,#04H
409e: 09 f1 97 fd  MOV     !0FD97H,A
40a2: 2c cd 42     BR      !42CDH
40a5: 09 f0 97 fd  MOV     A,!0FD97H
40a9: ac f1        AND     A,#0F1H
40ab: ae 08        OR      A,#08H
40ad: 09 f1 97 fd  MOV     !0FD97H,A
40b1: 2c cd 42     BR      !42CDH
40b4: 09 f0 97 fd  MOV     A,!0FD97H
40b8: ac 1f        AND     A,#1FH
40ba: ae 20        OR      A,#20H
40bc: 09 f1 97 fd  MOV     !0FD97H,A
40c0: 2c cd 42     BR      !42CDH
40c3: 09 f0 97 fd  MOV     A,!0FD97H
40c7: ac 1f        AND     A,#1FH
40c9: ae 40        OR      A,#40H
40cb: 09 f1 97 fd  MOV     !0FD97H,A
40cf: 2c cd 42     BR      !42CDH
40d2: 09 f0 97 fd  MOV     A,!0FD97H
40d6: ac 1f        AND     A,#1FH
40d8: ae 80        OR      A,#80H
40da: 09 f1 97 fd  MOV     !0FD97H,A
40de: 2c cd 42     BR      !42CDH
40e1: 14 44        BR      $4127H
40e3: 08 a6 65 02  BF      0FE65H.6,$40E9H
40e7: 14 31        BR      $411AH
40e9: 08 a3 67 11  BF      0FE67H.3,$40FEH
40ed: 09 f0 98 fd  MOV     A,!0FD98H
40f1: ac 0f        AND     A,#0FH
40f3: b8 00        MOV     X,#00H
40f5: d8           XCH     A,X
40f6: 2d 99 fd     ADDW    AX,#0FD99H
40f9: 24 48        MOVW    DE,AX
40fb: 20 8c        MOV     A,0FE8CH
40fd: 54           MOV     [DE],A
40fe: a3 67        CLR1    0FE67H.3
4100: 28 d4 29     CALL    !29D4H
4103: 8a 08        SUBW    AX,AX
4105: 8f 0a        CMPW    AX,BC
4107: 80 0b        BNZ     $4114H
4109: 60 30 10     MOVW    AX,#1030H
410c: 64 95 fd     MOVW    DE,#0FD95H
410f: 05 e6        MOVW    [DE],AX
4111: 2c c9 3d     BR      !3DC9H
4114: 28 b3 2c     CALL    !2CB3H
4117: 2c 8b 44     BR      !448BH
411a: a6 65        CLR1    0FE65H.6
411c: 3a 82 00     MOV     0FE82H,#00H
411f: 28 b3 2c     CALL    !2CB3H
4122: 2c 8b 44     BR      !448BH
4125: 14 18        BR      $413FH
4127: 28 02 47     CALL    !4702H
412a: 24 0a        MOVW    AX,BC
412c: 2f 46 00     CMPW    AX,#0046H
412f: 81 e9        BZ      $411AH
4131: 24 0a        MOVW    AX,BC
4133: 2f 4f 00     CMPW    AX,#004FH
4136: 81 b1        BZ      $40E9H
4138: 24 0a        MOVW    AX,BC
413a: 2f 0d 00     CMPW    AX,#000DH
413d: 81 a4        BZ      $40E3H
413f: 2c cd 42     BR      !42CDH
4142: 1c 63        MOVW    AX,0FE63H
4144: 24 48        MOVW    DE,AX
4146: 06 00 06     MOV     A,[DE+06H]
4149: 30 99        SHR     A,3
414b: ac 07        AND     A,#07H
414d: b8 00        MOV     X,#00H
414f: d8           XCH     A,X
4150: 2f 05 00     CMPW    AX,#0005H
4153: 80 0b        BNZ     $4160H
4155: 1c 63        MOVW    AX,0FE63H
4157: 24 48        MOVW    DE,AX
4159: 5c           MOV     A,[DE]
415a: 03 9a        CLR1    A.2
415c: 54           MOV     [DE],A
415d: 2c c7 3d     BR      !3DC7H
4160: 2c 0a 46     BR      !460AH
4163: 1c 63        MOVW    AX,0FE63H
4165: 24 48        MOVW    DE,AX
4167: 06 00 06     MOV     A,[DE+06H]
416a: 30 99        SHR     A,3
416c: ac 07        AND     A,#07H
416e: b8 00        MOV     X,#00H
4170: d8           XCH     A,X
4171: 2f 05 00     CMPW    AX,#0005H
4174: 80 0e        BNZ     $4184H
4176: 1c 63        MOVW    AX,0FE63H
4178: 24 48        MOVW    DE,AX
417a: 5c           MOV     A,[DE]
417b: 03 8a        SET1    A.2
417d: 54           MOV     [DE],A
417e: 3a 89 64     MOV     0FE89H,#64H
4181: 2c c7 3d     BR      !3DC7H
4184: 2c 0a 46     BR      !460AH
4187: 14 0c        BR      $4195H
4189: b4 66        SET1    0FE66H.4
418b: 2c cb 3d     BR      !3DCBH
418e: a4 66        CLR1    0FE66H.4
4190: 2c cb 3d     BR      !3DCBH
4193: 14 11        BR      $41A6H
4195: 28 02 47     CALL    !4702H
4198: 24 0a        MOVW    AX,BC
419a: 2f 45 00     CMPW    AX,#0045H
419d: 81 ef        BZ      $418EH
419f: 24 0a        MOVW    AX,BC
41a1: 2f 55 00     CMPW    AX,#0055H
41a4: 81 e3        BZ      $4189H
41a6: 2c cd 42     BR      !42CDH
41a9: 14 59        BR      $4204H
41ab: 76 65 08     BT      0FE65H.6,$41B6H
41ae: b9 01        MOV     A,#01H
41b0: 09 f1 a3 fd  MOV     !0FDA3H,A
41b4: 14 03        BR      $41B9H
41b6: 2c 0a 46     BR      !460AH
41b9: 14 71        BR      $422CH
41bb: b9 02        MOV     A,#02H
41bd: 09 f1 a3 fd  MOV     !0FDA3H,A
41c1: 1c 63        MOVW    AX,0FE63H
41c3: 24 48        MOVW    DE,AX
41c5: 60 01 00     MOVW    AX,#0001H
41c8: 88 0c        ADDW    AX,DE
41ca: 24 48        MOVW    DE,AX
41cc: b9 f0        MOV     A,#0F0H
41ce: 16 4c        AND     A,[DE]
41d0: 54           MOV     [DE],A
41d1: 14 59        BR      $422CH
41d3: b9 03        MOV     A,#03H
41d5: 09 f1 a3 fd  MOV     !0FDA3H,A
41d9: 1c 63        MOVW    AX,0FE63H
41db: 24 48        MOVW    DE,AX
41dd: 60 01 00     MOVW    AX,#0001H
41e0: 88 0c        ADDW    AX,DE
41e2: 24 48        MOVW    DE,AX
41e4: b9 00        MOV     A,#00H
41e6: 54           MOV     [DE],A
41e7: 14 43        BR      $422CH
41e9: 08 a6 65 08  BF      0FE65H.6,$41F5H
41ed: b9 04        MOV     A,#04H
41ef: 09 f1 a3 fd  MOV     !0FDA3H,A
41f3: 14 03        BR      $41F8H
41f5: 2c 0a 46     BR      !460AH
41f8: 14 32        BR      $422CH
41fa: 28 d3 26     CALL    !26D3H
41fd: 14 2d        BR      $422CH
41ff: 2c 0a 46     BR      !460AH
4202: 14 28        BR      $422CH
4204: 28 02 47     CALL    !4702H
4207: 24 0a        MOVW    AX,BC
4209: 2f 0d 00     CMPW    AX,#000DH
420c: 81 ec        BZ      $41FAH
420e: 24 0a        MOVW    AX,BC
4210: 2f 33 00     CMPW    AX,#0033H
4213: 81 d4        BZ      $41E9H
4215: 24 0a        MOVW    AX,BC
4217: 2f 32 00     CMPW    AX,#0032H
421a: 81 b7        BZ      $41D3H
421c: 24 0a        MOVW    AX,BC
421e: 2f 31 00     CMPW    AX,#0031H
4221: 81 98        BZ      $41BBH
4223: 24 0a        MOVW    AX,BC
4225: 2f 30 00     CMPW    AX,#0030H
4228: 81 81        BZ      $41ABH
422a: 14 d3        BR      $41FFH
422c: b2 68        SET1    0FE68H.2
422e: 2c cb 3d     BR      !3DCBH
4231: 1c 63        MOVW    AX,0FE63H
4233: 24 48        MOVW    DE,AX
4235: 5c           MOV     A,[DE]
4236: 03 8c        SET1    A.4
4238: 54           MOV     [DE],A
4239: b2 68        SET1    0FE68H.2
423b: 2c cb 3d     BR      !3DCBH
423e: 1c 63        MOVW    AX,0FE63H
4240: 24 48        MOVW    DE,AX
4242: 5c           MOV     A,[DE]
4243: 03 9c        CLR1    A.4
4245: 54           MOV     [DE],A
4246: b2 68        SET1    0FE68H.2
4248: 2c cb 3d     BR      !3DCBH
424b: 2c cd 42     BR      !42CDH
424e: 28 02 47     CALL    !4702H
4251: 24 0a        MOVW    AX,BC
4253: 2f 4b 00     CMPW    AX,#004BH
4256: 81 e6        BZ      $423EH
4258: 24 0a        MOVW    AX,BC
425a: 2f 4d 00     CMPW    AX,#004DH
425d: 81 d2        BZ      $4231H
425f: 24 0a        MOVW    AX,BC
4261: 2f 54 00     CMPW    AX,#0054H
4264: 80 03        BNZ     $4269H
4266: 2c a9 41     BR      !41A9H
4269: 24 0a        MOVW    AX,BC
426b: 2f 53 00     CMPW    AX,#0053H
426e: 80 03        BNZ     $4273H
4270: 2c 87 41     BR      !4187H
4273: 24 0a        MOVW    AX,BC
4275: 2f 4f 00     CMPW    AX,#004FH
4278: 80 03        BNZ     $427DH
427a: 2c 63 41     BR      !4163H
427d: 24 0a        MOVW    AX,BC
427f: 2f 46 00     CMPW    AX,#0046H
4282: 80 03        BNZ     $4287H
4284: 2c 42 41     BR      !4142H
4287: 24 0a        MOVW    AX,BC
4289: 2f 43 00     CMPW    AX,#0043H
428c: 80 03        BNZ     $4291H
428e: 2c e1 40     BR      !40E1H
4291: 24 0a        MOVW    AX,BC
4293: 2f 36 00     CMPW    AX,#0036H
4296: 80 03        BNZ     $429BH
4298: 2c d2 40     BR      !40D2H
429b: 24 0a        MOVW    AX,BC
429d: 2f 35 00     CMPW    AX,#0035H
42a0: 80 03        BNZ     $42A5H
42a2: 2c c3 40     BR      !40C3H
42a5: 24 0a        MOVW    AX,BC
42a7: 2f 34 00     CMPW    AX,#0034H
42aa: 80 03        BNZ     $42AFH
42ac: 2c b4 40     BR      !40B4H
42af: 24 0a        MOVW    AX,BC
42b1: 2f 33 00     CMPW    AX,#0033H
42b4: 80 03        BNZ     $42B9H
42b6: 2c a5 40     BR      !40A5H
42b9: 24 0a        MOVW    AX,BC
42bb: 2f 32 00     CMPW    AX,#0032H
42be: 80 03        BNZ     $42C3H
42c0: 2c 96 40     BR      !4096H
42c3: 24 0a        MOVW    AX,BC
42c5: 2f 31 00     CMPW    AX,#0031H
42c8: 80 03        BNZ     $42CDH
42ca: 2c 87 40     BR      !4087H
42cd: 2c c9 3d     BR      !3DC9H
42d0: 2c 88 43     BR      !4388H
42d3: 3a ba 01     MOV     0FEBAH,#01H
42d6: 1c b2        MOVW    AX,I2C_OutputBuffer
42d8: 3c           PUSH    AX
42d9: 1c ba        MOVW    AX,0FEBAH
42db: 1a b2        MOVW    I2C_OutputBuffer,AX
42dd: 28 86 4d     CALL    !4D86H
42e0: 34           POP     AX
42e1: 1a b2        MOVW    I2C_OutputBuffer,AX
42e3: 8a 08        SUBW    AX,AX
42e5: 8f 0a        CMPW    AX,BC
42e7: 81 03        BZ      $42ECH
42e9: 2c c9 3d     BR      !3DC9H
42ec: 2c e3 43     BR      !43E3H
42ef: 3a ba 00     MOV     0FEBAH,#00H
42f2: 1c b2        MOVW    AX,I2C_OutputBuffer
42f4: 3c           PUSH    AX
42f5: 1c ba        MOVW    AX,0FEBAH
42f7: 1a b2        MOVW    I2C_OutputBuffer,AX
42f9: 28 86 4d     CALL    !4D86H
42fc: 34           POP     AX
42fd: 1a b2        MOVW    I2C_OutputBuffer,AX
42ff: 8a 08        SUBW    AX,AX
4301: 8f 0a        CMPW    AX,BC
4303: 81 03        BZ      $4308H
4305: 2c c9 3d     BR      !3DC9H
4308: 2c e3 43     BR      !43E3H
430b: b3 65        SET1    0FE65H.3
430d: 3a 86 05     MOV     0FE86H,#05H
4310: b2 68        SET1    0FE68H.2
4312: b1 69        SET1    0FE69H.1
4314: 2c cb 3d     BR      !3DCBH
4317: b2 72        SET1    0FE72H.2
4319: 2c c7 3d     BR      !3DC7H
431c: a2 72        CLR1    0FE72H.2
431e: 2c c7 3d     BR      !3DC7H
4321: 14 0c        BR      $432FH
4323: b1 73        SET1    0FE73H.1
4325: 2c cb 3d     BR      !3DCBH
4328: a1 73        CLR1    0FE73H.1
432a: 2c c7 3d     BR      !3DC7H
432d: 14 11        BR      $4340H
432f: 28 02 47     CALL    !4702H
4332: 24 0a        MOVW    AX,BC
4334: 2f 46 00     CMPW    AX,#0046H
4337: 81 ef        BZ      $4328H
4339: 24 0a        MOVW    AX,BC
433b: 2f 4f 00     CMPW    AX,#004FH
433e: 81 e3        BZ      $4323H
4340: 2c e3 43     BR      !43E3H
4343: 64 f4 df     MOVW    DE,#0DFF4H
4346: 3e           PUSH    DE
4347: 28 14 48     CALL    !4814H
434a: 34           POP     AX
434b: 24 0a        MOVW    AX,BC
434d: 2f 01 00     CMPW    AX,#0001H
4350: 80 03        BNZ     $4355H
4352: 2c cb 3d     BR      !3DCBH
4355: 2c e3 43     BR      !43E3H
4358: 64 fa df     MOVW    DE,#0DFFAH
435b: 3e           PUSH    DE
435c: 28 14 48     CALL    !4814H
435f: 34           POP     AX
4360: 24 0a        MOVW    AX,BC
4362: 2f 01 00     CMPW    AX,#0001H
4365: 80 03        BNZ     $436AH
4367: 2c cb 3d     BR      !3DCBH
436a: 14 77        BR      $43E3H
436c: a0 a1        CLR1    0FEA1H.0
436e: 64 25 fd     MOVW    DE,#0FD25H
4371: 3e           PUSH    DE
4372: 28 50 49     CALL    !4950H
4375: 34           POP     AX
4376: 2c c9 3d     BR      !3DC9H
4379: b0 a1        SET1    0FEA1H.0
437b: 64 28 fd     MOVW    DE,#0FD28H
437e: 3e           PUSH    DE
437f: 28 50 49     CALL    !4950H
4382: 34           POP     AX
4383: 2c c9 3d     BR      !3DC9H
4386: 14 5b        BR      $43E3H
4388: 28 02 47     CALL    !4702H
438b: 24 0a        MOVW    AX,BC
438d: 2f 55 00     CMPW    AX,#0055H
4390: 81 e7        BZ      $4379H
4392: 24 0a        MOVW    AX,BC
4394: 2f 4c 00     CMPW    AX,#004CH
4397: 81 d3        BZ      $436CH
4399: 24 0a        MOVW    AX,BC
439b: 2f 32 00     CMPW    AX,#0032H
439e: 81 b8        BZ      $4358H
43a0: 24 0a        MOVW    AX,BC
43a2: 2f 31 00     CMPW    AX,#0031H
43a5: 81 9c        BZ      $4343H
43a7: 24 0a        MOVW    AX,BC
43a9: 2f 53 00     CMPW    AX,#0053H
43ac: 80 03        BNZ     $43B1H
43ae: 2c 21 43     BR      !4321H
43b1: 24 0a        MOVW    AX,BC
43b3: 2f 46 00     CMPW    AX,#0046H
43b6: 80 03        BNZ     $43BBH
43b8: 2c 1c 43     BR      !431CH
43bb: 24 0a        MOVW    AX,BC
43bd: 2f 4f 00     CMPW    AX,#004FH
43c0: 80 03        BNZ     $43C5H
43c2: 2c 17 43     BR      !4317H
43c5: 24 0a        MOVW    AX,BC
43c7: 2f 49 00     CMPW    AX,#0049H
43ca: 80 03        BNZ     $43CFH
43cc: 2c 0b 43     BR      !430BH
43cf: 24 0a        MOVW    AX,BC
43d1: 2f 44 00     CMPW    AX,#0044H
43d4: 80 03        BNZ     $43D9H
43d6: 2c ef 42     BR      !42EFH
43d9: 24 0a        MOVW    AX,BC
43db: 2f 45 00     CMPW    AX,#0045H
43de: 80 03        BNZ     $43E3H
43e0: 2c d3 42     BR      !42D3H
43e3: 2c 0a 46     BR      !460AH
43e6: 08 a6 65 0c  BF      0FE65H.6,$43F6H
43ea: 09 f0 98 fd  MOV     A,!0FD98H
43ee: 03 8c        SET1    A.4
43f0: 09 f1 98 fd  MOV     !0FD98H,A
43f4: 14 19        BR      $440FH
43f6: 08 a5 65 0b  BF      0FE65H.5,$4405H
43fa: 74 65 08     BT      0FE65H.4,$4405H
43fd: 28 17 7e     CALL    !7E17H
4400: 28 43 7d     CALL    !7D43H
4403: 14 0a        BR      $440FH
4405: 75 69 03     BT      0FE69H.5,$440BH
4408: 3a 75 00     MOV     Wheel_Count,#00H
440b: b5 69        SET1    0FE69H.5
440d: 26 75        INC     Wheel_Count
440f: 28 16 20     CALL    !2016H
4412: 2c 0a 46     BR      !460AH
4415: 14 61        BR      $4478H
4417: 08 a5 65 1e  BF      0FE65H.5,$4439H
441b: 28 40 2d     CALL    !2D40H
441e: a5 65        CLR1    0FE65H.5
4420: 60 0f 00     MOVW    AX,#000FH
4423: 3c           PUSH    AX
4424: 28 6d 8b     CALL    Delay_Loop
4427: 34           POP     AX
4428: 28 ce 7a     CALL    Query_DFBE
442b: 1c 63        MOVW    AX,0FE63H
442d: 3c           PUSH    AX
442e: 60 80 df     MOVW    AX,#0DF80H
4431: 3c           PUSH    AX
4432: 28 a8 9a     CALL    !9AA8H
4435: 34           POP     AX
4436: 34           POP     AX
4437: b2 68        SET1    0FE68H.2
4439: 0c 63 55 fe  MOVW    0FE63H,#0FE55H
443d: 28 2b 92     CALL    !922BH
4440: 28 16 20     CALL    !2016H
4443: 14 46        BR      $448BH
4445: 08 a5 65 1e  BF      0FE65H.5,$4467H
4449: 28 40 2d     CALL    !2D40H
444c: a5 65        CLR1    0FE65H.5
444e: 60 0f 00     MOVW    AX,#000FH
4451: 3c           PUSH    AX
4452: 28 6d 8b     CALL    Delay_Loop
4455: 34           POP     AX
4456: 28 ce 7a     CALL    Query_DFBE
4459: 1c 63        MOVW    AX,0FE63H
445b: 3c           PUSH    AX
445c: 60 80 df     MOVW    AX,#0DF80H
445f: 3c           PUSH    AX
4460: 28 a8 9a     CALL    !9AA8H
4463: 34           POP     AX
4464: 34           POP     AX
4465: b2 68        SET1    0FE68H.2
4467: 0c 63 5c fe  MOVW    0FE63H,#0FE5CH
446b: 28 2b 92     CALL    !922BH
446e: 28 16 20     CALL    !2016H
4471: 14 18        BR      $448BH
4473: 2c 0a 46     BR      !460AH
4476: 14 13        BR      $448BH
4478: 28 02 47     CALL    !4702H
447b: 24 0a        MOVW    AX,BC
447d: 2f 42 00     CMPW    AX,#0042H
4480: 81 c3        BZ      $4445H
4482: 24 0a        MOVW    AX,BC
4484: 2f 41 00     CMPW    AX,#0041H
4487: 81 8e        BZ      $4417H
4489: 14 e8        BR      $4473H
448b: 28 16 20     CALL    !2016H
448e: 2c cb 3d     BR      !3DCBH
4491: 3a af ff     MOV     0FEAFH,#0FFH
4494: 14 1b        BR      $44B1H
4496: 3a af 00     MOV     0FEAFH,#00H
4499: 14 3c        BR      $44D7H
449b: 3a af 01     MOV     0FEAFH,#01H
449e: 14 37        BR      $44D7H
44a0: 3a af 02     MOV     0FEAFH,#02H
44a3: 14 32        BR      $44D7H
44a5: 3a af 03     MOV     0FEAFH,#03H
44a8: 14 2d        BR      $44D7H
44aa: 3a af 04     MOV     0FEAFH,#04H
44ad: 14 28        BR      $44D7H
44af: 14 26        BR      $44D7H
44b1: 28 02 47     CALL    !4702H
44b4: 24 0a        MOVW    AX,BC
44b6: 2f 36 00     CMPW    AX,#0036H
44b9: 81 ef        BZ      $44AAH
44bb: 24 0a        MOVW    AX,BC
44bd: 2f 34 00     CMPW    AX,#0034H
44c0: 81 e3        BZ      $44A5H
44c2: 24 0a        MOVW    AX,BC
44c4: 2f 32 00     CMPW    AX,#0032H
44c7: 81 d7        BZ      $44A0H
44c9: 24 0a        MOVW    AX,BC
44cb: 2f 31 00     CMPW    AX,#0031H
44ce: 81 cb        BZ      $449BH
44d0: 24 0a        MOVW    AX,BC
44d2: 2f 30 00     CMPW    AX,#0030H
44d5: 81 bf        BZ      $4496H
44d7: 6f af ff     CMP     0FEAFH,#0FFH
44da: 81 13        BZ      $44EFH
44dc: 38 af ba     MOV     0FEBAH,0FEAFH
44df: 1c b2        MOVW    AX,I2C_OutputBuffer
44e1: 3c           PUSH    AX
44e2: 1c ba        MOVW    AX,0FEBAH
44e4: 1a b2        MOVW    I2C_OutputBuffer,AX
44e6: 28 3e 20     CALL    !203EH
44e9: 34           POP     AX
44ea: 1a b2        MOVW    I2C_OutputBuffer,AX
44ec: 2c cb 3d     BR      !3DCBH
44ef: 2c 0a 46     BR      !460AH
44f2: 28 02 47     CALL    !4702H
44f5: 24 0a        MOVW    AX,BC
44f7: 2f 0d 00     CMPW    AX,#000DH
44fa: 80 2c        BNZ     $4528H
44fc: 09 f0 30 fd  MOV     A,!0FD30H
4500: 30 91        SHR     A,2
4502: ac 01        AND     A,#01H
4504: b8 00        MOV     X,#00H
4506: d8           XCH     A,X
4507: 2f 01 00     CMPW    AX,#0001H
450a: 80 06        BNZ     $4512H
450c: 28 9b 7e     CALL    !7E9BH
450f: 2c cb 3d     BR      !3DCBH
4512: 09 f0 30 fd  MOV     A,!0FD30H
4516: 30 a9        SHR     A,5
4518: ac 01        AND     A,#01H
451a: b8 00        MOV     X,#00H
451c: d8           XCH     A,X
451d: 2f 01 00     CMPW    AX,#0001H
4520: 80 06        BNZ     $4528H
4522: 28 32 27     CALL    !2732H
4525: 2c cb 3d     BR      !3DCBH
4528: 09 f0 30 fd  MOV     A,!0FD30H
452c: 03 9d        CLR1    A.5
452e: 09 f1 30 fd  MOV     !0FD30H,A
4532: 30 a9        SHR     A,5
4534: ac 01        AND     A,#01H
4536: b8 00        MOV     X,#00H
4538: d8           XCH     A,X
4539: 24 28        MOVW    BC,AX
453b: 09 f0 30 fd  MOV     A,!0FD30H
453f: 30 8a        SHR     C,1
4541: 03 1a        MOV1    A.2,CY
4543: 09 f1 30 fd  MOV     !0FD30H,A
4547: 2c 0a 46     BR      !460AH
454a: 09 f0 30 fd  MOV     A,!0FD30H
454e: 30 99        SHR     A,3
4550: ac 01        AND     A,#01H
4552: b8 00        MOV     X,#00H
4554: d8           XCH     A,X
4555: 2f 01 00     CMPW    AX,#0001H
4558: 80 19        BNZ     $4573H
455a: 20 af        MOV     A,0FEAFH
455c: b8 00        MOV     X,#00H
455e: d8           XCH     A,X
455f: 3c           PUSH    AX
4560: 28 b9 47     CALL    !47B9H
4563: 34           POP     AX
4564: 28 f0 8c     CALL    !8CF0H
4567: 8a 08        SUBW    AX,AX
4569: 8f 0a        CMPW    AX,BC
456b: 81 06        BZ      $4573H
456d: 28 7b 7c     CALL    !7C7BH
4570: 2c 8b 44     BR      !448BH
4573: 2c 0a 46     BR      !460AH
4576: 70 72 1d     BT      0FE72H.0,$4596H
4579: 09 f0 93 fd  MOV     A,!0FD93H
457d: d8           XCH     A,X
457e: 09 f0 94 fd  MOV     A,!0FD94H
4582: 8f 10        CMP     A,X
4584: 80 05        BNZ     $458BH
4586: 60 3d 10     MOVW    AX,#103DH
4589: 14 03        BR      $458EH
458b: 60 40 10     MOVW    AX,#1040H
458e: 64 95 fd     MOVW    DE,#0FD95H
4591: 05 e6        MOVW    [DE],AX
4593: 3a b1 01     MOV     0FEB1H,#01H
4596: 14 72        BR      $460AH
4598: 14 70        BR      $460AH
459a: 20 af        MOV     A,0FEAFH
459c: af 30        CMP     A,#30H
459e: 83 d6        BC      $4576H
45a0: b8 59        MOV     X,#59H
45a2: 8f 01        CMP     X,A
45a4: 83 d0        BC      $4576H
45a6: aa 30        SUB     A,#30H
45a8: d8           XCH     A,X
45a9: b9 00        MOV     A,#00H
45ab: 88 08        ADDW    AX,AX
45ad: 2d b6 45     ADDW    AX,#45B6H
45b0: 24 48        MOVW    DE,AX
45b2: 05 e2        MOVW    AX,[DE]
45b4: 05 48        BR      AX
45b6: 4a           DI
45b7: 45           INCW    BC
45b8: 4a           DI
45b9: 45           INCW    BC
45ba: 4a           DI
45bb: 45           INCW    BC
45bc: 4a           DI
45bd: 45           INCW    BC
45be: 4a           DI
45bf: 45           INCW    BC
45c0: 4a           DI
45c1: 45           INCW    BC
45c2: 4a           DI
45c3: 45           INCW    BC
45c4: 4a           DI
45c5: 45           INCW    BC
45c6: 4a           DI
45c7: 45           INCW    BC
45c8: 4a           DI
45c9: 45           INCW    BC
45ca: 76 45 76     BT      0FE45H.6,$4643H
45cd: 45           INCW    BC
45ce: 76 45 76     BT      0FE45H.6,$4647H
45d1: 45           INCW    BC
45d2: 76 45 76     BT      0FE45H.6,$464BH
45d5: 45           INCW    BC
45d6: 76 45 f8     BT      0FE45H.6,$45D1H
45d9: 34           POP     AX
45da: 07           DB      07H
45db: 36           POP     DE
45dc: 75 37 f7     BT      0FE37H.5,$45D6H
45df: 37           POP     HL
45e0: 27 38        DEC     0FE38H
45e2: c2           INC     C
45e3: 38 fd 38     MOV     0FE38H,0FEFDH
45e6: 76 45 85     BT      0FE45H.6,$456EH
45e9: 39 76 45     XCH     0FE45H,0FE76H
45ec: 76 45 cd     BT      0FE45H.6,$45BCH
45ef: 39 86 3a     XCH     0FE3AH,0FE86H
45f2: b6 3c        SET1    0FE3CH.6
45f4: d1           MOV     A,A
45f5: 3d           PUSH    BC
45f6: fd           CALLT   [007AH]
45f7: 3d           PUSH    BC
45f8: 02 3f        DB      02H,3FH
45fa: c3           INC     B
45fb: 3f           PUSH    HL
45fc: 84           DB      84H
45fd: 40           CLR1    CY
45fe: d0           MOV     A,X
45ff: 42           NOT1    CY
4600: e6           CALLT   [004CH]
4601: 43 15        POP     CR20
4603: 44           INCW    AX
4604: 91 44        CALLF   !0944H
4606: 76 45 f2     BT      0FE45H.6,$45FBH
4609: 44           INCW    AX
460a: 09 f0 94 fd  MOV     A,!0FD94H
460e: 09 f1 93 fd  MOV     !0FD93H,A
4612: 6f b1 01     CMP     0FEB1H,#01H
4615: 80 0a        BNZ     $4621H
4617: 64 95 fd     MOVW    DE,#0FD95H
461a: 05 e2        MOVW    AX,[DE]
461c: 3c           PUSH    AX
461d: 28 79 46     CALL    !4679H
4620: 34           POP     AX
4621: 34           POP     AX
4622: 34           POP     AX
4623: 1a b0        MOVW    0FEB0H,AX
4625: 34           POP     AX
4626: 1a ae        MOVW    0FEAEH,AX
4628: 34           POP     AX
4629: 1a ac        MOVW    0FEACH,AX
462b: 37           POP     HL
462c: 56           RET
462d: 3f           PUSH    HL
462e: 11 fc        MOVW    AX,SP
4630: 24 68        MOVW    HL,AX
4632: 77 69 16     BT      0FE69H.7,$464BH
4635: 09 f0 92 fd  MOV     A,!0FD92H
4639: d8           XCH     A,X
463a: 09 f0 91 fd  MOV     A,!0FD91H
463e: 8f 10        CMP     A,X
4640: 80 09        BNZ     $464BH
4642: 06 20 04     MOV     A,[HL+04H]
4645: 12 8e        MOV     TXS,A
4647: b7 69        SET1    0FE69H.7
4649: 14 2c        BR      $4677H
464b: 09 f0 92 fd  MOV     A,!0FD92H
464f: c1           INC     A
4650: ac 1f        AND     A,#1FH
4652: d8           XCH     A,X
4653: 09 f0 91 fd  MOV     A,!0FD91H
4657: 8f 01        CMP     X,A
4659: 81 1c        BZ      $4677H
465b: 09 f0 92 fd  MOV     A,!0FD92H
465f: b8 00        MOV     X,#00H
4661: d8           XCH     A,X
4662: 2d 71 fd     ADDW    AX,#0FD71H
4665: 24 48        MOVW    DE,AX
4667: 06 20 04     MOV     A,[HL+04H]
466a: 54           MOV     [DE],A
466b: 64 92 fd     MOVW    DE,#0FD92H
466e: 5c           MOV     A,[DE]
466f: c1           INC     A
4670: 54           MOV     [DE],A
4671: ac 1f        AND     A,#1FH
4673: 09 f1 92 fd  MOV     !0FD92H,A
4677: 37           POP     HL
4678: 56           RET
4679: 3f           PUSH    HL
467a: 05 c9        DECW    SP
467c: 05 c9        DECW    SP
467e: 11 fc        MOVW    AX,SP
4680: 24 68        MOVW    HL,AX
4682: 60 ff ff     MOVW    AX,#0FFFFH
4685: 06 a0 01     MOV     [HL+01H],A
4688: d8           XCH     A,X
4689: 55           MOV     [HL],A
468a: 77 69 25     BT      0FE69H.7,$46B2H
468d: 09 f0 92 fd  MOV     A,!0FD92H
4691: d8           XCH     A,X
4692: 09 f0 91 fd  MOV     A,!0FD91H
4696: 8f 10        CMP     A,X
4698: 80 18        BNZ     $46B2H
469a: 06 20 06     MOV     A,[HL+06H]
469d: d8           XCH     A,X
469e: 06 20 07     MOV     A,[HL+07H]
46a1: 44           INCW    AX
46a2: 06 a0 07     MOV     [HL+07H],A
46a5: d8           XCH     A,X
46a6: 06 a0 06     MOV     [HL+06H],A
46a9: d8           XCH     A,X
46aa: 4c           DECW    AX
46ab: 24 48        MOVW    DE,AX
46ad: 5c           MOV     A,[DE]
46ae: 12 8e        MOV     TXS,A
46b0: b7 69        SET1    0FE69H.7
46b2: 06 20 06     MOV     A,[HL+06H]
46b5: d8           XCH     A,X
46b6: 06 20 07     MOV     A,[HL+07H]
46b9: 24 48        MOVW    DE,AX
46bb: 5c           MOV     A,[DE]
46bc: af 00        CMP     A,#00H
46be: 81 3f        BZ      $46FFH
46c0: 09 f0 92 fd  MOV     A,!0FD92H
46c4: c1           INC     A
46c5: ac 1f        AND     A,#1FH
46c7: d8           XCH     A,X
46c8: 09 f0 91 fd  MOV     A,!0FD91H
46cc: 8f 01        CMP     X,A
46ce: 80 11        BNZ     $46E1H
46d0: 05 e3        MOVW    AX,[HL]
46d2: 2f 00 00     CMPW    AX,#0000H
46d5: 81 0a        BZ      $46E1H
46d7: 05 e3        MOVW    AX,[HL]
46d9: 4c           DECW    AX
46da: 06 a0 01     MOV     [HL+01H],A
46dd: d8           XCH     A,X
46de: 55           MOV     [HL],A
46df: 14 df        BR      $46C0H
46e1: 06 20 06     MOV     A,[HL+06H]
46e4: d8           XCH     A,X
46e5: 06 20 07     MOV     A,[HL+07H]
46e8: 44           INCW    AX
46e9: 06 a0 07     MOV     [HL+07H],A
46ec: d8           XCH     A,X
46ed: 06 a0 06     MOV     [HL+06H],A
46f0: d8           XCH     A,X
46f1: 4c           DECW    AX
46f2: 24 48        MOVW    DE,AX
46f4: 5c           MOV     A,[DE]
46f5: b8 00        MOV     X,#00H
46f7: d8           XCH     A,X
46f8: 3c           PUSH    AX
46f9: 28 2d 46     CALL    !462DH
46fc: 34           POP     AX
46fd: 14 b3        BR      $46B2H
46ff: 34           POP     AX
4700: 37           POP     HL
4701: 56           RET
4702: 1c ac        MOVW    AX,0FEACH
4704: 3c           PUSH    AX
4705: 3a ac ff     MOV     0FEACH,#0FFH
4708: 09 f0 94 fd  MOV     A,!0FD94H
470c: d8           XCH     A,X
470d: 09 f0 93 fd  MOV     A,!0FD93H
4711: 8f 10        CMP     A,X
4713: 81 1b        BZ      $4730H
4715: 09 f0 93 fd  MOV     A,!0FD93H
4719: b8 00        MOV     X,#00H
471b: d8           XCH     A,X
471c: 2d 31 fd     ADDW    AX,#0FD31H
471f: 24 48        MOVW    DE,AX
4721: 5c           MOV     A,[DE]
4722: 22 ac        MOV     0FEACH,A
4724: 64 93 fd     MOVW    DE,#0FD93H
4727: 5c           MOV     A,[DE]
4728: c1           INC     A
4729: 54           MOV     [DE],A
472a: ac 3f        AND     A,#3FH
472c: 09 f1 93 fd  MOV     !0FD93H,A
4730: 20 ac        MOV     A,0FEACH
4732: bb 00        MOV     B,#00H
4734: da           XCH     A,C
4735: 34           POP     AX
4736: 1a ac        MOVW    0FEACH,AX
4738: 56           RET
4739: 3f           PUSH    HL
473a: 05 c9        DECW    SP
473c: 05 c9        DECW    SP
473e: 11 fc        MOVW    AX,SP
4740: 24 68        MOVW    HL,AX
4742: 09 f0 93 fd  MOV     A,!0FD93H
4746: b8 00        MOV     X,#00H
4748: d8           XCH     A,X
4749: 2d 31 fd     ADDW    AX,#0FD31H
474c: 24 48        MOVW    DE,AX
474e: b9 39        MOV     A,#39H
4750: 16 4f        CMP     A,[DE]
4752: 83 21        BC      $4775H
4754: 09 f0 93 fd  MOV     A,!0FD93H
4758: b8 00        MOV     X,#00H
475a: d8           XCH     A,X
475b: 2d 31 fd     ADDW    AX,#0FD31H
475e: 24 48        MOVW    DE,AX
4760: 5c           MOV     A,[DE]
4761: af 30        CMP     A,#30H
4763: 83 10        BC      $4775H
4765: 28 02 47     CALL    !4702H
4768: 24 0a        MOVW    AX,BC
476a: 2e 30 00     SUBW    AX,#0030H
476d: 31 e0        SHLW    AX,4
476f: d0           MOV     A,X
4770: 06 a0 01     MOV     [HL+01H],A
4773: 14 05        BR      $477AH
4775: 62 ff 00     MOVW    BC,#00FFH
4778: 14 3c        BR      $47B6H
477a: 09 f0 93 fd  MOV     A,!0FD93H
477e: b8 00        MOV     X,#00H
4780: d8           XCH     A,X
4781: 2d 31 fd     ADDW    AX,#0FD31H
4784: 24 48        MOVW    DE,AX
4786: b9 39        MOV     A,#39H
4788: 16 4f        CMP     A,[DE]
478a: 83 1f        BC      $47ABH
478c: 09 f0 93 fd  MOV     A,!0FD93H
4790: b8 00        MOV     X,#00H
4792: d8           XCH     A,X
4793: 2d 31 fd     ADDW    AX,#0FD31H
4796: 24 48        MOVW    DE,AX
4798: 5c           MOV     A,[DE]
4799: af 30        CMP     A,#30H
479b: 83 0e        BC      $47ABH
479d: 28 02 47     CALL    !4702H
47a0: d2           MOV     A,C
47a1: aa 30        SUB     A,#30H
47a3: 06 28 01     ADD     A,[HL+01H]
47a6: 06 a0 01     MOV     [HL+01H],A
47a9: 14 05        BR      $47B0H
47ab: b9 ff        MOV     A,#0FFH
47ad: 06 a0 01     MOV     [HL+01H],A
47b0: 06 20 01     MOV     A,[HL+01H]
47b3: bb 00        MOV     B,#00H
47b5: da           XCH     A,C
47b6: 34           POP     AX
47b7: 37           POP     HL
47b8: 56           RET
47b9: 3f           PUSH    HL
47ba: 11 fc        MOVW    AX,SP
47bc: 24 68        MOVW    HL,AX
47be: 3a 91 00     MOV     0FE91H,#00H
47c1: 06 20 04     MOV     A,[HL+04H]
47c4: aa 30        SUB     A,#30H
47c6: 22 90        MOV     0FE90H,A
47c8: 28 02 47     CALL    !4702H
47cb: d2           MOV     A,C
47cc: 06 a0 04     MOV     [HL+04H],A
47cf: af 30        CMP     A,#30H
47d1: 83 3f        BC      $4812H
47d3: b9 39        MOV     A,#39H
47d5: 06 2f 04     CMP     A,[HL+04H]
47d8: 83 38        BC      $4812H
47da: 20 90        MOV     A,0FE90H
47dc: 31 a1        SHL     A,4
47de: d8           XCH     A,X
47df: 06 20 04     MOV     A,[HL+04H]
47e2: aa 30        SUB     A,#30H
47e4: da           XCH     A,C
47e5: b9 00        MOV     A,#00H
47e7: bb 00        MOV     B,#00H
47e9: 88 0a        ADDW    AX,BC
47eb: d0           MOV     A,X
47ec: 22 90        MOV     0FE90H,A
47ee: 28 02 47     CALL    !4702H
47f1: d2           MOV     A,C
47f2: 06 a0 04     MOV     [HL+04H],A
47f5: af 30        CMP     A,#30H
47f7: 83 19        BC      $4812H
47f9: b9 39        MOV     A,#39H
47fb: 06 2f 04     CMP     A,[HL+04H]
47fe: 83 12        BC      $4812H
4800: 1c 90        MOVW    AX,0FE90H
4802: 31 e0        SHLW    AX,4
4804: 24 28        MOVW    BC,AX
4806: 06 20 04     MOV     A,[HL+04H]
4809: aa 30        SUB     A,#30H
480b: b8 00        MOV     X,#00H
480d: d8           XCH     A,X
480e: 88 0a        ADDW    AX,BC
4810: 1a 90        MOVW    0FE90H,AX
4812: 37           POP     HL
4813: 56           RET
4814: 3f           PUSH    HL
4815: 11 fc        MOVW    AX,SP
4817: 24 68        MOVW    HL,AX
4819: 28 02 47     CALL    !4702H
481c: d2           MOV     A,C
481d: 22 6a        MOV     0FE6AH,A
481f: 6f 6a 46     CMP     0FE6AH,#46H
4822: 80 12        BNZ     $4836H
4824: 06 20 04     MOV     A,[HL+04H]
4827: d8           XCH     A,X
4828: 06 20 05     MOV     A,[HL+05H]
482b: 44           INCW    AX
482c: 44           INCW    AX
482d: 06 a0 05     MOV     [HL+05H],A
4830: d8           XCH     A,X
4831: 06 a0 04     MOV     [HL+04H],A
4834: 14 0b        BR      $4841H
4836: 6f 6a 4f     CMP     0FE6AH,#4FH
4839: 81 06        BZ      $4841H
483b: 62 00 00     MOVW    BC,#0000H
483e: 2c 4e 49     BR      !494EH
4841: 09 f0 93 fd  MOV     A,!0FD93H
4845: b8 00        MOV     X,#00H
4847: d8           XCH     A,X
4848: 2d 31 fd     ADDW    AX,#0FD31H
484b: 24 48        MOVW    DE,AX
484d: 5c           MOV     A,[DE]
484e: af 0d        CMP     A,#0DH
4850: 81 03        BZ      $4855H
4852: 2c f0 48     BR      !48F0H
4855: 60 0d 00     MOVW    AX,#000DH
4858: 3c           PUSH    AX
4859: 28 2d 46     CALL    !462DH
485c: 34           POP     AX
485d: 60 0a 00     MOVW    AX,#000AH
4860: 3c           PUSH    AX
4861: 28 2d 46     CALL    !462DH
4864: 34           POP     AX
4865: 06 20 04     MOV     A,[HL+04H]
4868: d8           XCH     A,X
4869: 06 20 05     MOV     A,[HL+05H]
486c: 3c           PUSH    AX
486d: 28 2b 7c     CALL    !7C2BH
4870: 34           POP     AX
4871: 30 e2        SHRW    BC,4
4873: 24 0a        MOVW    AX,BC
4875: 2d 30 00     ADDW    AX,#0030H
4878: d0           MOV     A,X
4879: 22 6f        MOV     0FE6FH,A
487b: 06 20 04     MOV     A,[HL+04H]
487e: d8           XCH     A,X
487f: 06 20 05     MOV     A,[HL+05H]
4882: 44           INCW    AX
4883: 06 a0 05     MOV     [HL+05H],A
4886: d8           XCH     A,X
4887: 06 a0 04     MOV     [HL+04H],A
488a: d8           XCH     A,X
488b: 4c           DECW    AX
488c: 3c           PUSH    AX
488d: 28 2b 7c     CALL    !7C2BH
4890: 34           POP     AX
4891: d2           MOV     A,C
4892: ac 0f        AND     A,#0FH
4894: a8 30        ADD     A,#30H
4896: 22 70        MOV     0FE70H,A
4898: 06 20 04     MOV     A,[HL+04H]
489b: d8           XCH     A,X
489c: 06 20 05     MOV     A,[HL+05H]
489f: 3c           PUSH    AX
48a0: 28 2b 7c     CALL    !7C2BH
48a3: 34           POP     AX
48a4: 30 e2        SHRW    BC,4
48a6: 24 0a        MOVW    AX,BC
48a8: 2d 30 00     ADDW    AX,#0030H
48ab: d0           MOV     A,X
48ac: 22 6c        MOV     0FE6CH,A
48ae: 06 20 04     MOV     A,[HL+04H]
48b1: d8           XCH     A,X
48b2: 06 20 05     MOV     A,[HL+05H]
48b5: 3c           PUSH    AX
48b6: 28 2b 7c     CALL    !7C2BH
48b9: 34           POP     AX
48ba: d2           MOV     A,C
48bb: ac 0f        AND     A,#0FH
48bd: a8 30        ADD     A,#30H
48bf: 22 6d        MOV     0FE6DH,A
48c1: 3a 6e 3a     MOV     0FE6EH,#3AH
48c4: 3a 71 00     MOV     0FE71H,#00H
48c7: b9 39        MOV     A,#39H
48c9: 9f 6d        CMP     A,0FE6DH
48cb: 82 0c        BNC     $48D9H
48cd: 3a 70 2d     MOV     0FE70H,#2DH
48d0: 3a 6f 2d     MOV     0FE6FH,#2DH
48d3: 3a 6d 2d     MOV     0FE6DH,#2DH
48d6: 3a 6c 2d     MOV     0FE6CH,#2DH
48d9: 64 6c fe     MOVW    DE,#0FE6CH
48dc: 3e           PUSH    DE
48dd: 28 79 46     CALL    !4679H
48e0: 34           POP     AX
48e1: 60 53 10     MOVW    AX,#1053H
48e4: 64 95 fd     MOVW    DE,#0FD95H
48e7: 05 e6        MOVW    [DE],AX
48e9: 62 01 00     MOVW    BC,#0001H
48ec: 14 60        BR      $494EH
48ee: 14 5b        BR      $494BH
48f0: 28 50 4d     CALL    !4D50H
48f3: 60 04 00     MOVW    AX,#0004H
48f6: 8f 0a        CMPW    AX,BC
48f8: 82 51        BNC     $494BH
48fa: 3a 6a 00     MOV     0FE6AH,#00H
48fd: 28 39 47     CALL    !4739H
4900: d2           MOV     A,C
4901: 22 6c        MOV     0FE6CH,A
4903: 28 39 47     CALL    !4739H
4906: d2           MOV     A,C
4907: 22 6b        MOV     0FE6BH,A
4909: 64 6a fe     MOVW    DE,#0FE6AH
490c: 3e           PUSH    DE
490d: 28 99 5d     CALL    !5D99H
4910: 34           POP     AX
4911: 8a 08        SUBW    AX,AX
4913: 8f 0a        CMPW    AX,BC
4915: 81 34        BZ      $494BH
4917: 06 20 04     MOV     A,[HL+04H]
491a: d8           XCH     A,X
491b: 06 20 05     MOV     A,[HL+05H]
491e: 3c           PUSH    AX
491f: 20 6b        MOV     A,0FE6BH
4921: b8 00        MOV     X,#00H
4923: d8           XCH     A,X
4924: 3c           PUSH    AX
4925: 28 18 7b     CALL    !7B18H
4928: 34           POP     AX
4929: 34           POP     AX
492a: 06 20 04     MOV     A,[HL+04H]
492d: d8           XCH     A,X
492e: 06 20 05     MOV     A,[HL+05H]
4931: 44           INCW    AX
4932: 06 a0 05     MOV     [HL+05H],A
4935: d8           XCH     A,X
4936: 06 a0 04     MOV     [HL+04H],A
4939: d8           XCH     A,X
493a: 3c           PUSH    AX
493b: 20 6c        MOV     A,0FE6CH
493d: b8 00        MOV     X,#00H
493f: d8           XCH     A,X
4940: 3c           PUSH    AX
4941: 28 18 7b     CALL    !7B18H
4944: 34           POP     AX
4945: 34           POP     AX
4946: 62 01 00     MOVW    BC,#0001H
4949: 14 03        BR      $494EH
494b: 62 00 00     MOVW    BC,#0000H
494e: 37           POP     HL
494f: 56           RET
4950: 3f           PUSH    HL
4951: 11 fc        MOVW    AX,SP
4953: 24 68        MOVW    HL,AX
4955: 09 f0 93 fd  MOV     A,!0FD93H
4959: b8 00        MOV     X,#00H
495b: d8           XCH     A,X
495c: 2d 31 fd     ADDW    AX,#0FD31H
495f: 24 48        MOVW    DE,AX
4961: 5c           MOV     A,[DE]
4962: af 0d        CMP     A,#0DH
4964: 81 03        BZ      $4969H
4966: 2c ff 49     BR      !49FFH
4969: 60 56 10     MOVW    AX,#1056H
496c: 3c           PUSH    AX
496d: 28 79 46     CALL    !4679H
4970: 34           POP     AX
4971: 06 20 04     MOV     A,[HL+04H]
4974: d8           XCH     A,X
4975: 06 20 05     MOV     A,[HL+05H]
4978: 24 48        MOVW    DE,AX
497a: 06 00 02     MOV     A,[DE+02H]
497d: 30 a1        SHR     A,4
497f: ac 03        AND     A,#03H
4981: a8 30        ADD     A,#30H
4983: 22 6c        MOV     0FE6CH,A
4985: 06 20 04     MOV     A,[HL+04H]
4988: d8           XCH     A,X
4989: 06 20 05     MOV     A,[HL+05H]
498c: 24 48        MOVW    DE,AX
498e: 06 00 02     MOV     A,[DE+02H]
4991: ac 0f        AND     A,#0FH
4993: a8 30        ADD     A,#30H
4995: 22 6d        MOV     0FE6DH,A
4997: 3a 6e 3a     MOV     0FE6EH,#3AH
499a: 06 20 04     MOV     A,[HL+04H]
499d: d8           XCH     A,X
499e: 06 20 05     MOV     A,[HL+05H]
49a1: 24 48        MOVW    DE,AX
49a3: 06 00 01     MOV     A,[DE+01H]
49a6: 30 a1        SHR     A,4
49a8: a8 30        ADD     A,#30H
49aa: 22 6f        MOV     0FE6FH,A
49ac: 06 20 04     MOV     A,[HL+04H]
49af: d8           XCH     A,X
49b0: 06 20 05     MOV     A,[HL+05H]
49b3: 24 48        MOVW    DE,AX
49b5: 06 00 01     MOV     A,[DE+01H]
49b8: ac 0f        AND     A,#0FH
49ba: a8 30        ADD     A,#30H
49bc: 22 70        MOV     0FE70H,A
49be: 3a 71 00     MOV     0FE71H,#00H
49c1: 64 6c fe     MOVW    DE,#0FE6CH
49c4: 3e           PUSH    DE
49c5: 28 79 46     CALL    !4679H
49c8: 34           POP     AX
49c9: 3a 6c 3a     MOV     0FE6CH,#3AH
49cc: 06 20 04     MOV     A,[HL+04H]
49cf: d8           XCH     A,X
49d0: 06 20 05     MOV     A,[HL+05H]
49d3: 24 48        MOVW    DE,AX
49d5: 5c           MOV     A,[DE]
49d6: 30 a1        SHR     A,4
49d8: a8 30        ADD     A,#30H
49da: 22 6d        MOV     0FE6DH,A
49dc: 06 20 04     MOV     A,[HL+04H]
49df: d8           XCH     A,X
49e0: 06 20 05     MOV     A,[HL+05H]
49e3: 24 48        MOVW    DE,AX
49e5: 5c           MOV     A,[DE]
49e6: ac 0f        AND     A,#0FH
49e8: a8 30        ADD     A,#30H
49ea: 22 6e        MOV     0FE6EH,A
49ec: 3a 6f 0d     MOV     0FE6FH,#0DH
49ef: 3a 70 0a     MOV     0FE70H,#0AH
49f2: 3a 71 00     MOV     0FE71H,#00H
49f5: 60 6c fe     MOVW    AX,#0FE6CH
49f8: 64 95 fd     MOVW    DE,#0FD95H
49fb: 05 e6        MOVW    [DE],AX
49fd: 14 1b        BR      $4A1AH
49ff: 28 39 47     CALL    !4739H
4a02: d2           MOV     A,C
4a03: 09 f1 2d fd  MOV     !0FD2DH,A
4a07: 28 39 47     CALL    !4739H
4a0a: d2           MOV     A,C
4a0b: 09 f1 2c fd  MOV     !0FD2CH,A
4a0f: 28 39 47     CALL    !4739H
4a12: d2           MOV     A,C
4a13: 09 f1 2b fd  MOV     !0FD2BH,A
4a17: 28 23 5c     CALL    !5C23H
4a1a: 37           POP     HL
4a1b: 56           RET
4a1c: 3f           PUSH    HL
4a1d: 05 c9        DECW    SP
4a1f: 05 c9        DECW    SP
4a21: 11 fc        MOVW    AX,SP
4a23: 24 68        MOVW    HL,AX
4a25: 09 f0 a8 fd  MOV     A,!0FDA8H
4a29: ac 02        AND     A,#02H
4a2b: 81 4a        BZ      $4A77H
4a2d: 08 a5 65 05  BF      0FE65H.5,$4A36H
4a31: 60 2a 00     MOVW    AX,#002AH
4a34: 14 03        BR      $4A39H
4a36: 60 20 00     MOVW    AX,#0020H
4a39: d0           MOV     A,X
4a3a: 22 6a        MOV     0FE6AH,A
4a3c: 70 72 08     BT      0FE72H.0,$4A47H
4a3f: 20 91        MOV     A,0FE91H
4a41: ac 0f        AND     A,#0FH
4a43: ae 30        OR      A,#30H
4a45: 14 02        BR      $4A49H
4a47: b9 00        MOV     A,#00H
4a49: 22 6b        MOV     0FE6BH,A
4a4b: 6f 6b 3b     CMP     0FE6BH,#3BH
4a4e: 80 03        BNZ     $4A53H
4a50: 3a 6b 3a     MOV     0FE6BH,#3AH
4a53: 3a 6c 00     MOV     0FE6CH,#00H
4a56: 28 47 4d     CALL    !4D47H
4a59: 20 90        MOV     A,0FE90H
4a5b: 30 a1        SHR     A,4
4a5d: ae 30        OR      A,#30H
4a5f: 22 6a        MOV     0FE6AH,A
4a61: 20 90        MOV     A,0FE90H
4a63: ac 0f        AND     A,#0FH
4a65: ae 30        OR      A,#30H
4a67: 22 6b        MOV     0FE6BH,A
4a69: 6f 6b 3b     CMP     0FE6BH,#3BH
4a6c: 80 03        BNZ     $4A71H
4a6e: 3a 6b 3a     MOV     0FE6BH,#3AH
4a71: 3a 6c 00     MOV     0FE6CH,#00H
4a74: 28 47 4d     CALL    !4D47H
4a77: 09 f0 a8 fd  MOV     A,!0FDA8H
4a7b: ac 04        AND     A,#04H
4a7d: 80 03        BNZ     $4A82H
4a7f: 2c 0c 4b     BR      !4B0CH
4a82: 1c 63        MOVW    AX,0FE63H
4a84: 2d 05 00     ADDW    AX,#0005H
4a87: 06 a0 01     MOV     [HL+01H],A
4a8a: d8           XCH     A,X
4a8b: 55           MOV     [HL],A
4a8c: 3a 6a 20     MOV     0FE6AH,#20H
4a8f: 05 e3        MOVW    AX,[HL]
4a91: 24 48        MOVW    DE,AX
4a93: 5c           MOV     A,[DE]
4a94: 30 a1        SHR     A,4
4a96: ae 30        OR      A,#30H
4a98: 22 6b        MOV     0FE6BH,A
4a9a: 05 e3        MOVW    AX,[HL]
4a9c: 24 48        MOVW    DE,AX
4a9e: 5c           MOV     A,[DE]
4a9f: ac 0f        AND     A,#0FH
4aa1: ae 30        OR      A,#30H
4aa3: 22 6c        MOV     0FE6CH,A
4aa5: 05 e3        MOVW    AX,[HL]
4aa7: 44           INCW    AX
4aa8: 06 a0 01     MOV     [HL+01H],A
4aab: d8           XCH     A,X
4aac: 55           MOV     [HL],A
4aad: d8           XCH     A,X
4aae: 24 48        MOVW    DE,AX
4ab0: 5c           MOV     A,[DE]
4ab1: 30 a1        SHR     A,4
4ab3: ae 30        OR      A,#30H
4ab5: 22 6d        MOV     0FE6DH,A
4ab7: 05 e3        MOVW    AX,[HL]
4ab9: 24 48        MOVW    DE,AX
4abb: 5c           MOV     A,[DE]
4abc: ac 0f        AND     A,#0FH
4abe: ae 30        OR      A,#30H
4ac0: 22 6e        MOV     0FE6EH,A
4ac2: 08 a6 65 05  BF      0FE65H.6,$4ACBH
4ac6: 60 32 00     MOVW    AX,#0032H
4ac9: 14 03        BR      $4ACEH
4acb: 60 30 00     MOVW    AX,#0030H
4ace: d0           MOV     A,X
4acf: 22 6f        MOV     0FE6FH,A
4ad1: 70 72 14     BT      0FE72H.0,$4AE8H
4ad4: 1c 63        MOVW    AX,0FE63H
4ad6: 24 48        MOVW    DE,AX
4ad8: 5c           MOV     A,[DE]
4ad9: 30 a1        SHR     A,4
4adb: ac 01        AND     A,#01H
4add: b8 00        MOV     X,#00H
4adf: d8           XCH     A,X
4ae0: 2f 01 00     CMPW    AX,#0001H
4ae3: 80 03        BNZ     $4AE8H
4ae5: 6e 6f 01     OR      0FE6FH,#01H
4ae8: 1c 63        MOVW    AX,0FE63H
4aea: 24 48        MOVW    DE,AX
4aec: 5c           MOV     A,[DE]
4aed: 30 91        SHR     A,2
4aef: ac 01        AND     A,#01H
4af1: b8 00        MOV     X,#00H
4af3: d8           XCH     A,X
4af4: 2f 01 00     CMPW    AX,#0001H
4af7: 80 03        BNZ     $4AFCH
4af9: 6e 6f 04     OR      0FE6FH,#04H
4afc: 1c 63        MOVW    AX,0FE63H
4afe: 2f 55 fe     CMPW    AX,#0FE55H
4b01: 80 03        BNZ     $4B06H
4b03: 6e 6f 08     OR      0FE6FH,#08H
4b06: 3a 70 00     MOV     0FE70H,#00H
4b09: 28 47 4d     CALL    !4D47H
4b0c: 09 f0 a8 fd  MOV     A,!0FDA8H
4b10: ac 01        AND     A,#01H
4b12: 80 03        BNZ     $4B17H
4b14: 2c 41 4c     BR      !4C41H
4b17: 1c 63        MOVW    AX,0FE63H
4b19: 2d 04 00     ADDW    AX,#0004H
4b1c: 06 a0 01     MOV     [HL+01H],A
4b1f: d8           XCH     A,X
4b20: 55           MOV     [HL],A
4b21: 3a 6a 20     MOV     0FE6AH,#20H
4b24: 05 e3        MOVW    AX,[HL]
4b26: 24 48        MOVW    DE,AX
4b28: 5c           MOV     A,[DE]
4b29: 30 a1        SHR     A,4
4b2b: ae 30        OR      A,#30H
4b2d: 22 6b        MOV     0FE6BH,A
4b2f: 6f 6b 30     CMP     0FE6BH,#30H
4b32: 80 03        BNZ     $4B37H
4b34: 3a 6b 20     MOV     0FE6BH,#20H
4b37: 05 e3        MOVW    AX,[HL]
4b39: 24 48        MOVW    DE,AX
4b3b: 5c           MOV     A,[DE]
4b3c: ac 0f        AND     A,#0FH
4b3e: ae 30        OR      A,#30H
4b40: 22 6c        MOV     0FE6CH,A
4b42: 6f 6b 20     CMP     0FE6BH,#20H
4b45: 80 08        BNZ     $4B4FH
4b47: 6f 6c 30     CMP     0FE6CH,#30H
4b4a: 80 03        BNZ     $4B4FH
4b4c: 3a 6c 20     MOV     0FE6CH,#20H
4b4f: 05 e3        MOVW    AX,[HL]
4b51: 4c           DECW    AX
4b52: 06 a0 01     MOV     [HL+01H],A
4b55: d8           XCH     A,X
4b56: 55           MOV     [HL],A
4b57: d8           XCH     A,X
4b58: 24 48        MOVW    DE,AX
4b5a: 5c           MOV     A,[DE]
4b5b: 30 a1        SHR     A,4
4b5d: ae 30        OR      A,#30H
4b5f: 22 6d        MOV     0FE6DH,A
4b61: 1c 63        MOVW    AX,0FE63H
4b63: 24 48        MOVW    DE,AX
4b65: 5c           MOV     A,[DE]
4b66: 30 a1        SHR     A,4
4b68: ac 01        AND     A,#01H
4b6a: b8 00        MOV     X,#00H
4b6c: d8           XCH     A,X
4b6d: 2f 01 00     CMPW    AX,#0001H
4b70: 81 04        BZ      $4B76H
4b72: 08 a0 72 05  BF      0FE72H.0,$4B7BH
4b76: 60 2e 00     MOVW    AX,#002EH
4b79: 14 02        BR      $4B7DH
4b7b: 8a 08        SUBW    AX,AX
4b7d: 1a 6e        MOVW    0FE6EH,AX
4b7f: 09 f0 a8 fd  MOV     A,!0FDA8H
4b83: ac 06        AND     A,#06H
4b85: 81 0a        BZ      $4B91H
4b87: 64 6a fe     MOVW    DE,#0FE6AH
4b8a: 3e           PUSH    DE
4b8b: 28 79 46     CALL    !4679H
4b8e: 34           POP     AX
4b8f: 14 08        BR      $4B99H
4b91: 64 6b fe     MOVW    DE,#0FE6BH
4b94: 3e           PUSH    DE
4b95: 28 79 46     CALL    !4679H
4b98: 34           POP     AX
4b99: 05 e3        MOVW    AX,[HL]
4b9b: 24 48        MOVW    DE,AX
4b9d: 5c           MOV     A,[DE]
4b9e: ac 0f        AND     A,#0FH
4ba0: ae 30        OR      A,#30H
4ba2: 22 6a        MOV     0FE6AH,A
4ba4: 05 e3        MOVW    AX,[HL]
4ba6: 4c           DECW    AX
4ba7: 06 a0 01     MOV     [HL+01H],A
4baa: d8           XCH     A,X
4bab: 55           MOV     [HL],A
4bac: d8           XCH     A,X
4bad: 24 48        MOVW    DE,AX
4baf: 5c           MOV     A,[DE]
4bb0: 30 a1        SHR     A,4
4bb2: ae 30        OR      A,#30H
4bb4: 22 6b        MOV     0FE6BH,A
4bb6: 05 e3        MOVW    AX,[HL]
4bb8: 24 48        MOVW    DE,AX
4bba: 5c           MOV     A,[DE]
4bbb: ac 0f        AND     A,#0FH
4bbd: ae 30        OR      A,#30H
4bbf: 22 6c        MOV     0FE6CH,A
4bc1: 1c 63        MOVW    AX,0FE63H
4bc3: 24 48        MOVW    DE,AX
4bc5: 5c           MOV     A,[DE]
4bc6: 30 a1        SHR     A,4
4bc8: ac 01        AND     A,#01H
4bca: b8 00        MOV     X,#00H
4bcc: d8           XCH     A,X
4bcd: 2f 00 00     CMPW    AX,#0000H
4bd0: 80 08        BNZ     $4BDAH
4bd2: 70 72 05     BT      0FE72H.0,$4BDAH
4bd5: 60 2e 00     MOVW    AX,#002EH
4bd8: 14 02        BR      $4BDCH
4bda: 8a 08        SUBW    AX,AX
4bdc: d0           MOV     A,X
4bdd: 22 6d        MOV     0FE6DH,A
4bdf: 3a 6e 00     MOV     0FE6EH,#00H
4be2: 28 47 4d     CALL    !4D47H
4be5: 05 e3        MOVW    AX,[HL]
4be7: 4c           DECW    AX
4be8: 06 a0 01     MOV     [HL+01H],A
4beb: d8           XCH     A,X
4bec: 55           MOV     [HL],A
4bed: d8           XCH     A,X
4bee: 24 48        MOVW    DE,AX
4bf0: 5c           MOV     A,[DE]
4bf1: 30 a1        SHR     A,4
4bf3: ae 30        OR      A,#30H
4bf5: 22 6a        MOV     0FE6AH,A
4bf7: 05 e3        MOVW    AX,[HL]
4bf9: 24 48        MOVW    DE,AX
4bfb: 5c           MOV     A,[DE]
4bfc: ac 0f        AND     A,#0FH
4bfe: ae 30        OR      A,#30H
4c00: 22 6b        MOV     0FE6BH,A
4c02: 08 a1 07 05  BF      P7.1,$4C0BH
4c06: 60 2a 00     MOVW    AX,#002AH
4c09: 14 03        BR      $4C0EH
4c0b: 60 20 00     MOVW    AX,#0020H
4c0e: d0           MOV     A,X
4c0f: 22 6c        MOV     0FE6CH,A
4c11: 1c 63        MOVW    AX,0FE63H
4c13: 24 48        MOVW    DE,AX
4c15: 5c           MOV     A,[DE]
4c16: 30 a1        SHR     A,4
4c18: ac 01        AND     A,#01H
4c1a: b8 00        MOV     X,#00H
4c1c: d8           XCH     A,X
4c1d: 2f 01 00     CMPW    AX,#0001H
4c20: 81 04        BZ      $4C26H
4c22: 08 a0 72 05  BF      0FE72H.0,$4C2BH
4c26: 60 4d 00     MOVW    AX,#004DH
4c29: 14 03        BR      $4C2EH
4c2b: 60 4b 00     MOVW    AX,#004BH
4c2e: d0           MOV     A,X
4c2f: 22 6d        MOV     0FE6DH,A
4c31: 3a 6e 00     MOV     0FE6EH,#00H
4c34: 28 47 4d     CALL    !4D47H
4c37: 0c 6a 48 7a  MOVW    0FE6AH,#7A48H
4c3b: 3a 6c 00     MOV     0FE6CH,#00H
4c3e: 28 47 4d     CALL    !4D47H
4c41: 09 f0 a8 fd  MOV     A,!0FDA8H
4c45: ac 08        AND     A,#08H
4c47: 80 03        BNZ     $4C4CH
4c49: 2c e7 4c     BR      !4CE7H
4c4c: 08 a0 72 03  BF      0FE72H.0,$4C53H
4c50: 2c e7 4c     BR      !4CE7H
4c53: 3a 6a 20     MOV     0FE6AH,#20H
4c56: 09 f0 0f fd  MOV     A,!0FD0FH
4c5a: b8 00        MOV     X,#00H
4c5c: d8           XCH     A,X
4c5d: 3c           PUSH    AX
4c5e: 28 6d 51     CALL    !516DH
4c61: 34           POP     AX
4c62: d2           MOV     A,C
4c63: 22 6b        MOV     0FE6BH,A
4c65: 3a 6c 00     MOV     0FE6CH,#00H
4c68: 28 47 4d     CALL    !4D47H
4c6b: 09 f0 0f fd  MOV     A,!0FD0FH
4c6f: af ff        CMP     A,#0FFH
4c71: 80 14        BNZ     $4C87H
4c73: 3a 6a 20     MOV     0FE6AH,#20H
4c76: 3a 6b 20     MOV     0FE6BH,#20H
4c79: 3a 6c 20     MOV     0FE6CH,#20H
4c7c: 3a 6d 20     MOV     0FE6DH,#20H
4c7f: 3a 6e 20     MOV     0FE6EH,#20H
4c82: 3a 6f 20     MOV     0FE6FH,#20H
4c85: 14 5a        BR      $4CE1H
4c87: 09 f0 10 fd  MOV     A,!0FD10H
4c8b: b8 00        MOV     X,#00H
4c8d: d8           XCH     A,X
4c8e: 3c           PUSH    AX
4c8f: 28 6d 51     CALL    !516DH
4c92: 34           POP     AX
4c93: d2           MOV     A,C
4c94: 22 6a        MOV     0FE6AH,A
4c96: 09 f0 11 fd  MOV     A,!0FD11H
4c9a: b8 00        MOV     X,#00H
4c9c: d8           XCH     A,X
4c9d: 3c           PUSH    AX
4c9e: 28 6d 51     CALL    !516DH
4ca1: 34           POP     AX
4ca2: d2           MOV     A,C
4ca3: 22 6b        MOV     0FE6BH,A
4ca5: 09 f0 12 fd  MOV     A,!0FD12H
4ca9: b8 00        MOV     X,#00H
4cab: d8           XCH     A,X
4cac: 3c           PUSH    AX
4cad: 28 6d 51     CALL    !516DH
4cb0: 34           POP     AX
4cb1: d2           MOV     A,C
4cb2: 22 6c        MOV     0FE6CH,A
4cb4: 09 f0 13 fd  MOV     A,!0FD13H
4cb8: b8 00        MOV     X,#00H
4cba: d8           XCH     A,X
4cbb: 3c           PUSH    AX
4cbc: 28 6d 51     CALL    !516DH
4cbf: 34           POP     AX
4cc0: d2           MOV     A,C
4cc1: 22 6d        MOV     0FE6DH,A
4cc3: 09 f0 14 fd  MOV     A,!0FD14H
4cc7: b8 00        MOV     X,#00H
4cc9: d8           XCH     A,X
4cca: 3c           PUSH    AX
4ccb: 28 6d 51     CALL    !516DH
4cce: 34           POP     AX
4ccf: d2           MOV     A,C
4cd0: 22 6e        MOV     0FE6EH,A
4cd2: 09 f0 15 fd  MOV     A,!0FD15H
4cd6: b8 00        MOV     X,#00H
4cd8: d8           XCH     A,X
4cd9: 3c           PUSH    AX
4cda: 28 6d 51     CALL    !516DH
4cdd: 34           POP     AX
4cde: d2           MOV     A,C
4cdf: 22 6f        MOV     0FE6FH,A
4ce1: 3a 70 00     MOV     0FE70H,#00H
4ce4: 28 47 4d     CALL    !4D47H
4ce7: 09 f0 a8 fd  MOV     A,!0FDA8H
4ceb: ac 10        AND     A,#10H
4ced: 81 38        BZ      $4D27H
4cef: 70 72 35     BT      0FE72H.0,$4D27H
4cf2: 3a 6a 20     MOV     0FE6AH,#20H
4cf5: 09 f0 a5 fd  MOV     A,!0FDA5H
4cf9: 30 a1        SHR     A,4
4cfb: 22 6b        MOV     0FE6BH,A
4cfd: b9 09        MOV     A,#09H
4cff: 9f 6b        CMP     A,0FE6BH
4d01: 83 05        BC      $4D08H
4d03: 68 6b 30     ADD     0FE6BH,#30H
4d06: 14 03        BR      $4D0BH
4d08: 68 6b 37     ADD     0FE6BH,#37H
4d0b: 09 f0 a5 fd  MOV     A,!0FDA5H
4d0f: ac 0f        AND     A,#0FH
4d11: 22 6c        MOV     0FE6CH,A
4d13: b9 09        MOV     A,#09H
4d15: 9f 6c        CMP     A,0FE6CH
4d17: 83 05        BC      $4D1EH
4d19: 68 6c 30     ADD     0FE6CH,#30H
4d1c: 14 03        BR      $4D21H
4d1e: 68 6c 37     ADD     0FE6CH,#37H
4d21: 3a 6d 00     MOV     0FE6DH,#00H
4d24: 28 47 4d     CALL    !4D47H
4d27: 09 f0 a8 fd  MOV     A,!0FDA8H
4d2b: af 00        CMP     A,#00H
4d2d: 81 0a        BZ      $4D39H
4d2f: 0c 6a 0d 0a  MOVW    0FE6AH,#0A0DH
4d33: 3a 6c 00     MOV     0FE6CH,#00H
4d36: 28 47 4d     CALL    !4D47H
4d39: 09 f0 a8 fd  MOV     A,!0FDA8H
4d3d: ac 80        AND     A,#80H
4d3f: 81 03        BZ      $4D44H
4d41: 3a 8a fa     MOV     0FE8AH,#0FAH
4d44: 34           POP     AX
4d45: 37           POP     HL
4d46: 56           RET
4d47: 64 6a fe     MOVW    DE,#0FE6AH
4d4a: 3e           PUSH    DE
4d4b: 28 79 46     CALL    !4679H
4d4e: 34           POP     AX
4d4f: 56           RET
4d50: 09 f0 94 fd  MOV     A,!0FD94H
4d54: d8           XCH     A,X
4d55: 09 f0 93 fd  MOV     A,!0FD93H
4d59: 8f 10        CMP     A,X
4d5b: 83 13        BC      $4D70H
4d5d: 09 f0 93 fd  MOV     A,!0FD93H
4d61: d8           XCH     A,X
4d62: 09 f0 94 fd  MOV     A,!0FD94H
4d66: 8a 01        SUB     X,A
4d68: 24 20        MOV     C,X
4d6a: bb 00        MOV     B,#00H
4d6c: 14 17        BR      $4D85H
4d6e: 14 15        BR      $4D85H
4d70: b9 40        MOV     A,#40H
4d72: d8           XCH     A,X
4d73: 09 f0 94 fd  MOV     A,!0FD94H
4d77: 8a 01        SUB     X,A
4d79: d0           MOV     A,X
4d7a: d8           XCH     A,X
4d7b: 09 f0 93 fd  MOV     A,!0FD93H
4d7f: 88 01        ADD     X,A
4d81: 24 20        MOV     C,X
4d83: bb 00        MOV     B,#00H
4d85: 56           RET
4d86: 14 4c        BR      $4DD4H
4d88: 20 b2        MOV     A,I2C_OutputBuffer
4d8a: 03 08        MOV1    CY,A.0
4d8c: 08 17 a1     MOV1    0FEA1H.7,CY
4d8f: 08 a7 a1 15  BF      0FEA1H.7,$4DA8H
4d93: 60 f8 df     MOVW    AX,#0DFF8H
4d96: 3c           PUSH    AX
4d97: 08 a5 65 04  BF      0FE65H.5,$4D9FH
4d9b: 1c 90        MOVW    AX,0FE90H
4d9d: 14 03        BR      $4DA2H
4d9f: 60 ab 0b     MOVW    AX,#0BABH
4da2: 3c           PUSH    AX
4da3: 28 63 7b     CALL    !7B63H
4da6: 34           POP     AX
4da7: 34           POP     AX
4da8: 62 01 00     MOVW    BC,#0001H
4dab: 14 3b        BR      $4DE8H
4dad: 20 b2        MOV     A,I2C_OutputBuffer
4daf: 03 08        MOV1    CY,A.0
4db1: 08 16 a1     MOV1    0FEA1H.6,CY
4db4: 08 a6 a1 15  BF      0FEA1H.6,$4DCDH
4db8: 60 fe df     MOVW    AX,#0DFFEH
4dbb: 3c           PUSH    AX
4dbc: 08 a5 65 04  BF      0FE65H.5,$4DC4H
4dc0: 1c 90        MOVW    AX,0FE90H
4dc2: 14 03        BR      $4DC7H
4dc4: 60 ab 0b     MOVW    AX,#0BABH
4dc7: 3c           PUSH    AX
4dc8: 28 63 7b     CALL    !7B63H
4dcb: 34           POP     AX
4dcc: 34           POP     AX
4dcd: 62 01 00     MOVW    BC,#0001H
4dd0: 14 16        BR      $4DE8H
4dd2: 14 11        BR      $4DE5H
4dd4: 28 02 47     CALL    !4702H
4dd7: 24 0a        MOVW    AX,BC
4dd9: 2f 32 00     CMPW    AX,#0032H
4ddc: 81 cf        BZ      $4DADH
4dde: 24 0a        MOVW    AX,BC
4de0: 2f 31 00     CMPW    AX,#0031H
4de3: 81 a3        BZ      $4D88H
4de5: 62 00 00     MOVW    BC,#0000H
4de8: 56           RET
4de9: 3f           PUSH    HL
4dea: 05 c9        DECW    SP
4dec: 05 c9        DECW    SP
4dee: 11 fc        MOVW    AX,SP
4df0: 24 68        MOVW    HL,AX
4df2: 0c 90 ff ff  MOVW    0FE90H,#0FFFFH
4df6: 09 f0 93 fd  MOV     A,!0FD93H
4dfa: b8 00        MOV     X,#00H
4dfc: d8           XCH     A,X
4dfd: 2d 31 fd     ADDW    AX,#0FD31H
4e00: 24 48        MOVW    DE,AX
4e02: 5c           MOV     A,[DE]
4e03: 06 a0 01     MOV     [HL+01H],A
4e06: af 30        CMP     A,#30H
4e08: 82 03        BNC     $4E0DH
4e0a: 2c 8f 4e     BR      !4E8FH
4e0d: b9 39        MOV     A,#39H
4e0f: 06 2f 01     CMP     A,[HL+01H]
4e12: 83 7b        BC      $4E8FH
4e14: 3a 91 00     MOV     0FE91H,#00H
4e17: 28 02 47     CALL    !4702H
4e1a: d2           MOV     A,C
4e1b: ac 0f        AND     A,#0FH
4e1d: 22 90        MOV     0FE90H,A
4e1f: 09 f0 93 fd  MOV     A,!0FD93H
4e23: b8 00        MOV     X,#00H
4e25: d8           XCH     A,X
4e26: 2d 31 fd     ADDW    AX,#0FD31H
4e29: 24 48        MOVW    DE,AX
4e2b: 5c           MOV     A,[DE]
4e2c: 06 a0 01     MOV     [HL+01H],A
4e2f: af 30        CMP     A,#30H
4e31: 83 5c        BC      $4E8FH
4e33: b9 39        MOV     A,#39H
4e35: 06 2f 01     CMP     A,[HL+01H]
4e38: 83 55        BC      $4E8FH
4e3a: 20 90        MOV     A,0FE90H
4e3c: 31 a1        SHL     A,4
4e3e: 3c           PUSH    AX
4e3f: 28 02 47     CALL    !4702H
4e42: 34           POP     AX
4e43: dc           XCH     A,E
4e44: 60 0f 00     MOVW    AX,#000FH
4e47: 8c 20        AND     C,X
4e49: 8c 31        AND     B,A
4e4b: bd 00        MOV     D,#00H
4e4d: 8e 42        OR      E,C
4e4f: 8e 53        OR      D,B
4e51: d4           MOV     A,E
4e52: 22 90        MOV     0FE90H,A
4e54: 09 f0 93 fd  MOV     A,!0FD93H
4e58: b8 00        MOV     X,#00H
4e5a: d8           XCH     A,X
4e5b: 2d 31 fd     ADDW    AX,#0FD31H
4e5e: 24 48        MOVW    DE,AX
4e60: 5c           MOV     A,[DE]
4e61: 06 a0 01     MOV     [HL+01H],A
4e64: af 30        CMP     A,#30H
4e66: 83 27        BC      $4E8FH
4e68: b9 39        MOV     A,#39H
4e6a: 06 2f 01     CMP     A,[HL+01H]
4e6d: 83 20        BC      $4E8FH
4e6f: 20 90        MOV     A,0FE90H
4e71: 30 a1        SHR     A,4
4e73: 22 91        MOV     0FE91H,A
4e75: 20 90        MOV     A,0FE90H
4e77: 31 a1        SHL     A,4
4e79: 3c           PUSH    AX
4e7a: 28 02 47     CALL    !4702H
4e7d: 34           POP     AX
4e7e: dc           XCH     A,E
4e7f: 60 0f 00     MOVW    AX,#000FH
4e82: 8c 20        AND     C,X
4e84: 8c 31        AND     B,A
4e86: bd 00        MOV     D,#00H
4e88: 8e 42        OR      E,C
4e8a: 8e 53        OR      D,B
4e8c: d4           MOV     A,E
4e8d: 22 90        MOV     0FE90H,A
4e8f: 34           POP     AX
4e90: 37           POP     HL
4e91: 56           RET
4e92: 3f           PUSH    HL
4e93: 11 fc        MOVW    AX,SP
4e95: 2e 08 00     SUBW    AX,#0008H
4e98: 24 68        MOVW    HL,AX
4e9a: 13 fc        MOVW    SP,AX
4e9c: b9 00        MOV     A,#00H
4e9e: 06 a0 07     MOV     [HL+07H],A
4ea1: b9 00        MOV     A,#00H
4ea3: 06 a0 06     MOV     [HL+06H],A
4ea6: 1c 63        MOVW    AX,0FE63H
4ea8: 24 48        MOVW    DE,AX
4eaa: 06 00 06     MOV     A,[DE+06H]
4ead: 30 b1        SHR     A,6
4eaf: ac 03        AND     A,#03H
4eb1: b8 00        MOV     X,#00H
4eb3: d8           XCH     A,X
4eb4: 2f 01 00     CMPW    AX,#0001H
4eb7: 81 05        BZ      $4EBEH
4eb9: 60 06 00     MOVW    AX,#0006H
4ebc: 14 03        BR      $4EC1H
4ebe: 60 07 00     MOVW    AX,#0007H
4ec1: d0           MOV     A,X
4ec2: 06 a0 04     MOV     [HL+04H],A
4ec5: 8a 08        SUBW    AX,AX
4ec7: 24 28        MOVW    BC,AX
4ec9: 55           MOV     [HL],A
4eca: 06 a0 01     MOV     [HL+01H],A
4ecd: 06 a0 02     MOV     [HL+02H],A
4ed0: 06 a0 03     MOV     [HL+03H],A
4ed3: 06 20 04     MOV     A,[HL+04H]
4ed6: af 08        CMP     A,#08H
4ed8: 83 03        BC      $4EDDH
4eda: 2c 57 50     BR      !5057H
4edd: 06 20 0c     MOV     A,[HL+0CH]
4ee0: af 30        CMP     A,#30H
4ee2: 83 0c        BC      $4EF0H
4ee4: b9 39        MOV     A,#39H
4ee6: 06 2f 0c     CMP     A,[HL+0CH]
4ee9: 83 05        BC      $4EF0H
4eeb: 60 30 00     MOVW    AX,#0030H
4eee: 14 06        BR      $4EF6H
4ef0: 06 20 0c     MOV     A,[HL+0CH]
4ef3: b8 00        MOV     X,#00H
4ef5: d8           XCH     A,X
4ef6: d0           MOV     A,X
4ef7: 06 a0 05     MOV     [HL+05H],A
4efa: 2c 39 50     BR      !5039H
4efd: 06 20 06     MOV     A,[HL+06H]
4f00: af 00        CMP     A,#00H
4f02: 81 03        BZ      $4F07H
4f04: 2c ea 4f     BR      !4FEAH
4f07: b9 01        MOV     A,#01H
4f09: 06 a0 06     MOV     [HL+06H],A
4f0c: 1c 63        MOVW    AX,0FE63H
4f0e: 24 48        MOVW    DE,AX
4f10: 5c           MOV     A,[DE]
4f11: 30 a1        SHR     A,4
4f13: ac 01        AND     A,#01H
4f15: b8 00        MOV     X,#00H
4f17: d8           XCH     A,X
4f18: 2f 00 00     CMPW    AX,#0000H
4f1b: 81 05        BZ      $4F22H
4f1d: 60 04 00     MOVW    AX,#0004H
4f20: 14 03        BR      $4F25H
4f22: 60 01 00     MOVW    AX,#0001H
4f25: d0           MOV     A,X
4f26: 06 a0 05     MOV     [HL+05H],A
4f29: 06 2f 04     CMP     A,[HL+04H]
4f2c: 82 5f        BNC     $4F8DH
4f2e: 06 20 05     MOV     A,[HL+05H]
4f31: 06 2f 04     CMP     A,[HL+04H]
4f34: 82 55        BNC     $4F8BH
4f36: 06 20 04     MOV     A,[HL+04H]
4f39: c9           DEC     A
4f3a: 06 a0 04     MOV     [HL+04H],A
4f3d: 5d           MOV     A,[HL]
4f3e: 30 a1        SHR     A,4
4f40: d8           XCH     A,X
4f41: 06 20 01     MOV     A,[HL+01H]
4f44: 31 a1        SHL     A,4
4f46: da           XCH     A,C
4f47: b9 00        MOV     A,#00H
4f49: bb 00        MOV     B,#00H
4f4b: 8e 02        OR      X,C
4f4d: 8e 13        OR      A,B
4f4f: d0           MOV     A,X
4f50: 55           MOV     [HL],A
4f51: 06 20 01     MOV     A,[HL+01H]
4f54: 30 a1        SHR     A,4
4f56: d8           XCH     A,X
4f57: 06 20 02     MOV     A,[HL+02H]
4f5a: 31 a1        SHL     A,4
4f5c: da           XCH     A,C
4f5d: b9 00        MOV     A,#00H
4f5f: bb 00        MOV     B,#00H
4f61: 8e 02        OR      X,C
4f63: 8e 13        OR      A,B
4f65: d0           MOV     A,X
4f66: 06 a0 01     MOV     [HL+01H],A
4f69: 06 20 02     MOV     A,[HL+02H]
4f6c: 30 a1        SHR     A,4
4f6e: d8           XCH     A,X
4f6f: 06 20 03     MOV     A,[HL+03H]
4f72: 31 a1        SHL     A,4
4f74: da           XCH     A,C
4f75: b9 00        MOV     A,#00H
4f77: bb 00        MOV     B,#00H
4f79: 8e 02        OR      X,C
4f7b: 8e 13        OR      A,B
4f7d: d0           MOV     A,X
4f7e: 06 a0 02     MOV     [HL+02H],A
4f81: 06 20 03     MOV     A,[HL+03H]
4f84: 30 a1        SHR     A,4
4f86: 06 a0 03     MOV     [HL+03H],A
4f89: 14 a3        BR      $4F2EH
4f8b: 14 5b        BR      $4FE8H
4f8d: 06 20 04     MOV     A,[HL+04H]
4f90: 06 2f 05     CMP     A,[HL+05H]
4f93: 82 53        BNC     $4FE8H
4f95: 06 20 04     MOV     A,[HL+04H]
4f98: c1           INC     A
4f99: 06 a0 04     MOV     [HL+04H],A
4f9c: 06 20 03     MOV     A,[HL+03H]
4f9f: 31 a1        SHL     A,4
4fa1: d8           XCH     A,X
4fa2: 06 20 02     MOV     A,[HL+02H]
4fa5: 30 a1        SHR     A,4
4fa7: da           XCH     A,C
4fa8: b9 00        MOV     A,#00H
4faa: bb 00        MOV     B,#00H
4fac: 8e 02        OR      X,C
4fae: 8e 13        OR      A,B
4fb0: d0           MOV     A,X
4fb1: 06 a0 03     MOV     [HL+03H],A
4fb4: 06 20 02     MOV     A,[HL+02H]
4fb7: 31 a1        SHL     A,4
4fb9: d8           XCH     A,X
4fba: 06 20 01     MOV     A,[HL+01H]
4fbd: 30 a1        SHR     A,4
4fbf: da           XCH     A,C
4fc0: b9 00        MOV     A,#00H
4fc2: bb 00        MOV     B,#00H
4fc4: 8e 02        OR      X,C
4fc6: 8e 13        OR      A,B
4fc8: d0           MOV     A,X
4fc9: 06 a0 02     MOV     [HL+02H],A
4fcc: 06 20 01     MOV     A,[HL+01H]
4fcf: 31 a1        SHL     A,4
4fd1: d8           XCH     A,X
4fd2: 5d           MOV     A,[HL]
4fd3: 30 a1        SHR     A,4
4fd5: da           XCH     A,C
4fd6: b9 00        MOV     A,#00H
4fd8: bb 00        MOV     B,#00H
4fda: 8e 02        OR      X,C
4fdc: 8e 13        OR      A,B
4fde: d0           MOV     A,X
4fdf: 06 a0 01     MOV     [HL+01H],A
4fe2: 5d           MOV     A,[HL]
4fe3: 31 a1        SHL     A,4
4fe5: 55           MOV     [HL],A
4fe6: 14 a5        BR      $4F8DH
4fe8: 14 05        BR      $4FEFH
4fea: b9 fe        MOV     A,#0FEH
4fec: 06 a0 04     MOV     [HL+04H],A
4fef: 14 5c        BR      $504DH
4ff1: b9 ff        MOV     A,#0FFH
4ff3: 06 a0 04     MOV     [HL+04H],A
4ff6: 14 55        BR      $504DH
4ff8: b9 0f        MOV     A,#0FH
4ffa: 06 2c 0c     AND     A,[HL+0CH]
4ffd: 06 a0 0c     MOV     [HL+0CH],A
5000: 06 20 04     MOV     A,[HL+04H]
5003: ac 01        AND     A,#01H
5005: 81 0a        BZ      $5011H
5007: 06 20 0c     MOV     A,[HL+0CH]
500a: 31 a1        SHL     A,4
500c: b8 00        MOV     X,#00H
500e: d8           XCH     A,X
500f: 14 06        BR      $5017H
5011: 06 20 0c     MOV     A,[HL+0CH]
5014: b8 00        MOV     X,#00H
5016: d8           XCH     A,X
5017: 24 28        MOVW    BC,AX
5019: 06 20 04     MOV     A,[HL+04H]
501c: 30 89        SHR     A,1
501e: b8 00        MOV     X,#00H
5020: d8           XCH     A,X
5021: 88 0e        ADDW    AX,HL
5023: 24 48        MOVW    DE,AX
5025: d2           MOV     A,C
5026: 16 4e        OR      A,[DE]
5028: 54           MOV     [DE],A
5029: 06 20 04     MOV     A,[HL+04H]
502c: c9           DEC     A
502d: 06 a0 04     MOV     [HL+04H],A
5030: 14 1b        BR      $504DH
5032: b9 fe        MOV     A,#0FEH
5034: 06 a0 04     MOV     [HL+04H],A
5037: 14 14        BR      $504DH
5039: 06 20 05     MOV     A,[HL+05H]
503c: af 30        CMP     A,#30H
503e: 81 b8        BZ      $4FF8H
5040: af 0d        CMP     A,#0DH
5042: 81 ad        BZ      $4FF1H
5044: af 2e        CMP     A,#2EH
5046: 80 03        BNZ     $504BH
5048: 2c fd 4e     BR      !4EFDH
504b: 14 e5        BR      $5032H
504d: 28 02 47     CALL    !4702H
5050: d2           MOV     A,C
5051: 06 a0 0c     MOV     [HL+0CH],A
5054: 2c d3 4e     BR      !4ED3H
5057: 06 20 04     MOV     A,[HL+04H]
505a: af ff        CMP     A,#0FFH
505c: 80 0b        BNZ     $5069H
505e: 24 0e        MOVW    AX,HL
5060: 3c           PUSH    AX
5061: 28 36 98     CALL    !9836H
5064: 34           POP     AX
5065: d2           MOV     A,C
5066: 06 a0 07     MOV     [HL+07H],A
5069: 06 20 07     MOV     A,[HL+07H]
506c: bb 00        MOV     B,#00H
506e: da           XCH     A,C
506f: 34           POP     AX
5070: 34           POP     AX
5071: 34           POP     AX
5072: 34           POP     AX
5073: 37           POP     HL
5074: 56           RET
5075: 3f           PUSH    HL
5076: 05 c9        DECW    SP
5078: 05 c9        DECW    SP
507a: 11 fc        MOVW    AX,SP
507c: 24 68        MOVW    HL,AX
507e: 28 02 47     CALL    !4702H
5081: d2           MOV     A,C
5082: 06 a0 01     MOV     [HL+01H],A
5085: b9 39        MOV     A,#39H
5087: 06 2f 01     CMP     A,[HL+01H]
508a: 82 05        BNC     $5091H
508c: 60 37 00     MOVW    AX,#0037H
508f: 14 03        BR      $5094H
5091: 60 30 00     MOVW    AX,#0030H
5094: 24 28        MOVW    BC,AX
5096: 06 20 01     MOV     A,[HL+01H]
5099: b8 00        MOV     X,#00H
509b: d8           XCH     A,X
509c: 8a 0a        SUBW    AX,BC
509e: 31 e0        SHLW    AX,4
50a0: d0           MOV     A,X
50a1: 22 71        MOV     0FE71H,A
50a3: 28 02 47     CALL    !4702H
50a6: d2           MOV     A,C
50a7: 06 a0 01     MOV     [HL+01H],A
50aa: b9 39        MOV     A,#39H
50ac: 06 2f 01     CMP     A,[HL+01H]
50af: 82 05        BNC     $50B6H
50b1: 60 37 00     MOVW    AX,#0037H
50b4: 14 03        BR      $50B9H
50b6: 60 30 00     MOVW    AX,#0030H
50b9: 24 28        MOVW    BC,AX
50bb: 06 20 01     MOV     A,[HL+01H]
50be: b8 00        MOV     X,#00H
50c0: d8           XCH     A,X
50c1: 8a 0a        SUBW    AX,BC
50c3: 24 28        MOVW    BC,AX
50c5: 20 71        MOV     A,0FE71H
50c7: b8 00        MOV     X,#00H
50c9: 8e 03        OR      X,B
50cb: 8e 12        OR      A,C
50cd: 22 71        MOV     0FE71H,A
50cf: 28 02 47     CALL    !4702H
50d2: d2           MOV     A,C
50d3: 06 a0 01     MOV     [HL+01H],A
50d6: b9 39        MOV     A,#39H
50d8: 06 2f 01     CMP     A,[HL+01H]
50db: 82 05        BNC     $50E2H
50dd: 60 37 00     MOVW    AX,#0037H
50e0: 14 03        BR      $50E5H
50e2: 60 30 00     MOVW    AX,#0030H
50e5: 24 28        MOVW    BC,AX
50e7: 06 20 01     MOV     A,[HL+01H]
50ea: b8 00        MOV     X,#00H
50ec: d8           XCH     A,X
50ed: 8a 0a        SUBW    AX,BC
50ef: 31 e0        SHLW    AX,4
50f1: d0           MOV     A,X
50f2: 22 70        MOV     0FE70H,A
50f4: 28 02 47     CALL    !4702H
50f7: d2           MOV     A,C
50f8: 06 a0 01     MOV     [HL+01H],A
50fb: b9 39        MOV     A,#39H
50fd: 06 2f 01     CMP     A,[HL+01H]
5100: 82 05        BNC     $5107H
5102: 60 37 00     MOVW    AX,#0037H
5105: 14 03        BR      $510AH
5107: 60 30 00     MOVW    AX,#0030H
510a: 24 28        MOVW    BC,AX
510c: 06 20 01     MOV     A,[HL+01H]
510f: b8 00        MOV     X,#00H
5111: d8           XCH     A,X
5112: 8a 0a        SUBW    AX,BC
5114: 24 28        MOVW    BC,AX
5116: 20 70        MOV     A,0FE70H
5118: b8 00        MOV     X,#00H
511a: 8e 03        OR      X,B
511c: 8e 12        OR      A,C
511e: 22 70        MOV     0FE70H,A
5120: 34           POP     AX
5121: 37           POP     HL
5122: 56           RET
5123: 3f           PUSH    HL
5124: 05 c9        DECW    SP
5126: 05 c9        DECW    SP
5128: 11 fc        MOVW    AX,SP
512a: 24 68        MOVW    HL,AX
512c: 06 20 06     MOV     A,[HL+06H]
512f: d8           XCH     A,X
5130: 06 20 07     MOV     A,[HL+07H]
5133: 24 48        MOVW    DE,AX
5135: 5c           MOV     A,[DE]
5136: 30 a1        SHR     A,4
5138: ae 30        OR      A,#30H
513a: 55           MOV     [HL],A
513b: 06 20 06     MOV     A,[HL+06H]
513e: d8           XCH     A,X
513f: 06 20 07     MOV     A,[HL+07H]
5142: 24 48        MOVW    DE,AX
5144: 5c           MOV     A,[DE]
5145: ac 0f        AND     A,#0FH
5147: ae 30        OR      A,#30H
5149: 06 a0 01     MOV     [HL+01H],A
514c: b9 39        MOV     A,#39H
514e: 16 5f        CMP     A,[HL]
5150: 82 05        BNC     $5157H
5152: b9 07        MOV     A,#07H
5154: 16 58        ADD     A,[HL]
5156: 55           MOV     [HL],A
5157: b9 39        MOV     A,#39H
5159: 06 2f 01     CMP     A,[HL+01H]
515c: 82 08        BNC     $5166H
515e: b9 07        MOV     A,#07H
5160: 06 28 01     ADD     A,[HL+01H]
5163: 06 a0 01     MOV     [HL+01H],A
5166: 05 e3        MOVW    AX,[HL]
5168: 24 28        MOVW    BC,AX
516a: 34           POP     AX
516b: 37           POP     HL
516c: 56           RET
516d: 3f           PUSH    HL
516e: 11 fc        MOVW    AX,SP
5170: 24 68        MOVW    HL,AX
5172: 06 20 04     MOV     A,[HL+04H]
5175: af 0a        CMP     A,#0AH
5177: 82 0a        BNC     $5183H
5179: b9 30        MOV     A,#30H
517b: 06 28 04     ADD     A,[HL+04H]
517e: 06 a0 04     MOV     [HL+04H],A
5181: 14 32        BR      $51B5H
5183: 06 20 04     MOV     A,[HL+04H]
5186: af 0a        CMP     A,#0AH
5188: 80 07        BNZ     $5191H
518a: b9 2d        MOV     A,#2DH
518c: 06 a0 04     MOV     [HL+04H],A
518f: 14 24        BR      $51B5H
5191: 06 20 04     MOV     A,[HL+04H]
5194: af 0b        CMP     A,#0BH
5196: 80 07        BNZ     $519FH
5198: b9 20        MOV     A,#20H
519a: 06 a0 04     MOV     [HL+04H],A
519d: 14 16        BR      $51B5H
519f: 06 20 04     MOV     A,[HL+04H]
51a2: af 26        CMP     A,#26H
51a4: 82 0a        BNC     $51B0H
51a6: b9 35        MOV     A,#35H
51a8: 06 28 04     ADD     A,[HL+04H]
51ab: 06 a0 04     MOV     [HL+04H],A
51ae: 14 05        BR      $51B5H
51b0: b9 20        MOV     A,#20H
51b2: 06 a0 04     MOV     [HL+04H],A
51b5: 06 20 04     MOV     A,[HL+04H]
51b8: bb 00        MOV     B,#00H
51ba: da           XCH     A,C
51bb: 37           POP     HL
51bc: 56           RET
Read_RTC_Seconds:
51bd: 3f           PUSH    HL
51be: 11 fc        MOVW    AX,SP
51c0: 2e 0a 00     SUBW    AX,#000AH
51c3: 24 68        MOVW    HL,AX
51c5: 13 fc        MOVW    SP,AX
51c7: 8a 08        SUBW    AX,AX
51c9: 06 a0 08     MOV     [HL+08H],A
51cc: 06 a0 09     MOV     [HL+09H],A
51cf: b4 00        SET1    P0.4            ; turn on RTC chip select
51d1: 64 00 e0     MOVW    DE,#0E000H      ; read Seconds
51d4: 5c           MOV     A,[DE]
51d5: 06 a0 07     MOV     [HL+07H],A
51d8: a4 00        CLR1    P0.4
51da: 60 02 00     MOVW    AX,#0002H
51dd: 3c           PUSH    AX
51de: 28 6d 8b     CALL    Delay_Loop
51e1: 34           POP     AX
51e2: b4 00        SET1    P0.4
51e4: 64 00 e0     MOVW    DE,#0E000H
51e7: 5c           MOV     A,[DE]
51e8: 06 a0 06     MOV     [HL+06H],A
51eb: a4 00        CLR1    P0.4
51ed: 06 20 08     MOV     A,[HL+08H]
51f0: d8           XCH     A,X
51f1: 06 20 09     MOV     A,[HL+09H]
51f4: 44           INCW    AX
51f5: 06 a0 09     MOV     [HL+09H],A
51f8: d8           XCH     A,X
51f9: 06 a0 08     MOV     [HL+08H],A
51fc: 06 20 08     MOV     A,[HL+08H]
51ff: d8           XCH     A,X
5200: 06 20 09     MOV     A,[HL+09H]
5203: 2f 14 00     CMPW    AX,#0014H
5206: 82 08        BNC     $5210H
5208: 06 20 06     MOV     A,[HL+06H]
520b: 06 2f 07     CMP     A,[HL+07H]
520e: 80 bf        BNZ     $51CFH
5210: 8a 08        SUBW    AX,AX
5212: 06 a0 08     MOV     [HL+08H],A
5215: 06 a0 09     MOV     [HL+09H],A
5218: b4 00        SET1    P0.4
521a: 64 01 e0     MOVW    DE,#0E001H
521d: 5c           MOV     A,[DE]
521e: 06 a0 07     MOV     [HL+07H],A
5221: a4 00        CLR1    P0.4
5223: 60 02 00     MOVW    AX,#0002H
5226: 3c           PUSH    AX
5227: 28 6d 8b     CALL    Delay_Loop
522a: 34           POP     AX
522b: b4 00        SET1    P0.4
522d: 64 01 e0     MOVW    DE,#0E001H
5230: 5c           MOV     A,[DE]
5231: 06 a0 05     MOV     [HL+05H],A
5234: a4 00        CLR1    P0.4
5236: 06 20 08     MOV     A,[HL+08H]
5239: d8           XCH     A,X
523a: 06 20 09     MOV     A,[HL+09H]
523d: 44           INCW    AX
523e: 06 a0 09     MOV     [HL+09H],A
5241: d8           XCH     A,X
5242: 06 a0 08     MOV     [HL+08H],A
5245: 06 20 08     MOV     A,[HL+08H]
5248: d8           XCH     A,X
5249: 06 20 09     MOV     A,[HL+09H]
524c: 2f 14 00     CMPW    AX,#0014H
524f: 82 08        BNC     $5259H
5251: 06 20 05     MOV     A,[HL+05H]
5254: 06 2f 07     CMP     A,[HL+07H]
5257: 80 bf        BNZ     $5218H
5259: 06 20 06     MOV     A,[HL+06H]
525c: ac 0f        AND     A,#0FH
525e: d8           XCH     A,X
525f: 06 20 05     MOV     A,[HL+05H]
5262: 31 a1        SHL     A,4
5264: da           XCH     A,C
5265: b9 00        MOV     A,#00H
5267: bb 00        MOV     B,#00H
5269: 8e 02        OR      X,C
526b: 8e 13        OR      A,B
526d: d0           MOV     A,X
526e: 09 f1 25 fd  MOV     !0FD25H,A
5272: 8a 08        SUBW    AX,AX
5274: 06 a0 08     MOV     [HL+08H],A
5277: 06 a0 09     MOV     [HL+09H],A
527a: b4 00        SET1    P0.4
527c: 64 02 e0     MOVW    DE,#0E002H
527f: 5c           MOV     A,[DE]
5280: 06 a0 07     MOV     [HL+07H],A
5283: a4 00        CLR1    P0.4
5285: 60 02 00     MOVW    AX,#0002H
5288: 3c           PUSH    AX
5289: 28 6d 8b     CALL    Delay_Loop
528c: 34           POP     AX
528d: b4 00        SET1    P0.4
528f: 64 02 e0     MOVW    DE,#0E002H
5292: 5c           MOV     A,[DE]
5293: 06 a0 04     MOV     [HL+04H],A
5296: a4 00        CLR1    P0.4
5298: 06 20 08     MOV     A,[HL+08H]
529b: d8           XCH     A,X
529c: 06 20 09     MOV     A,[HL+09H]
529f: 44           INCW    AX
52a0: 06 a0 09     MOV     [HL+09H],A
52a3: d8           XCH     A,X
52a4: 06 a0 08     MOV     [HL+08H],A
52a7: 06 20 08     MOV     A,[HL+08H]
52aa: d8           XCH     A,X
52ab: 06 20 09     MOV     A,[HL+09H]
52ae: 2f 14 00     CMPW    AX,#0014H
52b1: 82 08        BNC     $52BBH
52b3: 06 20 04     MOV     A,[HL+04H]
52b6: 06 2f 07     CMP     A,[HL+07H]
52b9: 80 bf        BNZ     $527AH
52bb: 8a 08        SUBW    AX,AX
52bd: 06 a0 08     MOV     [HL+08H],A
52c0: 06 a0 09     MOV     [HL+09H],A
52c3: b4 00        SET1    P0.4
52c5: 64 03 e0     MOVW    DE,#0E003H
52c8: 5c           MOV     A,[DE]
52c9: 06 a0 07     MOV     [HL+07H],A
52cc: a4 00        CLR1    P0.4
52ce: 60 02 00     MOVW    AX,#0002H
52d1: 3c           PUSH    AX
52d2: 28 6d 8b     CALL    Delay_Loop
52d5: 34           POP     AX
52d6: b4 00        SET1    P0.4
52d8: 64 03 e0     MOVW    DE,#0E003H
52db: 5c           MOV     A,[DE]
52dc: 06 a0 03     MOV     [HL+03H],A
52df: a4 00        CLR1    P0.4
52e1: 06 20 08     MOV     A,[HL+08H]
52e4: d8           XCH     A,X
52e5: 06 20 09     MOV     A,[HL+09H]
52e8: 44           INCW    AX
52e9: 06 a0 09     MOV     [HL+09H],A
52ec: d8           XCH     A,X
52ed: 06 a0 08     MOV     [HL+08H],A
52f0: 06 20 08     MOV     A,[HL+08H]
52f3: d8           XCH     A,X
52f4: 06 20 09     MOV     A,[HL+09H]
52f7: 2f 14 00     CMPW    AX,#0014H
52fa: 82 08        BNC     $5304H
52fc: 06 20 03     MOV     A,[HL+03H]
52ff: 06 2f 07     CMP     A,[HL+07H]
5302: 80 bf        BNZ     $52C3H
5304: 06 20 04     MOV     A,[HL+04H]
5307: ac 0f        AND     A,#0FH
5309: d8           XCH     A,X
530a: 06 20 03     MOV     A,[HL+03H]
530d: 31 a1        SHL     A,4
530f: da           XCH     A,C
5310: b9 00        MOV     A,#00H
5312: bb 00        MOV     B,#00H
5314: 8e 02        OR      X,C
5316: 8e 13        OR      A,B
5318: d0           MOV     A,X
5319: 09 f1 26 fd  MOV     !0FD26H,A
531d: 8a 08        SUBW    AX,AX
531f: 06 a0 08     MOV     [HL+08H],A
5322: 06 a0 09     MOV     [HL+09H],A
5325: b4 00        SET1    P0.4
5327: 64 04 e0     MOVW    DE,#0E004H
532a: 5c           MOV     A,[DE]
532b: 06 a0 07     MOV     [HL+07H],A
532e: a4 00        CLR1    P0.4
5330: 60 02 00     MOVW    AX,#0002H
5333: 3c           PUSH    AX
5334: 28 6d 8b     CALL    Delay_Loop
5337: 34           POP     AX
5338: b4 00        SET1    P0.4
533a: 64 04 e0     MOVW    DE,#0E004H
533d: 5c           MOV     A,[DE]
533e: 06 a0 02     MOV     [HL+02H],A
5341: a4 00        CLR1    P0.4
5343: 06 20 08     MOV     A,[HL+08H]
5346: d8           XCH     A,X
5347: 06 20 09     MOV     A,[HL+09H]
534a: 44           INCW    AX
534b: 06 a0 09     MOV     [HL+09H],A
534e: d8           XCH     A,X
534f: 06 a0 08     MOV     [HL+08H],A
5352: 06 20 08     MOV     A,[HL+08H]
5355: d8           XCH     A,X
5356: 06 20 09     MOV     A,[HL+09H]
5359: 2f 14 00     CMPW    AX,#0014H
535c: 82 08        BNC     $5366H
535e: 06 20 02     MOV     A,[HL+02H]
5361: 06 2f 07     CMP     A,[HL+07H]
5364: 80 bf        BNZ     $5325H
5366: 8a 08        SUBW    AX,AX
5368: 06 a0 08     MOV     [HL+08H],A
536b: 06 a0 09     MOV     [HL+09H],A
536e: b4 00        SET1    P0.4
5370: 64 05 e0     MOVW    DE,#0E005H
5373: 5c           MOV     A,[DE]
5374: 06 a0 07     MOV     [HL+07H],A
5377: a4 00        CLR1    P0.4
5379: 60 02 00     MOVW    AX,#0002H
537c: 3c           PUSH    AX
537d: 28 6d 8b     CALL    Delay_Loop
5380: 34           POP     AX
5381: b4 00        SET1    P0.4
5383: 64 05 e0     MOVW    DE,#0E005H
5386: 5c           MOV     A,[DE]
5387: 06 a0 01     MOV     [HL+01H],A
538a: a4 00        CLR1    P0.4
538c: 06 20 08     MOV     A,[HL+08H]
538f: d8           XCH     A,X
5390: 06 20 09     MOV     A,[HL+09H]
5393: 44           INCW    AX
5394: 06 a0 09     MOV     [HL+09H],A
5397: d8           XCH     A,X
5398: 06 a0 08     MOV     [HL+08H],A
539b: 06 20 08     MOV     A,[HL+08H]
539e: d8           XCH     A,X
539f: 06 20 09     MOV     A,[HL+09H]
53a2: 2f 14 00     CMPW    AX,#0014H
53a5: 82 08        BNC     $53AFH
53a7: 06 20 01     MOV     A,[HL+01H]
53aa: 06 2f 07     CMP     A,[HL+07H]
53ad: 80 bf        BNZ     $536EH
53af: 06 20 02     MOV     A,[HL+02H]
53b2: ac 0f        AND     A,#0FH
53b4: d8           XCH     A,X
53b5: 06 20 01     MOV     A,[HL+01H]
53b8: 31 a1        SHL     A,4
53ba: ac 30        AND     A,#30H
53bc: da           XCH     A,C
53bd: b9 00        MOV     A,#00H
53bf: bb 00        MOV     B,#00H
53c1: 8e 02        OR      X,C
53c3: 8e 13        OR      A,B
53c5: d0           MOV     A,X
53c6: 09 f1 27 fd  MOV     !0FD27H,A
53ca: 28 c6 56     CALL    !56C6H
53cd: 24 0e        MOVW    AX,HL
53cf: 2d 0a 00     ADDW    AX,#000AH
53d2: 13 fc        MOVW    SP,AX
53d4: 37           POP     HL
53d5: 56           RET
53d6: 3f           PUSH    HL
53d7: 11 fc        MOVW    AX,SP
53d9: 2e 0c 00     SUBW    AX,#000CH
53dc: 24 68        MOVW    HL,AX
53de: 13 fc        MOVW    SP,AX
53e0: 60 dc ff     MOVW    AX,#0FFDCH
53e3: 06 a0 01     MOV     [HL+01H],A
53e6: d8           XCH     A,X
53e7: 55           MOV     [HL],A
53e8: 8a 08        SUBW    AX,AX
53ea: 06 a0 0a     MOV     [HL+0AH],A
53ed: 06 a0 0b     MOV     [HL+0BH],A
53f0: b4 00        SET1    P0.4
53f2: 64 00 e0     MOVW    DE,#0E000H
53f5: 5c           MOV     A,[DE]
53f6: 06 a0 09     MOV     [HL+09H],A
53f9: a4 00        CLR1    P0.4
53fb: 60 02 00     MOVW    AX,#0002H
53fe: 3c           PUSH    AX
53ff: 28 6d 8b     CALL    Delay_Loop
5402: 34           POP     AX
5403: b4 00        SET1    P0.4
5405: 64 00 e0     MOVW    DE,#0E000H
5408: 5c           MOV     A,[DE]
5409: 06 a0 08     MOV     [HL+08H],A
540c: a4 00        CLR1    P0.4
540e: 06 20 0a     MOV     A,[HL+0AH]
5411: d8           XCH     A,X
5412: 06 20 0b     MOV     A,[HL+0BH]
5415: 44           INCW    AX
5416: 06 a0 0b     MOV     [HL+0BH],A
5419: d8           XCH     A,X
541a: 06 a0 0a     MOV     [HL+0AH],A
541d: 06 20 0a     MOV     A,[HL+0AH]
5420: d8           XCH     A,X
5421: 06 20 0b     MOV     A,[HL+0BH]
5424: 2f 14 00     CMPW    AX,#0014H
5427: 82 08        BNC     $5431H
5429: 06 20 08     MOV     A,[HL+08H]
542c: 06 2f 09     CMP     A,[HL+09H]
542f: 80 bf        BNZ     $53F0H
5431: 8a 08        SUBW    AX,AX
5433: 06 a0 0a     MOV     [HL+0AH],A
5436: 06 a0 0b     MOV     [HL+0BH],A
5439: b4 00        SET1    P0.4
543b: 64 01 e0     MOVW    DE,#0E001H
543e: 5c           MOV     A,[DE]
543f: 06 a0 09     MOV     [HL+09H],A
5442: a4 00        CLR1    P0.4
5444: 60 02 00     MOVW    AX,#0002H
5447: 3c           PUSH    AX
5448: 28 6d 8b     CALL    Delay_Loop
544b: 34           POP     AX
544c: b4 00        SET1    P0.4
544e: 64 01 e0     MOVW    DE,#0E001H
5451: 5c           MOV     A,[DE]
5452: 06 a0 07     MOV     [HL+07H],A
5455: a4 00        CLR1    P0.4
5457: 06 20 0a     MOV     A,[HL+0AH]
545a: d8           XCH     A,X
545b: 06 20 0b     MOV     A,[HL+0BH]
545e: 44           INCW    AX
545f: 06 a0 0b     MOV     [HL+0BH],A
5462: d8           XCH     A,X
5463: 06 a0 0a     MOV     [HL+0AH],A
5466: 06 20 0a     MOV     A,[HL+0AH]
5469: d8           XCH     A,X
546a: 06 20 0b     MOV     A,[HL+0BH]
546d: 2f 14 00     CMPW    AX,#0014H
5470: 82 08        BNC     $547AH
5472: 06 20 07     MOV     A,[HL+07H]
5475: 06 2f 09     CMP     A,[HL+09H]
5478: 80 bf        BNZ     $5439H
547a: 06 20 08     MOV     A,[HL+08H]
547d: ac 0f        AND     A,#0FH
547f: d8           XCH     A,X
5480: 06 20 07     MOV     A,[HL+07H]
5483: 31 a1        SHL     A,4
5485: da           XCH     A,C
5486: b9 00        MOV     A,#00H
5488: bb 00        MOV     B,#00H
548a: 8e 02        OR      X,C
548c: 8e 13        OR      A,B
548e: d0           MOV     A,X
548f: 09 f1 25 fd  MOV     !0FD25H,A
5493: 06 a0 02     MOV     [HL+02H],A
5496: 09 f0 25 fd  MOV     A,!0FD25H
549a: 06 2f 02     CMP     A,[HL+02H]
549d: 81 03        BZ      $54A2H
549f: 2c 62 55     BR      !5562H
54a2: 05 e3        MOVW    AX,[HL]
54a4: 4c           DECW    AX
54a5: 06 a0 01     MOV     [HL+01H],A
54a8: d8           XCH     A,X
54a9: 55           MOV     [HL],A
54aa: d8           XCH     A,X
54ab: 44           INCW    AX
54ac: 2f 00 00     CMPW    AX,#0000H
54af: 80 03        BNZ     $54B4H
54b1: 2c 62 55     BR      !5562H
54b4: 8a 08        SUBW    AX,AX
54b6: 06 a0 0a     MOV     [HL+0AH],A
54b9: 06 a0 0b     MOV     [HL+0BH],A
54bc: b4 00        SET1    P0.4
54be: 64 00 e0     MOVW    DE,#0E000H
54c1: 5c           MOV     A,[DE]
54c2: 06 a0 09     MOV     [HL+09H],A
54c5: a4 00        CLR1    P0.4
54c7: 60 02 00     MOVW    AX,#0002H
54ca: 3c           PUSH    AX
54cb: 28 6d 8b     CALL    Delay_Loop
54ce: 34           POP     AX
54cf: b4 00        SET1    P0.4
54d1: 64 00 e0     MOVW    DE,#0E000H
54d4: 5c           MOV     A,[DE]
54d5: 06 a0 08     MOV     [HL+08H],A
54d8: a4 00        CLR1    P0.4
54da: 06 20 0a     MOV     A,[HL+0AH]
54dd: d8           XCH     A,X
54de: 06 20 0b     MOV     A,[HL+0BH]
54e1: 44           INCW    AX
54e2: 06 a0 0b     MOV     [HL+0BH],A
54e5: d8           XCH     A,X
54e6: 06 a0 0a     MOV     [HL+0AH],A
54e9: 06 20 0a     MOV     A,[HL+0AH]
54ec: d8           XCH     A,X
54ed: 06 20 0b     MOV     A,[HL+0BH]
54f0: 2f 14 00     CMPW    AX,#0014H
54f3: 82 08        BNC     $54FDH
54f5: 06 20 08     MOV     A,[HL+08H]
54f8: 06 2f 09     CMP     A,[HL+09H]
54fb: 80 bf        BNZ     $54BCH
54fd: 8a 08        SUBW    AX,AX
54ff: 06 a0 0a     MOV     [HL+0AH],A
5502: 06 a0 0b     MOV     [HL+0BH],A
5505: b4 00        SET1    P0.4
5507: 64 01 e0     MOVW    DE,#0E001H
550a: 5c           MOV     A,[DE]
550b: 06 a0 09     MOV     [HL+09H],A
550e: a4 00        CLR1    P0.4
5510: 60 02 00     MOVW    AX,#0002H
5513: 3c           PUSH    AX
5514: 28 6d 8b     CALL    Delay_Loop
5517: 34           POP     AX
5518: b4 00        SET1    P0.4
551a: 64 01 e0     MOVW    DE,#0E001H
551d: 5c           MOV     A,[DE]
551e: 06 a0 07     MOV     [HL+07H],A
5521: a4 00        CLR1    P0.4
5523: 06 20 0a     MOV     A,[HL+0AH]
5526: d8           XCH     A,X
5527: 06 20 0b     MOV     A,[HL+0BH]
552a: 44           INCW    AX
552b: 06 a0 0b     MOV     [HL+0BH],A
552e: d8           XCH     A,X
552f: 06 a0 0a     MOV     [HL+0AH],A
5532: 06 20 0a     MOV     A,[HL+0AH]
5535: d8           XCH     A,X
5536: 06 20 0b     MOV     A,[HL+0BH]
5539: 2f 14 00     CMPW    AX,#0014H
553c: 82 08        BNC     $5546H
553e: 06 20 07     MOV     A,[HL+07H]
5541: 06 2f 09     CMP     A,[HL+09H]
5544: 80 bf        BNZ     $5505H
5546: 06 20 08     MOV     A,[HL+08H]
5549: ac 0f        AND     A,#0FH
554b: d8           XCH     A,X
554c: 06 20 07     MOV     A,[HL+07H]
554f: 31 a1        SHL     A,4
5551: da           XCH     A,C
5552: b9 00        MOV     A,#00H
5554: bb 00        MOV     B,#00H
5556: 8e 02        OR      X,C
5558: 8e 13        OR      A,B
555a: d0           MOV     A,X
555b: 09 f1 25 fd  MOV     !0FD25H,A
555f: 2c 96 54     BR      !5496H
5562: 8a 08        SUBW    AX,AX
5564: 06 a0 0a     MOV     [HL+0AH],A
5567: 06 a0 0b     MOV     [HL+0BH],A
556a: b4 00        SET1    P0.4
556c: 64 02 e0     MOVW    DE,#0E002H
556f: 5c           MOV     A,[DE]
5570: 06 a0 09     MOV     [HL+09H],A
5573: a4 00        CLR1    P0.4
5575: 60 02 00     MOVW    AX,#0002H
5578: 3c           PUSH    AX
5579: 28 6d 8b     CALL    Delay_Loop
557c: 34           POP     AX
557d: b4 00        SET1    P0.4
557f: 64 02 e0     MOVW    DE,#0E002H
5582: 5c           MOV     A,[DE]
5583: 06 a0 06     MOV     [HL+06H],A
5586: a4 00        CLR1    P0.4
5588: 06 20 0a     MOV     A,[HL+0AH]
558b: d8           XCH     A,X
558c: 06 20 0b     MOV     A,[HL+0BH]
558f: 44           INCW    AX
5590: 06 a0 0b     MOV     [HL+0BH],A
5593: d8           XCH     A,X
5594: 06 a0 0a     MOV     [HL+0AH],A
5597: 06 20 0a     MOV     A,[HL+0AH]
559a: d8           XCH     A,X
559b: 06 20 0b     MOV     A,[HL+0BH]
559e: 2f 14 00     CMPW    AX,#0014H
55a1: 82 08        BNC     $55ABH
55a3: 06 20 06     MOV     A,[HL+06H]
55a6: 06 2f 09     CMP     A,[HL+09H]
55a9: 80 bf        BNZ     $556AH
55ab: 8a 08        SUBW    AX,AX
55ad: 06 a0 0a     MOV     [HL+0AH],A
55b0: 06 a0 0b     MOV     [HL+0BH],A
55b3: b4 00        SET1    P0.4
55b5: 64 03 e0     MOVW    DE,#0E003H
55b8: 5c           MOV     A,[DE]
55b9: 06 a0 09     MOV     [HL+09H],A
55bc: a4 00        CLR1    P0.4
55be: 60 02 00     MOVW    AX,#0002H
55c1: 3c           PUSH    AX
55c2: 28 6d 8b     CALL    Delay_Loop
55c5: 34           POP     AX
55c6: b4 00        SET1    P0.4
55c8: 64 03 e0     MOVW    DE,#0E003H
55cb: 5c           MOV     A,[DE]
55cc: 06 a0 05     MOV     [HL+05H],A
55cf: a4 00        CLR1    P0.4
55d1: 06 20 0a     MOV     A,[HL+0AH]
55d4: d8           XCH     A,X
55d5: 06 20 0b     MOV     A,[HL+0BH]
55d8: 44           INCW    AX
55d9: 06 a0 0b     MOV     [HL+0BH],A
55dc: d8           XCH     A,X
55dd: 06 a0 0a     MOV     [HL+0AH],A
55e0: 06 20 0a     MOV     A,[HL+0AH]
55e3: d8           XCH     A,X
55e4: 06 20 0b     MOV     A,[HL+0BH]
55e7: 2f 14 00     CMPW    AX,#0014H
55ea: 82 08        BNC     $55F4H
55ec: 06 20 05     MOV     A,[HL+05H]
55ef: 06 2f 09     CMP     A,[HL+09H]
55f2: 80 bf        BNZ     $55B3H
55f4: 06 20 06     MOV     A,[HL+06H]
55f7: ac 0f        AND     A,#0FH
55f9: d8           XCH     A,X
55fa: 06 20 05     MOV     A,[HL+05H]
55fd: 31 a1        SHL     A,4
55ff: da           XCH     A,C
5600: b9 00        MOV     A,#00H
5602: bb 00        MOV     B,#00H
5604: 8e 02        OR      X,C
5606: 8e 13        OR      A,B
5608: d0           MOV     A,X
5609: 09 f1 26 fd  MOV     !0FD26H,A
560d: 8a 08        SUBW    AX,AX
560f: 06 a0 0a     MOV     [HL+0AH],A
5612: 06 a0 0b     MOV     [HL+0BH],A
5615: b4 00        SET1    P0.4
5617: 64 04 e0     MOVW    DE,#0E004H
561a: 5c           MOV     A,[DE]
561b: 06 a0 09     MOV     [HL+09H],A
561e: a4 00        CLR1    P0.4
5620: 60 02 00     MOVW    AX,#0002H
5623: 3c           PUSH    AX
5624: 28 6d 8b     CALL    Delay_Loop
5627: 34           POP     AX
5628: b4 00        SET1    P0.4
562a: 64 04 e0     MOVW    DE,#0E004H
562d: 5c           MOV     A,[DE]
562e: 06 a0 04     MOV     [HL+04H],A
5631: a4 00        CLR1    P0.4
5633: 06 20 0a     MOV     A,[HL+0AH]
5636: d8           XCH     A,X
5637: 06 20 0b     MOV     A,[HL+0BH]
563a: 44           INCW    AX
563b: 06 a0 0b     MOV     [HL+0BH],A
563e: d8           XCH     A,X
563f: 06 a0 0a     MOV     [HL+0AH],A
5642: 06 20 0a     MOV     A,[HL+0AH]
5645: d8           XCH     A,X
5646: 06 20 0b     MOV     A,[HL+0BH]
5649: 2f 14 00     CMPW    AX,#0014H
564c: 82 08        BNC     $5656H
564e: 06 20 04     MOV     A,[HL+04H]
5651: 06 2f 09     CMP     A,[HL+09H]
5654: 80 bf        BNZ     $5615H
5656: 8a 08        SUBW    AX,AX
5658: 06 a0 0a     MOV     [HL+0AH],A
565b: 06 a0 0b     MOV     [HL+0BH],A
565e: b4 00        SET1    P0.4
5660: 64 05 e0     MOVW    DE,#0E005H
5663: 5c           MOV     A,[DE]
5664: 06 a0 09     MOV     [HL+09H],A
5667: a4 00        CLR1    P0.4
5669: 60 02 00     MOVW    AX,#0002H
566c: 3c           PUSH    AX
566d: 28 6d 8b     CALL    Delay_Loop
5670: 34           POP     AX
5671: b4 00        SET1    P0.4
5673: 64 05 e0     MOVW    DE,#0E005H
5676: 5c           MOV     A,[DE]
5677: 06 a0 03     MOV     [HL+03H],A
567a: a4 00        CLR1    P0.4
567c: 06 20 0a     MOV     A,[HL+0AH]
567f: d8           XCH     A,X
5680: 06 20 0b     MOV     A,[HL+0BH]
5683: 44           INCW    AX
5684: 06 a0 0b     MOV     [HL+0BH],A
5687: d8           XCH     A,X
5688: 06 a0 0a     MOV     [HL+0AH],A
568b: 06 20 0a     MOV     A,[HL+0AH]
568e: d8           XCH     A,X
568f: 06 20 0b     MOV     A,[HL+0BH]
5692: 2f 14 00     CMPW    AX,#0014H
5695: 82 08        BNC     $569FH
5697: 06 20 03     MOV     A,[HL+03H]
569a: 06 2f 09     CMP     A,[HL+09H]
569d: 80 bf        BNZ     $565EH
569f: 06 20 04     MOV     A,[HL+04H]
56a2: ac 0f        AND     A,#0FH
56a4: d8           XCH     A,X
56a5: 06 20 03     MOV     A,[HL+03H]
56a8: 31 a1        SHL     A,4
56aa: ac 30        AND     A,#30H
56ac: da           XCH     A,C
56ad: b9 00        MOV     A,#00H
56af: bb 00        MOV     B,#00H
56b1: 8e 02        OR      X,C
56b3: 8e 13        OR      A,B
56b5: d0           MOV     A,X
56b6: 09 f1 27 fd  MOV     !0FD27H,A
56ba: 28 c6 56     CALL    !56C6H
56bd: 24 0e        MOVW    AX,HL
56bf: 2d 0c 00     ADDW    AX,#000CH
56c2: 13 fc        MOVW    SP,AX
56c4: 37           POP     HL
56c5: 56           RET
56c6: 3f           PUSH    HL
56c7: 1c ac        MOVW    AX,0FEACH
56c9: 3c           PUSH    AX
56ca: 05 c9        DECW    SP
56cc: 05 c9        DECW    SP
56ce: 11 fc        MOVW    AX,SP
56d0: 24 68        MOVW    HL,AX
56d2: 3a ac 00     MOV     0FEACH,#00H
56d5: 3a ad 00     MOV     0FEADH,#00H
56d8: 60 0f 00     MOVW    AX,#000FH
56db: 3c           PUSH    AX
56dc: 28 6d 8b     CALL    Delay_Loop
56df: 34           POP     AX
56e0: 28 ce 7a     CALL    Query_DFBE
56e3: 64 f1 df     MOVW    DE,#0DFF1H
56e6: 5c           MOV     A,[DE]
56e7: 22 6a        MOV     0FE6AH,A
56e9: 09 f0 25 fd  MOV     A,!0FD25H
56ed: 22 6b        MOV     0FE6BH,A
56ef: 28 8b 5e     CALL    !5E8BH
56f2: d2           MOV     A,C
56f3: 09 f1 28 fd  MOV     !0FD28H,A
56f7: 20 6b        MOV     A,0FE6BH
56f9: 09 f1 29 fd  MOV     !0FD29H,A
56fd: 09 f0 28 fd  MOV     A,!0FD28H
5701: af 59        CMP     A,#59H
5703: 83 16        BC      $571BH
5705: 81 14        BZ      $571BH
5707: 09 f0 28 fd  MOV     A,!0FD28H
570b: 22 6a        MOV     0FE6AH,A
570d: 3a 6b 60     MOV     0FE6BH,#60H
5710: 28 71 5e     CALL    !5E71H
5713: d2           MOV     A,C
5714: 09 f1 28 fd  MOV     !0FD28H,A
5718: 3a ac 01     MOV     0FEACH,#01H
571b: 60 0f 00     MOVW    AX,#000FH
571e: 3c           PUSH    AX
571f: 28 6d 8b     CALL    Delay_Loop
5722: 34           POP     AX
5723: 28 ce 7a     CALL    Query_DFBE
5726: 60 f1 df     MOVW    AX,#0DFF1H
5729: 44           INCW    AX
572a: 24 48        MOVW    DE,AX
572c: 5c           MOV     A,[DE]
572d: 22 6a        MOV     0FE6AH,A
572f: 09 f0 26 fd  MOV     A,!0FD26H
5733: 22 6b        MOV     0FE6BH,A
5735: 28 8b 5e     CALL    !5E8BH
5738: d2           MOV     A,C
5739: 06 a0 01     MOV     [HL+01H],A
573c: 20 6b        MOV     A,0FE6BH
573e: 09 f1 2a fd  MOV     !0FD2AH,A
5742: b9 59        MOV     A,#59H
5744: 06 2f 01     CMP     A,[HL+01H]
5747: 82 12        BNC     $575BH
5749: 06 20 01     MOV     A,[HL+01H]
574c: 22 6a        MOV     0FE6AH,A
574e: 3a 6b 60     MOV     0FE6BH,#60H
5751: 28 71 5e     CALL    !5E71H
5754: d2           MOV     A,C
5755: 06 a0 01     MOV     [HL+01H],A
5758: 3a ad 01     MOV     0FEADH,#01H
575b: 09 f0 29 fd  MOV     A,!0FD29H
575f: 22 6a        MOV     0FE6AH,A
5761: 06 20 01     MOV     A,[HL+01H]
5764: 22 6b        MOV     0FE6BH,A
5766: 28 8b 5e     CALL    !5E8BH
5769: d2           MOV     A,C
576a: 09 f1 29 fd  MOV     !0FD29H,A
576e: af 59        CMP     A,#59H
5770: 83 15        BC      $5787H
5772: 81 13        BZ      $5787H
5774: 09 f0 29 fd  MOV     A,!0FD29H
5778: 22 6a        MOV     0FE6AH,A
577a: 3a 6b 60     MOV     0FE6BH,#60H
577d: 28 71 5e     CALL    !5E71H
5780: d2           MOV     A,C
5781: 06 a0 01     MOV     [HL+01H],A
5784: 3a ad 01     MOV     0FEADH,#01H
5787: 6f ac 01     CMP     0FEACH,#01H
578a: 80 11        BNZ     $579DH
578c: 09 f0 29 fd  MOV     A,!0FD29H
5790: 22 6a        MOV     0FE6AH,A
5792: 28 65 5e     CALL    !5E65H
5795: d2           MOV     A,C
5796: 09 f1 29 fd  MOV     !0FD29H,A
579a: 3a ac 00     MOV     0FEACH,#00H
579d: 09 f0 29 fd  MOV     A,!0FD29H
57a1: af 59        CMP     A,#59H
57a3: 83 16        BC      $57BBH
57a5: 81 14        BZ      $57BBH
57a7: 09 f0 29 fd  MOV     A,!0FD29H
57ab: 22 6a        MOV     0FE6AH,A
57ad: 3a 6b 60     MOV     0FE6BH,#60H
57b0: 28 71 5e     CALL    !5E71H
57b3: d2           MOV     A,C
57b4: 09 f1 29 fd  MOV     !0FD29H,A
57b8: 3a ad 01     MOV     0FEADH,#01H
57bb: 60 0f 00     MOVW    AX,#000FH
57be: 3c           PUSH    AX
57bf: 28 6d 8b     CALL    Delay_Loop
57c2: 34           POP     AX
57c3: 28 ce 7a     CALL    Query_DFBE
57c6: 64 f3 df     MOVW    DE,#0DFF3H
57c9: 5c           MOV     A,[DE]
57ca: 22 6a        MOV     0FE6AH,A
57cc: 09 f0 27 fd  MOV     A,!0FD27H
57d0: 22 6b        MOV     0FE6BH,A
57d2: 28 7e 5e     CALL    !5E7EH
57d5: d2           MOV     A,C
57d6: 06 a0 01     MOV     [HL+01H],A
57d9: 09 f0 2a fd  MOV     A,!0FD2AH
57dd: 22 6a        MOV     0FE6AH,A
57df: 06 20 01     MOV     A,[HL+01H]
57e2: 22 6b        MOV     0FE6BH,A
57e4: 28 7e 5e     CALL    !5E7EH
57e7: d2           MOV     A,C
57e8: 09 f1 2a fd  MOV     !0FD2AH,A
57ec: 6f ad 01     CMP     0FEADH,#01H
57ef: 80 0e        BNZ     $57FFH
57f1: 09 f0 2a fd  MOV     A,!0FD2AH
57f5: 22 6a        MOV     0FE6AH,A
57f7: 28 65 5e     CALL    !5E65H
57fa: d2           MOV     A,C
57fb: 09 f1 2a fd  MOV     !0FD2AH,A
57ff: 09 f0 2a fd  MOV     A,!0FD2AH
5803: af 23        CMP     A,#23H
5805: 83 13        BC      $581AH
5807: 81 11        BZ      $581AH
5809: 09 f0 2a fd  MOV     A,!0FD2AH
580d: 22 6a        MOV     0FE6AH,A
580f: 3a 6b 24     MOV     0FE6BH,#24H
5812: 28 71 5e     CALL    !5E71H
5815: d2           MOV     A,C
5816: 09 f1 2a fd  MOV     !0FD2AH,A
581a: 34           POP     AX
581b: 34           POP     AX
581c: 1a ac        MOVW    0FEACH,AX
581e: 37           POP     HL
581f: 56           RET
5820: 3f           PUSH    HL
5821: 05 c9        DECW    SP
5823: 05 c9        DECW    SP
5825: 11 fc        MOVW    AX,SP
5827: 24 68        MOVW    HL,AX
5829: b4 00        SET1    P0.4
582b: 64 0d e0     MOVW    DE,#0E00DH
582e: b9 01        MOV     A,#01H
5830: 54           MOV     [DE],A
5831: 64 0f e0     MOVW    DE,#0E00FH        ; Enable 1 Hz output
5834: b9 0a        MOV     A,#0AH
5836: 54           MOV     [DE],A
5837: 64 0a e0     MOVW    DE,#0E00AH
583a: b9 01        MOV     A,#01H
583c: 54           MOV     [DE],A
583d: 64 0e e0     MOVW    DE,#0E00EH
5840: b9 00        MOV     A,#00H
5842: 54           MOV     [DE],A
5843: 64 0d e0     MOVW    DE,#0E00DH
5846: b9 00        MOV     A,#00H
5848: 54           MOV     [DE],A
5849: b9 00        MOV     A,#00H
584b: 06 a0 01     MOV     [HL+01H],A
584e: 09 f0 25 fd  MOV     A,!0FD25H
5852: ac 0f        AND     A,#0FH
5854: 64 00 e0     MOVW    DE,#0E000H
5857: 54           MOV     [DE],A
5858: 55           MOV     [HL],A
5859: 06 20 01     MOV     A,[HL+01H]
585c: c1           INC     A
585d: 06 a0 01     MOV     [HL+01H],A
5860: 06 20 01     MOV     A,[HL+01H]
5863: af 14        CMP     A,#14H
5865: 82 08        BNC     $586FH
5867: 64 00 e0     MOVW    DE,#0E000H
586a: 5c           MOV     A,[DE]
586b: 16 5f        CMP     A,[HL]
586d: 80 df        BNZ     $584EH
586f: b9 00        MOV     A,#00H
5871: 06 a0 01     MOV     [HL+01H],A
5874: 09 f0 25 fd  MOV     A,!0FD25H
5878: 30 a1        SHR     A,4
587a: 64 01 e0     MOVW    DE,#0E001H
587d: 54           MOV     [DE],A
587e: 55           MOV     [HL],A
587f: 06 20 01     MOV     A,[HL+01H]
5882: c1           INC     A
5883: 06 a0 01     MOV     [HL+01H],A
5886: 06 20 01     MOV     A,[HL+01H]
5889: af 14        CMP     A,#14H
588b: 82 08        BNC     $5895H
588d: 64 01 e0     MOVW    DE,#0E001H
5890: 5c           MOV     A,[DE]
5891: 16 5f        CMP     A,[HL]
5893: 80 df        BNZ     $5874H
5895: b9 00        MOV     A,#00H
5897: 06 a0 01     MOV     [HL+01H],A
589a: 09 f0 26 fd  MOV     A,!0FD26H
589e: ac 0f        AND     A,#0FH
58a0: 64 02 e0     MOVW    DE,#0E002H
58a3: 54           MOV     [DE],A
58a4: 55           MOV     [HL],A
58a5: 06 20 01     MOV     A,[HL+01H]
58a8: c1           INC     A
58a9: 06 a0 01     MOV     [HL+01H],A
58ac: 06 20 01     MOV     A,[HL+01H]
58af: af 14        CMP     A,#14H
58b1: 82 08        BNC     $58BBH
58b3: 64 02 e0     MOVW    DE,#0E002H
58b6: 5c           MOV     A,[DE]
58b7: 16 5f        CMP     A,[HL]
58b9: 80 df        BNZ     $589AH
58bb: b9 00        MOV     A,#00H
58bd: 06 a0 01     MOV     [HL+01H],A
58c0: 09 f0 26 fd  MOV     A,!0FD26H
58c4: 30 a1        SHR     A,4
58c6: 64 03 e0     MOVW    DE,#0E003H
58c9: 54           MOV     [DE],A
58ca: 55           MOV     [HL],A
58cb: 06 20 01     MOV     A,[HL+01H]
58ce: c1           INC     A
58cf: 06 a0 01     MOV     [HL+01H],A
58d2: 06 20 01     MOV     A,[HL+01H]
58d5: af 14        CMP     A,#14H
58d7: 82 08        BNC     $58E1H
58d9: 64 03 e0     MOVW    DE,#0E003H
58dc: 5c           MOV     A,[DE]
58dd: 16 5f        CMP     A,[HL]
58df: 80 df        BNZ     $58C0H
58e1: b9 00        MOV     A,#00H
58e3: 06 a0 01     MOV     [HL+01H],A
58e6: 09 f0 27 fd  MOV     A,!0FD27H
58ea: ac 0f        AND     A,#0FH
58ec: 64 04 e0     MOVW    DE,#0E004H
58ef: 54           MOV     [DE],A
58f0: 55           MOV     [HL],A
58f1: 06 20 01     MOV     A,[HL+01H]
58f4: c1           INC     A
58f5: 06 a0 01     MOV     [HL+01H],A
58f8: 06 20 01     MOV     A,[HL+01H]
58fb: af 14        CMP     A,#14H
58fd: 82 08        BNC     $5907H
58ff: 64 04 e0     MOVW    DE,#0E004H
5902: 5c           MOV     A,[DE]
5903: 16 5f        CMP     A,[HL]
5905: 80 df        BNZ     $58E6H
5907: b9 00        MOV     A,#00H
5909: 06 a0 01     MOV     [HL+01H],A
590c: 09 f0 27 fd  MOV     A,!0FD27H
5910: 30 a1        SHR     A,4
5912: ac 03        AND     A,#03H
5914: 64 05 e0     MOVW    DE,#0E005H
5917: 54           MOV     [DE],A
5918: 55           MOV     [HL],A
5919: 06 20 01     MOV     A,[HL+01H]
591c: c1           INC     A
591d: 06 a0 01     MOV     [HL+01H],A
5920: 06 20 01     MOV     A,[HL+01H]
5923: af 14        CMP     A,#14H
5925: 82 08        BNC     $592FH
5927: 64 05 e0     MOVW    DE,#0E005H
592a: 5c           MOV     A,[DE]
592b: 16 5f        CMP     A,[HL]
592d: 80 dd        BNZ     $590CH
592f: 64 0d e0     MOVW    DE,#0E00DH
5932: b9 08        MOV     A,#08H
5934: 54           MOV     [DE],A
5935: a4 00        CLR1    P0.4
5937: 34           POP     AX
5938: 37           POP     HL
5939: 56           RET
593a: 3f           PUSH    HL
593b: 1c ac        MOVW    AX,0FEACH
593d: 3c           PUSH    AX
593e: 11 fc        MOVW    AX,SP
5940: 2e 04 00     SUBW    AX,#0004H
5943: 24 68        MOVW    HL,AX
5945: 13 fc        MOVW    SP,AX
5947: 08 a1 a1 06  BF      0FEA1H.1,$5951H
594b: 28 bd 51     CALL    !Read_RTC_Seconds
594e: 2c 3b 5a     BR      !5A3BH
5951: 4a           DI
5952: 09 f0 2e fd  MOV     A,!0FD2EH
5956: 9f 9e        CMP     A,0FE9EH
5958: 83 05        BC      $595FH
595a: 81 03        BZ      $595FH
595c: 2c da 59     BR      !59DAH
595f: 20 9e        MOV     A,0FE9EH
5961: d8           XCH     A,X
5962: 09 f0 2e fd  MOV     A,!0FD2EH
5966: 8a 01        SUB     X,A
5968: d0           MOV     A,X
5969: 22 9e        MOV     0FE9EH,A
596b: 4b           EI
596c: 09 f0 25 fd  MOV     A,!0FD25H
5970: 22 6a        MOV     0FE6AH,A
5972: 28 65 5e     CALL    !5E65H
5975: d2           MOV     A,C
5976: 09 f1 25 fd  MOV     !0FD25H,A
597a: af 60        CMP     A,#60H
597c: 83 36        BC      $59B4H
597e: b9 00        MOV     A,#00H
5980: 09 f1 25 fd  MOV     !0FD25H,A
5984: 09 f0 26 fd  MOV     A,!0FD26H
5988: 22 6a        MOV     0FE6AH,A
598a: 28 65 5e     CALL    !5E65H
598d: d2           MOV     A,C
598e: 09 f1 26 fd  MOV     !0FD26H,A
5992: af 60        CMP     A,#60H
5994: 83 1e        BC      $59B4H
5996: b9 00        MOV     A,#00H
5998: 09 f1 26 fd  MOV     !0FD26H,A
599c: 09 f0 27 fd  MOV     A,!0FD27H
59a0: 22 6a        MOV     0FE6AH,A
59a2: 28 65 5e     CALL    !5E65H
59a5: d2           MOV     A,C
59a6: 09 f1 27 fd  MOV     !0FD27H,A
59aa: af 24        CMP     A,#24H
59ac: 83 06        BC      $59B4H
59ae: b9 00        MOV     A,#00H
59b0: 09 f1 27 fd  MOV     !0FD27H,A
59b4: 09 f0 25 fd  MOV     A,!0FD25H
59b8: af 30        CMP     A,#30H
59ba: 80 1e        BNZ     $59DAH
59bc: 64 0d e0     MOVW    DE,#0E00DH
59bf: b9 00        MOV     A,#00H
59c1: 54           MOV     [DE],A
59c2: 64 0f e0     MOVW    DE,#0E00FH
59c5: b9 0a        MOV     A,#0AH
59c7: 54           MOV     [DE],A
59c8: 64 00 e0     MOVW    DE,#0E000H
59cb: b9 00        MOV     A,#00H
59cd: 54           MOV     [DE],A
59ce: 64 01 e0     MOVW    DE,#0E001H
59d1: b9 03        MOV     A,#03H
59d3: 54           MOV     [DE],A
59d4: 64 0d e0     MOVW    DE,#0E00DH
59d7: b9 08        MOV     A,#08H
59d9: 54           MOV     [DE],A
59da: 4a           DI
59db: 09 f0 2e fd  MOV     A,!0FD2EH
59df: 9f 9f        CMP     A,0FE9FH
59e1: 83 02        BC      $59E5H
59e3: 80 55        BNZ     $5A3AH
59e5: 20 9f        MOV     A,0FE9FH
59e7: d8           XCH     A,X
59e8: 09 f0 2e fd  MOV     A,!0FD2EH
59ec: 8a 01        SUB     X,A
59ee: d0           MOV     A,X
59ef: 22 9f        MOV     0FE9FH,A
59f1: 4b           EI
59f2: 09 f0 28 fd  MOV     A,!0FD28H
59f6: 22 6a        MOV     0FE6AH,A
59f8: 28 65 5e     CALL    !5E65H
59fb: d2           MOV     A,C
59fc: 09 f1 28 fd  MOV     !0FD28H,A
5a00: af 60        CMP     A,#60H
5a02: 83 36        BC      $5A3AH
5a04: b9 00        MOV     A,#00H
5a06: 09 f1 28 fd  MOV     !0FD28H,A
5a0a: 09 f0 29 fd  MOV     A,!0FD29H
5a0e: 22 6a        MOV     0FE6AH,A
5a10: 28 65 5e     CALL    !5E65H
5a13: d2           MOV     A,C
5a14: 09 f1 29 fd  MOV     !0FD29H,A
5a18: af 60        CMP     A,#60H
5a1a: 83 1e        BC      $5A3AH
5a1c: b9 00        MOV     A,#00H
5a1e: 09 f1 29 fd  MOV     !0FD29H,A
5a22: 09 f0 2a fd  MOV     A,!0FD2AH
5a26: 22 6a        MOV     0FE6AH,A
5a28: 28 65 5e     CALL    !5E65H
5a2b: d2           MOV     A,C
5a2c: 09 f1 2a fd  MOV     !0FD2AH,A
5a30: af 24        CMP     A,#24H
5a32: 83 06        BC      $5A3AH
5a34: b9 00        MOV     A,#00H
5a36: 09 f1 2a fd  MOV     !0FD2AH,A
5a3a: 4b           EI
5a3b: 08 a0 a1 08  BF      0FEA1H.0,$5A47H
5a3f: 09 f0 28 fd  MOV     A,!0FD28H
5a43: af 00        CMP     A,#00H
5a45: 81 12        BZ      $5A59H
5a47: 08 a0 a1 03  BF      0FEA1H.0,$5A4EH
5a4b: 2c 2f 5b     BR      !5B2FH
5a4e: 09 f0 25 fd  MOV     A,!0FD25H
5a52: af 00        CMP     A,#00H
5a54: 81 03        BZ      $5A59H
5a56: 2c 2f 5b     BR      !5B2FH
5a59: 08 a7 a1 67  BF      0FEA1H.7,$5AC4H
5a5d: 60 f6 df     MOVW    AX,#0DFF6H
5a60: 3c           PUSH    AX
5a61: 28 36 5b     CALL    !5B36H
5a64: 34           POP     AX
5a65: 8a 08        SUBW    AX,AX
5a67: 8f 0a        CMPW    AX,BC
5a69: 81 0c        BZ      $5A77H
5a6b: a2 72        CLR1    0FE72H.2
5a6d: 08 a0 66 06  BF      0FE66H.0,$5A77H
5a71: 28 89 8c     CALL    !8C89H
5a74: 28 16 20     CALL    !2016H
5a77: 64 f4 df     MOVW    DE,#0DFF4H
5a7a: 3e           PUSH    DE
5a7b: 28 36 5b     CALL    !5B36H
5a7e: 34           POP     AX
5a7f: 8a 08        SUBW    AX,AX
5a81: 8f 0a        CMPW    AX,BC
5a83: 81 3f        BZ      $5AC4H
5a85: 70 66 03     BT      0FE66H.0,$5A8BH
5a88: 28 0e 8c     CALL    !8C0EH
5a8b: 60 0f 00     MOVW    AX,#000FH
5a8e: 3c           PUSH    AX
5a8f: 28 6d 8b     CALL    Delay_Loop
5a92: 34           POP     AX
5a93: 28 ce 7a     CALL    Query_DFBE
5a96: 64 f4 df     MOVW    DE,#0DFF4H
5a99: 06 00 04     MOV     A,[DE+04H]
5a9c: d8           XCH     A,X
5a9d: 06 00 05     MOV     A,[DE+05H]
5aa0: 2f ab 0b     CMPW    AX,#0BABH
5aa3: 81 1a        BZ      $5ABFH
5aa5: 64 f4 df     MOVW    DE,#0DFF4H
5aa8: 06 00 04     MOV     A,[DE+04H]
5aab: d8           XCH     A,X
5aac: 06 00 05     MOV     A,[DE+05H]
5aaf: 1a 90        MOVW    0FE90H,AX
5ab1: b5 65        SET1    0FE65H.5
5ab3: 28 86 7f     CALL    !7F86H
5ab6: 8a 08        SUBW    AX,AX
5ab8: 8f 0a        CMPW    AX,BC
5aba: 81 03        BZ      $5ABFH
5abc: 28 43 7d     CALL    !7D43H
5abf: b2 72        SET1    0FE72H.2
5ac1: 28 16 20     CALL    !2016H
5ac4: 08 a6 a1 67  BF      0FEA1H.6,$5B2FH
5ac8: 60 fc df     MOVW    AX,#0DFFCH
5acb: 3c           PUSH    AX
5acc: 28 36 5b     CALL    !5B36H
5acf: 34           POP     AX
5ad0: 8a 08        SUBW    AX,AX
5ad2: 8f 0a        CMPW    AX,BC
5ad4: 81 0c        BZ      $5AE2H
5ad6: a2 72        CLR1    0FE72H.2
5ad8: 08 a0 66 06  BF      0FE66H.0,$5AE2H
5adc: 28 89 8c     CALL    !8C89H
5adf: 28 16 20     CALL    !2016H
5ae2: 64 fa df     MOVW    DE,#0DFFAH
5ae5: 3e           PUSH    DE
5ae6: 28 36 5b     CALL    !5B36H
5ae9: 34           POP     AX
5aea: 8a 08        SUBW    AX,AX
5aec: 8f 0a        CMPW    AX,BC
5aee: 81 3f        BZ      $5B2FH
5af0: 70 66 03     BT      0FE66H.0,$5AF6H
5af3: 28 0e 8c     CALL    !8C0EH
5af6: 60 0f 00     MOVW    AX,#000FH
5af9: 3c           PUSH    AX
5afa: 28 6d 8b     CALL    Delay_Loop
5afd: 34           POP     AX
5afe: 28 ce 7a     CALL    Query_DFBE
5b01: 64 fa df     MOVW    DE,#0DFFAH
5b04: 06 00 04     MOV     A,[DE+04H]
5b07: d8           XCH     A,X
5b08: 06 00 05     MOV     A,[DE+05H]
5b0b: 2f ab 0b     CMPW    AX,#0BABH
5b0e: 81 1a        BZ      $5B2AH
5b10: 64 fa df     MOVW    DE,#0DFFAH
5b13: 06 00 04     MOV     A,[DE+04H]
5b16: d8           XCH     A,X
5b17: 06 00 05     MOV     A,[DE+05H]
5b1a: 1a 90        MOVW    0FE90H,AX
5b1c: b5 65        SET1    0FE65H.5
5b1e: 28 86 7f     CALL    !7F86H
5b21: 8a 08        SUBW    AX,AX
5b23: 8f 0a        CMPW    AX,BC
5b25: 81 03        BZ      $5B2AH
5b27: 28 43 7d     CALL    !7D43H
5b2a: b2 72        SET1    0FE72H.2
5b2c: 28 16 20     CALL    !2016H
5b2f: 34           POP     AX
5b30: 34           POP     AX
5b31: 34           POP     AX
5b32: 1a ac        MOVW    0FEACH,AX
5b34: 37           POP     HL
5b35: 56           RET

5b36: 3f           PUSH    HL
5b37: 05 c9        DECW    SP
5b39: 05 c9        DECW    SP
5b3b: 11 fc        MOVW    AX,SP
5b3d: 24 68        MOVW    HL,AX
5b3f: 08 a0 a1 0a  BF      0FEA1H.0,$5B4DH
5b43: 60 28 fd     MOVW    AX,#0FD28H
5b46: 06 a0 01     MOV     [HL+01H],A
5b49: d8           XCH     A,X
5b4a: 55           MOV     [HL],A
5b4b: 14 08        BR      $5B55H
5b4d: 60 25 fd     MOVW    AX,#0FD25H
5b50: 06 a0 01     MOV     [HL+01H],A
5b53: d8           XCH     A,X
5b54: 55           MOV     [HL],A
5b55: 05 e3        MOVW    AX,[HL]
5b57: 44           INCW    AX
5b58: 06 a0 01     MOV     [HL+01H],A
5b5b: d8           XCH     A,X
5b5c: 55           MOV     [HL],A
5b5d: 08 a0 a1 0d  BF      0FEA1H.0,$5B6EH
5b61: 60 bd df     MOVW    AX,#0DFBDH
5b64: 3c           PUSH    AX
5b65: 28 2b 7c     CALL    !7C2BH
5b68: 34           POP     AX
5b69: d2           MOV     A,C
5b6a: ac 02        AND     A,#02H
5b6c: 81 10        BZ      $5B7EH
5b6e: 70 a1 3d     BT      0FEA1H.0,$5BAEH
5b71: 60 bd df     MOVW    AX,#0DFBDH
5b74: 3c           PUSH    AX
5b75: 28 2b 7c     CALL    !7C2BH
5b78: 34           POP     AX
5b79: d2           MOV     A,C
5b7a: ac 01        AND     A,#01H
5b7c: 80 30        BNZ     $5BAEH
5b7e: 05 e3        MOVW    AX,[HL]
5b80: 24 48        MOVW    DE,AX
5b82: 5c           MOV     A,[DE]
5b83: da           XCH     A,C
5b84: 06 20 06     MOV     A,[HL+06H]
5b87: d8           XCH     A,X
5b88: 06 20 07     MOV     A,[HL+07H]
5b8b: 24 48        MOVW    DE,AX
5b8d: d2           MOV     A,C
5b8e: 16 4f        CMP     A,[DE]
5b90: 80 1c        BNZ     $5BAEH
5b92: 05 e3        MOVW    AX,[HL]
5b94: 24 48        MOVW    DE,AX
5b96: 06 00 01     MOV     A,[DE+01H]
5b99: da           XCH     A,C
5b9a: 06 20 06     MOV     A,[HL+06H]
5b9d: d8           XCH     A,X
5b9e: 06 20 07     MOV     A,[HL+07H]
5ba1: 24 48        MOVW    DE,AX
5ba3: d2           MOV     A,C
5ba4: 06 0f 01     CMP     A,[DE+01H]
5ba7: 80 05        BNZ     $5BAEH
5ba9: 62 01 00     MOVW    BC,#0001H
5bac: 14 03        BR      $5BB1H
5bae: 62 00 00     MOVW    BC,#0000H
5bb1: 34           POP     AX
5bb2: 37           POP     HL
5bb3: 56           RET
5bb4: 64 f4 df     MOVW    DE,#0DFF4H
5bb7: 3e           PUSH    DE
5bb8: 60 aa 00     MOVW    AX,#00AAH
5bbb: 3c           PUSH    AX
5bbc: 28 18 7b     CALL    !7B18H
5bbf: 34           POP     AX
5bc0: 34           POP     AX
5bc1: 60 f4 df     MOVW    AX,#0DFF4H
5bc4: 44           INCW    AX
5bc5: 3c           PUSH    AX
5bc6: 60 aa 00     MOVW    AX,#00AAH
5bc9: 3c           PUSH    AX
5bca: 28 18 7b     CALL    !7B18H
5bcd: 34           POP     AX
5bce: 34           POP     AX
5bcf: 60 f6 df     MOVW    AX,#0DFF6H
5bd2: 3c           PUSH    AX
5bd3: 60 aa 00     MOVW    AX,#00AAH
5bd6: 3c           PUSH    AX
5bd7: 28 18 7b     CALL    !7B18H
5bda: 34           POP     AX
5bdb: 34           POP     AX
5bdc: 60 f7 df     MOVW    AX,#0DFF7H
5bdf: 3c           PUSH    AX
5be0: 60 aa 00     MOVW    AX,#00AAH
5be3: 3c           PUSH    AX
5be4: 28 18 7b     CALL    !7B18H
5be7: 34           POP     AX
5be8: 34           POP     AX
5be9: 64 fa df     MOVW    DE,#0DFFAH
5bec: 3e           PUSH    DE
5bed: 60 aa 00     MOVW    AX,#00AAH
5bf0: 3c           PUSH    AX
5bf1: 28 18 7b     CALL    !7B18H
5bf4: 34           POP     AX
5bf5: 34           POP     AX
5bf6: 60 fa df     MOVW    AX,#0DFFAH
5bf9: 44           INCW    AX
5bfa: 3c           PUSH    AX
5bfb: 60 aa 00     MOVW    AX,#00AAH
5bfe: 3c           PUSH    AX
5bff: 28 18 7b     CALL    !7B18H
5c02: 34           POP     AX
5c03: 34           POP     AX
5c04: 60 fc df     MOVW    AX,#0DFFCH
5c07: 3c           PUSH    AX
5c08: 60 aa 00     MOVW    AX,#00AAH
5c0b: 3c           PUSH    AX
5c0c: 28 18 7b     CALL    !7B18H
5c0f: 34           POP     AX
5c10: 34           POP     AX
5c11: 60 fd df     MOVW    AX,#0DFFDH
5c14: 3c           PUSH    AX
5c15: 60 aa 00     MOVW    AX,#00AAH
5c18: 3c           PUSH    AX
5c19: 28 18 7b     CALL    !7B18H
5c1c: 34           POP     AX
5c1d: 34           POP     AX
5c1e: a7 a1        CLR1    0FEA1H.7
5c20: a6 a1        CLR1    0FEA1H.6
5c22: 56           RET
5c23: 1c ac        MOVW    AX,0FEACH
5c25: 3c           PUSH    AX
5c26: 1c ae        MOVW    AX,0FEAEH
5c28: 3c           PUSH    AX
5c29: 64 2b fd     MOVW    DE,#0FD2BH
5c2c: 3e           PUSH    DE
5c2d: 28 99 5d     CALL    !5D99H
5c30: 34           POP     AX
5c31: 8a 08        SUBW    AX,AX
5c33: 8f 0a        CMPW    AX,BC
5c35: 80 03        BNZ     $5C3AH
5c37: 2c 92 5d     BR      !5D92H
5c3a: 60 bd df     MOVW    AX,#0DFBDH
5c3d: 3c           PUSH    AX
5c3e: 28 2b 7c     CALL    !7C2BH
5c41: 34           POP     AX
5c42: d2           MOV     A,C
5c43: 22 ae        MOV     0FEAEH,A
5c45: 08 a0 a1 09  BF      0FEA1H.0,$5C52H
5c49: 6c ae fd     AND     0FEAEH,#0FDH
5c4c: 0c ac 28 fd  MOVW    0FEACH,#0FD28H
5c50: 14 07        BR      $5C59H
5c52: 6c ae fe     AND     0FEAEH,#0FEH
5c55: 0c ac 25 fd  MOVW    0FEACH,#0FD25H
5c59: 60 bd df     MOVW    AX,#0DFBDH
5c5c: 3c           PUSH    AX
5c5d: 20 ae        MOV     A,0FEAEH
5c5f: b8 00        MOV     X,#00H
5c61: d8           XCH     A,X
5c62: 3c           PUSH    AX
5c63: 28 18 7b     CALL    !7B18H
5c66: 34           POP     AX
5c67: 34           POP     AX
5c68: 1c ac        MOVW    AX,0FEACH
5c6a: 24 48        MOVW    DE,AX
5c6c: 09 f0 2b fd  MOV     A,!0FD2BH
5c70: 54           MOV     [DE],A
5c71: 1c ac        MOVW    AX,0FEACH
5c73: 44           INCW    AX
5c74: 24 48        MOVW    DE,AX
5c76: 09 f0 2c fd  MOV     A,!0FD2CH
5c7a: 54           MOV     [DE],A
5c7b: 1c ac        MOVW    AX,0FEACH
5c7d: 44           INCW    AX
5c7e: 44           INCW    AX
5c7f: 24 48        MOVW    DE,AX
5c81: 09 f0 2d fd  MOV     A,!0FD2DH
5c85: 54           MOV     [DE],A
5c86: 4a           DI
5c87: 3a 9f 00     MOV     0FE9FH,#00H
5c8a: 3a 9e 00     MOV     0FE9EH,#00H
5c8d: 4b           EI
5c8e: 28 20 58     CALL    !5820H
5c91: 09 f0 25 fd  MOV     A,!0FD25H
5c95: d8           XCH     A,X
5c96: 09 f0 28 fd  MOV     A,!0FD28H
5c9a: 8f 10        CMP     A,X
5c9c: 82 4f        BNC     $5CEDH
5c9e: 09 f0 28 fd  MOV     A,!0FD28H
5ca2: 22 6a        MOV     0FE6AH,A
5ca4: 3a 6b 60     MOV     0FE6BH,#60H
5ca7: 28 7e 5e     CALL    !5E7EH
5caa: d2           MOV     A,C
5cab: 09 f1 28 fd  MOV     !0FD28H,A
5caf: 09 f0 29 fd  MOV     A,!0FD29H
5cb3: af 00        CMP     A,#00H
5cb5: 80 25        BNZ     $5CDCH
5cb7: b9 60        MOV     A,#60H
5cb9: 09 f1 29 fd  MOV     !0FD29H,A
5cbd: 09 f0 2a fd  MOV     A,!0FD2AH
5cc1: af 00        CMP     A,#00H
5cc3: 80 06        BNZ     $5CCBH
5cc5: b9 24        MOV     A,#24H
5cc7: 09 f1 2a fd  MOV     !0FD2AH,A
5ccb: 09 f0 2a fd  MOV     A,!0FD2AH
5ccf: 22 6a        MOV     0FE6AH,A
5cd1: 3a 6b 01     MOV     0FE6BH,#01H
5cd4: 28 71 5e     CALL    !5E71H
5cd7: d2           MOV     A,C
5cd8: 09 f1 2a fd  MOV     !0FD2AH,A
5cdc: 09 f0 29 fd  MOV     A,!0FD29H
5ce0: 22 6a        MOV     0FE6AH,A
5ce2: 3a 6b 01     MOV     0FE6BH,#01H
5ce5: 28 71 5e     CALL    !5E71H
5ce8: d2           MOV     A,C
5ce9: 09 f1 29 fd  MOV     !0FD29H,A
5ced: 09 f0 28 fd  MOV     A,!0FD28H
5cf1: 22 6a        MOV     0FE6AH,A
5cf3: 09 f0 25 fd  MOV     A,!0FD25H
5cf7: 22 6b        MOV     0FE6BH,A
5cf9: 60 f1 df     MOVW    AX,#0DFF1H
5cfc: 3c           PUSH    AX
5cfd: 28 71 5e     CALL    !5E71H
5d00: bb 00        MOV     B,#00H
5d02: 3d           PUSH    BC
5d03: 28 18 7b     CALL    !7B18H
5d06: 34           POP     AX
5d07: 34           POP     AX
5d08: 09 f0 26 fd  MOV     A,!0FD26H
5d0c: d8           XCH     A,X
5d0d: 09 f0 29 fd  MOV     A,!0FD29H
5d11: 8f 10        CMP     A,X
5d13: 82 30        BNC     $5D45H
5d15: 09 f0 29 fd  MOV     A,!0FD29H
5d19: 22 6a        MOV     0FE6AH,A
5d1b: 3a 6b 60     MOV     0FE6BH,#60H
5d1e: 28 7e 5e     CALL    !5E7EH
5d21: d2           MOV     A,C
5d22: 09 f1 29 fd  MOV     !0FD29H,A
5d26: 09 f0 2a fd  MOV     A,!0FD2AH
5d2a: af 00        CMP     A,#00H
5d2c: 80 06        BNZ     $5D34H
5d2e: b9 24        MOV     A,#24H
5d30: 09 f1 2a fd  MOV     !0FD2AH,A
5d34: 09 f0 2a fd  MOV     A,!0FD2AH
5d38: 22 6a        MOV     0FE6AH,A
5d3a: 3a 6b 01     MOV     0FE6BH,#01H
5d3d: 28 71 5e     CALL    !5E71H
5d40: d2           MOV     A,C
5d41: 09 f1 2a fd  MOV     !0FD2AH,A
5d45: 09 f0 29 fd  MOV     A,!0FD29H
5d49: 22 6a        MOV     0FE6AH,A
5d4b: 09 f0 26 fd  MOV     A,!0FD26H
5d4f: 22 6b        MOV     0FE6BH,A
5d51: 60 f1 df     MOVW    AX,#0DFF1H
5d54: 44           INCW    AX
5d55: 3c           PUSH    AX
5d56: 28 71 5e     CALL    !5E71H
5d59: bb 00        MOV     B,#00H
5d5b: 3d           PUSH    BC
5d5c: 28 18 7b     CALL    !7B18H
5d5f: 34           POP     AX
5d60: 34           POP     AX
5d61: 09 f0 2a fd  MOV     A,!0FD2AH
5d65: 22 6a        MOV     0FE6AH,A
5d67: 09 f0 27 fd  MOV     A,!0FD27H
5d6b: 9f 6a        CMP     A,0FE6AH
5d6d: 83 0b        BC      $5D7AH
5d6f: 81 09        BZ      $5D7AH
5d71: 3a 6b 24     MOV     0FE6BH,#24H
5d74: 28 7e 5e     CALL    !5E7EH
5d77: d2           MOV     A,C
5d78: 22 6a        MOV     0FE6AH,A
5d7a: 09 f0 27 fd  MOV     A,!0FD27H
5d7e: 22 6b        MOV     0FE6BH,A
5d80: 60 f3 df     MOVW    AX,#0DFF3H
5d83: 3c           PUSH    AX
5d84: 28 71 5e     CALL    !5E71H
5d87: bb 00        MOV     B,#00H
5d89: 3d           PUSH    BC
5d8a: 28 18 7b     CALL    !7B18H
5d8d: 34           POP     AX
5d8e: 34           POP     AX
5d8f: 28 c6 56     CALL    !56C6H
5d92: 34           POP     AX
5d93: 1a ae        MOVW    0FEAEH,AX
5d95: 34           POP     AX
5d96: 1a ac        MOVW    0FEACH,AX
5d98: 56           RET
5d99: 3f           PUSH    HL
5d9a: 11 fc        MOVW    AX,SP
5d9c: 24 68        MOVW    HL,AX
5d9e: 06 20 04     MOV     A,[HL+04H]
5da1: d8           XCH     A,X
5da2: 06 20 05     MOV     A,[HL+05H]
5da5: 24 48        MOVW    DE,AX
5da7: 5c           MOV     A,[DE]
5da8: ac 0f        AND     A,#0FH
5daa: b8 09        MOV     X,#09H
5dac: 8f 01        CMP     X,A
5dae: 83 5c        BC      $5E0CH
5db0: 06 20 04     MOV     A,[HL+04H]
5db3: d8           XCH     A,X
5db4: 06 20 05     MOV     A,[HL+05H]
5db7: 24 48        MOVW    DE,AX
5db9: b9 59        MOV     A,#59H
5dbb: 16 4f        CMP     A,[DE]
5dbd: 83 4d        BC      $5E0CH
5dbf: 06 20 04     MOV     A,[HL+04H]
5dc2: d8           XCH     A,X
5dc3: 06 20 05     MOV     A,[HL+05H]
5dc6: 24 48        MOVW    DE,AX
5dc8: 06 00 01     MOV     A,[DE+01H]
5dcb: ac 0f        AND     A,#0FH
5dcd: b8 09        MOV     X,#09H
5dcf: 8f 01        CMP     X,A
5dd1: 83 39        BC      $5E0CH
5dd3: 06 20 04     MOV     A,[HL+04H]
5dd6: d8           XCH     A,X
5dd7: 06 20 05     MOV     A,[HL+05H]
5dda: 24 48        MOVW    DE,AX
5ddc: b9 59        MOV     A,#59H
5dde: 06 0f 01     CMP     A,[DE+01H]
5de1: 83 29        BC      $5E0CH
5de3: 06 20 04     MOV     A,[HL+04H]
5de6: d8           XCH     A,X
5de7: 06 20 05     MOV     A,[HL+05H]
5dea: 24 48        MOVW    DE,AX
5dec: 06 00 02     MOV     A,[DE+02H]
5def: ac 0f        AND     A,#0FH
5df1: b8 09        MOV     X,#09H
5df3: 8f 01        CMP     X,A
5df5: 83 15        BC      $5E0CH
5df7: 06 20 04     MOV     A,[HL+04H]
5dfa: d8           XCH     A,X
5dfb: 06 20 05     MOV     A,[HL+05H]
5dfe: 24 48        MOVW    DE,AX
5e00: b9 23        MOV     A,#23H
5e02: 06 0f 02     CMP     A,[DE+02H]
5e05: 83 05        BC      $5E0CH
5e07: 62 01 00     MOVW    BC,#0001H
5e0a: 14 03        BR      $5E0FH
5e0c: 62 00 00     MOVW    BC,#0000H
5e0f: 37           POP     HL
5e10: 56           RET
5e11: 3f           PUSH    HL
5e12: 11 fc        MOVW    AX,SP
5e14: 24 68        MOVW    HL,AX
5e16: 06 20 04     MOV     A,[HL+04H]
5e19: d8           XCH     A,X
5e1a: 06 20 05     MOV     A,[HL+05H]
5e1d: 24 48        MOVW    DE,AX
5e1f: 5c           MOV     A,[DE]
5e20: ac 0f        AND     A,#0FH
5e22: b8 09        MOV     X,#09H
5e24: 8f 01        CMP     X,A
5e26: 83 38        BC      $5E60H
5e28: 06 20 04     MOV     A,[HL+04H]
5e2b: d8           XCH     A,X
5e2c: 06 20 05     MOV     A,[HL+05H]
5e2f: 24 48        MOVW    DE,AX
5e31: b9 59        MOV     A,#59H
5e33: 16 4f        CMP     A,[DE]
5e35: 83 29        BC      $5E60H
5e37: 06 20 04     MOV     A,[HL+04H]
5e3a: d8           XCH     A,X
5e3b: 06 20 05     MOV     A,[HL+05H]
5e3e: 24 48        MOVW    DE,AX
5e40: 06 00 01     MOV     A,[DE+01H]
5e43: ac 0f        AND     A,#0FH
5e45: b8 09        MOV     X,#09H
5e47: 8f 01        CMP     X,A
5e49: 83 15        BC      $5E60H
5e4b: 06 20 04     MOV     A,[HL+04H]
5e4e: d8           XCH     A,X
5e4f: 06 20 05     MOV     A,[HL+05H]
5e52: 24 48        MOVW    DE,AX
5e54: b9 23        MOV     A,#23H
5e56: 06 0f 01     CMP     A,[DE+01H]
5e59: 83 05        BC      $5E60H
5e5b: 62 01 00     MOVW    BC,#0001H
5e5e: 14 03        BR      $5E63H
5e60: 62 00 00     MOVW    BC,#0000H
5e63: 37           POP     HL
5e64: 56           RET
5e65: 20 6a        MOV     A,0FE6AH
5e67: c1           INC     A
5e68: 0e           ADJBA
5e69: 22 6a        MOV     0FE6AH,A
5e6b: 20 6a        MOV     A,0FE6AH
5e6d: bb 00        MOV     B,#00H
5e6f: da           XCH     A,C
5e70: 56           RET
5e71: 20 6a        MOV     A,0FE6AH
5e73: 9a 6b        SUB     A,0FE6BH
5e75: 0f           ADJBS
5e76: 22 6a        MOV     0FE6AH,A
5e78: 20 6a        MOV     A,0FE6AH
5e7a: bb 00        MOV     B,#00H
5e7c: da           XCH     A,C
5e7d: 56           RET
5e7e: 20 6a        MOV     A,0FE6AH
5e80: 98 6b        ADD     A,0FE6BH
5e82: 0e           ADJBA
5e83: 22 6a        MOV     0FE6AH,A
5e85: 20 6a        MOV     A,0FE6AH
5e87: bb 00        MOV     B,#00H
5e89: da           XCH     A,C
5e8a: 56           RET
5e8b: 20 6a        MOV     A,0FE6AH
5e8d: 98 6b        ADD     A,0FE6BH
5e8f: b8 99        MOV     X,#99H
5e91: 8f 01        CMP     X,A
5e93: 83 03        BC      $5E98H
5e95: 2c a8 5e     BR      !5EA8H
5e98: 20 6a        MOV     A,0FE6AH
5e9a: 98 6b        ADD     A,0FE6BH
5e9c: 0e           ADJBA
5e9d: a8 40        ADD     A,#40H
5e9f: 0e           ADJBA
5ea0: 22 6a        MOV     0FE6AH,A
5ea2: 3a 6b 01     MOV     0FE6BH,#01H
5ea5: 2c b2 5e     BR      !5EB2H
5ea8: 20 6a        MOV     A,0FE6AH
5eaa: 98 6b        ADD     A,0FE6BH
5eac: 0e           ADJBA
5ead: 22 6a        MOV     0FE6AH,A
5eaf: 3a 6b 00     MOV     0FE6BH,#00H
5eb2: 20 6a        MOV     A,0FE6AH
5eb4: bb 00        MOV     B,#00H
5eb6: da           XCH     A,C
5eb7: 56           RET
5eb8: 3f           PUSH    HL
5eb9: 11 fc        MOVW    AX,SP
5ebb: 2e 04 00     SUBW    AX,#0004H
5ebe: 24 68        MOVW    HL,AX
5ec0: 13 fc        MOVW    SP,AX
5ec2: 1c 63        MOVW    AX,0FE63H
5ec4: 24 48        MOVW    DE,AX
5ec6: 06 00 03     MOV     A,[DE+03H]
5ec9: d8           XCH     A,X
5eca: 06 00 04     MOV     A,[DE+04H]
5ecd: 24 28        MOVW    BC,AX
5ecf: 06 00 01     MOV     A,[DE+01H]
5ed2: d8           XCH     A,X
5ed3: 06 00 02     MOV     A,[DE+02H]
5ed6: 06 a0 01     MOV     [HL+01H],A
5ed9: d8           XCH     A,X
5eda: 55           MOV     [HL],A
5edb: 25 02        XCH     X,C
5edd: db           XCH     A,B
5ede: 06 a0 03     MOV     [HL+03H],A
5ee1: d8           XCH     A,X
5ee2: 06 a0 02     MOV     [HL+02H],A
5ee5: 3a 6a 00     MOV     0FE6AH,#00H
5ee8: 6f 6a 14     CMP     0FE6AH,#14H
5eeb: 82 33        BNC     $5F20H
5eed: 20 6a        MOV     A,0FE6AH
5eef: b8 00        MOV     X,#00H
5ef1: d8           XCH     A,X
5ef2: 31 d0        SHLW    AX,2
5ef4: 2d 59 10     ADDW    AX,#1059H
5ef7: 24 48        MOVW    DE,AX
5ef9: 58           MOV     A,[DE+]
5efa: d8           XCH     A,X
5efb: 58           MOV     A,[DE+]
5efc: 1a a8        MOVW    0FEA8H,AX
5efe: 05 e2        MOVW    AX,[DE]
5f00: 1a aa        MOVW    0FEAAH,AX
5f02: 1c a8        MOVW    AX,0FEA8H
5f04: 1a a4        MOVW    0FEA4H,AX
5f06: 1c aa        MOVW    AX,0FEAAH
5f08: 1a a6        MOVW    0FEA6H,AX
5f0a: 05 e3        MOVW    AX,[HL]
5f0c: 1a a8        MOVW    0FEA8H,AX
5f0e: 06 20 02     MOV     A,[HL+02H]
5f11: d8           XCH     A,X
5f12: 06 20 03     MOV     A,[HL+03H]
5f15: 1a aa        MOVW    0FEAAH,AX
5f17: 28 ea ab     CALL    Compare_32Bits
5f1a: 82 04        BNC     $5F20H
5f1c: 26 6a        INC     0FE6AH
5f1e: 14 c8        BR      $5EE8H
5f20: 06 20 02     MOV     A,[HL+02H]
5f23: d8           XCH     A,X
5f24: 06 20 03     MOV     A,[HL+03H]
5f27: 24 28        MOVW    BC,AX
5f29: 05 e3        MOVW    AX,[HL]
5f2b: 3d           PUSH    BC
5f2c: 3c           PUSH    AX
5f2d: 20 6a        MOV     A,0FE6AH
5f2f: b8 00        MOV     X,#00H
5f31: d8           XCH     A,X
5f32: 31 d0        SHLW    AX,2
5f34: 2d a9 10     ADDW    AX,#10A9H
5f37: 24 48        MOVW    DE,AX
5f39: 06 00 02     MOV     A,[DE+02H]
5f3c: d8           XCH     A,X
5f3d: 06 00 03     MOV     A,[DE+03H]
5f40: 24 28        MOVW    BC,AX
5f42: 05 e2        MOVW    AX,[DE]
5f44: 3d           PUSH    BC
5f45: 3c           PUSH    AX
5f46: 28 4c 60     CALL    !604CH
5f49: 34           POP     AX
5f4a: 34           POP     AX
5f4b: 34           POP     AX
5f4c: 34           POP     AX
5f4d: 09 f0 a7 fd  MOV     A,!0FDA7H
5f51: 9f 6a        CMP     A,0FE6AH
5f53: 80 06        BNZ     $5F5BH
5f55: 76 72 03     BT      0FE72H.6,$5F5BH
5f58: 2c 47 60     BR      !6047H
5f5b: 20 6a        MOV     A,0FE6AH
5f5d: 09 f1 a7 fd  MOV     !0FDA7H,A
5f61: 3a bb 80     MOV     0FEBBH,#80H
5f64: 3a ba 80     MOV     0FEBAH,#80H
5f67: 1c b2        MOVW    AX,I2C_OutputBuffer
5f69: 3c           PUSH    AX
5f6a: 1c ba        MOVW    AX,0FEBAH
5f6c: 1a b2        MOVW    I2C_OutputBuffer,AX
5f6e: 90 00        CALLF   I2C_Output
5f70: 34           POP     AX
5f71: 1a b2        MOVW    I2C_OutputBuffer,AX
5f73: 3a bb 80     MOV     0FEBBH,#80H
5f76: 3a ba 47     MOV     0FEBAH,#47H
5f79: 1c b2        MOVW    AX,I2C_OutputBuffer
5f7b: 3c           PUSH    AX
5f7c: 1c ba        MOVW    AX,0FEBAH
5f7e: 1a b2        MOVW    I2C_OutputBuffer,AX
5f80: 90 00        CALLF   I2C_Output
5f82: 34           POP     AX
5f83: 1a b2        MOVW    I2C_OutputBuffer,AX
5f85: 3a bb 80     MOV     0FEBBH,#80H
5f88: 3a ba f0     MOV     0FEBAH,#0F0H
5f8b: 1c b2        MOVW    AX,I2C_OutputBuffer
5f8d: 3c           PUSH    AX
5f8e: 1c ba        MOVW    AX,0FEBAH
5f90: 1a b2        MOVW    I2C_OutputBuffer,AX
5f92: 90 00        CALLF   I2C_Output
5f94: 34           POP     AX
5f95: 1a b2        MOVW    I2C_OutputBuffer,AX
5f97: 3a bb 80     MOV     0FEBBH,#80H
5f9a: 3a ba 00     MOV     0FEBAH,#00H
5f9d: 1c b2        MOVW    AX,I2C_OutputBuffer
5f9f: 3c           PUSH    AX
5fa0: 1c ba        MOVW    AX,0FEBAH
5fa2: 1a b2        MOVW    I2C_OutputBuffer,AX
5fa4: 90 00        CALLF   I2C_Output
5fa6: 34           POP     AX
5fa7: 1a b2        MOVW    I2C_OutputBuffer,AX
5fa9: 20 06        MOV     A,P6
5fab: ac f8        AND     A,#0F8H
5fad: ae 03        OR      A,#03H
5faf: 22 06        MOV     P6,A
5fb1: 28 4b 60     CALL    Empty_Debug
5fb4: 6c 06 f8     AND     P6,#0F8H
5fb7: 3a bb 04     MOV     0FEBBH,#04H
5fba: 3a ba 00     MOV     0FEBAH,#00H
5fbd: 1c b2        MOVW    AX,I2C_OutputBuffer
5fbf: 3c           PUSH    AX
5fc0: 1c ba        MOVW    AX,0FEBAH
5fc2: 1a b2        MOVW    I2C_OutputBuffer,AX
5fc4: 90 00        CALLF   I2C_Output
5fc6: 34           POP     AX
5fc7: 1a b2        MOVW    I2C_OutputBuffer,AX
5fc9: 3a bb 80     MOV     0FEBBH,#80H
5fcc: 20 6a        MOV     A,0FE6AH
5fce: b8 00        MOV     X,#00H
5fd0: d8           XCH     A,X
5fd1: 2d f9 10     ADDW    AX,#10F9H
5fd4: 24 48        MOVW    DE,AX
5fd6: 5c           MOV     A,[DE]
5fd7: 22 ba        MOV     0FEBAH,A
5fd9: 1c b2        MOVW    AX,I2C_OutputBuffer
5fdb: 3c           PUSH    AX
5fdc: 1c ba        MOVW    AX,0FEBAH
5fde: 1a b2        MOVW    I2C_OutputBuffer,AX
5fe0: 90 00        CALLF   I2C_OuputH
5fe2: 34           POP     AX
5fe3: 1a b2        MOVW    I2C_OutputBuffer,AX
5fe5: 3a bb 80     MOV     0FEBBH,#80H
5fe8: 20 6a        MOV     A,0FE6AH
5fea: b8 00        MOV     X,#00H
5fec: d8           XCH     A,X
5fed: 2d 0d 11     ADDW    AX,#110DH
5ff0: 24 48        MOVW    DE,AX
5ff2: 5c           MOV     A,[DE]
5ff3: 22 ba        MOV     0FEBAH,A
5ff5: 1c b2        MOVW    AX,I2C_OutputBuffer
5ff7: 3c           PUSH    AX
5ff8: 1c ba        MOVW    AX,0FEBAH
5ffa: 1a b2        MOVW    I2C_OutputBuffer,AX
5ffc: 90 00        CALLF   I2C_OuputH
5ffe: 34           POP     AX
5fff: 1a b2        MOVW    I2C_OutputBuffer,AX
6001: 3a bb 80     MOV     0FEBBH,#80H
6004: 20 6a        MOV     A,0FE6AH
6006: b8 00        MOV     X,#00H
6008: d8           XCH     A,X
6009: 2d 21 11     ADDW    AX,#1121H
600c: 24 48        MOVW    DE,AX
600e: 5c           MOV     A,[DE]
600f: 22 ba        MOV     0FEBAH,A
6011: 1c b2        MOVW    AX,I2C_OutputBuffer
6013: 3c           PUSH    AX
6014: 1c ba        MOVW    AX,0FEBAH
6016: 1a b2        MOVW    I2C_OutputBuffer,AX
6018: 90 00        CALLF   I2C_OuputH
601a: 34           POP     AX
601b: 1a b2        MOVW    I2C_OutputBuffer,AX
601d: 3a bb 80     MOV     0FEBBH,#80H
6020: 20 6a        MOV     A,0FE6AH
6022: b8 00        MOV     X,#00H
6024: d8           XCH     A,X
6025: 2d 35 11     ADDW    AX,#1135H
6028: 24 48        MOVW    DE,AX
602a: 5c           MOV     A,[DE]
602b: 22 ba        MOV     0FEBAH,A
602d: 1c b2        MOVW    AX,I2C_OutputBuffer
602f: 3c           PUSH    AX
6030: 1c ba        MOVW    AX,0FEBAH
6032: 1a b2        MOVW    I2C_OutputBuffer,AX
6034: 90 00        CALLF   I2C_OuputH
6036: 34           POP     AX
6037: 1a b2        MOVW    I2C_OutputBuffer,AX
6039: 20 06        MOV     A,P6
603b: ac f8        AND     A,#0F8H
603d: ae 03        OR      A,#03H
603f: 22 06        MOV     P6,A
6041: 28 4b 60     CALL    Empty_Debug
6044: 6c 06 f8     AND     P6,#0F8H
6047: 34           POP     AX
6048: 34           POP     AX
6049: 37           POP     HL
604a: 56           RET
Empty_Debug:
604b: 56           RET
604c: 3f           PUSH    HL
604d: 11 fc        MOVW    AX,SP
604f: 24 68        MOVW    HL,AX
6051: 64 1a fd     MOVW    DE,#0FD1AH
6054: 06 20 04     MOV     A,[HL+04H]
6057: 06 2a 08     SUB     A,[HL+08H]
605a: 0f           ADJBS
605b: 54           MOV     [DE],A
605c: 06 20 05     MOV     A,[HL+05H]
605f: 06 2b 09     SUBC    A,[HL+09H]
6062: 0f           ADJBS
6063: 06 80 01     MOV     [DE+01H],A
6066: 06 20 06     MOV     A,[HL+06H]
6069: 06 2b 0a     SUBC    A,[HL+0AH]
606c: 0f           ADJBS
606d: 06 80 02     MOV     [DE+02H],A
6070: 06 20 07     MOV     A,[HL+07H]
6073: 06 2b 0b     SUBC    A,[HL+0BH]
6076: 0f           ADJBS
6077: 06 80 03     MOV     [DE+03H],A
607a: 37           POP     HL
607b: 56           RET
LCD1_Activate:
607c: 20 06        MOV     A,P6
607e: ac f8        AND     A,#0F8H
6080: ae 01        OR      A,#01H
6082: 22 06        MOV     P6,A
6084: 56           RET
LCD2_Activate:
6085: 20 06        MOV     A,P6
6087: ac f8        AND     A,#0F8H
6089: ae 02        OR      A,#02H
608b: 22 06        MOV     P6,A
608d: 56           RET
608e: 6e 06 08     OR      P6,#08H
6091: 4a           DI
6092: 60 01 00     MOVW    AX,#0001H
6095: 3c           PUSH    AX
6096: 28 d5 60     CALL    !60D5H
6099: 34           POP     AX
609a: 60 00 00     MOVW    AX,#0000H
609d: 3c           PUSH    AX
609e: 90 be        CALLF   Puzzle_Piece1
60a0: 34           POP     AX
60a1: 60 ff 00     MOVW    AX,#00FFH
60a4: 3c           PUSH    AX
60a5: 60 10 00     MOVW    AX,#0010H
60a8: 3c           PUSH    AX
60a9: 28 04 61     CALL    !6104H
60ac: 34           POP     AX
60ad: 34           POP     AX
60ae: 6c 06 f8     AND     P6,#0F8H
60b1: 60 02 00     MOVW    AX,#0002H
60b4: 3c           PUSH    AX
60b5: 28 d5 60     CALL    !60D5H
60b8: 34           POP     AX
60b9: 60 00 00     MOVW    AX,#0000H
60bc: 3c           PUSH    AX
60bd: 90 d8        CALLF   !08D8H
60bf: 34           POP     AX
60c0: 60 ff 00     MOVW    AX,#00FFH
60c3: 3c           PUSH    AX
60c4: 60 10 00     MOVW    AX,#0010H
60c7: 3c           PUSH    AX
60c8: 28 04 61     CALL    !6104H
60cb: 34           POP     AX
60cc: 34           POP     AX
60cd: 6c 06 f8     AND     P6,#0F8H
60d0: 3a 83 96     MOV     0FE83H,#96H
60d3: 4b           EI
60d4: 56           RET
60d5: 3f           PUSH    HL
60d6: 11 fc        MOVW    AX,SP
60d8: 24 68        MOVW    HL,AX
60da: 90 23        CALLF   !Set_HiBit
60dc: 06 20 04     MOV     A,[HL+04H]
60df: af 01        CMP     A,#01H
60e1: 80 05        BNZ     $60E8H
60e3: 28 7c 60     CALL    LCD1_Activate
60e6: 14 03        BR      $60EBH
60e8: 28 85 60     CALL    LCD2_Activate
60eb: 60 42 00     MOVW    AX,#0042H
60ee: 3c           PUSH    AX
60ef: 90 3b        CALLF   !Weird_Stack_Thing
60f1: 34           POP     AX
60f2: 60 00 00     MOVW    AX,#0000H
60f5: 3c           PUSH    AX
60f6: 90 3b        CALLF   !Weird_Stack_Thing
60f8: 34           POP     AX
60f9: 60 11 00     MOVW    AX,#0011H
60fc: 3c           PUSH    AX
60fd: 90 3b        CALLF   !Weird_Stack_Thing
60ff: 34           POP     AX
6100: 90 2f        CALLF   !Clear_HiBit
6102: 37           POP     HL
6103: 56           RET
6104: 3f           PUSH    HL
6105: 11 fc        MOVW    AX,SP
6107: 24 68        MOVW    HL,AX
6109: b9 00        MOV     A,#00H
610b: 06 2f 04     CMP     A,[HL+04H]
610e: 82 1b        BNC     $612BH
6110: 60 14 00     MOVW    AX,#0014H
6113: 3c           PUSH    AX
6114: 28 6d 8b     CALL    Delay_Loop
6117: 34           POP     AX
6118: 06 20 06     MOV     A,[HL+06H]
611b: b8 00        MOV     X,#00H
611d: d8           XCH     A,X
611e: 3c           PUSH    AX
611f: 90 3b        CALLF   !Weird_Stack_Thing
6121: 34           POP     AX
6122: 06 20 04     MOV     A,[HL+04H]
6125: c9           DEC     A
6126: 06 a0 04     MOV     [HL+04H],A
6129: 14 de        BR      $6109H
612b: 37           POP     HL
612c: 56           RET
612d: 90 23        CALLF   !Set_HiBit
612f: 28 7c 60     CALL    LCD1_Activate
6132: 60 20 00     MOVW    AX,#0020H
6135: 3c           PUSH    AX
6136: 90 3b        CALLF   !Weird_Stack_Thing
6138: 34           POP     AX
6139: 28 85 60     CALL    LCD2_Activate
613c: 60 20 00     MOVW    AX,#0020H
613f: 3c           PUSH    AX
6140: 90 3b        CALLF   !Weird_Stack_Thing
6142: 34           POP     AX
6143: 56           RET
6144: 60 0f 00     MOVW    AX,#000FH
6147: 3c           PUSH    AX
6148: 28 6d 8b     CALL    Delay_Loop
614b: 34           POP     AX
614c: 28 ce 7a     CALL    Query_DFBE
614f: 08 a1 66 03  BF      0FE66H.1,$6156H
6153: 2c 05 62     BR      !6205H
6156: a2 68        CLR1    0FE68H.2
6158: 08 a0 66 0a  BF      0FE66H.0,$6166H
615c: 60 06 00     MOVW    AX,#0006H
615f: 3c           PUSH    AX
6160: 90 d8        CALLF   !08D8H
6162: 34           POP     AX
6163: 28 19 69     CALL    !6919H
6166: 60 00 00     MOVW    AX,#0000H
6169: 3c           PUSH    AX
616a: 90 be        CALLF   Puzzle_Piece1
616c: 34           POP     AX
616d: 08 a1 72 06  BF      0FE72H.1,$6177H
6171: 28 2f 70     CALL    !702FH
6174: 2c 05 62     BR      !6205H
6177: 28 c4 70     CALL    !70C4H
617a: 8a 08        SUBW    AX,AX
617c: 8f 0a        CMPW    AX,BC
617e: 81 06        BZ      $6186H
6180: 28 7d 70     CALL    !707DH
6183: 2c 05 62     BR      !6205H
6186: 08 a7 66 05  BF      0FE66H.7,$618FH
618a: 28 ae 67     CALL    !67AEH
618d: 14 76        BR      $6205H
618f: 72 67 07     BT      0FE67H.2,$6199H
6192: 74 67 04     BT      0FE67H.4,$6199H
6195: 08 a1 67 05  BF      0FE67H.1,$619EH
6199: 28 a7 66     CALL    !66A7H
619c: 14 67        BR      $6205H
619e: 08 a5 67 05  BF      0FE67H.5,$61A7H
61a2: 28 5d 69     CALL    !695DH
61a5: 14 5e        BR      $6205H
61a7: 09 f0 b2 fd  MOV     A,!0FDB2H
61ab: af 08        CMP     A,#08H
61ad: 83 0b        BC      $61BAH
61af: 81 09        BZ      $61BAH
61b1: 08 a0 66 05  BF      0FE66H.0,$61BAH
61b5: 28 90 6d     CALL    !6D90H
61b8: 14 4b        BR      $6205H
61ba: 73 65 09     BT      0FE65H.3,$61C6H
61bd: 08 a0 66 05  BF      0FE66H.0,$61C6H
61c1: 6f 88 00     CMP     0FE88H,#00H
61c4: 81 05        BZ      $61CBH
61c6: 28 11 68     CALL    !6811H
61c9: 14 3a        BR      $6205H
61cb: 08 a2 65 33  BF      0FE65H.2,$6202H
61cf: 09 f0 0f fd  MOV     A,!0FD0FH
61d3: af ff        CMP     A,#0FFH
61d5: 81 2b        BZ      $6202H
61d7: 09 f0 0c fd  MOV     A,!0FD0CH
61db: 30 b9        SHR     A,7
61dd: ac 01        AND     A,#01H
61df: b8 00        MOV     X,#00H
61e1: d8           XCH     A,X
61e2: 2f 00 00     CMPW    AX,#0000H
61e5: 81 0e        BZ      $61F5H
61e7: 09 f0 0c fd  MOV     A,!0FD0CH
61eb: ac 7f        AND     A,#7FH
61ed: b8 00        MOV     X,#00H
61ef: d8           XCH     A,X
61f0: 2f 00 00     CMPW    AX,#0000H
61f3: 80 08        BNZ     $61FDH
61f5: 72 73 05     BT      0FE73H.2,$61FDH
61f8: 28 5d 69     CALL    !695DH
61fb: 14 03        BR      $6200H
61fd: 28 20 6a     CALL    !6A20H
6200: 14 03        BR      $6205H
6202: 28 20 6a     CALL    !6A20H
6205: 6c 06 f8     AND     P6,#0F8H
6208: 56           RET
6209: 08 a0 73 15  BF      0FE73H.0,$6222H
620d: 6f 85 00     CMP     0FE85H,#00H
6210: 80 10        BNZ     $6222H
6212: 09 f0 92 fd  MOV     A,!0FD92H
6216: d8           XCH     A,X
6217: 09 f0 91 fd  MOV     A,!0FD91H
621b: 8f 10        CMP     A,X
621d: 80 03        BNZ     $6222H
621f: 3a 8a 01     MOV     0FE8AH,#01H
6222: 56           RET
6223: 1c ac        MOVW    AX,0FEACH
6225: 3c           PUSH    AX
6226: a1 68        CLR1    0FE68H.1
6228: 60 0c 00     MOVW    AX,#000CH
622b: 3c           PUSH    AX
622c: 90 d8        CALLF   !08D8H
622e: 34           POP     AX
622f: 70 66 03     BT      0FE66H.0,$6235H
6232: 2c 26 66     BR      !6626H
6235: 1c 63        MOVW    AX,0FE63H
6237: 2f 5c fe     CMPW    AX,#0FE5CH
623a: 80 05        BNZ     $6241H
623c: 60 04 00     MOVW    AX,#0004H
623f: 14 02        BR      $6243H
6241: 8a 08        SUBW    AX,AX
6243: d0           MOV     A,X
6244: 22 ac        MOV     0FEACH,A
6246: 6f 7f 00     CMP     0FE7FH,#00H
6249: 81 04        BZ      $624FH
624b: 08 a3 72 09  BF      0FE72H.3,$6258H
624f: 6f 7f 00     CMP     0FE7FH,#00H
6252: 80 07        BNZ     $625BH
6254: 08 a3 72 03  BF      0FE72H.3,$625BH
6258: 6e ac 80     OR      0FEACH,#80H
625b: 14 0f        BR      $626CH
625d: 6e ac 08     OR      0FEACH,#08H
6260: 14 1c        BR      $627EH
6262: 6e ac 02     OR      0FEACH,#02H
6265: 14 17        BR      $627EH
6267: 6e ac 01     OR      0FEACH,#01H
626a: 14 12        BR      $627EH
626c: 09 f0 97 fd  MOV     A,!0FD97H
6270: ac e0        AND     A,#0E0H
6272: af 20        CMP     A,#20H
6274: 81 f1        BZ      $6267H
6276: af 40        CMP     A,#40H
6278: 81 e8        BZ      $6262H
627a: af 80        CMP     A,#80H
627c: 81 df        BZ      $625DH
627e: 08 a6 65 03  BF      0FE65H.6,$6285H
6282: 6e ac 30     OR      0FEACH,#30H
6285: 20 ac        MOV     A,0FEACH
6287: b8 00        MOV     X,#00H
6289: d8           XCH     A,X
628a: 3c           PUSH    AX
628b: 90 3b        CALLF   !Weird_Stack_Thing
628d: 34           POP     AX
628e: 1c 63        MOVW    AX,0FE63H
6290: 2f 55 fe     CMPW    AX,#0FE55H
6293: 80 05        BNZ     $629AH
6295: 60 04 00     MOVW    AX,#0004H
6298: 14 02        BR      $629CH
629a: 8a 08        SUBW    AX,AX
629c: d0           MOV     A,X
629d: 22 ac        MOV     0FEACH,A
629f: 14 0f        BR      $62B0H
62a1: 6e ac 08     OR      0FEACH,#08H
62a4: 14 1c        BR      $62C2H
62a6: 6e ac 02     OR      0FEACH,#02H
62a9: 14 17        BR      $62C2H
62ab: 6e ac 01     OR      0FEACH,#01H
62ae: 14 12        BR      $62C2H
62b0: 09 f0 97 fd  MOV     A,!0FD97H
62b4: ac 0e        AND     A,#0EH
62b6: af 02        CMP     A,#02H
62b8: 81 f1        BZ      $62ABH
62ba: af 04        CMP     A,#04H
62bc: 81 e8        BZ      $62A6H
62be: af 08        CMP     A,#08H
62c0: 81 df        BZ      $62A1H
62c2: 08 a7 72 03  BF      0FE72H.7,$62C9H
62c6: 6e ac 40     OR      0FEACH,#40H
62c9: 20 ac        MOV     A,0FEACH
62cb: b8 00        MOV     X,#00H
62cd: d8           XCH     A,X
62ce: 3c           PUSH    AX
62cf: 90 3b        CALLF   !Weird_Stack_Thing
62d1: 34           POP     AX
62d2: 3a ac 00     MOV     0FEACH,#00H
62d5: 28 c4 70     CALL    !70C4H
62d8: 8a 08        SUBW    AX,AX
62da: 8f 0a        CMPW    AX,BC
62dc: 81 03        BZ      $62E1H
62de: 2c 6c 63     BR      !636CH
62e1: 14 0f        BR      $62F2H
62e3: 3a ac 01     MOV     0FEACH,#01H
62e6: 14 24        BR      $630CH
62e8: 3a ac 04     MOV     0FEACH,#04H
62eb: 14 1f        BR      $630CH
62ed: 3a ac 08     MOV     0FEACH,#08H
62f0: 14 1a        BR      $630CH
62f2: 1c 63        MOVW    AX,0FE63H
62f4: 24 48        MOVW    DE,AX
62f6: 06 00 06     MOV     A,[DE+06H]
62f9: 30 b1        SHR     A,6
62fb: ac 03        AND     A,#03H
62fd: b8 00        MOV     X,#00H
62ff: d8           XCH     A,X
6300: 2f 01 00     CMPW    AX,#0001H
6303: 81 e3        BZ      $62E8H
6305: 2f 02 00     CMPW    AX,#0002H
6308: 81 d9        BZ      $62E3H
630a: 14 e1        BR      $62EDH
630c: 1c 63        MOVW    AX,0FE63H
630e: 24 48        MOVW    DE,AX
6310: 06 00 06     MOV     A,[DE+06H]
6313: 30 99        SHR     A,3
6315: ac 07        AND     A,#07H
6317: b8 00        MOV     X,#00H
6319: d8           XCH     A,X
631a: 2f 04 00     CMPW    AX,#0004H
631d: 81 24        BZ      $6343H
631f: 14 0a        BR      $632BH
6321: 6e ac 10     OR      0FEACH,#10H
6324: 14 1d        BR      $6343H
6326: 6e ac 40     OR      0FEACH,#40H
6329: 14 18        BR      $6343H
632b: 1c 63        MOVW    AX,0FE63H
632d: 24 48        MOVW    DE,AX
632f: 06 00 05     MOV     A,[DE+05H]
6332: 30 a1        SHR     A,4
6334: ac 03        AND     A,#03H
6336: b8 00        MOV     X,#00H
6338: d8           XCH     A,X
6339: 2f 03 00     CMPW    AX,#0003H
633c: 81 e8        BZ      $6326H
633e: 2f 02 00     CMPW    AX,#0002H
6341: 81 de        BZ      $6321H
6343: 1c 63        MOVW    AX,0FE63H
6345: 24 48        MOVW    DE,AX
6347: 06 00 05     MOV     A,[DE+05H]
634a: 30 89        SHR     A,1
634c: ac 01        AND     A,#01H
634e: b8 00        MOV     X,#00H
6350: d8           XCH     A,X
6351: 2f 01 00     CMPW    AX,#0001H
6354: 80 16        BNZ     $636CH
6356: 1c 63        MOVW    AX,0FE63H
6358: 24 48        MOVW    DE,AX
635a: 06 00 06     MOV     A,[DE+06H]
635d: 30 99        SHR     A,3
635f: ac 07        AND     A,#07H
6361: b8 00        MOV     X,#00H
6363: d8           XCH     A,X
6364: 2f 04 00     CMPW    AX,#0004H
6367: 81 03        BZ      $636CH
6369: 6e ac 20     OR      0FEACH,#20H
636c: 1c 63        MOVW    AX,0FE63H
636e: 24 48        MOVW    DE,AX
6370: 06 00 05     MOV     A,[DE+05H]
6373: 30 91        SHR     A,2
6375: ac 01        AND     A,#01H
6377: b8 00        MOV     X,#00H
6379: d8           XCH     A,X
637a: 2f 01 00     CMPW    AX,#0001H
637d: 80 03        BNZ     $6382H
637f: 6e ac 02     OR      0FEACH,#02H
6382: 20 ac        MOV     A,0FEACH
6384: b8 00        MOV     X,#00H
6386: d8           XCH     A,X
6387: 3c           PUSH    AX
6388: 90 3b        CALLF   !Weird_Stack_Thing
638a: 34           POP     AX
638b: 28 c4 70     CALL    !70C4H
638e: 8a 08        SUBW    AX,AX
6390: 8f 0a        CMPW    AX,BC
6392: 81 09        BZ      $639DH
6394: 60 00 00     MOVW    AX,#0000H
6397: 3c           PUSH    AX
6398: 90 3b        CALLF   !Weird_Stack_Thing
639a: 34           POP     AX
639b: 14 5a        BR      $63F7H
639d: 3a ac 00     MOV     0FEACH,#00H
63a0: 1c 63        MOVW    AX,0FE63H
63a2: 24 48        MOVW    DE,AX
63a4: 06 00 06     MOV     A,[DE+06H]
63a7: 30 99        SHR     A,3
63a9: ac 07        AND     A,#07H
63ab: b8 00        MOV     X,#00H
63ad: d8           XCH     A,X
63ae: 2f 04 00     CMPW    AX,#0004H
63b1: 81 26        BZ      $63D9H
63b3: 14 0c        BR      $63C1H
63b5: 3a ac 10     MOV     0FEACH,#10H
63b8: 14 1f        BR      $63D9H
63ba: 3a ac 80     MOV     0FEACH,#80H
63bd: 14 1a        BR      $63D9H
63bf: 14 18        BR      $63D9H
63c1: 1c 63        MOVW    AX,0FE63H
63c3: 24 48        MOVW    DE,AX
63c5: 06 00 05     MOV     A,[DE+05H]
63c8: 30 b1        SHR     A,6
63ca: ac 03        AND     A,#03H
63cc: b8 00        MOV     X,#00H
63ce: d8           XCH     A,X
63cf: 2f 03 00     CMPW    AX,#0003H
63d2: 81 e6        BZ      $63BAH
63d4: 2f 01 00     CMPW    AX,#0001H
63d7: 81 dc        BZ      $63B5H
63d9: 08 a2 65 03  BF      0FE65H.2,$63E0H
63dd: 6e ac 40     OR      0FEACH,#40H
63e0: 08 a5 65 0a  BF      0FE65H.5,$63EEH
63e4: 6e ac 08     OR      0FEACH,#08H
63e7: 08 a4 65 03  BF      0FE65H.4,$63EEH
63eb: 6e ac 01     OR      0FEACH,#01H
63ee: 20 ac        MOV     A,0FEACH
63f0: b8 00        MOV     X,#00H
63f2: d8           XCH     A,X
63f3: 3c           PUSH    AX
63f4: 90 3b        CALLF   !Weird_Stack_Thing
63f6: 34           POP     AX
63f7: 08 a6 66 05  BF      0FE66H.6,$6400H
63fb: 60 80 00     MOVW    AX,#0080H
63fe: 14 02        BR      $6402H
6400: 8a 08        SUBW    AX,AX
6402: d0           MOV     A,X
6403: 22 ac        MOV     0FEACH,A
6405: 08 a7 a1 03  BF      0FEA1H.7,$640CH
6409: 6e ac 04     OR      0FEACH,#04H
640c: 08 a6 a1 03  BF      0FEA1H.6,$6413H
6410: 6e ac 02     OR      0FEACH,#02H
6413: 20 ac        MOV     A,0FEACH
6415: b8 00        MOV     X,#00H
6417: d8           XCH     A,X
6418: 3c           PUSH    AX
6419: 90 3b        CALLF   !Weird_Stack_Thing
641b: 34           POP     AX
641c: 28 c4 70     CALL    !70C4H
641f: 8a 08        SUBW    AX,AX
6421: 8f 0a        CMPW    AX,BC
6423: 81 11        BZ      $6436H
6425: 60 20 00     MOVW    AX,#0020H
6428: 3c           PUSH    AX
6429: 90 3b        CALLF   !Weird_Stack_Thing
642b: 34           POP     AX
642c: 60 00 00     MOVW    AX,#0000H
642f: 3c           PUSH    AX
6430: 90 3b        CALLF   !Weird_Stack_Thing
6432: 34           POP     AX
6433: 2c ea 65     BR      !65EAH
6436: 6f 89 00     CMP     0FE89H,#00H
6439: 81 20        BZ      $645BH
643b: 6f 89 63     CMP     0FE89H,#63H
643e: 82 1b        BNC     $645BH
6440: 1c 63        MOVW    AX,0FE63H
6442: 24 48        MOVW    DE,AX
6444: 5c           MOV     A,[DE]
6445: 30 91        SHR     A,2
6447: ac 01        AND     A,#01H
6449: b8 00        MOV     X,#00H
644b: d8           XCH     A,X
644c: 2f 01 00     CMPW    AX,#0001H
644f: 80 0a        BNZ     $645BH
6451: 60 18 00     MOVW    AX,#0018H
6454: 3c           PUSH    AX
6455: 90 d8        CALLF   !08D8H
6457: 34           POP     AX
6458: 2c 0a 65     BR      !650AH
645b: 3a ac 20     MOV     0FEACH,#20H
645e: 14 77        BR      $64D7H
6460: 14 09        BR      $646BH
6462: 6e ac 01     OR      0FEACH,#01H
6465: 14 21        BR      $6488H
6467: 14 1f        BR      $6488H
6469: 14 1d        BR      $6488H
646b: 1c 63        MOVW    AX,0FE63H
646d: 24 48        MOVW    DE,AX
646f: 06 00 06     MOV     A,[DE+06H]
6472: 30 b1        SHR     A,6
6474: ac 03        AND     A,#03H
6476: b8 00        MOV     X,#00H
6478: d8           XCH     A,X
6479: 2f 01 00     CMPW    AX,#0001H
647c: 81 e9        BZ      $6467H
647e: 2f 02 00     CMPW    AX,#0002H
6481: 81 df        BZ      $6462H
6483: 2f 00 00     CMPW    AX,#0000H
6486: 81 da        BZ      $6462H
6488: 14 77        BR      $6501H
648a: 14 09        BR      $6495H
648c: 14 24        BR      $64B2H
648e: 6e ac 01     OR      0FEACH,#01H
6491: 14 1f        BR      $64B2H
6493: 14 1d        BR      $64B2H
6495: 1c 63        MOVW    AX,0FE63H
6497: 24 48        MOVW    DE,AX
6499: 06 00 06     MOV     A,[DE+06H]
649c: 30 b1        SHR     A,6
649e: ac 03        AND     A,#03H
64a0: b8 00        MOV     X,#00H
64a2: d8           XCH     A,X
64a3: 2f 01 00     CMPW    AX,#0001H
64a6: 81 e6        BZ      $648EH
64a8: 2f 02 00     CMPW    AX,#0002H
64ab: 81 df        BZ      $648CH
64ad: 2f 00 00     CMPW    AX,#0000H
64b0: 81 da        BZ      $648CH
64b2: 14 4d        BR      $6501H
64b4: 6e ac 02     OR      0FEACH,#02H
64b7: 14 48        BR      $6501H
64b9: 6e ac 04     OR      0FEACH,#04H
64bc: 14 43        BR      $6501H
64be: 6e ac 80     OR      0FEACH,#80H
64c1: 1c 63        MOVW    AX,0FE63H
64c3: 24 48        MOVW    DE,AX
64c5: 5c           MOV     A,[DE]
64c6: 30 91        SHR     A,2
64c8: ac 01        AND     A,#01H
64ca: b8 00        MOV     X,#00H
64cc: d8           XCH     A,X
64cd: 2f 01 00     CMPW    AX,#0001H
64d0: 80 03        BNZ     $64D5H
64d2: 6e ac 08     OR      0FEACH,#08H
64d5: 14 2a        BR      $6501H
64d7: 1c 63        MOVW    AX,0FE63H
64d9: 24 48        MOVW    DE,AX
64db: 06 00 06     MOV     A,[DE+06H]
64de: 30 99        SHR     A,3
64e0: ac 07        AND     A,#07H
64e2: b8 00        MOV     X,#00H
64e4: d8           XCH     A,X
64e5: 2f 05 00     CMPW    AX,#0005H
64e8: 81 d4        BZ      $64BEH
64ea: 2f 04 00     CMPW    AX,#0004H
64ed: 81 ca        BZ      $64B9H
64ef: 2f 02 00     CMPW    AX,#0002H
64f2: 81 c0        BZ      $64B4H
64f4: 2f 00 00     CMPW    AX,#0000H
64f7: 81 91        BZ      $648AH
64f9: 2f 01 00     CMPW    AX,#0001H
64fc: 80 03        BNZ     $6501H
64fe: 2c 60 64     BR      !6460H
6501: 20 ac        MOV     A,0FEACH
6503: b8 00        MOV     X,#00H
6505: d8           XCH     A,X
6506: 3c           PUSH    AX
6507: 90 3b        CALLF   !Weird_Stack_Thing
6509: 34           POP     AX
650a: 3a ac 00     MOV     0FEACH,#00H
650d: 1c 63        MOVW    AX,0FE63H
650f: 24 48        MOVW    DE,AX
6511: 06 00 06     MOV     A,[DE+06H]
6514: 30 99        SHR     A,3
6516: ac 07        AND     A,#07H
6518: b8 00        MOV     X,#00H
651a: d8           XCH     A,X
651b: 2f 04 00     CMPW    AX,#0004H
651e: 81 40        BZ      $6560H
6520: 14 19        BR      $653BH
6522: 3a ac 02     MOV     0FEACH,#02H
6525: 14 39        BR      $6560H
6527: 3a ac 01     MOV     0FEACH,#01H
652a: 14 34        BR      $6560H
652c: 3a ac 04     MOV     0FEACH,#04H
652f: 14 2f        BR      $6560H
6531: 3a ac 20     MOV     0FEACH,#20H
6534: 14 2a        BR      $6560H
6536: 3a ac 40     MOV     0FEACH,#40H
6539: 14 25        BR      $6560H
653b: 1c 63        MOVW    AX,0FE63H
653d: 24 48        MOVW    DE,AX
653f: 06 00 06     MOV     A,[DE+06H]
6542: ac 07        AND     A,#07H
6544: b8 00        MOV     X,#00H
6546: d8           XCH     A,X
6547: 2f 00 00     CMPW    AX,#0000H
654a: 81 ea        BZ      $6536H
654c: 2f 01 00     CMPW    AX,#0001H
654f: 81 e0        BZ      $6531H
6551: 2f 02 00     CMPW    AX,#0002H
6554: 81 d6        BZ      $652CH
6556: 2f 03 00     CMPW    AX,#0003H
6559: 81 cc        BZ      $6527H
655b: 2f 04 00     CMPW    AX,#0004H
655e: 81 c2        BZ      $6522H
6560: 08 a1 65 03  BF      0FE65H.1,$6567H
6564: 6e ac 08     OR      0FEACH,#08H
6567: 14 5b        BR      $65C4H
6569: 6e ac 10     OR      0FEACH,#10H
656c: 14 73        BR      $65E1H
656e: 14 09        BR      $6579H
6570: 6e ac 80     OR      0FEACH,#80H
6573: 14 21        BR      $6596H
6575: 14 1f        BR      $6596H
6577: 14 1d        BR      $6596H
6579: 1c 63        MOVW    AX,0FE63H
657b: 24 48        MOVW    DE,AX
657d: 06 00 06     MOV     A,[DE+06H]
6580: 30 b1        SHR     A,6
6582: ac 03        AND     A,#03H
6584: b8 00        MOV     X,#00H
6586: d8           XCH     A,X
6587: 2f 01 00     CMPW    AX,#0001H
658a: 81 e9        BZ      $6575H
658c: 2f 02 00     CMPW    AX,#0002H
658f: 81 df        BZ      $6570H
6591: 2f 00 00     CMPW    AX,#0000H
6594: 81 da        BZ      $6570H
6596: 14 49        BR      $65E1H
6598: 14 09        BR      $65A3H
659a: 14 24        BR      $65C0H
659c: 6e ac 80     OR      0FEACH,#80H
659f: 14 1f        BR      $65C0H
65a1: 14 1d        BR      $65C0H
65a3: 1c 63        MOVW    AX,0FE63H
65a5: 24 48        MOVW    DE,AX
65a7: 06 00 06     MOV     A,[DE+06H]
65aa: 30 b1        SHR     A,6
65ac: ac 03        AND     A,#03H
65ae: b8 00        MOV     X,#00H
65b0: d8           XCH     A,X
65b1: 2f 01 00     CMPW    AX,#0001H
65b4: 81 e6        BZ      $659CH
65b6: 2f 02 00     CMPW    AX,#0002H
65b9: 81 df        BZ      $659AH
65bb: 2f 00 00     CMPW    AX,#0000H
65be: 81 da        BZ      $659AH
65c0: 14 1f        BR      $65E1H
65c2: 14 1d        BR      $65E1H
65c4: 1c 63        MOVW    AX,0FE63H
65c6: 24 48        MOVW    DE,AX
65c8: 06 00 06     MOV     A,[DE+06H]
65cb: 30 99        SHR     A,3
65cd: ac 07        AND     A,#07H
65cf: b8 00        MOV     X,#00H
65d1: d8           XCH     A,X
65d2: 2f 01 00     CMPW    AX,#0001H
65d5: 81 c1        BZ      $6598H
65d7: 2f 00 00     CMPW    AX,#0000H
65da: 81 92        BZ      $656EH
65dc: 2f 03 00     CMPW    AX,#0003H
65df: 81 88        BZ      $6569H
65e1: 20 ac        MOV     A,0FEACH
65e3: b8 00        MOV     X,#00H
65e5: d8           XCH     A,X
65e6: 3c           PUSH    AX
65e7: 90 3b        CALLF   !Weird_Stack_Thing
65e9: 34           POP     AX
65ea: 60 00 00     MOVW    AX,#0000H
65ed: 3c           PUSH    AX
65ee: 90 d8        CALLF   !08D8H
65f0: 34           POP     AX
65f1: 90 23        CALLF   !Set_HiBit
65f3: 1c 63        MOVW    AX,0FE63H
65f5: 24 48        MOVW    DE,AX
65f7: 06 00 05     MOV     A,[DE+05H]
65fa: 30 99        SHR     A,3
65fc: ac 01        AND     A,#01H
65fe: b8 00        MOV     X,#00H
6600: d8           XCH     A,X
6601: 2f 01 00     CMPW    AX,#0001H
6604: 80 05        BNZ     $660BH
6606: 60 d2 00     MOVW    AX,#00D2H
6609: 14 03        BR      $660EH
660b: 60 d0 00     MOVW    AX,#00D0H
660e: b9 00        MOV     A,#00H
6610: 3c           PUSH    AX
6611: 90 3b        CALLF   !Weird_Stack_Thing
6613: 34           POP     AX
6614: 60 1c 00     MOVW    AX,#001CH
6617: 3c           PUSH    AX
6618: 90 be        CALLF   Puzzle_Piece1
661a: 34           POP     AX
661b: 90 23        CALLF   !Set_HiBit
661d: 60 bf 00     MOVW    AX,#00BFH
6620: 3c           PUSH    AX
6621: 90 3b        CALLF   !Weird_Stack_Thing
6623: 34           POP     AX
6624: 14 44        BR      $666AH
6626: 3a ac 00     MOV     0FEACH,#00H
6629: 6f ac 10     CMP     0FEACH,#10H
662c: 82 0b        BNC     $6639H
662e: 60 00 00     MOVW    AX,#0000H
6631: 3c           PUSH    AX
6632: 90 3b        CALLF   !Weird_Stack_Thing
6634: 34           POP     AX
6635: 26 ac        INC     0FEACH
6637: 14 f0        BR      $6629H
6639: 60 14 00     MOVW    AX,#0014H
663c: 3c           PUSH    AX
663d: 90 d8        CALLF   !08D8H
663f: 34           POP     AX
6640: 3a ac 00     MOV     0FEACH,#00H
6643: 08 a7 a1 03  BF      0FEA1H.7,$664AH
6647: 6e ac 04     OR      0FEACH,#04H
664a: 08 a6 a1 03  BF      0FEA1H.6,$6651H
664e: 6e ac 02     OR      0FEACH,#02H
6651: 20 ac        MOV     A,0FEACH
6653: b8 00        MOV     X,#00H
6655: d8           XCH     A,X
6656: 3c           PUSH    AX
6657: 90 3b        CALLF   !Weird_Stack_Thing
6659: 34           POP     AX
665a: 60 1c 00     MOVW    AX,#001CH
665d: 3c           PUSH    AX
665e: 90 be        CALLF   Puzzle_Piece1
6660: 34           POP     AX
6661: 90 23        CALLF   !Set_HiBit
6663: 60 90 00     MOVW    AX,#0090H
6666: 3c           PUSH    AX
6667: 90 3b        CALLF   !Weird_Stack_Thing
6669: 34           POP     AX
666a: 6c 06 f8     AND     P6,#0F8H
666d: 34           POP     AX
666e: 1a ac        MOVW    0FEACH,AX
6670: 56           RET
6671: 3f           PUSH    HL
6672: 11 fc        MOVW    AX,SP
6674: 24 68        MOVW    HL,AX
6676: 06 20 04     MOV     A,[HL+04H]
6679: b8 00        MOV     X,#00H
667b: d8           XCH     A,X
667c: 88 08        ADDW    AX,AX
667e: 2d 49 11     ADDW    AX,#1149H
6681: 24 48        MOVW    DE,AX
6683: 05 e2        MOVW    AX,[DE]
6685: 3c           PUSH    AX
6686: 90 98        CALLF   !Interpret_Thing
6688: 34           POP     AX
6689: 37           POP     HL
668a: 56           RET
668b: 3f           PUSH    HL
668c: 11 fc        MOVW    AX,SP
668e: 24 68        MOVW    HL,AX
6690: 06 20 04     MOV     A,[HL+04H]
6693: ac 0f        AND     A,#0FH
6695: b8 00        MOV     X,#00H
6697: d8           XCH     A,X
6698: 2d 95 11     ADDW    AX,#1195H
669b: 24 48        MOVW    DE,AX
669d: 5c           MOV     A,[DE]
669e: b8 00        MOV     X,#00H
66a0: d8           XCH     A,X
66a1: 3c           PUSH    AX
66a2: 90 3b        CALLF   !Weird_Stack_Thing
66a4: 34           POP     AX
66a5: 37           POP     HL
66a6: 56           RET
66a7: 4a           DI
66a8: 60 00 00     MOVW    AX,#0000H
66ab: 3c           PUSH    AX
66ac: 90 be        CALLF   Puzzle_Piece1
66ae: 34           POP     AX
66af: 60 00 00     MOVW    AX,#0000H
66b2: 3c           PUSH    AX
66b3: 60 0e 00     MOVW    AX,#000EH
66b6: 3c           PUSH    AX
66b7: 28 04 61     CALL    !6104H
66ba: 34           POP     AX
66bb: 34           POP     AX
66bc: 4b           EI
66bd: 28 d7 6d     CALL    !6DD7H
66c0: 60 00 00     MOVW    AX,#0000H
66c3: 3c           PUSH    AX
66c4: 90 be        CALLF   Puzzle_Piece1
66c6: 34           POP     AX
66c7: 08 a1 67 13  BF      0FE67H.1,$66DEH
66cb: 1c 63        MOVW    AX,0FE63H
66cd: 24 48        MOVW    DE,AX
66cf: 06 00 06     MOV     A,[DE+06H]
66d2: 30 b1        SHR     A,6
66d4: ac 03        AND     A,#03H
66d6: b8 00        MOV     X,#00H
66d8: d8           XCH     A,X
66d9: 2f 01 00     CMPW    AX,#0001H
66dc: 80 6f        BNZ     $674DH
66de: 20 8f        MOV     A,0FE8FH
66e0: 30 a1        SHR     A,4
66e2: b8 00        MOV     X,#00H
66e4: d8           XCH     A,X
66e5: 3c           PUSH    AX
66e6: 90 f2        CALLF   !08F2H
66e8: 34           POP     AX
66e9: 20 8f        MOV     A,0FE8FH
66eb: b8 00        MOV     X,#00H
66ed: d8           XCH     A,X
66ee: 3c           PUSH    AX
66ef: 91 0e        CALLF   !090EH
66f1: 34           POP     AX
66f2: 20 8e        MOV     A,0FE8EH
66f4: 30 a1        SHR     A,4
66f6: b8 00        MOV     X,#00H
66f8: d8           XCH     A,X
66f9: 3c           PUSH    AX
66fa: 90 f2        CALLF   !08F2H
66fc: 34           POP     AX
66fd: 20 8e        MOV     A,0FE8EH
66ff: b8 00        MOV     X,#00H
6701: d8           XCH     A,X
6702: 3c           PUSH    AX
6703: 91 0e        CALLF   !090EH
6705: 34           POP     AX
6706: 08 a4 67 0e  BF      0FE67H.4,$6718H
670a: 8a 08        SUBW    AX,AX
670c: 3c           PUSH    AX
670d: 90 98        CALLF   !Interpret_Thing
670f: 34           POP     AX
6710: 8a 08        SUBW    AX,AX
6712: 3c           PUSH    AX
6713: 90 98        CALLF   !Interpret_Thing
6715: 34           POP     AX
6716: 14 33        BR      $674BH
6718: 20 8d        MOV     A,0FE8DH
671a: 30 a1        SHR     A,4
671c: b8 00        MOV     X,#00H
671e: d8           XCH     A,X
671f: 3c           PUSH    AX
6720: 90 f2        CALLF   !08F2H
6722: 34           POP     AX
6723: 20 8d        MOV     A,0FE8DH
6725: b8 00        MOV     X,#00H
6727: d8           XCH     A,X
6728: 3c           PUSH    AX
6729: 91 0e        CALLF   !090EH
672b: 34           POP     AX
672c: 72 67 0d     BT      0FE67H.2,$673CH
672f: 20 8c        MOV     A,0FE8CH
6731: 30 a1        SHR     A,4
6733: b8 00        MOV     X,#00H
6735: d8           XCH     A,X
6736: 3c           PUSH    AX
6737: 90 f2        CALLF   !08F2H
6739: 34           POP     AX
673a: 14 0f        BR      $674BH
673c: 70 a1 05     BT      0FEA1H.0,$6744H
673f: 60 00 03     MOVW    AX,#0300H
6742: 14 03        BR      $6747H
6744: 60 52 00     MOVW    AX,#0052H
6747: 3c           PUSH    AX
6748: 90 98        CALLF   !Interpret_Thing
674a: 34           POP     AX
674b: 14 45        BR      $6792H
674d: 20 8f        MOV     A,0FE8FH
674f: b8 00        MOV     X,#00H
6751: d8           XCH     A,X
6752: 3c           PUSH    AX
6753: 90 f2        CALLF   !08F2H
6755: 34           POP     AX
6756: 20 8e        MOV     A,0FE8EH
6758: 30 a1        SHR     A,4
675a: b8 00        MOV     X,#00H
675c: d8           XCH     A,X
675d: 3c           PUSH    AX
675e: 91 0e        CALLF   !090EH
6760: 34           POP     AX
6761: 20 8e        MOV     A,0FE8EH
6763: b8 00        MOV     X,#00H
6765: d8           XCH     A,X
6766: 3c           PUSH    AX
6767: 90 f2        CALLF   !08F2H
6769: 34           POP     AX
676a: 20 8d        MOV     A,0FE8DH
676c: 30 a1        SHR     A,4
676e: b8 00        MOV     X,#00H
6770: d8           XCH     A,X
6771: 3c           PUSH    AX
6772: 91 0e        CALLF   !090EH
6774: 34           POP     AX
6775: 20 8d        MOV     A,0FE8DH
6777: b8 00        MOV     X,#00H
6779: d8           XCH     A,X
677a: 3c           PUSH    AX
677b: 90 f2        CALLF   !08F2H
677d: 34           POP     AX
677e: 20 8c        MOV     A,0FE8CH
6780: 30 a1        SHR     A,4
6782: b8 00        MOV     X,#00H
6784: d8           XCH     A,X
6785: 3c           PUSH    AX
6786: 91 0e        CALLF   !090EH
6788: 34           POP     AX
6789: 20 8c        MOV     A,0FE8CH
678b: b8 00        MOV     X,#00H
678d: d8           XCH     A,X
678e: 3c           PUSH    AX
678f: 90 f2        CALLF   !08F2H
6791: 34           POP     AX
6792: 74 67 09     BT      0FE67H.4,$679EH
6795: 08 a1 67 05  BF      0FE67H.1,$679EH
6799: 28 25 6c     CALL    !6C25H
679c: 14 0f        BR      $67ADH
679e: 74 67 09     BT      0FE67H.4,$67AAH
67a1: 73 65 06     BT      0FE65H.3,$67AAH
67a4: b9 00        MOV     A,#00H
67a6: 9f 88        CMP     A,0FE88H
67a8: 82 03        BNC     $67ADH
67aa: 28 ae 6c     CALL    !6CAEH
67ad: 56           RET
67ae: 4a           DI
67af: 60 00 00     MOVW    AX,#0000H
67b2: 3c           PUSH    AX
67b3: 90 be        CALLF   Puzzle_Piece1
67b5: 34           POP     AX
67b6: 60 00 00     MOVW    AX,#0000H
67b9: 3c           PUSH    AX
67ba: 60 0e 00     MOVW    AX,#000EH
67bd: 3c           PUSH    AX
67be: 28 04 61     CALL    !6104H
67c1: 34           POP     AX
67c2: 34           POP     AX
67c3: 4b           EI
67c4: 60 08 00     MOVW    AX,#0008H
67c7: 3c           PUSH    AX
67c8: 90 be        CALLF   Puzzle_Piece1
67ca: 34           POP     AX
67cb: 08 a7 a1 09  BF      0FEA1H.7,$67D8H
67cf: 60 90 00     MOVW    AX,#0090H
67d2: 3c           PUSH    AX
67d3: 90 98        CALLF   !Interpret_Thing
67d5: 34           POP     AX
67d6: 14 07        BR      $67DFH
67d8: 60 40 02     MOVW    AX,#0240H
67db: 3c           PUSH    AX
67dc: 90 98        CALLF   !Interpret_Thing
67de: 34           POP     AX
67df: 60 10 00     MOVW    AX,#0010H
67e2: 3c           PUSH    AX
67e3: 90 be        CALLF   Puzzle_Piece1
67e5: 34           POP     AX
67e6: 08 a6 a1 09  BF      0FEA1H.6,$67F3H
67ea: 60 50 9a     MOVW    AX,#9A50H
67ed: 3c           PUSH    AX
67ee: 90 98        CALLF   !Interpret_Thing
67f0: 34           POP     AX
67f1: 14 07        BR      $67FAH
67f3: 60 40 02     MOVW    AX,#0240H
67f6: 3c           PUSH    AX
67f7: 90 98        CALLF   !Interpret_Thing
67f9: 34           POP     AX
67fa: 60 15 00     MOVW    AX,#0015H
67fd: 3c           PUSH    AX
67fe: 90 d8        CALLF   !08D8H
6800: 34           POP     AX
6801: 90 23        CALLF   !Set_HiBit
6803: 60 b1 00     MOVW    AX,#00B1H
6806: 3c           PUSH    AX
6807: 90 3b        CALLF   !Weird_Stack_Thing
6809: 34           POP     AX
680a: 28 d7 6d     CALL    !6DD7H
680d: 3a 86 96     MOV     0FE86H,#96H
6810: 56           RET
6811: 3f           PUSH    HL
6812: 05 c9        DECW    SP
6814: 05 c9        DECW    SP
6816: 11 fc        MOVW    AX,SP
6818: 24 68        MOVW    HL,AX
681a: 70 a1 05     BT      0FEA1H.0,$6822H
681d: 60 27 fd     MOVW    AX,#0FD27H
6820: 14 03        BR      $6825H
6822: 60 2a fd     MOVW    AX,#0FD2AH
6825: 06 a0 01     MOV     [HL+01H],A
6828: d8           XCH     A,X
6829: 55           MOV     [HL],A
682a: d8           XCH     A,X
682b: 24 48        MOVW    DE,AX
682d: 09 f0 24 fd  MOV     A,!0FD24H
6831: 0a 0f fe ff  CMP     A,-2[DE]
6835: 80 03        BNZ     $683AH
6837: 2c eb 68     BR      !68EBH
683a: 60 00 00     MOVW    AX,#0000H
683d: 3c           PUSH    AX
683e: 90 be        CALLF   Puzzle_Piece1
6840: 34           POP     AX
6841: 64 bd df     MOVW    DE,#0DFBDH
6844: 70 a1 05     BT      0FEA1H.0,$684CH
6847: 60 01 00     MOVW    AX,#0001H
684a: 14 03        BR      $684FH
684c: 60 02 00     MOVW    AX,#0002H
684f: 24 28        MOVW    BC,AX
6851: 5c           MOV     A,[DE]
6852: b8 00        MOV     X,#00H
6854: 8c 03        AND     X,B
6856: 8c 12        AND     A,C
6858: d8           XCH     A,X
6859: 2f 00 00     CMPW    AX,#0000H
685c: 80 42        BNZ     $68A0H
685e: 05 e3        MOVW    AX,[HL]
6860: 4c           DECW    AX
6861: 06 a0 01     MOV     [HL+01H],A
6864: d8           XCH     A,X
6865: 55           MOV     [HL],A
6866: d8           XCH     A,X
6867: 44           INCW    AX
6868: 3c           PUSH    AX
6869: 28 ee 68     CALL    !68EEH
686c: 34           POP     AX
686d: 05 e3        MOVW    AX,[HL]
686f: 4c           DECW    AX
6870: 06 a0 01     MOV     [HL+01H],A
6873: d8           XCH     A,X
6874: 55           MOV     [HL],A
6875: d8           XCH     A,X
6876: 44           INCW    AX
6877: 3c           PUSH    AX
6878: 28 ee 68     CALL    !68EEH
687b: 34           POP     AX
687c: 05 e3        MOVW    AX,[HL]
687e: 3c           PUSH    AX
687f: 28 ee 68     CALL    !68EEH
6882: 34           POP     AX
6883: 05 e3        MOVW    AX,[HL]
6885: 24 48        MOVW    DE,AX
6887: 5c           MOV     A,[DE]
6888: 09 f1 24 fd  MOV     !0FD24H,A
688c: 70 a1 05     BT      0FEA1H.0,$6894H
688f: 60 00 03     MOVW    AX,#0300H
6892: 14 03        BR      $6897H
6894: 60 52 00     MOVW    AX,#0052H
6897: 3c           PUSH    AX
6898: 90 98        CALLF   !Interpret_Thing
689a: 34           POP     AX
689b: 28 ae 6c     CALL    !6CAEH
689e: 14 4b        BR      $68EBH
68a0: 60 50 1b     MOVW    AX,#1B50H
68a3: 3c           PUSH    AX
68a4: 90 98        CALLF   !Interpret_Thing
68a6: 34           POP     AX
68a7: 60 94 0d     MOVW    AX,#0D94H
68aa: 3c           PUSH    AX
68ab: 28 2d 6f     CALL    !6F2DH
68ae: 34           POP     AX
68af: 3d           PUSH    BC
68b0: 90 98        CALLF   !Interpret_Thing
68b2: 34           POP     AX
68b3: 60 54 1b     MOVW    AX,#1B54H
68b6: 3c           PUSH    AX
68b7: 90 98        CALLF   !Interpret_Thing
68b9: 34           POP     AX
68ba: 60 00 89     MOVW    AX,#8900H
68bd: 3c           PUSH    AX
68be: 28 2d 6f     CALL    !6F2DH
68c1: 34           POP     AX
68c2: 3d           PUSH    BC
68c3: 90 98        CALLF   !Interpret_Thing
68c5: 34           POP     AX
68c6: 60 90 99     MOVW    AX,#9990H
68c9: 3c           PUSH    AX
68ca: 90 98        CALLF   !Interpret_Thing
68cc: 34           POP     AX
68cd: 60 c0 93     MOVW    AX,#93C0H
68d0: 3c           PUSH    AX
68d1: 28 2d 6f     CALL    !6F2DH
68d4: 34           POP     AX
68d5: 3d           PUSH    BC
68d6: 90 98        CALLF   !Interpret_Thing
68d8: 34           POP     AX
68d9: 70 a1 05     BT      0FEA1H.0,$68E1H
68dc: 60 00 03     MOVW    AX,#0300H
68df: 14 03        BR      $68E4H
68e1: 60 52 00     MOVW    AX,#0052H
68e4: 3c           PUSH    AX
68e5: 90 98        CALLF   !Interpret_Thing
68e7: 34           POP     AX
68e8: 28 d7 6d     CALL    !6DD7H
68eb: 34           POP     AX
68ec: 37           POP     HL
68ed: 56           RET
68ee: 3f           PUSH    HL
68ef: 11 fc        MOVW    AX,SP
68f1: 24 68        MOVW    HL,AX
68f3: 06 20 04     MOV     A,[HL+04H]
68f6: d8           XCH     A,X
68f7: 06 20 05     MOV     A,[HL+05H]
68fa: 24 48        MOVW    DE,AX
68fc: 5c           MOV     A,[DE]
68fd: 30 a1        SHR     A,4
68ff: b8 00        MOV     X,#00H
6901: d8           XCH     A,X
6902: 3c           PUSH    AX
6903: 90 f2        CALLF   !08F2H
6905: 34           POP     AX
6906: 06 20 04     MOV     A,[HL+04H]
6909: d8           XCH     A,X
690a: 06 20 05     MOV     A,[HL+05H]
690d: 24 48        MOVW    DE,AX
690f: 5c           MOV     A,[DE]
6910: b8 00        MOV     X,#00H
6912: d8           XCH     A,X
6913: 3c           PUSH    AX
6914: 91 0e        CALLF   !090EH
6916: 34           POP     AX
6917: 37           POP     HL
6918: 56           RET
6919: 08 a3 67 1f  BF      0FE67H.3,$693CH
691d: 20 8c        MOV     A,0FE8CH
691f: 30 a1        SHR     A,4
6921: b8 00        MOV     X,#00H
6923: d8           XCH     A,X
6924: 3c           PUSH    AX
6925: 28 8b 66     CALL    !668BH
6928: 34           POP     AX
6929: 20 8c        MOV     A,0FE8CH
692b: b8 00        MOV     X,#00H
692d: d8           XCH     A,X
692e: 3c           PUSH    AX
692f: 28 8b 66     CALL    !668BH
6932: 34           POP     AX
6933: 60 01 00     MOVW    AX,#0001H
6936: 3c           PUSH    AX
6937: 90 3b        CALLF   !Weird_Stack_Thing
6939: 34           POP     AX
693a: 14 20        BR      $695CH
693c: 20 91        MOV     A,0FE91H
693e: b8 00        MOV     X,#00H
6940: d8           XCH     A,X
6941: 3c           PUSH    AX
6942: 28 8b 66     CALL    !668BH
6945: 34           POP     AX
6946: 20 90        MOV     A,0FE90H
6948: 30 a1        SHR     A,4
694a: b8 00        MOV     X,#00H
694c: d8           XCH     A,X
694d: 3c           PUSH    AX
694e: 28 8b 66     CALL    !668BH
6951: 34           POP     AX
6952: 20 90        MOV     A,0FE90H
6954: b8 00        MOV     X,#00H
6956: d8           XCH     A,X
6957: 3c           PUSH    AX
6958: 28 8b 66     CALL    !668BH
695b: 34           POP     AX
695c: 56           RET
695d: 3f           PUSH    HL
695e: 05 c9        DECW    SP
6960: 05 c9        DECW    SP
6962: 11 fc        MOVW    AX,SP
6964: 24 68        MOVW    HL,AX
6966: 75 67 05     BT      0FE67H.5,$696EH
6969: 64 0f fd     MOVW    DE,#0FD0FH
696c: 14 03        BR      $6971H
696e: 64 ab fd     MOVW    DE,#0FDABH
6971: 24 0c        MOVW    AX,DE
6973: 06 a0 01     MOV     [HL+01H],A
6976: d8           XCH     A,X
6977: 55           MOV     [HL],A
6978: 3a 6c 00     MOV     0FE6CH,#00H
697b: 6f 6c 07     CMP     0FE6CH,#07H
697e: 82 5f        BNC     $69DFH
6980: 05 e3        MOVW    AX,[HL]
6982: 24 48        MOVW    DE,AX
6984: 5c           MOV     A,[DE]
6985: af ff        CMP     A,#0FFH
6987: 80 0e        BNZ     $6997H
6989: 08 a5 67 05  BF      0FE67H.5,$6992H
698d: 60 0a 00     MOVW    AX,#000AH
6990: 14 03        BR      $6995H
6992: 60 0b 00     MOVW    AX,#000BH
6995: 14 08        BR      $699FH
6997: 05 e3        MOVW    AX,[HL]
6999: 24 48        MOVW    DE,AX
699b: 5c           MOV     A,[DE]
699c: b8 00        MOV     X,#00H
699e: d8           XCH     A,X
699f: d0           MOV     A,X
69a0: 22 6d        MOV     0FE6DH,A
69a2: 20 6c        MOV     A,0FE6CH
69a4: ac 01        AND     A,#01H
69a6: 81 19        BZ      $69C1H
69a8: 20 6d        MOV     A,0FE6DH
69aa: b8 00        MOV     X,#00H
69ac: d8           XCH     A,X
69ad: 88 08        ADDW    AX,AX
69af: 2d 49 11     ADDW    AX,#1149H
69b2: 24 48        MOVW    DE,AX
69b4: 05 e2        MOVW    AX,[DE]
69b6: 3c           PUSH    AX
69b7: 28 2d 6f     CALL    !6F2DH
69ba: 34           POP     AX
69bb: 3d           PUSH    BC
69bc: 90 98        CALLF   !Interpret_Thing
69be: 34           POP     AX
69bf: 14 12        BR      $69D3H
69c1: 20 6d        MOV     A,0FE6DH
69c3: b8 00        MOV     X,#00H
69c5: d8           XCH     A,X
69c6: 88 08        ADDW    AX,AX
69c8: 2d 49 11     ADDW    AX,#1149H
69cb: 24 48        MOVW    DE,AX
69cd: 05 e2        MOVW    AX,[DE]
69cf: 3c           PUSH    AX
69d0: 90 98        CALLF   !Interpret_Thing
69d2: 34           POP     AX
69d3: 26 6c        INC     0FE6CH
69d5: 05 e3        MOVW    AX,[HL]
69d7: 44           INCW    AX
69d8: 06 a0 01     MOV     [HL+01H],A
69db: d8           XCH     A,X
69dc: 55           MOV     [HL],A
69dd: 14 9c        BR      $697BH
69df: 28 d7 6d     CALL    !6DD7H
69e2: 60 05 00     MOVW    AX,#0005H
69e5: 3c           PUSH    AX
69e6: 90 d8        CALLF   !08D8H
69e8: 34           POP     AX
69e9: 90 23        CALLF   !Set_HiBit
69eb: 1c 63        MOVW    AX,0FE63H
69ed: 24 48        MOVW    DE,AX
69ef: 06 00 06     MOV     A,[DE+06H]
69f2: 30 b1        SHR     A,6
69f4: ac 03        AND     A,#03H
69f6: b8 00        MOV     X,#00H
69f8: d8           XCH     A,X
69f9: 2f 01 00     CMPW    AX,#0001H
69fc: 81 11        BZ      $6A0FH
69fe: 1c 63        MOVW    AX,0FE63H
6a00: 24 48        MOVW    DE,AX
6a02: 5c           MOV     A,[DE]
6a03: 30 a1        SHR     A,4
6a05: ac 01        AND     A,#01H
6a07: b8 00        MOV     X,#00H
6a09: d8           XCH     A,X
6a0a: 2f 01 00     CMPW    AX,#0001H
6a0d: 80 05        BNZ     $6A14H
6a0f: 60 d1 00     MOVW    AX,#00D1H
6a12: 14 03        BR      $6A17H
6a14: 60 d4 00     MOVW    AX,#00D4H
6a17: b9 00        MOV     A,#00H
6a19: 3c           PUSH    AX
6a1a: 90 3b        CALLF   !Weird_Stack_Thing
6a1c: 34           POP     AX
6a1d: 34           POP     AX
6a1e: 37           POP     HL
6a1f: 56           RET
6a20: 1c ac        MOVW    AX,0FEACH
6a22: 3c           PUSH    AX
6a23: 1c 63        MOVW    AX,0FE63H
6a25: 24 48        MOVW    DE,AX
6a27: 06 00 06     MOV     A,[DE+06H]
6a2a: 30 b1        SHR     A,6
6a2c: ac 03        AND     A,#03H
6a2e: b8 00        MOV     X,#00H
6a30: d8           XCH     A,X
6a31: 2f 01 00     CMPW    AX,#0001H
6a34: 81 03        BZ      $6A39H
6a36: 2c da 6a     BR      !6ADAH
6a39: 1c 63        MOVW    AX,0FE63H
6a3b: 24 08        MOVW    AX,AX
6a3d: 2d 04 00     ADDW    AX,#0004H
6a40: 24 48        MOVW    DE,AX
6a42: 5c           MOV     A,[DE]
6a43: 30 a1        SHR     A,4
6a45: 22 ac        MOV     0FEACH,A
6a47: 6f ac 00     CMP     0FEACH,#00H
6a4a: 80 08        BNZ     $6A54H
6a4c: 8a 08        SUBW    AX,AX
6a4e: 3c           PUSH    AX
6a4f: 90 98        CALLF   !Interpret_Thing
6a51: 34           POP     AX
6a52: 14 09        BR      $6A5DH
6a54: 20 ac        MOV     A,0FEACH
6a56: b8 00        MOV     X,#00H
6a58: d8           XCH     A,X
6a59: 3c           PUSH    AX
6a5a: 90 f2        CALLF   !08F2H
6a5c: 34           POP     AX
6a5d: 1c 63        MOVW    AX,0FE63H
6a5f: 24 08        MOVW    AX,AX
6a61: 2d 04 00     ADDW    AX,#0004H
6a64: 24 48        MOVW    DE,AX
6a66: 5c           MOV     A,[DE]
6a67: b8 00        MOV     X,#00H
6a69: d8           XCH     A,X
6a6a: 3c           PUSH    AX
6a6b: 91 0e        CALLF   !090EH
6a6d: 34           POP     AX
6a6e: 1c 63        MOVW    AX,0FE63H
6a70: 24 08        MOVW    AX,AX
6a72: 2d 03 00     ADDW    AX,#0003H
6a75: 24 48        MOVW    DE,AX
6a77: 5c           MOV     A,[DE]
6a78: 30 a1        SHR     A,4
6a7a: b8 00        MOV     X,#00H
6a7c: d8           XCH     A,X
6a7d: 3c           PUSH    AX
6a7e: 90 f2        CALLF   !08F2H
6a80: 34           POP     AX
6a81: 1c 63        MOVW    AX,0FE63H
6a83: 24 08        MOVW    AX,AX
6a85: 2d 03 00     ADDW    AX,#0003H
6a88: 24 48        MOVW    DE,AX
6a8a: 5c           MOV     A,[DE]
6a8b: b8 00        MOV     X,#00H
6a8d: d8           XCH     A,X
6a8e: 3c           PUSH    AX
6a8f: 91 0e        CALLF   !090EH
6a91: 34           POP     AX
6a92: 1c 63        MOVW    AX,0FE63H
6a94: 24 08        MOVW    AX,AX
6a96: 44           INCW    AX
6a97: 44           INCW    AX
6a98: 24 48        MOVW    DE,AX
6a9a: 5c           MOV     A,[DE]
6a9b: 30 a1        SHR     A,4
6a9d: b8 00        MOV     X,#00H
6a9f: d8           XCH     A,X
6aa0: 3c           PUSH    AX
6aa1: 90 f2        CALLF   !08F2H
6aa3: 34           POP     AX
6aa4: 1c 63        MOVW    AX,0FE63H
6aa6: 24 08        MOVW    AX,AX
6aa8: 44           INCW    AX
6aa9: 44           INCW    AX
6aaa: 24 48        MOVW    DE,AX
6aac: 5c           MOV     A,[DE]
6aad: b8 00        MOV     X,#00H
6aaf: d8           XCH     A,X
6ab0: 3c           PUSH    AX
6ab1: 91 0e        CALLF   !090EH
6ab3: 34           POP     AX
6ab4: 09 f0 a3 fd  MOV     A,!0FDA3H
6ab8: af 02        CMP     A,#02H
6aba: 83 0a        BC      $6AC6H
6abc: 81 08        BZ      $6AC6H
6abe: 8a 08        SUBW    AX,AX
6ac0: 3c           PUSH    AX
6ac1: 90 98        CALLF   !Interpret_Thing
6ac3: 34           POP     AX
6ac4: 14 11        BR      $6AD7H
6ac6: 1c 63        MOVW    AX,0FE63H
6ac8: 24 08        MOVW    AX,AX
6aca: 44           INCW    AX
6acb: 24 48        MOVW    DE,AX
6acd: 5c           MOV     A,[DE]
6ace: 30 a1        SHR     A,4
6ad0: b8 00        MOV     X,#00H
6ad2: d8           XCH     A,X
6ad3: 3c           PUSH    AX
6ad4: 90 f2        CALLF   !08F2H
6ad6: 34           POP     AX
6ad7: 2c cb 6b     BR      !6BCBH
6ada: 1c 63        MOVW    AX,0FE63H
6adc: 24 08        MOVW    AX,AX
6ade: 2d 04 00     ADDW    AX,#0004H
6ae1: 24 48        MOVW    DE,AX
6ae3: 5c           MOV     A,[DE]
6ae4: ac 0f        AND     A,#0FH
6ae6: 22 ac        MOV     0FEACH,A
6ae8: 6f ac 00     CMP     0FEACH,#00H
6aeb: 80 08        BNZ     $6AF5H
6aed: 8a 08        SUBW    AX,AX
6aef: 3c           PUSH    AX
6af0: 90 98        CALLF   !Interpret_Thing
6af2: 34           POP     AX
6af3: 14 09        BR      $6AFEH
6af5: 20 ac        MOV     A,0FEACH
6af7: b8 00        MOV     X,#00H
6af9: d8           XCH     A,X
6afa: 3c           PUSH    AX
6afb: 90 f2        CALLF   !08F2H
6afd: 34           POP     AX
6afe: 1c 63        MOVW    AX,0FE63H
6b00: 24 08        MOVW    AX,AX
6b02: 2d 03 00     ADDW    AX,#0003H
6b05: 24 48        MOVW    DE,AX
6b07: 5c           MOV     A,[DE]
6b08: 30 a1        SHR     A,4
6b0a: 22 ac        MOV     0FEACH,A
6b0c: 6f ac 00     CMP     0FEACH,#00H
6b0f: 80 3c        BNZ     $6B4DH
6b11: 1c 63        MOVW    AX,0FE63H
6b13: 24 48        MOVW    DE,AX
6b15: 06 00 01     MOV     A,[DE+01H]
6b18: d8           XCH     A,X
6b19: 06 00 02     MOV     A,[DE+02H]
6b1c: 1a a4        MOVW    0FEA4H,AX
6b1e: 06 00 03     MOV     A,[DE+03H]
6b21: d8           XCH     A,X
6b22: 06 00 04     MOV     A,[DE+04H]
6b25: 1a a6        MOVW    0FEA6H,AX
6b27: 0c a8 00 00  MOVW    0FEA8H,#0000H
6b2b: 0c aa 10 00  MOVW    0FEAAH,#0010H
6b2f: 28 ea ab     CALL    Compare_32Bits
6b32: 82 19        BNC     $6B4DH
6b34: 1c 63        MOVW    AX,0FE63H
6b36: 24 48        MOVW    DE,AX
6b38: 5c           MOV     A,[DE]
6b39: 30 a1        SHR     A,4
6b3b: ac 01        AND     A,#01H
6b3d: b8 00        MOV     X,#00H
6b3f: d8           XCH     A,X
6b40: 2f 00 00     CMPW    AX,#0000H
6b43: 80 08        BNZ     $6B4DH
6b45: 8a 08        SUBW    AX,AX
6b47: 3c           PUSH    AX
6b48: 90 98        CALLF   !Interpret_Thing
6b4a: 34           POP     AX
6b4b: 14 09        BR      $6B56H
6b4d: 20 ac        MOV     A,0FEACH
6b4f: b8 00        MOV     X,#00H
6b51: d8           XCH     A,X
6b52: 3c           PUSH    AX
6b53: 91 0e        CALLF   !090EH
6b55: 34           POP     AX
6b56: 1c 63        MOVW    AX,0FE63H
6b58: 24 08        MOVW    AX,AX
6b5a: 2d 03 00     ADDW    AX,#0003H
6b5d: 24 48        MOVW    DE,AX
6b5f: 5c           MOV     A,[DE]
6b60: b8 00        MOV     X,#00H
6b62: d8           XCH     A,X
6b63: 3c           PUSH    AX
6b64: 90 f2        CALLF   !08F2H
6b66: 34           POP     AX
6b67: 1c 63        MOVW    AX,0FE63H
6b69: 24 08        MOVW    AX,AX
6b6b: 44           INCW    AX
6b6c: 44           INCW    AX
6b6d: 24 48        MOVW    DE,AX
6b6f: 5c           MOV     A,[DE]
6b70: 30 a1        SHR     A,4
6b72: b8 00        MOV     X,#00H
6b74: d8           XCH     A,X
6b75: 3c           PUSH    AX
6b76: 91 0e        CALLF   !090EH
6b78: 34           POP     AX
6b79: 1c 63        MOVW    AX,0FE63H
6b7b: 24 08        MOVW    AX,AX
6b7d: 44           INCW    AX
6b7e: 44           INCW    AX
6b7f: 24 48        MOVW    DE,AX
6b81: 5c           MOV     A,[DE]
6b82: b8 00        MOV     X,#00H
6b84: d8           XCH     A,X
6b85: 3c           PUSH    AX
6b86: 90 f2        CALLF   !08F2H
6b88: 34           POP     AX
6b89: 09 f0 a3 fd  MOV     A,!0FDA3H
6b8d: af 02        CMP     A,#02H
6b8f: 83 0a        BC      $6B9BH
6b91: 81 08        BZ      $6B9BH
6b93: 8a 08        SUBW    AX,AX
6b95: 3c           PUSH    AX
6b96: 90 98        CALLF   !Interpret_Thing
6b98: 34           POP     AX
6b99: 14 11        BR      $6BACH
6b9b: 1c 63        MOVW    AX,0FE63H
6b9d: 24 08        MOVW    AX,AX
6b9f: 44           INCW    AX
6ba0: 24 48        MOVW    DE,AX
6ba2: 5c           MOV     A,[DE]
6ba3: 30 a1        SHR     A,4
6ba5: b8 00        MOV     X,#00H
6ba7: d8           XCH     A,X
6ba8: 3c           PUSH    AX
6ba9: 91 0e        CALLF   !090EH
6bab: 34           POP     AX
6bac: 09 f0 a3 fd  MOV     A,!0FDA3H
6bb0: af 01        CMP     A,#01H
6bb2: 81 08        BZ      $6BBCH
6bb4: 8a 08        SUBW    AX,AX
6bb6: 3c           PUSH    AX
6bb7: 90 98        CALLF   !Interpret_Thing
6bb9: 34           POP     AX
6bba: 14 0f        BR      $6BCBH
6bbc: 1c 63        MOVW    AX,0FE63H
6bbe: 24 08        MOVW    AX,AX
6bc0: 44           INCW    AX
6bc1: 24 48        MOVW    DE,AX
6bc3: 5c           MOV     A,[DE]
6bc4: b8 00        MOV     X,#00H
6bc6: d8           XCH     A,X
6bc7: 3c           PUSH    AX
6bc8: 90 f2        CALLF   !08F2H
6bca: 34           POP     AX
6bcb: 28 25 6c     CALL    !6C25H
6bce: 34           POP     AX
6bcf: 1a ac        MOVW    0FEACH,AX
6bd1: 56           RET
6bd2: 60 00 00     MOVW    AX,#0000H
6bd5: 3c           PUSH    AX
6bd6: 90 be        CALLF   Puzzle_Piece1
6bd8: 34           POP     AX
6bd9: 8a 08        SUBW    AX,AX
6bdb: 3c           PUSH    AX
6bdc: 90 98        CALLF   !Interpret_Thing
6bde: 34           POP     AX
6bdf: 60 00 9b     MOVW    AX,#9B00H
6be2: 3c           PUSH    AX
6be3: 28 2d 6f     CALL    !6F2DH
6be6: 34           POP     AX
6be7: 3d           PUSH    BC
6be8: 90 98        CALLF   !Interpret_Thing
6bea: 34           POP     AX
6beb: 60 40 0a     MOVW    AX,#0A40H
6bee: 3c           PUSH    AX
6bef: 90 98        CALLF   !Interpret_Thing
6bf1: 34           POP     AX
6bf2: 60 40 0a     MOVW    AX,#0A40H
6bf5: 3c           PUSH    AX
6bf6: 28 2d 6f     CALL    !6F2DH
6bf9: 34           POP     AX
6bfa: 3d           PUSH    BC
6bfb: 90 98        CALLF   !Interpret_Thing
6bfd: 34           POP     AX
6bfe: 60 c0 8a     MOVW    AX,#8AC0H
6c01: 3c           PUSH    AX
6c02: 90 98        CALLF   !Interpret_Thing
6c04: 34           POP     AX
6c05: 60 40 0a     MOVW    AX,#0A40H
6c08: 3c           PUSH    AX
6c09: 28 2d 6f     CALL    !6F2DH
6c0c: 34           POP     AX
6c0d: 3d           PUSH    BC
6c0e: 90 98        CALLF   !Interpret_Thing
6c10: 34           POP     AX
6c11: 8a 08        SUBW    AX,AX
6c13: 3c           PUSH    AX
6c14: 90 98        CALLF   !Interpret_Thing
6c16: 34           POP     AX
6c17: 6c 06 f8     AND     P6,#0F8H
6c1a: 28 d7 6d     CALL    !6DD7H
6c1d: 3a 86 1e     MOV     0FE86H,#1EH
6c20: b2 69        SET1    0FE69H.2
6c22: b1 66        SET1    0FE66H.1
6c24: 56           RET
6c25: 60 01 00     MOVW    AX,#0001H
6c28: 3c           PUSH    AX
6c29: 90 d8        CALLF   !08D8H
6c2b: 34           POP     AX
6c2c: 08 a1 67 10  BF      0FE67H.1,$6C40H
6c30: 09 f0 0e fd  MOV     A,!0FD0EH
6c34: ac 0f        AND     A,#0FH
6c36: b8 00        MOV     X,#00H
6c38: d8           XCH     A,X
6c39: 2f 01 00     CMPW    AX,#0001H
6c3c: 80 02        BNZ     $6C40H
6c3e: 14 13        BR      $6C53H
6c40: 1c 63        MOVW    AX,0FE63H
6c42: 24 48        MOVW    DE,AX
6c44: 06 00 06     MOV     A,[DE+06H]
6c47: 30 b1        SHR     A,6
6c49: ac 03        AND     A,#03H
6c4b: b8 00        MOV     X,#00H
6c4d: d8           XCH     A,X
6c4e: 2f 01 00     CMPW    AX,#0001H
6c51: 80 19        BNZ     $6C6CH
6c53: 60 80 00     MOVW    AX,#0080H
6c56: 3c           PUSH    AX
6c57: 90 3b        CALLF   !Weird_Stack_Thing
6c59: 34           POP     AX
6c5a: 60 00 00     MOVW    AX,#0000H
6c5d: 3c           PUSH    AX
6c5e: 90 3b        CALLF   !Weird_Stack_Thing
6c60: 34           POP     AX
6c61: 90 23        CALLF   !Set_HiBit
6c63: 60 d9 00     MOVW    AX,#00D9H
6c66: 3c           PUSH    AX
6c67: 90 3b        CALLF   !Weird_Stack_Thing
6c69: 34           POP     AX
6c6a: 14 41        BR      $6CADH
6c6c: 1c 63        MOVW    AX,0FE63H
6c6e: 24 48        MOVW    DE,AX
6c70: 5c           MOV     A,[DE]
6c71: 30 a1        SHR     A,4
6c73: ac 01        AND     A,#01H
6c75: b8 00        MOV     X,#00H
6c77: d8           XCH     A,X
6c78: 2f 00 00     CMPW    AX,#0000H
6c7b: 80 19        BNZ     $6C96H
6c7d: 60 00 00     MOVW    AX,#0000H
6c80: 3c           PUSH    AX
6c81: 90 3b        CALLF   !Weird_Stack_Thing
6c83: 34           POP     AX
6c84: 60 80 00     MOVW    AX,#0080H
6c87: 3c           PUSH    AX
6c88: 90 3b        CALLF   !Weird_Stack_Thing
6c8a: 34           POP     AX
6c8b: 90 23        CALLF   !Set_HiBit
6c8d: 60 d4 00     MOVW    AX,#00D4H
6c90: 3c           PUSH    AX
6c91: 90 3b        CALLF   !Weird_Stack_Thing
6c93: 34           POP     AX
6c94: 14 17        BR      $6CADH
6c96: 60 08 00     MOVW    AX,#0008H
6c99: 3c           PUSH    AX
6c9a: 90 3b        CALLF   !Weird_Stack_Thing
6c9c: 34           POP     AX
6c9d: 60 80 00     MOVW    AX,#0080H
6ca0: 3c           PUSH    AX
6ca1: 90 3b        CALLF   !Weird_Stack_Thing
6ca3: 34           POP     AX
6ca4: 90 23        CALLF   !Set_HiBit
6ca6: 60 d1 00     MOVW    AX,#00D1H
6ca9: 3c           PUSH    AX
6caa: 90 3b        CALLF   !Weird_Stack_Thing
6cac: 34           POP     AX
6cad: 56           RET
6cae: 60 01 00     MOVW    AX,#0001H
6cb1: 3c           PUSH    AX
6cb2: 90 d8        CALLF   !08D8H
6cb4: 34           POP     AX
6cb5: 90 23        CALLF   !Set_HiBit
6cb7: 60 d2 00     MOVW    AX,#00D2H
6cba: 3c           PUSH    AX
6cbb: 90 3b        CALLF   !Weird_Stack_Thing
6cbd: 34           POP     AX
6cbe: 60 d0 00     MOVW    AX,#00D0H
6cc1: 3c           PUSH    AX
6cc2: 90 3b        CALLF   !Weird_Stack_Thing
6cc4: 34           POP     AX
6cc5: 74 67 10     BT      0FE67H.4,$6CD8H
6cc8: 60 d2 00     MOVW    AX,#00D2H
6ccb: 3c           PUSH    AX
6ccc: 90 3b        CALLF   !Weird_Stack_Thing
6cce: 34           POP     AX
6ccf: 60 d0 00     MOVW    AX,#00D0H
6cd2: 3c           PUSH    AX
6cd3: 90 3b        CALLF   !Weird_Stack_Thing
6cd5: 34           POP     AX
6cd6: 14 0e        BR      $6CE6H
6cd8: 60 d0 00     MOVW    AX,#00D0H
6cdb: 3c           PUSH    AX
6cdc: 90 3b        CALLF   !Weird_Stack_Thing
6cde: 34           POP     AX
6cdf: 60 d0 00     MOVW    AX,#00D0H
6ce2: 3c           PUSH    AX
6ce3: 90 3b        CALLF   !Weird_Stack_Thing
6ce5: 34           POP     AX
6ce6: 60 05 00     MOVW    AX,#0005H
6ce9: 3c           PUSH    AX
6cea: 90 d8        CALLF   !08D8H
6cec: 34           POP     AX
6ced: 90 23        CALLF   !Set_HiBit
6cef: 60 d0 00     MOVW    AX,#00D0H
6cf2: 3c           PUSH    AX
6cf3: 90 3b        CALLF   !Weird_Stack_Thing
6cf5: 34           POP     AX
6cf6: 56           RET
6cf7: 60 00 00     MOVW    AX,#0000H
6cfa: 3c           PUSH    AX
6cfb: 90 be        CALLF   Puzzle_Piece1
6cfd: 34           POP     AX
6cfe: 8a 08        SUBW    AX,AX
6d00: 3c           PUSH    AX
6d01: 90 98        CALLF   !Interpret_Thing
6d03: 34           POP     AX
6d04: 60 54 1b     MOVW    AX,#1B54H
6d07: 3c           PUSH    AX
6d08: 28 2d 6f     CALL    !6F2DH
6d0b: 34           POP     AX
6d0c: 3d           PUSH    BC
6d0d: 90 98        CALLF   !Interpret_Thing
6d0f: 34           POP     AX
6d10: 60 00 9b     MOVW    AX,#9B00H
6d13: 3c           PUSH    AX
6d14: 90 98        CALLF   !Interpret_Thing
6d16: 34           POP     AX
6d17: 60 01 0d     MOVW    AX,#0D01H
6d1a: 3c           PUSH    AX
6d1b: 28 2d 6f     CALL    !6F2DH
6d1e: 34           POP     AX
6d1f: 3d           PUSH    BC
6d20: 90 98        CALLF   !Interpret_Thing
6d22: 34           POP     AX
6d23: 8a 08        SUBW    AX,AX
6d25: 3c           PUSH    AX
6d26: 90 98        CALLF   !Interpret_Thing
6d28: 34           POP     AX
6d29: 60 91 9d     MOVW    AX,#9D91H
6d2c: 3c           PUSH    AX
6d2d: 28 2d 6f     CALL    !6F2DH
6d30: 34           POP     AX
6d31: 3d           PUSH    BC
6d32: 90 98        CALLF   !Interpret_Thing
6d34: 34           POP     AX
6d35: 60 c0 9b     MOVW    AX,#9BC0H
6d38: 3c           PUSH    AX
6d39: 90 98        CALLF   !Interpret_Thing
6d3b: 34           POP     AX
6d3c: 28 d7 6d     CALL    !6DD7H
6d3f: 56           RET
6d40: b1 66        SET1    0FE66H.1
6d42: 60 00 00     MOVW    AX,#0000H
6d45: 3c           PUSH    AX
6d46: 90 be        CALLF   Puzzle_Piece1
6d48: 34           POP     AX
6d49: 60 40 02     MOVW    AX,#0240H
6d4c: 3c           PUSH    AX
6d4d: 90 98        CALLF   !Interpret_Thing
6d4f: 34           POP     AX
6d50: 60 40 02     MOVW    AX,#0240H
6d53: 3c           PUSH    AX
6d54: 28 2d 6f     CALL    !6F2DH
6d57: 34           POP     AX
6d58: 3d           PUSH    BC
6d59: 90 98        CALLF   !Interpret_Thing
6d5b: 34           POP     AX
6d5c: 60 92 d0     MOVW    AX,#0D092H
6d5f: 3c           PUSH    AX
6d60: 90 98        CALLF   !Interpret_Thing
6d62: 34           POP     AX
6d63: 60 91 29     MOVW    AX,#2991H
6d66: 3c           PUSH    AX
6d67: 28 2d 6f     CALL    !6F2DH
6d6a: 34           POP     AX
6d6b: 3d           PUSH    BC
6d6c: 90 98        CALLF   !Interpret_Thing
6d6e: 34           POP     AX
6d6f: 60 d0 1b     MOVW    AX,#1BD0H
6d72: 3c           PUSH    AX
6d73: 90 98        CALLF   !Interpret_Thing
6d75: 34           POP     AX
6d76: 60 40 02     MOVW    AX,#0240H
6d79: 3c           PUSH    AX
6d7a: 28 2d 6f     CALL    !6F2DH
6d7d: 34           POP     AX
6d7e: 3d           PUSH    BC
6d7f: 90 98        CALLF   !Interpret_Thing
6d81: 34           POP     AX
6d82: 60 40 02     MOVW    AX,#0240H
6d85: 3c           PUSH    AX
6d86: 90 98        CALLF   !Interpret_Thing
6d88: 34           POP     AX
6d89: 3a 86 fa     MOV     0FE86H,#0FAH
6d8c: 28 d7 6d     CALL    !6DD7H
6d8f: 56           RET
6d90: 60 90 89     MOVW    AX,#8990H
6d93: 3c           PUSH    AX
6d94: 90 98        CALLF   !Interpret_Thing
6d96: 34           POP     AX
6d97: 60 94 29     MOVW    AX,#2994H
6d9a: 3c           PUSH    AX
6d9b: 28 2d 6f     CALL    !6F2DH
6d9e: 34           POP     AX
6d9f: 3d           PUSH    BC
6da0: 90 98        CALLF   !Interpret_Thing
6da2: 34           POP     AX
6da3: 60 00 89     MOVW    AX,#8900H
6da6: 3c           PUSH    AX
6da7: 90 98        CALLF   !Interpret_Thing
6da9: 34           POP     AX
6daa: 60 90 99     MOVW    AX,#9990H
6dad: 3c           PUSH    AX
6dae: 28 2d 6f     CALL    !6F2DH
6db1: 34           POP     AX
6db2: 3d           PUSH    BC
6db3: 90 98        CALLF   !Interpret_Thing
6db5: 34           POP     AX
6db6: 60 00 99     MOVW    AX,#9900H
6db9: 3c           PUSH    AX
6dba: 90 98        CALLF   !Interpret_Thing
6dbc: 34           POP     AX
6dbd: 60 05 0b     MOVW    AX,#0B05H
6dc0: 3c           PUSH    AX
6dc1: 28 2d 6f     CALL    !6F2DH
6dc4: 34           POP     AX
6dc5: 3d           PUSH    BC
6dc6: 90 98        CALLF   !Interpret_Thing
6dc8: 34           POP     AX
6dc9: 60 92 d0     MOVW    AX,#0D092H
6dcc: 3c           PUSH    AX
6dcd: 90 98        CALLF   !Interpret_Thing
6dcf: 34           POP     AX
6dd0: 6c 06 f8     AND     P6,#0F8H
6dd3: 28 d7 6d     CALL    !6DD7H
6dd6: 56           RET
6dd7: 60 00 00     MOVW    AX,#0000H
6dda: 3c           PUSH    AX
6ddb: 90 d8        CALLF   !08D8H
6ddd: 34           POP     AX
6dde: 90 23        CALLF   !Set_HiBit
6de0: 60 92 00     MOVW    AX,#0092H
6de3: 3c           PUSH    AX
6de4: 90 3b        CALLF   !Weird_Stack_Thing
6de6: 34           POP     AX
6de7: 90 2f        CALLF   !Clear_HiBit
6de9: 8a 08        SUBW    AX,AX
6deb: 3c           PUSH    AX
6dec: 90 98        CALLF   !Interpret_Thing
6dee: 34           POP     AX
6def: 90 23        CALLF   !Set_HiBit
6df1: 60 95 00     MOVW    AX,#0095H
6df4: 3c           PUSH    AX
6df5: 90 3b        CALLF   !Weird_Stack_Thing
6df7: 34           POP     AX
6df8: 6c 06 f8     AND     P6,#0F8H
6dfb: 56           RET
6dfc: 3f           PUSH    HL
6dfd: 05 c9        DECW    SP
6dff: 05 c9        DECW    SP
6e01: 11 fc        MOVW    AX,SP
6e03: 24 68        MOVW    HL,AX
6e05: 72 67 04     BT      0FE67H.2,$6E0CH
6e08: 08 a4 67 17  BF      0FE67H.4,$6E23H
6e0c: 20 7e        MOV     A,0FE7EH
6e0e: ac 0f        AND     A,#0FH
6e10: af 0f        CMP     A,#0FH
6e12: 80 0f        BNZ     $6E23H
6e14: 0c 6a 01 02  MOVW    0FE6AH,#0201H
6e18: 91 2f        CALLF   !092FH
6e1a: 74 67 06     BT      0FE67H.4,$6E23H
6e1d: 0c 6a 03 02  MOVW    0FE6AH,#0203H
6e21: 91 2f        CALLF   !092FH
6e23: 08 a0 66 1e  BF      0FE66H.0,$6E45H
6e27: 77 65 15     BT      0FE65H.7,$6E3FH
6e2a: 08 a5 65 17  BF      0FE65H.5,$6E45H
6e2e: 1c 63        MOVW    AX,0FE63H
6e30: 24 48        MOVW    DE,AX
6e32: 5c           MOV     A,[DE]
6e33: 30 89        SHR     A,1
6e35: ac 01        AND     A,#01H
6e37: b8 00        MOV     X,#00H
6e39: d8           XCH     A,X
6e3a: 2f 01 00     CMPW    AX,#0001H
6e3d: 80 06        BNZ     $6E45H
6e3f: 0c 6a 12 08  MOVW    0FE6AH,#0812H
6e43: 91 2f        CALLF   !092FH
6e45: 08 a4 67 20  BF      0FE67H.4,$6E69H
6e49: 08 a2 a1 05  BF      0FEA1H.2,$6E52H
6e4d: 60 14 02     MOVW    AX,#0214H
6e50: 14 03        BR      $6E55H
6e52: 60 14 04     MOVW    AX,#0414H
6e55: 1a 6a        MOVW    0FE6AH,AX
6e57: 91 2f        CALLF   !092FH
6e59: 08 a3 a1 05  BF      0FEA1H.3,$6E62H
6e5d: 60 14 08     MOVW    AX,#0814H
6e60: 14 03        BR      $6E65H
6e62: 60 14 01     MOVW    AX,#0114H
6e65: 1a 6a        MOVW    0FE6AH,AX
6e67: 91 2f        CALLF   !092FH
6e69: 28 c4 70     CALL    !70C4H
6e6c: 8a 08        SUBW    AX,AX
6e6e: 8f 0a        CMPW    AX,BC
6e70: 80 2f        BNZ     $6EA1H
6e72: 1c 63        MOVW    AX,0FE63H
6e74: 24 48        MOVW    DE,AX
6e76: 5c           MOV     A,[DE]
6e77: 30 91        SHR     A,2
6e79: ac 01        AND     A,#01H
6e7b: b8 00        MOV     X,#00H
6e7d: d8           XCH     A,X
6e7e: 2f 01 00     CMPW    AX,#0001H
6e81: 80 1e        BNZ     $6EA1H
6e83: 6f 89 00     CMP     0FE89H,#00H
6e86: 81 19        BZ      $6EA1H
6e88: 1c 63        MOVW    AX,0FE63H
6e8a: 24 48        MOVW    DE,AX
6e8c: 06 00 06     MOV     A,[DE+06H]
6e8f: 30 99        SHR     A,3
6e91: ac 07        AND     A,#07H
6e93: b8 00        MOV     X,#00H
6e95: d8           XCH     A,X
6e96: 2f 05 00     CMPW    AX,#0005H
6e99: 80 06        BNZ     $6EA1H
6e9b: 0c 6a 16 08  MOVW    0FE6AH,#0816H
6e9f: 91 2f        CALLF   !092FH
6ea1: 08 a6 65 06  BF      0FE65H.6,$6EABH
6ea5: 0c 6a 0d 02  MOVW    0FE6AH,#020DH
6ea9: 91 2f        CALLF   !092FH
6eab: 08 a3 67 06  BF      0FE67H.3,$6EB5H
6eaf: 0c 6a 0e 02  MOVW    0FE6AH,#020EH
6eb3: 91 2f        CALLF   !092FH
6eb5: 08 a2 73 06  BF      0FE73H.2,$6EBFH
6eb9: 0c 6a 0e 08  MOVW    0FE6AH,#080EH
6ebd: 91 2f        CALLF   !092FH
6ebf: 08 a5 67 67  BF      0FE67H.5,$6F2AH
6ec3: 0c 6a 13 04  MOVW    0FE6AH,#0413H
6ec7: 91 2f        CALLF   !092FH
6ec9: 09 f0 a9 fd  MOV     A,!0FDA9H
6ecd: 31 91        SHL     A,2
6ecf: b8 00        MOV     X,#00H
6ed1: d8           XCH     A,X
6ed2: 3c           PUSH    AX
6ed3: 90 be        CALLF   Puzzle_Piece1
6ed5: 34           POP     AX
6ed6: 20 7e        MOV     A,0FE7EH
6ed8: ac 10        AND     A,#10H
6eda: 80 0f        BNZ     $6EEBH
6edc: 09 f0 a9 fd  MOV     A,!0FDA9H
6ee0: b8 00        MOV     X,#00H
6ee2: d8           XCH     A,X
6ee3: 2d ab fd     ADDW    AX,#0FDABH
6ee6: 24 48        MOVW    DE,AX
6ee8: 5c           MOV     A,[DE]
6ee9: 14 02        BR      $6EEDH
6eeb: b9 0b        MOV     A,#0BH
6eed: 22 6a        MOV     0FE6AH,A
6eef: 6f 6a ff     CMP     0FE6AH,#0FFH
6ef2: 80 03        BNZ     $6EF7H
6ef4: 3a 6a 0a     MOV     0FE6AH,#0AH
6ef7: 09 f0 a9 fd  MOV     A,!0FDA9H
6efb: ac 01        AND     A,#01H
6efd: 80 14        BNZ     $6F13H
6eff: 20 6a        MOV     A,0FE6AH
6f01: b8 00        MOV     X,#00H
6f03: d8           XCH     A,X
6f04: 88 08        ADDW    AX,AX
6f06: 2d 49 11     ADDW    AX,#1149H
6f09: 24 48        MOVW    DE,AX
6f0b: 05 e2        MOVW    AX,[DE]
6f0d: 3c           PUSH    AX
6f0e: 90 98        CALLF   !Interpret_Thing
6f10: 34           POP     AX
6f11: 14 17        BR      $6F2AH
6f13: 20 6a        MOV     A,0FE6AH
6f15: b8 00        MOV     X,#00H
6f17: d8           XCH     A,X
6f18: 88 08        ADDW    AX,AX
6f1a: 2d 49 11     ADDW    AX,#1149H
6f1d: 24 48        MOVW    DE,AX
6f1f: 05 e2        MOVW    AX,[DE]
6f21: 3c           PUSH    AX
6f22: 28 2d 6f     CALL    !6F2DH
6f25: 34           POP     AX
6f26: 3d           PUSH    BC
6f27: 90 98        CALLF   !Interpret_Thing
6f29: 34           POP     AX
6f2a: 34           POP     AX
6f2b: 37           POP     HL
6f2c: 56           RET
6f2d: 3f           PUSH    HL
6f2e: 05 c9        DECW    SP
6f30: 05 c9        DECW    SP
6f32: 11 fc        MOVW    AX,SP
6f34: 24 68        MOVW    HL,AX
6f36: 06 20 06     MOV     A,[HL+06H]
6f39: d8           XCH     A,X
6f3a: 06 20 07     MOV     A,[HL+07H]
6f3d: ac 99        AND     A,#99H
6f3f: d8           XCH     A,X
6f40: ac 99        AND     A,#99H
6f42: d8           XCH     A,X
6f43: 06 a0 01     MOV     [HL+01H],A
6f46: d8           XCH     A,X
6f47: 55           MOV     [HL],A
6f48: 06 20 06     MOV     A,[HL+06H]
6f4b: d8           XCH     A,X
6f4c: 06 20 07     MOV     A,[HL+07H]
6f4f: ac 40        AND     A,#40H
6f51: d8           XCH     A,X
6f52: ac 00        AND     A,#00H
6f54: d8           XCH     A,X
6f55: 2f 00 00     CMPW    AX,#0000H
6f58: 81 09        BZ      $6F63H
6f5a: 05 e3        MOVW    AX,[HL]
6f5c: ae 20        OR      A,#20H
6f5e: 06 a0 01     MOV     [HL+01H],A
6f61: d8           XCH     A,X
6f62: 55           MOV     [HL],A
6f63: 06 20 06     MOV     A,[HL+06H]
6f66: d8           XCH     A,X
6f67: 06 20 07     MOV     A,[HL+07H]
6f6a: ac 20        AND     A,#20H
6f6c: d8           XCH     A,X
6f6d: ac 00        AND     A,#00H
6f6f: d8           XCH     A,X
6f70: 2f 00 00     CMPW    AX,#0000H
6f73: 81 09        BZ      $6F7EH
6f75: 05 e3        MOVW    AX,[HL]
6f77: ae 40        OR      A,#40H
6f79: 06 a0 01     MOV     [HL+01H],A
6f7c: d8           XCH     A,X
6f7d: 55           MOV     [HL],A
6f7e: 06 20 06     MOV     A,[HL+06H]
6f81: d8           XCH     A,X
6f82: 06 20 07     MOV     A,[HL+07H]
6f85: ac 04        AND     A,#04H
6f87: d8           XCH     A,X
6f88: ac 00        AND     A,#00H
6f8a: d8           XCH     A,X
6f8b: 2f 00 00     CMPW    AX,#0000H
6f8e: 81 09        BZ      $6F99H
6f90: 05 e3        MOVW    AX,[HL]
6f92: ae 02        OR      A,#02H
6f94: 06 a0 01     MOV     [HL+01H],A
6f97: d8           XCH     A,X
6f98: 55           MOV     [HL],A
6f99: 06 20 06     MOV     A,[HL+06H]
6f9c: d8           XCH     A,X
6f9d: 06 20 07     MOV     A,[HL+07H]
6fa0: ac 02        AND     A,#02H
6fa2: d8           XCH     A,X
6fa3: ac 00        AND     A,#00H
6fa5: d8           XCH     A,X
6fa6: 2f 00 00     CMPW    AX,#0000H
6fa9: 81 09        BZ      $6FB4H
6fab: 05 e3        MOVW    AX,[HL]
6fad: ae 04        OR      A,#04H
6faf: 06 a0 01     MOV     [HL+01H],A
6fb2: d8           XCH     A,X
6fb3: 55           MOV     [HL],A
6fb4: 06 20 06     MOV     A,[HL+06H]
6fb7: d8           XCH     A,X
6fb8: 06 20 07     MOV     A,[HL+07H]
6fbb: ac 00        AND     A,#00H
6fbd: d8           XCH     A,X
6fbe: ac 40        AND     A,#40H
6fc0: d8           XCH     A,X
6fc1: 2f 00 00     CMPW    AX,#0000H
6fc4: 81 0b        BZ      $6FD1H
6fc6: 05 e3        MOVW    AX,[HL]
6fc8: d8           XCH     A,X
6fc9: ae 20        OR      A,#20H
6fcb: d8           XCH     A,X
6fcc: 06 a0 01     MOV     [HL+01H],A
6fcf: d8           XCH     A,X
6fd0: 55           MOV     [HL],A
6fd1: 06 20 06     MOV     A,[HL+06H]
6fd4: d8           XCH     A,X
6fd5: 06 20 07     MOV     A,[HL+07H]
6fd8: ac 00        AND     A,#00H
6fda: d8           XCH     A,X
6fdb: ac 20        AND     A,#20H
6fdd: d8           XCH     A,X
6fde: 2f 00 00     CMPW    AX,#0000H
6fe1: 81 0b        BZ      $6FEEH
6fe3: 05 e3        MOVW    AX,[HL]
6fe5: d8           XCH     A,X
6fe6: ae 40        OR      A,#40H
6fe8: d8           XCH     A,X
6fe9: 06 a0 01     MOV     [HL+01H],A
6fec: d8           XCH     A,X
6fed: 55           MOV     [HL],A
6fee: 06 20 06     MOV     A,[HL+06H]
6ff1: d8           XCH     A,X
6ff2: 06 20 07     MOV     A,[HL+07H]
6ff5: ac 00        AND     A,#00H
6ff7: d8           XCH     A,X
6ff8: ac 04        AND     A,#04H
6ffa: d8           XCH     A,X
6ffb: 2f 00 00     CMPW    AX,#0000H
6ffe: 81 0b        BZ      $700BH
7000: 05 e3        MOVW    AX,[HL]
7002: d8           XCH     A,X
7003: ae 02        OR      A,#02H
7005: d8           XCH     A,X
7006: 06 a0 01     MOV     [HL+01H],A
7009: d8           XCH     A,X
700a: 55           MOV     [HL],A
700b: 06 20 06     MOV     A,[HL+06H]
700e: d8           XCH     A,X
700f: 06 20 07     MOV     A,[HL+07H]
7012: ac 00        AND     A,#00H
7014: d8           XCH     A,X
7015: ac 02        AND     A,#02H
7017: d8           XCH     A,X
7018: 2f 00 00     CMPW    AX,#0000H
701b: 81 0b        BZ      $7028H
701d: 05 e3        MOVW    AX,[HL]
701f: d8           XCH     A,X
7020: ae 04        OR      A,#04H
7022: d8           XCH     A,X
7023: 06 a0 01     MOV     [HL+01H],A
7026: d8           XCH     A,X
7027: 55           MOV     [HL],A
7028: 05 e3        MOVW    AX,[HL]
702a: 24 28        MOVW    BC,AX
702c: 34           POP     AX
702d: 37           POP     HL
702e: 56           RET
702f: 60 00 99     MOVW    AX,#9900H
7032: 3c           PUSH    AX
7033: 90 98        CALLF   !Interpret_Thing
7035: 34           POP     AX
7036: 60 02 d0     MOVW    AX,#0D002H
7039: 3c           PUSH    AX
703a: 28 2d 6f     CALL    !6F2DH
703d: 34           POP     AX
703e: 3d           PUSH    BC
703f: 90 98        CALLF   !Interpret_Thing
7041: 34           POP     AX
7042: 60 40 82     MOVW    AX,#8240H
7045: 3c           PUSH    AX
7046: 90 98        CALLF   !Interpret_Thing
7048: 34           POP     AX
7049: 60 54 1b     MOVW    AX,#1B54H
704c: 3c           PUSH    AX
704d: 28 2d 6f     CALL    !6F2DH
7050: 34           POP     AX
7051: 3d           PUSH    BC
7052: 90 98        CALLF   !Interpret_Thing
7054: 34           POP     AX
7055: 60 d0 9b     MOVW    AX,#9BD0H
7058: 3c           PUSH    AX
7059: 90 98        CALLF   !Interpret_Thing
705b: 34           POP     AX
705c: 08 a0 72 04  BF      0FE72H.0,$7064H
7060: 8a 08        SUBW    AX,AX
7062: 14 03        BR      $7067H
7064: 60 d0 1b     MOVW    AX,#1BD0H
7067: 3c           PUSH    AX
7068: 28 2d 6f     CALL    !6F2DH
706b: 34           POP     AX
706c: 3d           PUSH    BC
706d: 90 98        CALLF   !Interpret_Thing
706f: 34           POP     AX
7070: 8a 08        SUBW    AX,AX
7072: 3c           PUSH    AX
7073: 90 98        CALLF   !Interpret_Thing
7075: 34           POP     AX
7076: 6c 06 f8     AND     P6,#0F8H
7079: 28 d7 6d     CALL    !6DD7H
707c: 56           RET
707d: 60 91 29     MOVW    AX,#2991H
7080: 3c           PUSH    AX
7081: 90 98        CALLF   !Interpret_Thing
7083: 34           POP     AX
7084: 60 00 9b     MOVW    AX,#9B00H
7087: 3c           PUSH    AX
7088: 28 2d 6f     CALL    !6F2DH
708b: 34           POP     AX
708c: 3d           PUSH    BC
708d: 90 98        CALLF   !Interpret_Thing
708f: 34           POP     AX
7090: 60 91 29     MOVW    AX,#2991H
7093: 3c           PUSH    AX
7094: 90 98        CALLF   !Interpret_Thing
7096: 34           POP     AX
7097: 60 c0 93     MOVW    AX,#93C0H
709a: 3c           PUSH    AX
709b: 28 2d 6f     CALL    !6F2DH
709e: 34           POP     AX
709f: 3d           PUSH    BC
70a0: 90 98        CALLF   !Interpret_Thing
70a2: 34           POP     AX
70a3: 60 00 99     MOVW    AX,#9900H
70a6: 3c           PUSH    AX
70a7: 90 98        CALLF   !Interpret_Thing
70a9: 34           POP     AX
70aa: 60 d0 1b     MOVW    AX,#1BD0H
70ad: 3c           PUSH    AX
70ae: 28 2d 6f     CALL    !6F2DH
70b1: 34           POP     AX
70b2: 3d           PUSH    BC
70b3: 90 98        CALLF   !Interpret_Thing
70b5: 34           POP     AX
70b6: 60 94 29     MOVW    AX,#2994H
70b9: 3c           PUSH    AX
70ba: 90 98        CALLF   !Interpret_Thing
70bc: 34           POP     AX
70bd: 6c 06 f8     AND     P6,#0F8H
70c0: 28 d7 6d     CALL    !6DD7H
70c3: 56           RET
70c4: 08 a6 65 1d  BF      0FE65H.6,$70E5H
70c8: 09 f0 97 fd  MOV     A,!0FD97H
70cc: ac 06        AND     A,#06H
70ce: 81 15        BZ      $70E5H
70d0: 09 f0 98 fd  MOV     A,!0FD98H
70d4: 30 a9        SHR     A,5
70d6: ac 01        AND     A,#01H
70d8: b8 00        MOV     X,#00H
70da: d8           XCH     A,X
70db: 2f 01 00     CMPW    AX,#0001H
70de: 80 05        BNZ     $70E5H
70e0: 62 01 00     MOVW    BC,#0001H
70e3: 14 03        BR      $70E8H
70e5: 62 00 00     MOVW    BC,#0000H
70e8: 56           RET
Init_Step1:
70e9: 3a 06 00     MOV     P6,#00H
70ec: 3a 03 00     MOV     P3,#00H
70ef: 3a 00 10     MOV     P0,#10H
70f2: 0b e4 ff ff  MOVW    MK0,#0FFFFH
70f6: 2b 20 00     MOV     PM0,#00H
70f9: 3a 0c 00     MOV     RTPC,#00H
70fc: 2b c4 07     MOV     MM,#07H
70ff: 2b f5 00     MOV     INTM1,#00H
7102: 2b f4 00     MOV     INTM0,#00H
7105: 2b 40 08     MOV     PUO,#08H
7108: 2b 23 05     MOV     PM3,#05H
710b: 2b 43 43     MOV     PMC3,#43H
710e: 2b 26 00     MOV     PM6,#00H
7111: 0b ec 00 00  MOVW    ISM0,#0000H
7115: 0b e8 00 00  MOVW    PR0,#0000H
7119: 0c 12 be 1c  MOVW    CR01,#1CBEH
711d: 2b 30 18     MOV     CRC0,#18H
7120: 2b 32 0c     MOV     CRC1,#0CH
7123: 2b 34 18     MOV     CRC2,#18H
7126: 3a 15 00     MOV     CR20,#00H
7129: 2b 31 20     MOV     TOC,#20H
712c: 2b 5d 08     MOV     TMC0,#08H
712f: 2b 5f 08     MOV     TMC1,#08H
7132: 2b 5e 37     MOV     PRM1,#37H
7135: 2b 90 99     MOV     BRGC,#99H
7138: 2b 68 95     MOV     ADM,#95H
713b: 64 d0 ff     MOVW    DE,#0FFD0H
713e: b9 00        MOV     A,#00H
7140: 54           MOV     [DE],A
7141: 64 d1 ff     MOVW    DE,#0FFD1H
7144: b9 00        MOV     A,#00H
7146: 54           MOV     [DE],A
7147: 64 d2 ff     MOVW    DE,#0FFD2H
714a: b9 00        MOV     A,#00H
714c: 54           MOV     [DE],A
714d: 64 d3 ff     MOVW    DE,#0FFD3H
7150: b9 00        MOV     A,#00H
7152: 54           MOV     [DE],A
7153: 64 d4 ff     MOVW    DE,#0FFD4H
7156: b9 00        MOV     A,#00H
7158: 54           MOV     [DE],A
7159: 09 f1 2f fd  MOV     !0FD2FH,A
715d: 56           RET
Init_Step2:
715e: 6c 06 f7     AND     P6,#0F7H
7161: 28 70 76     CALL    Setup_Timers
7164: 3a 75 00     MOV     Wheel_Count,#00H
7167: b9 00        MOV     A,#00H
7169: 09 f1 0a fd  MOV     !0FD0AH,A
716d: 22 88        MOV     0FE88H,A
716f: 22 87        MOV     0FE87H,A
7171: 22 85        MOV     0FE85H,A
7173: 22 86        MOV     0FE86H,A
7175: 22 84        MOV     0FE84H,A
7177: b8 00        MOV     X,#00H
7179: d8           XCH     A,X
717a: 1a 80        MOVW    0FE80H,AX
717c: d0           MOV     A,X
717d: 22 7f        MOV     0FE7FH,A
717f: 22 67        MOV     0FE67H,A
7181: 22 69        MOV     0FE69H,A
7183: 22 68        MOV     0FE68H,A
7185: 20 77        MOV     A,0FE77H
7187: ac f0        AND     A,#0F0H
7189: 22 77        MOV     0FE77H,A
718b: 20 76        MOV     A,0FE76H
718d: ac f8        AND     A,#0F8H
718f: 22 76        MOV     0FE76H,A
7191: ac c7        AND     A,#0C7H
7193: 22 76        MOV     0FE76H,A
7195: 09 f0 30 fd  MOV     A,!0FD30H
7199: 03 98        CLR1    A.0
719b: 09 f1 30 fd  MOV     !0FD30H,A
719f: 03 99        CLR1    A.1
71a1: 09 f1 30 fd  MOV     !0FD30H,A
71a5: 03 9c        CLR1    A.4
71a7: 09 f1 30 fd  MOV     !0FD30H,A
71ab: 09 f0 0d fd  MOV     A,!0FD0DH
71af: ac f0        AND     A,#0F0H
71b1: ae 0f        OR      A,#0FH
71b3: 09 f1 0d fd  MOV     !0FD0DH,A
71b7: b9 00        MOV     A,#00H
71b9: 09 f1 94 fd  MOV     !0FD94H,A
71bd: 09 f1 93 fd  MOV     !0FD93H,A
71c1: 09 f1 92 fd  MOV     !0FD92H,A
71c5: 09 f1 91 fd  MOV     !0FD91H,A
71c9: b9 00        MOV     A,#00H
71cb: 09 f1 a8 fd  MOV     !0FDA8H,A
71cf: 22 8a        MOV     0FE8AH,A
71d1: 22 7d        MOV     0FE7DH,A
71d3: 60 ff 00     MOVW    AX,#00FFH
71d6: 3c           PUSH    AX
71d7: 28 43 8b     CALL    !8B43H
71da: 34           POP     AX
71db: 28 ce 7a     CALL    Query_DFBE
71de: 64 c0 df     MOVW    DE,#0DFC0H
71e1: 5c           MOV     A,[DE]
71e2: ac 01        AND     A,#01H
71e4: af 01        CMP     A,#01H
71e6: 81 08        BZ      $71F0H
71e8: 64 be df     MOVW    DE,#0DFBEH
71eb: 5c           MOV     A,[DE]
71ec: af 55        CMP     A,#55H
71ee: 81 05        BZ      $71F5H
71f0: 28 91 72     CALL    !7291H
71f3: 14 03        BR      $71F8H
71f5: 28 af 74     CALL    !74AFH
71f8: 08 a0 72 05  BF      0FE72H.0,$7201H
71fc: 60 f1 00     MOVW    AX,#00F1H
71ff: 14 03        BR      $7204H
7201: 60 c9 00     MOVW    AX,#00C9H
7204: d0           MOV     A,X
7205: 12 88        MOV     ASIM,A
7207: b3 69        SET1    0FE69H.3
7209: b6 72        SET1    0FE72H.6
720b: 28 16 20     CALL    !2016H
720e: 28 93 84     CALL    !8493H
7211: 28 8e 60     CALL    !608EH
7214: 3a 86 05     MOV     0FE86H,#05H
7217: b9 ff        MOV     A,#0FFH
7219: 09 f1 0f fd  MOV     !0FD0FH,A
721d: 08 a5 65 38  BF      0FE65H.5,$7259H
7221: 09 f0 90 fe  MOV     A,!0FE90H
7225: d8           XCH     A,X
7226: 09 f0 91 fe  MOV     A,!0FE91H
722a: 3c           PUSH    AX
722b: 28 e8 7d     CALL    !7DE8H
722e: 34           POP     AX
722f: 68 6a 07     ADD     0FE6AH,#07H
7232: 69 6b 00     ADDC    0FE6BH,#00H
7235: 3a 6c 00     MOV     0FE6CH,#00H
7238: 6f 6c 07     CMP     0FE6CH,#07H
723b: 82 1c        BNC     $7259H
723d: 1c 6a        MOVW    AX,0FE6AH
723f: 44           INCW    AX
7240: 1a 6a        MOVW    0FE6AH,AX
7242: 4c           DECW    AX
7243: 24 48        MOVW    DE,AX
7245: 5c           MOV     A,[DE]
7246: d8           XCH     A,X
7247: 20 6c        MOV     A,0FE6CH
7249: 24 20        MOV     C,X
724b: b8 00        MOV     X,#00H
724d: d8           XCH     A,X
724e: 2d 0f fd     ADDW    AX,#0FD0FH
7251: 24 48        MOVW    DE,AX
7253: d2           MOV     A,C
7254: 54           MOV     [DE],A
7255: 26 6c        INC     0FE6CH
7257: 14 df        BR      $7238H
7259: 1c 63        MOVW    AX,0FE63H
725b: 24 48        MOVW    DE,AX
725d: 06 00 06     MOV     A,[DE+06H]
7260: 30 99        SHR     A,3
7262: ac 07        AND     A,#07H
7264: b8 00        MOV     X,#00H
7266: d8           XCH     A,X
7267: 62 b0 df     MOVW    BC,#0DFB0H
726a: 88 0a        ADDW    AX,BC
726c: 3c           PUSH    AX
726d: 28 2b 7c     CALL    !7C2BH
7270: 34           POP     AX
7271: d2           MOV     A,C
7272: 09 f1 0b fd  MOV     !0FD0BH,A
7276: 64 98 fd     MOVW    DE,#0FD98H
7279: 5c           MOV     A,[DE]
727a: ac f0        AND     A,#0F0H
727c: 54           MOV     [DE],A
727d: 03 8c        SET1    A.4
727f: 09 f1 98 fd  MOV     !0FD98H,A
7283: a6 65        CLR1    0FE65H.6
7285: 28 2b 92     CALL    !922BH
7288: 60 6d b5     MOVW    AX,#0B56DH
728b: 64 b4 fd     MOVW    DE,@NMI_FLAG_WORD
728e: 05 e6        MOVW    [DE],AX
7290: 56           RET
7291: 28 4a 7c     CALL    !7C4AH
7294: 3a 55 00     MOV     0FE55H,#00H
7297: 3a 59 01     MOV     0FE59H,#01H
729a: 3a 58 00     MOV     0FE58H,#00H
729d: 3a 57 00     MOV     0FE57H,#00H
72a0: 3a 56 00     MOV     0FE56H,#00H
72a3: 3a 5a 30     MOV     0FE5AH,#30H
72a6: 3a 5b 2c     MOV     0FE5BH,#2CH
72a9: 3a 5c 00     MOV     0FE5CH,#00H
72ac: 3a 60 02     MOV     0FE60H,#02H
72af: 3a 5f 70     MOV     0FE5FH,#70H
72b2: 3a 5e 00     MOV     0FE5EH,#00H
72b5: 3a 5d 00     MOV     0FE5DH,#00H
72b8: 3a 61 30     MOV     0FE61H,#30H
72bb: 3a 62 2c     MOV     0FE62H,#2CH
72be: 64 b6 df     MOVW    DE,#0DFB6H
72c1: 3e           PUSH    DE
72c2: 60 10 00     MOVW    AX,#0010H
72c5: 3c           PUSH    AX
72c6: 28 18 7b     CALL    !7B18H
72c9: 34           POP     AX
72ca: 34           POP     AX
72cb: 60 ba df     MOVW    AX,#0DFBAH
72ce: 3c           PUSH    AX
72cf: 60 03 00     MOVW    AX,#0003H
72d2: 3c           PUSH    AX
72d3: 28 18 7b     CALL    !7B18H
72d6: 34           POP     AX
72d7: 34           POP     AX
72d8: 60 b9 df     MOVW    AX,#0DFB9H
72db: 3c           PUSH    AX
72dc: 60 50 00     MOVW    AX,#0050H
72df: 3c           PUSH    AX
72e0: 28 18 7b     CALL    !7B18H
72e3: 34           POP     AX
72e4: 34           POP     AX
72e5: 60 b8 df     MOVW    AX,#0DFB8H
72e8: 3c           PUSH    AX
72e9: 60 00 00     MOVW    AX,#0000H
72ec: 3c           PUSH    AX
72ed: 28 18 7b     CALL    !7B18H
72f0: 34           POP     AX
72f1: 34           POP     AX
72f2: 60 b6 df     MOVW    AX,#0DFB6H
72f5: 44           INCW    AX
72f6: 3c           PUSH    AX
72f7: 60 00 00     MOVW    AX,#0000H
72fa: 3c           PUSH    AX
72fb: 28 18 7b     CALL    !7B18H
72fe: 34           POP     AX
72ff: 34           POP     AX
7300: 60 bb df     MOVW    AX,#0DFBBH
7303: 3c           PUSH    AX
7304: 60 00 00     MOVW    AX,#0000H
7307: 3c           PUSH    AX
7308: 28 18 7b     CALL    !7B18H
730b: 34           POP     AX
730c: 34           POP     AX
730d: 60 bc df     MOVW    AX,#0DFBCH
7310: 3c           PUSH    AX
7311: 60 e4 00     MOVW    AX,#00E4H
7314: 3c           PUSH    AX
7315: 28 18 7b     CALL    !7B18H
7318: 34           POP     AX
7319: 34           POP     AX
731a: 60 0b 00     MOVW    AX,#000BH
731d: 3c           PUSH    AX
731e: 28 6d 8b     CALL    Delay_Loop
7321: 34           POP     AX
7322: 28 ce 7a     CALL    Query_DFBE
7325: b9 03        MOV     A,#03H
7327: 09 f1 09 fd  MOV     !0FD09H,A
732b: b9 00        MOV     A,#00H
732d: 09 f1 08 fd  MOV     !0FD08H,A
7331: b9 00        MOV     A,#00H
7333: 09 f1 07 fd  MOV     !0FD07H,A
7337: b9 00        MOV     A,#00H
7339: 09 f1 06 fd  MOV     !0FD06H,A
733d: b9 00        MOV     A,#00H
733f: 09 f1 05 fd  MOV     !0FD05H,A
7343: b9 01        MOV     A,#01H
7345: 09 f1 04 fd  MOV     !0FD04H,A
7349: b9 00        MOV     A,#00H
734b: 09 f1 03 fd  MOV     !0FD03H,A
734f: b9 00        MOV     A,#00H
7351: 09 f1 02 fd  MOV     !0FD02H,A
7355: b9 48        MOV     A,#48H
7357: 09 f1 97 fd  MOV     !0FD97H,A
735b: b9 03        MOV     A,#03H
735d: 09 f1 a4 fd  MOV     !0FDA4H,A
7361: 60 01 00     MOVW    AX,#0001H
7364: 3c           PUSH    AX
7365: 28 43 8b     CALL    !8B43H
7368: 34           POP     AX
7369: 28 ce 7a     CALL    Query_DFBE
736c: 64 55 d5     MOVW    DE,#0D555H
736f: b9 aa        MOV     A,#0AAH
7371: 54           MOV     [DE],A
7372: 64 aa ca     MOVW    DE,#0CAAAH
7375: b9 55        MOV     A,#55H
7377: 54           MOV     [DE],A
7378: 64 55 d5     MOVW    DE,#0D555H
737b: b9 a0        MOV     A,#0A0H
737d: 54           MOV     [DE],A
737e: 64 a0 df     MOVW    DE,#0DFA0H
7381: b9 00        MOV     A,#00H
7383: 54           MOV     [DE],A
7384: 60 01 00     MOVW    AX,#0001H
7387: 3c           PUSH    AX
7388: 28 43 8b     CALL    !8B43H
738b: 34           POP     AX
738c: 28 ce 7a     CALL    Query_DFBE
738f: 64 55 d5     MOVW    DE,#0D555H
7392: b9 aa        MOV     A,#0AAH
7394: 54           MOV     [DE],A
7395: 64 aa ca     MOVW    DE,#0CAAAH
7398: b9 55        MOV     A,#55H
739a: 54           MOV     [DE],A
739b: 64 55 d5     MOVW    DE,#0D555H
739e: b9 a0        MOV     A,#0A0H
73a0: 54           MOV     [DE],A
73a1: 64 e0 df     MOVW    DE,#0DFE0H
73a4: b9 e0        MOV     A,#0E0H
73a6: 54           MOV     [DE],A
73a7: 64 e1 df     MOVW    DE,#0DFE1H
73aa: b9 02        MOV     A,#02H
73ac: 54           MOV     [DE],A
73ad: 64 e4 df     MOVW    DE,#0DFE4H
73b0: b9 f9        MOV     A,#0F9H
73b2: 54           MOV     [DE],A
73b3: 62 de df     MOVW    BC,#0DFDEH
73b6: dc           XCH     A,E
73b7: 24 0a        MOVW    AX,BC
73b9: 2d 04 00     ADDW    AX,#0004H
73bc: 24 24        MOV     C,E
73be: 24 48        MOVW    DE,AX
73c0: d2           MOV     A,C
73c1: 54           MOV     [DE],A
73c2: 64 e6 df     MOVW    DE,#0DFE6H
73c5: b9 fa        MOV     A,#0FAH
73c7: 54           MOV     [DE],A
73c8: 62 de df     MOVW    BC,#0DFDEH
73cb: dc           XCH     A,E
73cc: 24 0a        MOVW    AX,BC
73ce: 2d 0a 00     ADDW    AX,#000AH
73d1: 24 24        MOV     C,E
73d3: 24 48        MOVW    DE,AX
73d5: d2           MOV     A,C
73d6: 54           MOV     [DE],A
73d7: 64 e7 df     MOVW    DE,#0DFE7H
73da: b9 01        MOV     A,#01H
73dc: 54           MOV     [DE],A
73dd: 62 de df     MOVW    BC,#0DFDEH
73e0: dc           XCH     A,E
73e1: 24 0a        MOVW    AX,BC
73e3: 2d 0b 00     ADDW    AX,#000BH
73e6: 24 24        MOV     C,E
73e8: 24 48        MOVW    DE,AX
73ea: d2           MOV     A,C
73eb: 54           MOV     [DE],A
73ec: 62 de df     MOVW    BC,#0DFDEH
73ef: dc           XCH     A,E
73f0: 24 0a        MOVW    AX,BC
73f2: 2d 07 00     ADDW    AX,#0007H
73f5: 24 24        MOV     C,E
73f7: 24 48        MOVW    DE,AX
73f9: d2           MOV     A,C
73fa: 54           MOV     [DE],A
73fb: 62 de df     MOVW    BC,#0DFDEH
73fe: dc           XCH     A,E
73ff: 24 0a        MOVW    AX,BC
7401: 2d 05 00     ADDW    AX,#0005H
7404: 24 24        MOV     C,E
7406: 24 48        MOVW    DE,AX
7408: d2           MOV     A,C
7409: 54           MOV     [DE],A
740a: 60 01 00     MOVW    AX,#0001H
740d: 3c           PUSH    AX
740e: 28 43 8b     CALL    !8B43H
7411: 34           POP     AX
7412: 28 ce 7a     CALL    Query_DFBE
7415: 64 55 d5     MOVW    DE,#0D555H
7418: b9 aa        MOV     A,#0AAH
741a: 54           MOV     [DE],A
741b: 64 aa ca     MOVW    DE,#0CAAAH
741e: b9 55        MOV     A,#55H
7420: 54           MOV     [DE],A
7421: 64 55 d5     MOVW    DE,#0D555H
7424: b9 a0        MOV     A,#0A0H
7426: 54           MOV     [DE],A
7427: 64 de df     MOVW    DE,#0DFDEH
742a: b9 fc        MOV     A,#0FCH
742c: 54           MOV     [DE],A
742d: 60 de df     MOVW    AX,#0DFDEH
7430: 44           INCW    AX
7431: 24 48        MOVW    DE,AX
7433: b9 02        MOV     A,#02H
7435: 54           MOV     [DE],A
7436: 0c 63 55 fe  MOVW    0FE63H,#0FE55H
743a: 60 01 00     MOVW    AX,#0001H
743d: 3c           PUSH    AX
743e: 28 43 8b     CALL    !8B43H
7441: 34           POP     AX
7442: 28 ce 7a     CALL    Query_DFBE
7445: 64 55 d5     MOVW    DE,#0D555H
7448: b9 aa        MOV     A,#0AAH
744a: 54           MOV     [DE],A
744b: 64 aa ca     MOVW    DE,#0CAAAH
744e: b9 55        MOV     A,#55H
7450: 54           MOV     [DE],A
7451: 64 55 d5     MOVW    DE,#0D555H
7454: b9 a0        MOV     A,#0A0H
7456: 54           MOV     [DE],A
7457: 64 c7 df     MOVW    DE,#0DFC7H
745a: 1c 63        MOVW    AX,0FE63H
745c: 05 e6        MOVW    [DE],AX
745e: 3a 65 02     MOV     0FE65H,#02H
7461: 3a 66 3c     MOV     0FE66H,#3CH
7464: 3a 72 00     MOV     0FE72H,#00H
7467: 3a 73 40     MOV     0FE73H,#40H
746a: 3a a1 0c     MOV     0FEA1H,#0CH
746d: b9 03        MOV     A,#03H
746f: 09 f1 a3 fd  MOV     !0FDA3H,A
7473: 60 0b 00     MOVW    AX,#000BH
7476: 3c           PUSH    AX
7477: 28 6d 8b     CALL    Delay_Loop
747a: 34           POP     AX
747b: 28 ce 7a     CALL    Query_DFBE
747e: 64 d7 df     MOVW    DE,#0DFD7H
7481: 05 e2        MOVW    AX,[DE]
7483: 1a 90        MOVW    0FE90H,AX
7485: 28 f0 8c     CALL    !8CF0H
7488: 8a 08        SUBW    AX,AX
748a: 8f 0a        CMPW    AX,BC
748c: 80 04        BNZ     $7492H
748e: 0c 90 ab 0b  MOVW    0FE90H,#0BABH
7492: 28 b4 5b     CALL    !5BB4H
7495: 3a 6a 00     MOV     0FE6AH,#00H
7498: 6f 6a 0a     CMP     0FE6AH,#0AH
749b: 82 11        BNC     $74AEH
749d: 20 6a        MOV     A,0FE6AH
749f: b8 00        MOV     X,#00H
74a1: d8           XCH     A,X
74a2: 2d 99 fd     ADDW    AX,#0FD99H
74a5: 24 48        MOVW    DE,AX
74a7: b9 aa        MOV     A,#0AAH
74a9: 54           MOV     [DE],A
74aa: 26 6a        INC     0FE6AH
74ac: 14 ea        BR      $7498H
74ae: 56           RET
74af: 60 0b 00     MOVW    AX,#000BH
74b2: 3c           PUSH    AX
74b3: 28 6d 8b     CALL    Delay_Loop
74b6: 34           POP     AX
74b7: 28 ce 7a     CALL    Query_DFBE
74ba: 60 c0 df     MOVW    AX,#0DFC0H
74bd: 3f           PUSH    HL
74be: 24 48        MOVW    DE,AX
74c0: 66 55 fe     MOVW    HL,#0FE55H
74c3: ba 07        MOV     C,#07H
74c5: 58           MOV     A,[DE+]
74c6: 51           MOV     [HL+],A
74c7: 32 fc        DBNZ    C,$74C5H
74c9: 37           POP     HL
74ca: 64 c7 df     MOVW    DE,#0DFC7H
74cd: 05 e2        MOVW    AX,[DE]
74cf: 1a 63        MOVW    0FE63H,AX
74d1: 60 c9 df     MOVW    AX,#0DFC9H
74d4: 3f           PUSH    HL
74d5: 24 48        MOVW    DE,AX
74d7: 66 5c fe     MOVW    HL,#0FE5CH
74da: ba 07        MOV     C,#07H
74dc: 58           MOV     A,[DE+]
74dd: 51           MOV     [HL+],A
74de: 32 fc        DBNZ    C,$74DCH
74e0: 37           POP     HL
74e1: 64 d0 df     MOVW    DE,#0DFD0H
74e4: 5c           MOV     A,[DE]
74e5: ac 3f        AND     A,#3FH
74e7: 22 65        MOV     0FE65H,A
74e9: 64 d1 df     MOVW    DE,#0DFD1H
74ec: 5c           MOV     A,[DE]
74ed: ac 3d        AND     A,#3DH
74ef: 22 66        MOV     0FE66H,A
74f1: 64 d2 df     MOVW    DE,#0DFD2H
74f4: 5c           MOV     A,[DE]
74f5: ac 4d        AND     A,#4DH
74f7: 22 72        MOV     0FE72H,A
74f9: 64 d3 df     MOVW    DE,#0DFD3H
74fc: 5c           MOV     A,[DE]
74fd: ac 23        AND     A,#23H
74ff: 22 73        MOV     0FE73H,A
7501: 64 d4 df     MOVW    DE,#0DFD4H
7504: 5c           MOV     A,[DE]
7505: 22 a1        MOV     0FEA1H,A
7507: 64 d5 df     MOVW    DE,#0DFD5H
750a: 5c           MOV     A,[DE]
750b: 09 f1 97 fd  MOV     !0FD97H,A
750f: 64 d6 df     MOVW    DE,#0DFD6H
7512: 5c           MOV     A,[DE]
7513: 09 f1 a3 fd  MOV     !0FDA3H,A
7517: 64 d7 df     MOVW    DE,#0DFD7H
751a: 05 e2        MOVW    AX,[DE]
751c: 1a 90        MOVW    0FE90H,AX
751e: 3a 6a 00     MOV     0FE6AH,#00H
7521: 6f 6a 0a     CMP     0FE6AH,#0AH
7524: 82 11        BNC     $7537H
7526: 20 6a        MOV     A,0FE6AH
7528: b8 00        MOV     X,#00H
752a: d8           XCH     A,X
752b: 2d 99 fd     ADDW    AX,#0FD99H
752e: 24 48        MOVW    DE,AX
7530: b9 aa        MOV     A,#0AAH
7532: 54           MOV     [DE],A
7533: 26 6a        INC     0FE6AH
7535: 14 ea        BR      $7521H
7537: b9 03        MOV     A,#03H
7539: 09 f1 09 fd  MOV     !0FD09H,A
753d: b9 00        MOV     A,#00H
753f: 09 f1 08 fd  MOV     !0FD08H,A
7543: b9 00        MOV     A,#00H
7545: 09 f1 07 fd  MOV     !0FD07H,A
7549: b9 00        MOV     A,#00H
754b: 09 f1 06 fd  MOV     !0FD06H,A
754f: b9 00        MOV     A,#00H
7551: 09 f1 05 fd  MOV     !0FD05H,A
7555: b9 01        MOV     A,#01H
7557: 09 f1 04 fd  MOV     !0FD04H,A
755b: b9 00        MOV     A,#00H
755d: 09 f1 03 fd  MOV     !0FD03H,A
7561: b9 00        MOV     A,#00H
7563: 09 f1 02 fd  MOV     !0FD02H,A
7567: b9 03        MOV     A,#03H
7569: 09 f1 a4 fd  MOV     !0FDA4H,A
756d: 56           RET
756e: 1c ac        MOVW    AX,0FEACH
7570: 3c           PUSH    AX
7571: 28 d6 53     CALL    !53D6H
7574: a1 a1        CLR1    0FEA1H.1
7576: 3a a0 03     MOV     0FEA0H,#03H
7579: 4a           DI
757a: 3a 9f 00     MOV     0FE9FH,#00H
757d: 3a 9e 00     MOV     0FE9EH,#00H
7580: b9 00        MOV     A,#00H
7582: 09 f1 2d fd  MOV     !0FD2DH,A
7586: 09 f1 2c fd  MOV     !0FD2CH,A
758a: 09 f1 2b fd  MOV     !0FD2BH,A
758e: 4b           EI
758f: 60 bd df     MOVW    AX,#0DFBDH
7592: 3c           PUSH    AX
7593: 28 2b 7c     CALL    !7C2BH
7596: 34           POP     AX
7597: d2           MOV     A,C
7598: 22 ac        MOV     0FEACH,A
759a: 10 6a        MOV     A,ADCR
759c: af 55        CMP     A,#55H
759e: 82 03        BNC     $75A3H
75a0: 6e ac 03     OR      0FEACH,#03H
75a3: 09 f0 25 fd  MOV     A,!0FD25H
75a7: ac 0f        AND     A,#0FH
75a9: b8 09        MOV     X,#09H
75ab: 8f 01        CMP     X,A
75ad: 83 36        BC      $75E5H
75af: 09 f0 26 fd  MOV     A,!0FD26H
75b3: ac 0f        AND     A,#0FH
75b5: b8 09        MOV     X,#09H
75b7: 8f 01        CMP     X,A
75b9: 83 2a        BC      $75E5H
75bb: 09 f0 27 fd  MOV     A,!0FD27H
75bf: ac 0f        AND     A,#0FH
75c1: b8 09        MOV     X,#09H
75c3: 8f 01        CMP     X,A
75c5: 83 1e        BC      $75E5H
75c7: 09 f0 25 fd  MOV     A,!0FD25H
75cb: af 59        CMP     A,#59H
75cd: 83 02        BC      $75D1H
75cf: 80 14        BNZ     $75E5H
75d1: 09 f0 26 fd  MOV     A,!0FD26H
75d5: af 59        CMP     A,#59H
75d7: 83 02        BC      $75DBH
75d9: 80 0a        BNZ     $75E5H
75db: 09 f0 27 fd  MOV     A,!0FD27H
75df: af 23        CMP     A,#23H
75e1: 83 05        BC      $75E8H
75e3: 81 03        BZ      $75E8H
75e5: 6e ac 01     OR      0FEACH,#01H
75e8: 09 f0 28 fd  MOV     A,!0FD28H
75ec: ac 0f        AND     A,#0FH
75ee: b8 09        MOV     X,#09H
75f0: 8f 01        CMP     X,A
75f2: 83 36        BC      $762AH
75f4: 09 f0 29 fd  MOV     A,!0FD29H
75f8: ac 0f        AND     A,#0FH
75fa: b8 09        MOV     X,#09H
75fc: 8f 01        CMP     X,A
75fe: 83 2a        BC      $762AH
7600: 09 f0 2a fd  MOV     A,!0FD2AH
7604: ac 0f        AND     A,#0FH
7606: b8 09        MOV     X,#09H
7608: 8f 01        CMP     X,A
760a: 83 1e        BC      $762AH
760c: 09 f0 28 fd  MOV     A,!0FD28H
7610: af 59        CMP     A,#59H
7612: 83 02        BC      $7616H
7614: 80 14        BNZ     $762AH
7616: 09 f0 29 fd  MOV     A,!0FD29H
761a: af 59        CMP     A,#59H
761c: 83 02        BC      $7620H
761e: 80 0a        BNZ     $762AH
7620: 09 f0 2a fd  MOV     A,!0FD2AH
7624: af 23        CMP     A,#23H
7626: 83 05        BC      $762DH
7628: 81 03        BZ      $762DH
762a: 6e ac 02     OR      0FEACH,#02H
762d: 20 ac        MOV     A,0FEACH
762f: ac 01        AND     A,#01H
7631: af 01        CMP     A,#01H
7633: 80 05        BNZ     $763AH
7635: a0 a1        CLR1    0FEA1H.0
7637: 28 23 5c     CALL    !5C23H
763a: 20 ac        MOV     A,0FEACH
763c: ac 02        AND     A,#02H
763e: af 02        CMP     A,#02H
7640: 80 05        BNZ     $7647H
7642: b0 a1        SET1    0FEA1H.0
7644: 28 23 5c     CALL    !5C23H
7647: 60 0b 00     MOVW    AX,#000BH
764a: 3c           PUSH    AX
764b: 28 6d 8b     CALL    Delay_Loop
764e: 34           POP     AX
764f: 28 ce 7a     CALL    Query_DFBE
7652: 64 d4 df     MOVW    DE,#0DFD4H
7655: 5c           MOV     A,[DE]
7656: 22 a1        MOV     0FEA1H,A
7658: 2b 68 93     MOV     ADM,#93H
765b: b5 03        SET1    P3.5
765d: 60 bd df     MOVW    AX,#0DFBDH
7660: 3c           PUSH    AX
7661: 20 ac        MOV     A,0FEACH
7663: b8 00        MOV     X,#00H
7665: d8           XCH     A,X
7666: 3c           PUSH    AX
7667: 28 18 7b     CALL    !7B18H
766a: 34           POP     AX
766b: 34           POP     AX
766c: 34           POP     AX
766d: 1a ac        MOVW    0FEACH,AX
766f: 56           RET
Setup_Timers:
7670: 3f           PUSH    HL
7671: 05 c9        DECW    SP
7673: 05 c9        DECW    SP
7675: 11 fc        MOVW    AX,SP
7677: 24 68        MOVW    HL,AX
7679: 60 10 27     MOVW    AX,#2710H
767c: 06 a0 01     MOV     [HL+01H],A
767f: d8           XCH     A,X
7680: 55           MOV     [HL],A
7681: b9 3c        MOV     A,#3CH
7683: 09 f1 2e fd  MOV     !0FD2EH,A
7687: 2b 30 10     MOV     CRC0,#10H
768a: 2b 5d 00     MOV     TMC0,#00H
768d: 73 02 1f     BT      P2.3,$76AFH
7690: 05 e3        MOVW    AX,[HL]
7692: 4c           DECW    AX
7693: 06 a0 01     MOV     [HL+01H],A
7696: d8           XCH     A,X
7697: 55           MOV     [HL],A
7698: d8           XCH     A,X
7699: 44           INCW    AX
769a: 24 28        MOVW    BC,AX
769c: 8a 08        SUBW    AX,AX
769e: 8f 0a        CMPW    AX,BC
76a0: 82 05        BNC     $76A7H
76a2: 73 02 02     BT      P2.3,$76A7H
76a5: 14 e9        BR      $7690H
76a7: 60 10 27     MOVW    AX,#2710H
76aa: 06 a0 01     MOV     [HL+01H],A
76ad: d8           XCH     A,X
76ae: 55           MOV     [HL],A
76af: 05 e3        MOVW    AX,[HL]
76b1: 4c           DECW    AX
76b2: 06 a0 01     MOV     [HL+01H],A
76b5: d8           XCH     A,X
76b6: 55           MOV     [HL],A
76b7: d8           XCH     A,X
76b8: 44           INCW    AX
76b9: 24 28        MOVW    BC,AX
76bb: 8a 08        SUBW    AX,AX
76bd: 8f 0a        CMPW    AX,BC
76bf: 82 06        BNC     $76C7H
76c1: 08 a3 02 02  BF      P2.3,$76C7H
76c5: 14 e8        BR      $76AFH
76c7: 2b 5d 08     MOV     TMC0,#08H
76ca: 60 10 27     MOVW    AX,#2710H
76cd: 06 a0 01     MOV     [HL+01H],A
76d0: d8           XCH     A,X
76d1: 55           MOV     [HL],A
76d2: 05 e3        MOVW    AX,[HL]
76d4: 4c           DECW    AX
76d5: 06 a0 01     MOV     [HL+01H],A
76d8: d8           XCH     A,X
76d9: 55           MOV     [HL],A
76da: d8           XCH     A,X
76db: 44           INCW    AX
76dc: 24 28        MOVW    BC,AX
76de: 8a 08        SUBW    AX,AX
76e0: 8f 0a        CMPW    AX,BC
76e2: 82 05        BNC     $76E9H
76e4: 73 02 02     BT      P2.3,$76E9H
76e7: 14 e9        BR      $76D2H
76e9: 60 10 27     MOVW    AX,#2710H
76ec: 06 a0 01     MOV     [HL+01H],A
76ef: d8           XCH     A,X
76f0: 55           MOV     [HL],A
76f1: 05 e3        MOVW    AX,[HL]
76f3: 4c           DECW    AX
76f4: 06 a0 01     MOV     [HL+01H],A
76f7: d8           XCH     A,X
76f8: 55           MOV     [HL],A
76f9: d8           XCH     A,X
76fa: 44           INCW    AX
76fb: 24 28        MOVW    BC,AX
76fd: 8a 08        SUBW    AX,AX
76ff: 8f 0a        CMPW    AX,BC
7701: 82 06        BNC     $7709H
7703: 08 a3 02 02  BF      P2.3,$7709H
7707: 14 e8        BR      $76F1H
7709: 11 50        MOVW    AX,TM0
770b: 06 a0 01     MOV     [HL+01H],A
770e: d8           XCH     A,X
770f: 55           MOV     [HL],A
7710: 2b 5d 00     MOV     TMC0,#00H
7713: 05 e3        MOVW    AX,[HL]
7715: 2f f3 35     CMPW    AX,#35F3H
7718: 83 08        BC      $7722H
771a: 81 06        BZ      $7722H
771c: b9 32        MOV     A,#32H
771e: 09 f1 2e fd  MOV     !0FD2EH,A
7722: 2b 30 18     MOV     CRC0,#18H
7725: 2b 5d 08     MOV     TMC0,#08H
7728: 34           POP     AX
7729: 37           POP     HL
772a: 56           RET
Service_INT_SR:
772b: 3f           PUSH    HL
772c: 3e           PUSH    DE
772d: 3d           PUSH    BC
772e: 3c           PUSH    AX
772f: 09 f0 30 fd  MOV     A,!0FD30H
7733: 30 a1        SHR     A,4
7735: ac 01        AND     A,#01H
7737: b8 00        MOV     X,#00H
7739: d8           XCH     A,X
773a: 2f 01 00     CMPW    AX,#0001H
773d: 80 20        BNZ     $775FH
773f: b4 03        SET1    P3.4
7741: 09 f0 94 fd  MOV     A,!0FD94H
7745: b8 00        MOV     X,#00H
7747: d8           XCH     A,X
7748: 2d 31 fd     ADDW    AX,#0FD31H
774b: 24 48        MOVW    DE,AX
774d: 10 8c        MOV     A,RXB
774f: 54           MOV     [DE],A
7750: 64 94 fd     MOVW    DE,#0FD94H
7753: 5c           MOV     A,[DE]
7754: c1           INC     A
7755: 54           MOV     [DE],A
7756: ac 3f        AND     A,#3FH
7758: 09 f1 94 fd  MOV     !0FD94H,A
775c: 2c 6b 78     BR      !786BH
775f: 10 8c        MOV     A,RXB
7761: af 20        CMP     A,#20H
7763: 80 13        BNZ     $7778H
7765: 09 f0 30 fd  MOV     A,!0FD30H
7769: 30 a1        SHR     A,4
776b: ac 01        AND     A,#01H
776d: b8 00        MOV     X,#00H
776f: d8           XCH     A,X
7770: 2f 00 00     CMPW    AX,#0000H
7773: 80 03        BNZ     $7778H
7775: 2c 6b 78     BR      !786BH
7778: b5 68        SET1    0FE68H.5
777a: 10 8c        MOV     A,RXB
777c: af 08        CMP     A,#08H
777e: 80 36        BNZ     $77B6H
7780: 09 f0 30 fd  MOV     A,!0FD30H
7784: 30 a1        SHR     A,4
7786: ac 01        AND     A,#01H
7788: b8 00        MOV     X,#00H
778a: d8           XCH     A,X
778b: 2f 00 00     CMPW    AX,#0000H
778e: 80 26        BNZ     $77B6H
7790: 09 f0 93 fd  MOV     A,!0FD93H
7794: d8           XCH     A,X
7795: 09 f0 94 fd  MOV     A,!0FD94H
7799: 8f 10        CMP     A,X
779b: 81 16        BZ      $77B3H
779d: 09 f0 94 fd  MOV     A,!0FD94H
77a1: af 00        CMP     A,#00H
77a3: 80 08        BNZ     $77ADH
77a5: b9 40        MOV     A,#40H
77a7: 09 f1 94 fd  MOV     !0FD94H,A
77ab: 14 06        BR      $77B3H
77ad: 64 94 fd     MOVW    DE,#0FD94H
77b0: 5c           MOV     A,[DE]
77b1: c9           DEC     A
77b2: 54           MOV     [DE],A
77b3: 2c 6b 78     BR      !786BH
77b6: 09 f0 94 fd  MOV     A,!0FD94H
77ba: b8 00        MOV     X,#00H
77bc: d8           XCH     A,X
77bd: 2d 31 fd     ADDW    AX,#0FD31H
77c0: 24 48        MOVW    DE,AX
77c2: 10 8c        MOV     A,RXB
77c4: 54           MOV     [DE],A
77c5: 09 f0 30 fd  MOV     A,!0FD30H
77c9: 30 a1        SHR     A,4
77cb: ac 01        AND     A,#01H
77cd: b8 00        MOV     X,#00H
77cf: d8           XCH     A,X
77d0: 2f 00 00     CMPW    AX,#0000H
77d3: 80 43        BNZ     $7818H
77d5: 09 f0 94 fd  MOV     A,!0FD94H
77d9: b8 00        MOV     X,#00H
77db: d8           XCH     A,X
77dc: 2d 31 fd     ADDW    AX,#0FD31H
77df: 24 48        MOVW    DE,AX
77e1: 5c           MOV     A,[DE]
77e2: af 61        CMP     A,#61H
77e4: 83 32        BC      $7818H
77e6: 09 f0 94 fd  MOV     A,!0FD94H
77ea: b8 00        MOV     X,#00H
77ec: d8           XCH     A,X
77ed: 2d 31 fd     ADDW    AX,#0FD31H
77f0: 24 48        MOVW    DE,AX
77f2: b9 7a        MOV     A,#7AH
77f4: 16 4f        CMP     A,[DE]
77f6: 83 20        BC      $7818H
77f8: 09 f0 94 fd  MOV     A,!0FD94H
77fc: b8 00        MOV     X,#00H
77fe: d8           XCH     A,X
77ff: 2d 31 fd     ADDW    AX,#0FD31H
7802: 24 48        MOVW    DE,AX
7804: 5c           MOV     A,[DE]
7805: aa 20        SUB     A,#20H
7807: d8           XCH     A,X
7808: 09 f0 94 fd  MOV     A,!0FD94H
780c: 24 20        MOV     C,X
780e: b8 00        MOV     X,#00H
7810: d8           XCH     A,X
7811: 2d 31 fd     ADDW    AX,#0FD31H
7814: 24 48        MOVW    DE,AX
7816: d2           MOV     A,C
7817: 54           MOV     [DE],A
7818: 09 f0 94 fd  MOV     A,!0FD94H
781c: b8 00        MOV     X,#00H
781e: d8           XCH     A,X
781f: 2d 31 fd     ADDW    AX,#0FD31H
7822: 24 48        MOVW    DE,AX
7824: 5c           MOV     A,[DE]
7825: af 0d        CMP     A,#0DH
7827: 80 0a        BNZ     $7833H
7829: 09 f0 30 fd  MOV     A,!0FD30H
782d: 03 88        SET1    A.0
782f: 09 f1 30 fd  MOV     !0FD30H,A
7833: 09 f0 94 fd  MOV     A,!0FD94H
7837: b8 00        MOV     X,#00H
7839: d8           XCH     A,X
783a: 2d 31 fd     ADDW    AX,#0FD31H
783d: 24 48        MOVW    DE,AX
783f: 5c           MOV     A,[DE]
7840: af 55        CMP     A,#55H
7842: 81 11        BZ      $7855H
7844: 09 f0 94 fd  MOV     A,!0FD94H
7848: b8 00        MOV     X,#00H
784a: d8           XCH     A,X
784b: 2d 31 fd     ADDW    AX,#0FD31H
784e: 24 48        MOVW    DE,AX
7850: 5c           MOV     A,[DE]
7851: af 44        CMP     A,#44H
7853: 80 0a        BNZ     $785FH
7855: 09 f0 30 fd  MOV     A,!0FD30H
7859: 03 89        SET1    A.1
785b: 09 f1 30 fd  MOV     !0FD30H,A
785f: 64 94 fd     MOVW    DE,#0FD94H
7862: 5c           MOV     A,[DE]
7863: c1           INC     A
7864: 54           MOV     [DE],A
7865: ac 3f        AND     A,#3FH
7867: 09 f1 94 fd  MOV     !0FD94H,A
786b: 34           POP     AX
786c: 35           POP     BC
786d: 36           POP     DE
786e: 37           POP     HL
786f: 57           RETI
Service_INTST:
7870: 3f           PUSH    HL
7871: 3e           PUSH    DE
7872: 3d           PUSH    BC
7873: 3c           PUSH    AX
7874: b6 68        SET1    0FE68H.6
7876: a7 69        CLR1    0FE69H.7
7878: 09 f0 92 fd  MOV     A,!0FD92H
787c: d8           XCH     A,X
787d: 09 f0 91 fd  MOV     A,!0FD91H
7881: 8f 10        CMP     A,X
7883: 81 1d        BZ      $78A2H
7885: 09 f0 91 fd  MOV     A,!0FD91H
7889: b8 00        MOV     X,#00H
788b: d8           XCH     A,X
788c: 2d 71 fd     ADDW    AX,#0FD71H
788f: 24 48        MOVW    DE,AX
7891: 5c           MOV     A,[DE]
7892: 12 8e        MOV     TXS,A
7894: 64 91 fd     MOVW    DE,#0FD91H
7897: 5c           MOV     A,[DE]
7898: c1           INC     A
7899: 54           MOV     [DE],A
789a: ac 1f        AND     A,#1FH
789c: 09 f1 91 fd  MOV     !0FD91H,A
78a0: b7 69        SET1    0FE69H.7
78a2: 34           POP     AX
78a3: 35           POP     BC
78a4: 36           POP     DE
78a5: 37           POP     HL
78a6: 57           RETI
Service_NMI:
78a7: 3f           PUSH    HL
78a8: 3e           PUSH    DE
78a9: 3d           PUSH    BC
78aa: 3c           PUSH    AX
78ab: 64 b4 fd     MOVW    DE,@NMI_FLAG_WORD
78ae: 05 e2        MOVW    AX,[DE]
78b0: 2f 6d b5     CMPW    AX,#0B56DH
78b3: 80 03        BNZ     $78B8H
78b5: 28 b4 92     CALL    !92B4H
78b8: 34           POP     AX
78b9: 35           POP     BC
78ba: 36           POP     DE
78bb: 37           POP     HL
78bc: 57           RETI
Service_RESET:
78bd: 0b fc 55 fe  MOVW    SP,#0FE55H
78c1: 8a 08        SUBW    AX,AX
78c3: 64 b4 fd     MOVW    DE,@NMI_FLAG_WORD
78c6: 05 e6        MOVW    [DE],AX
78c8: bb 00        MOV     B,#00H        ; clear RAM FD00-FDFF
78ca: b9 00        MOV     A,#00H
78cc: 64 ff fd     MOVW    DE,#0FDFFH
78cf: 54           MOV     [DE],A
78d0: 4e           DECW    DE
78d1: 33 fc        DBNZ    B,$78CFH
78d3: bb a1        MOV     B,#0A1H       ; Clear RAM FE20-FEC1
78d5: 64 c1 fe     MOVW    DE,#0FEC1H
78d8: 54           MOV     [DE],A
78d9: 4e           DECW    DE
78da: 33 fc        DBNZ    B,$78D8H
78dc: a4 00        CLR1    P0.4          ; Clear Port 0, bit 4   Turn off Real Time Clock - Chip Select - pin 2
78de: 28 0f 7a     CALL    Startup        ; actual startup
78e1: 57           RETI
Service_INT_P4:                                     ; We get here when the tuning knob has moved either way
78e2: 3f           PUSH    HL
78e3: 3e           PUSH    DE
78e4: 3d           PUSH    BC
78e5: 3c           PUSH    AX
78e6: 08 a0 66 1e  BF      0FE66H.0,$7908H
78ea: 76 66 1b     BT      0FE66H.6,$7908H
78ed: 76 65 18     BT      0FE65H.6,$7908H
78f0: 75 07 0b     BT      P7.5,$78FEH              ; get wheel direction
78f3: 08 a5 69 03  BF      0FE69H.5,$78FAH          ; compare to previous wheel direction flag
78f7: 3a 75 00     MOV     Wheel_Count,#00H
78fa: a5 69        CLR1    0FE69H.5
78fc: 14 08        BR      $7906H
78fe: 75 69 03     BT      0FE69H.5,$7904H
7901: 3a 75 00     MOV     Wheel_Count,#00H
7904: b5 69        SET1    0FE69H.5
7906: 26 75        INC     Wheel_Count
7908: 34           POP     AX
7909: 35           POP     BC
790a: 36           POP     DE
790b: 37           POP     HL
790c: 57           RETI
Service_INT_P2:
790d: 26 9e        INC     0FE9EH
790f: 26 9f        INC     0FE9FH
7911: a1 a1        CLR1    0FEA1H.1
7913: 3a a0 03     MOV     0FEA0H,#03H
7916: 57           RETI
Service_INTC01:
7917: b0 68        SET1    0FE68H.0
7919: 57           RETI
Service_INT_P0:
791a: 3f           PUSH    HL
791b: 3e           PUSH    DE
791c: 3d           PUSH    BC
791d: 3c           PUSH    AX
791e: 34           POP     AX
791f: 35           POP     BC
7920: 36           POP     DE
7921: 37           POP     HL
7922: 57           RETI
Service_BRK:
7923: 8a 08        SUBW    AX,AX
7925: 64 b4 fd     MOVW    DE,@NMI_FLAG_WORD
7928: 05 e6        MOVW    [DE],AX
792a: a4 00        CLR1    P0.4
792c: 0b fc 55 fe  MOVW    SP,#0FE55H
7930: 28 0f 7a     CALL    Startup
7933: 5f           RETB
7934: 3f           PUSH    HL
7935: 11 fc        MOVW    AX,SP
7937: 2e 04 00     SUBW    AX,#0004H
793a: 24 68        MOVW    HL,AX
793c: 13 fc        MOVW    SP,AX
793e: b9 00        MOV     A,#00H
7940: 06 a0 03     MOV     [HL+03H],A
7943: 3a 74 00     MOV     0FE74H,#00H
7946: b9 01        MOV     A,#01H
7948: 09 f1 2f fd  MOV     !0FD2FH,A
794c: 09 f0 2f fd  MOV     A,!0FD2FH
7950: af 80        CMP     A,#80H
7952: 83 03        BC      $7957H
7954: 2c fa 79     BR      !79FAH
7957: 64 d4 ff     MOVW    DE,#0FFD4H
795a: 09 f0 2f fd  MOV     A,!0FD2FH
795e: 54           MOV     [DE],A
795f: 00           NOP
7960: 00           NOP
7961: 00           NOP
7962: 00           NOP
7963: 00           NOP
7964: b9 09        MOV     A,#09H
7966: 55           MOV     [HL],A
7967: b9 00        MOV     A,#00H
7969: 06 a0 02     MOV     [HL+02H],A
796c: 64 d7 ff     MOVW    DE,#0FFD7H
796f: 5c           MOV     A,[DE]
7970: ac 3f        AND     A,#3FH
7972: 06 a0 01     MOV     [HL+01H],A
7975: af 00        CMP     A,#00H
7977: 81 6d        BZ      $79E6H
7979: 6f 74 00     CMP     0FE74H,#00H
797c: 80 65        BNZ     $79E3H
797e: b9 00        MOV     A,#00H
7980: 06 2f 01     CMP     A,[HL+01H]
7983: 82 1a        BNC     $799FH
7985: b9 00        MOV     A,#00H
7987: 16 5f        CMP     A,[HL]
7989: 82 14        BNC     $799FH
798b: 06 20 02     MOV     A,[HL+02H]
798e: c1           INC     A
798f: 06 a0 02     MOV     [HL+02H],A
7992: 06 20 01     MOV     A,[HL+01H]
7995: 30 89        SHR     A,1
7997: 06 a0 01     MOV     [HL+01H],A
799a: 5d           MOV     A,[HL]
799b: c9           DEC     A
799c: 55           MOV     [HL],A
799d: 14 df        BR      $797EH
799f: b8 06        MOV     X,#06H
79a1: 06 20 03     MOV     A,[HL+03H]
79a4: 05 08        MULU    X
79a6: d0           MOV     A,X
79a7: 06 28 02     ADD     A,[HL+02H]
79aa: 22 74        MOV     0FE74H,A
79ac: b9 00        MOV     A,#00H
79ae: 9f 7f        CMP     A,0FE7FH
79b0: 82 04        BNC     $79B6H
79b2: 08 a3 72 09  BF      0FE72H.3,$79BFH
79b6: 6f 7f 00     CMP     0FE7FH,#00H
79b9: 80 26        BNZ     $79E1H
79bb: 08 a3 72 22  BF      0FE72H.3,$79E1H
79bf: 6f 74 19     CMP     0FE74H,#19H
79c2: 81 1d        BZ      $79E1H
79c4: 06 20 03     MOV     A,[HL+03H]
79c7: af 05        CMP     A,#05H
79c9: 82 07        BNC     $79D2H
79cb: 06 20 02     MOV     A,[HL+02H]
79ce: af 04        CMP     A,#04H
79d0: 83 0c        BC      $79DEH
79d2: 06 20 03     MOV     A,[HL+03H]
79d5: af 00        CMP     A,#00H
79d7: 81 05        BZ      $79DEH
79d9: 6f 74 1c     CMP     0FE74H,#1CH
79dc: 80 03        BNZ     $79E1H
79de: 68 74 30     ADD     0FE74H,#30H
79e1: 14 03        BR      $79E6H
79e3: 3a 74 ff     MOV     0FE74H,#0FFH
79e6: 06 20 03     MOV     A,[HL+03H]
79e9: c1           INC     A
79ea: 06 a0 03     MOV     [HL+03H],A
79ed: 09 f0 2f fd  MOV     A,!0FD2FH
79f1: 88 11        ADD     A,A
79f3: 09 f1 2f fd  MOV     !0FD2FH,A
79f7: 2c 4c 79     BR      !794CH
79fa: 6f 74 00     CMP     0FE74H,#00H
79fd: 81 03        BZ      $7A02H
79ff: 3a 84 07     MOV     0FE84H,#07H
7a02: 34           POP     AX
7a03: 34           POP     AX
7a04: 37           POP     HL
7a05: 56           RET
7a06: 28 0f 7a     CALL    Startup
7a09: 56           RET
7a0a: 0b e4 da 9d  MOVW    MK0,#9DDAH
7a0e: 56           RET
Startup:
7a0f: 28 e9 70     CALL    !Init_Step1
7a12: 28 5e 71     CALL    !Init_Step2
7a15: 2b 8e 2a     MOV     TXS,#2AH
7a18: 28 0a 7a     CALL    !7A0AH
7a1b: 4b           EI
7a1c: 6f 68 00     CMP     0FE68H,#00H
7a1f: 81 fb        BZ      $7A1CH
7a21: 08 a0 68 03  BF      0FE68H.0,$7A28H
7a25: 28 28 9e     CALL    !9E28H
7a28: b9 00        MOV     A,#00H
7a2a: 9f 75        CMP     A,Wheel_Count
7a2c: 82 03        BNC     $7A31H
7a2e: 28 cb a7     CALL    !0A7CBH
7a31: 08 a5 68 03  BF      0FE68H.5,$7A38H
7a35: 28 f6 33     CALL    !33F6H
7a38: 08 a0 72 0a  BF      0FE72H.0,$7A46H
7a3c: a0 73        CLR1    0FE73H.0
7a3e: 1c 63        MOVW    AX,0FE63H
7a40: 24 48        MOVW    DE,AX
7a42: 5c           MOV     A,[DE]
7a43: 03 8c        SET1    A.4
7a45: 54           MOV     [DE],A
7a46: 08 a6 68 03  BF      0FE68H.6,$7A4DH
7a4a: 28 f3 33     CALL    !33F3H
7a4d: 08 a0 66 1e  BF      0FE66H.0,$7A6FH
7a51: 08 a4 02 06  BF      P2.4,$7A5BH
7a55: b3 68        SET1    0FE68H.3
7a57: b4 69        SET1    0FE69H.4
7a59: 14 14        BR      $7A6FH
7a5b: a4 69        CLR1    0FE69H.4
7a5d: 09 f0 b2 fd  MOV     A,!0FDB2H
7a61: af 06        CMP     A,#06H
7a63: 83 04        BC      $7A69H
7a65: 81 02        BZ      $7A69H
7a67: b2 68        SET1    0FE68H.2
7a69: b9 00        MOV     A,#00H
7a6b: 09 f1 b2 fd  MOV     !0FDB2H,A
7a6f: 72 73 03     BT      0FE73H.2,$7A75H
7a72: 28 6e 85     CALL    !856EH
7a75: 08 a3 68 03  BF      0FE68H.3,$7A7CH
7a79: 28 d4 a2     CALL    !0A2D4H
7a7c: 08 a4 68 03  BF      0FE68H.4,$7A83H
7a80: 28 29 a5     CALL    !0A529H
7a83: 6f 83 00     CMP     0FE83H,#00H
7a86: 80 0e        BNZ     $7A96H
7a88: 08 a1 68 03  BF      0FE68H.1,$7A8FH
7a8c: 28 23 62     CALL    !6223H
7a8f: 08 a2 68 03  BF      0FE68H.2,$7A96H
7a93: 28 44 61     CALL    !6144H
7a96: a3 69        CLR1    0FE69H.3
7a98: 28 ef 99     CALL    !99EFH
7a9b: 08 a7 02 03  BF      P2.7,$7AA2H
7a9f: 3a 7d 00     MOV     0FE7DH,#00H
7aa2: 1c 63        MOVW    AX,0FE63H
7aa4: 24 48        MOVW    DE,AX
7aa6: 06 00 06     MOV     A,[DE+06H]
7aa9: 30 b1        SHR     A,6
7aab: ac 03        AND     A,#03H
7aad: b8 00        MOV     X,#00H
7aaf: d8           XCH     A,X
7ab0: 2f 01 00     CMPW    AX,#0001H
7ab3: 80 10        BNZ     $7AC5H
7ab5: 64 d7 ff     MOVW    DE,#0FFD7H
7ab8: 5c           MOV     A,[DE]
7ab9: ac 80        AND     A,#80H
7abb: 80 08        BNZ     $7AC5H
7abd: 28 4e 9b     CALL    !9B4EH
7ac0: 28 16 20     CALL    !2016H
7ac3: b2 69        SET1    0FE69H.2
7ac5: 76 65 02     BT      0FE65H.6,$7ACAH
7ac8: b4 00        SET1    P0.4
7aca: 2c 18 7a     BR      !7A18H
7acd: 56           RET
Query_DFBE:
7ace: 3f           PUSH    HL
7acf: 05 c9        DECW    SP
7ad1: 05 c9        DECW    SP
7ad3: 11 fc        MOVW    AX,SP
7ad5: 24 68        MOVW    HL,AX
7ad7: 64 be df     MOVW    DE,#0DFBEH
7ada: 5c           MOV     A,[DE]
7adb: 06 a0 01     MOV     [HL+01H],A
7ade: ac 40        AND     A,#40H
7ae0: 06 a0 01     MOV     [HL+01H],A
7ae3: 64 be df     MOVW    DE,#0DFBEH
7ae6: 5c           MOV     A,[DE]
7ae7: 55           MOV     [HL],A
7ae8: ac 40        AND     A,#40H
7aea: 55           MOV     [HL],A
7aeb: 06 20 01     MOV     A,[HL+01H]
7aee: 16 5f        CMP     A,[HL]
7af0: 80 e5        BNZ     $7AD7H
7af2: 34           POP     AX
7af3: 37           POP     HL
7af4: 56           RET
7af5: 3f           PUSH    HL
7af6: 11 fc        MOVW    AX,SP
7af8: 24 68        MOVW    HL,AX
7afa: 06 20 06     MOV     A,[HL+06H]
7afd: d8           XCH     A,X
7afe: 06 20 07     MOV     A,[HL+07H]
7b01: 24 48        MOVW    DE,AX
7b03: 5c           MOV     A,[DE]
7b04: 06 2f 04     CMP     A,[HL+04H]
7b07: 81 0d        BZ      $7B16H
7b09: 06 20 06     MOV     A,[HL+06H]
7b0c: d8           XCH     A,X
7b0d: 06 20 07     MOV     A,[HL+07H]
7b10: 24 48        MOVW    DE,AX
7b12: 06 20 04     MOV     A,[HL+04H]
7b15: 54           MOV     [DE],A
7b16: 37           POP     HL
7b17: 56           RET
7b18: 3f           PUSH    HL
7b19: 11 fc        MOVW    AX,SP
7b1b: 24 68        MOVW    HL,AX
7b1d: 60 0b 00     MOVW    AX,#000BH
7b20: 3c           PUSH    AX
7b21: 28 6d 8b     CALL    Delay_Loop
7b24: 34           POP     AX
7b25: 28 ce 7a     CALL    Query_DFBE
7b28: 06 20 06     MOV     A,[HL+06H]
7b2b: d8           XCH     A,X
7b2c: 06 20 07     MOV     A,[HL+07H]
7b2f: 24 48        MOVW    DE,AX
7b31: 5c           MOV     A,[DE]
7b32: 06 2f 04     CMP     A,[HL+04H]
7b35: 81 2a        BZ      $7B61H
7b37: 64 55 d5     MOVW    DE,#0D555H
7b3a: b9 aa        MOV     A,#0AAH
7b3c: 54           MOV     [DE],A
7b3d: 64 aa ca     MOVW    DE,#0CAAAH
7b40: b9 55        MOV     A,#55H
7b42: 54           MOV     [DE],A
7b43: 64 55 d5     MOVW    DE,#0D555H
7b46: b9 a0        MOV     A,#0A0H
7b48: 54           MOV     [DE],A
7b49: 06 20 06     MOV     A,[HL+06H]
7b4c: d8           XCH     A,X
7b4d: 06 20 07     MOV     A,[HL+07H]
7b50: 24 48        MOVW    DE,AX
7b52: 06 20 04     MOV     A,[HL+04H]
7b55: 54           MOV     [DE],A
7b56: 60 0b 00     MOVW    AX,#000BH
7b59: 3c           PUSH    AX
7b5a: 28 6d 8b     CALL    Delay_Loop
7b5d: 34           POP     AX
7b5e: 28 ce 7a     CALL    Query_DFBE
7b61: 37           POP     HL
7b62: 56           RET
7b63: 3f           PUSH    HL
7b64: 05 c9        DECW    SP
7b66: 05 c9        DECW    SP
7b68: 11 fc        MOVW    AX,SP
7b6a: 24 68        MOVW    HL,AX
7b6c: 06 20 06     MOV     A,[HL+06H]
7b6f: 55           MOV     [HL],A
7b70: d8           XCH     A,X
7b71: 06 20 07     MOV     A,[HL+07H]
7b74: 06 a0 01     MOV     [HL+01H],A
7b77: 60 0b 00     MOVW    AX,#000BH
7b7a: 3c           PUSH    AX
7b7b: 28 6d 8b     CALL    Delay_Loop
7b7e: 34           POP     AX
7b7f: 28 ce 7a     CALL    Query_DFBE
7b82: 06 20 08     MOV     A,[HL+08H]
7b85: d8           XCH     A,X
7b86: 06 20 09     MOV     A,[HL+09H]
7b89: 24 48        MOVW    DE,AX
7b8b: 5c           MOV     A,[DE]
7b8c: 16 5f        CMP     A,[HL]
7b8e: 80 11        BNZ     $7BA1H
7b90: 06 20 08     MOV     A,[HL+08H]
7b93: d8           XCH     A,X
7b94: 06 20 09     MOV     A,[HL+09H]
7b97: 24 48        MOVW    DE,AX
7b99: 06 00 01     MOV     A,[DE+01H]
7b9c: 06 2f 01     CMP     A,[HL+01H]
7b9f: 81 37        BZ      $7BD8H
7ba1: 64 55 d5     MOVW    DE,#0D555H
7ba4: b9 aa        MOV     A,#0AAH
7ba6: 54           MOV     [DE],A
7ba7: 64 aa ca     MOVW    DE,#0CAAAH
7baa: b9 55        MOV     A,#55H
7bac: 54           MOV     [DE],A
7bad: 64 55 d5     MOVW    DE,#0D555H
7bb0: b9 a0        MOV     A,#0A0H
7bb2: 54           MOV     [DE],A
7bb3: 06 20 08     MOV     A,[HL+08H]
7bb6: d8           XCH     A,X
7bb7: 06 20 09     MOV     A,[HL+09H]
7bba: 24 48        MOVW    DE,AX
7bbc: 5d           MOV     A,[HL]
7bbd: 54           MOV     [DE],A
7bbe: 06 20 08     MOV     A,[HL+08H]
7bc1: d8           XCH     A,X
7bc2: 06 20 09     MOV     A,[HL+09H]
7bc5: 24 48        MOVW    DE,AX
7bc7: 06 20 01     MOV     A,[HL+01H]
7bca: 06 80 01     MOV     [DE+01H],A
7bcd: 60 0b 00     MOVW    AX,#000BH
7bd0: 3c           PUSH    AX
7bd1: 28 6d 8b     CALL    Delay_Loop
7bd4: 34           POP     AX
7bd5: 28 ce 7a     CALL    Query_DFBE
7bd8: 34           POP     AX
7bd9: 37           POP     HL
7bda: 56           RET
7bdb: 3f           PUSH    HL
7bdc: 05 c9        DECW    SP
7bde: 05 c9        DECW    SP
7be0: 11 fc        MOVW    AX,SP
7be2: 24 68        MOVW    HL,AX
7be4: 06 20 06     MOV     A,[HL+06H]
7be7: 55           MOV     [HL],A
7be8: d8           XCH     A,X
7be9: 06 20 07     MOV     A,[HL+07H]
7bec: 06 a0 01     MOV     [HL+01H],A
7bef: 06 20 08     MOV     A,[HL+08H]
7bf2: d8           XCH     A,X
7bf3: 06 20 09     MOV     A,[HL+09H]
7bf6: 24 48        MOVW    DE,AX
7bf8: 5c           MOV     A,[DE]
7bf9: 16 5f        CMP     A,[HL]
7bfb: 80 11        BNZ     $7C0EH
7bfd: 06 20 08     MOV     A,[HL+08H]
7c00: d8           XCH     A,X
7c01: 06 20 09     MOV     A,[HL+09H]
7c04: 24 48        MOVW    DE,AX
7c06: 06 00 01     MOV     A,[DE+01H]
7c09: 06 2f 01     CMP     A,[HL+01H]
7c0c: 81 1a        BZ      $7C28H
7c0e: 06 20 08     MOV     A,[HL+08H]
7c11: d8           XCH     A,X
7c12: 06 20 09     MOV     A,[HL+09H]
7c15: 24 48        MOVW    DE,AX
7c17: 5d           MOV     A,[HL]
7c18: 54           MOV     [DE],A
7c19: 06 20 08     MOV     A,[HL+08H]
7c1c: d8           XCH     A,X
7c1d: 06 20 09     MOV     A,[HL+09H]
7c20: 24 48        MOVW    DE,AX
7c22: 06 20 01     MOV     A,[HL+01H]
7c25: 06 80 01     MOV     [DE+01H],A
7c28: 34           POP     AX
7c29: 37           POP     HL
7c2a: 56           RET
7c2b: 3f           PUSH    HL
7c2c: 11 fc        MOVW    AX,SP
7c2e: 24 68        MOVW    HL,AX
7c30: 60 0b 00     MOVW    AX,#000BH
7c33: 3c           PUSH    AX
7c34: 28 6d 8b     CALL    Delay_Loop
7c37: 34           POP     AX
7c38: 28 ce 7a     CALL    Query_DFBE
7c3b: 06 20 04     MOV     A,[HL+04H]
7c3e: d8           XCH     A,X
7c3f: 06 20 05     MOV     A,[HL+05H]
7c42: 24 48        MOVW    DE,AX
7c44: 5c           MOV     A,[DE]
7c45: bb 00        MOV     B,#00H
7c47: da           XCH     A,C
7c48: 37           POP     HL
7c49: 56           RET
7c4a: 4a           DI
7c4b: 60 0a 00     MOVW    AX,#000AH
7c4e: 3c           PUSH    AX
7c4f: 28 43 8b     CALL    !8B43H
7c52: 34           POP     AX
7c53: 28 ce 7a     CALL    Query_DFBE
7c56: 64 55 d5     MOVW    DE,#0D555H
7c59: b9 aa        MOV     A,#0AAH
7c5b: 54           MOV     [DE],A
7c5c: 64 aa ca     MOVW    DE,#0CAAAH
7c5f: b9 55        MOV     A,#55H
7c61: 54           MOV     [DE],A
7c62: 64 55 d5     MOVW    DE,#0D555H
7c65: b9 a0        MOV     A,#0A0H
7c67: 54           MOV     [DE],A
7c68: 64 be df     MOVW    DE,#0DFBEH
7c6b: b9 55        MOV     A,#55H
7c6d: 54           MOV     [DE],A
7c6e: 60 0a 00     MOVW    AX,#000AH
7c71: 3c           PUSH    AX
7c72: 28 43 8b     CALL    !8B43H
7c75: 34           POP     AX
7c76: 28 ce 7a     CALL    Query_DFBE
7c79: 4b           EI
7c7a: 56           RET
7c7b: 3f           PUSH    HL
7c7c: 05 c9        DECW    SP
7c7e: 05 c9        DECW    SP
7c80: 11 fc        MOVW    AX,SP
7c82: 24 68        MOVW    HL,AX
7c84: 1c 63        MOVW    AX,0FE63H
7c86: 24 48        MOVW    DE,AX
7c88: b9 fc        MOV     A,#0FCH
7c8a: 16 4c        AND     A,[DE]
7c8c: 54           MOV     [DE],A
7c8d: 09 f0 90 fe  MOV     A,!0FE90H
7c91: d8           XCH     A,X
7c92: 09 f0 91 fe  MOV     A,!0FE91H
7c96: 3c           PUSH    AX
7c97: 28 e8 7d     CALL    !7DE8H
7c9a: 34           POP     AX
7c9b: 1c 6a        MOVW    AX,0FE6AH
7c9d: 3c           PUSH    AX
7c9e: 28 2b 7c     CALL    !7C2BH
7ca1: 34           POP     AX
7ca2: d2           MOV     A,C
7ca3: ac 01        AND     A,#01H
7ca5: 80 0e        BNZ     $7CB5H
7ca7: 09 f0 90 fe  MOV     A,!0FE90H
7cab: d8           XCH     A,X
7cac: 09 f0 91 fe  MOV     A,!0FE91H
7cb0: 3c           PUSH    AX
7cb1: 28 a5 83     CALL    !83A5H
7cb4: 34           POP     AX
7cb5: 09 f0 90 fe  MOV     A,!0FE90H
7cb9: d8           XCH     A,X
7cba: 09 f0 91 fe  MOV     A,!0FE91H
7cbe: 3c           PUSH    AX
7cbf: 28 e8 7d     CALL    !7DE8H
7cc2: 34           POP     AX
7cc3: 1c 6a        MOVW    AX,0FE6AH
7cc5: 3c           PUSH    AX
7cc6: 1c 63        MOVW    AX,0FE63H
7cc8: 3c           PUSH    AX
7cc9: 28 3f 9a     CALL    !9A3FH
7ccc: 34           POP     AX
7ccd: 34           POP     AX
7cce: 68 6a 07     ADD     0FE6AH,#07H
7cd1: 69 6b 00     ADDC    0FE6BH,#00H
7cd4: 1c 6a        MOVW    AX,0FE6AH
7cd6: 3c           PUSH    AX
7cd7: 09 f0 0f fd  MOV     A,!0FD0FH
7cdb: b8 00        MOV     X,#00H
7cdd: d8           XCH     A,X
7cde: 3c           PUSH    AX
7cdf: 28 18 7b     CALL    !7B18H
7ce2: 34           POP     AX
7ce3: 34           POP     AX
7ce4: 09 f0 0f fd  MOV     A,!0FD0FH
7ce8: af ff        CMP     A,#0FFH
7cea: 81 12        BZ      $7CFEH
7cec: 1c 6a        MOVW    AX,0FE6AH
7cee: 3c           PUSH    AX
7cef: 64 0f fd     MOVW    DE,#0FD0FH
7cf2: 3e           PUSH    DE
7cf3: 28 3f 9a     CALL    !9A3FH
7cf6: 34           POP     AX
7cf7: 34           POP     AX
7cf8: b9 ff        MOV     A,#0FFH
7cfa: 09 f1 ab fd  MOV     !0FDABH,A
7cfe: 09 f0 90 fe  MOV     A,!0FE90H
7d02: d8           XCH     A,X
7d03: 09 f0 91 fe  MOV     A,!0FE91H
7d07: 3c           PUSH    AX
7d08: 28 f4 82     CALL    !82F4H
7d0b: 34           POP     AX
7d0c: 09 f0 90 fe  MOV     A,!0FE90H
7d10: d8           XCH     A,X
7d11: 09 f0 91 fe  MOV     A,!0FE91H
7d15: 3c           PUSH    AX
7d16: 28 e8 7d     CALL    !7DE8H
7d19: 34           POP     AX
7d1a: 1c 63        MOVW    AX,0FE63H
7d1c: 3c           PUSH    AX
7d1d: 36           POP     DE
7d1e: 06 00 03     MOV     A,[DE+03H]
7d21: d8           XCH     A,X
7d22: 06 00 04     MOV     A,[DE+04H]
7d25: 24 28        MOVW    BC,AX
7d27: 06 00 01     MOV     A,[DE+01H]
7d2a: d8           XCH     A,X
7d2b: 06 00 02     MOV     A,[DE+02H]
7d2e: 1a 96        MOVW    0FE96H,AX
7d30: 25 02        XCH     X,C
7d32: db           XCH     A,B
7d33: 1a 98        MOVW    0FE98H,AX
7d35: 1c 90        MOVW    AX,0FE90H
7d37: 1a 92        MOVW    0FE92H,AX
7d39: 1c 90        MOVW    AX,0FE90H
7d3b: 64 1e fd     MOVW    DE,#0FD1EH
7d3e: 05 e6        MOVW    [DE],AX
7d40: 34           POP     AX
7d41: 37           POP     HL
7d42: 56           RET
7d43: 3f           PUSH    HL
7d44: 05 c9        DECW    SP
7d46: 05 c9        DECW    SP
7d48: 11 fc        MOVW    AX,SP
7d4a: 24 68        MOVW    HL,AX
7d4c: 09 f0 90 fe  MOV     A,!0FE90H
7d50: d8           XCH     A,X
7d51: 09 f0 91 fe  MOV     A,!0FE91H
7d55: 3c           PUSH    AX
7d56: 28 e8 7d     CALL    !7DE8H
7d59: 34           POP     AX
7d5a: b9 00        MOV     A,#00H
7d5c: 06 a0 01     MOV     [HL+01H],A
7d5f: 06 20 01     MOV     A,[HL+01H]
7d62: af 07        CMP     A,#07H
7d64: 82 24        BNC     $7D8AH
7d66: 1c 6a        MOVW    AX,0FE6AH
7d68: 44           INCW    AX
7d69: 1a 6a        MOVW    0FE6AH,AX
7d6b: 4c           DECW    AX
7d6c: 3c           PUSH    AX
7d6d: 28 2b 7c     CALL    !7C2BH
7d70: 34           POP     AX
7d71: 1c 63        MOVW    AX,0FE63H
7d73: 24 48        MOVW    DE,AX
7d75: 06 20 01     MOV     A,[HL+01H]
7d78: b8 00        MOV     X,#00H
7d7a: d8           XCH     A,X
7d7b: 88 0c        ADDW    AX,DE
7d7d: 24 48        MOVW    DE,AX
7d7f: d2           MOV     A,C
7d80: 54           MOV     [DE],A
7d81: 06 20 01     MOV     A,[HL+01H]
7d84: c1           INC     A
7d85: 06 a0 01     MOV     [HL+01H],A
7d88: 14 d5        BR      $7D5FH
7d8a: b9 00        MOV     A,#00H
7d8c: 06 a0 01     MOV     [HL+01H],A
7d8f: 06 20 01     MOV     A,[HL+01H]
7d92: af 07        CMP     A,#07H
7d94: 82 21        BNC     $7DB7H
7d96: 1c 6a        MOVW    AX,0FE6AH
7d98: 44           INCW    AX
7d99: 1a 6a        MOVW    0FE6AH,AX
7d9b: 4c           DECW    AX
7d9c: 3c           PUSH    AX
7d9d: 28 2b 7c     CALL    !7C2BH
7da0: 34           POP     AX
7da1: 06 20 01     MOV     A,[HL+01H]
7da4: b8 00        MOV     X,#00H
7da6: d8           XCH     A,X
7da7: 2d 0f fd     ADDW    AX,#0FD0FH
7daa: 24 48        MOVW    DE,AX
7dac: d2           MOV     A,C
7dad: 54           MOV     [DE],A
7dae: 06 20 01     MOV     A,[HL+01H]
7db1: c1           INC     A
7db2: 06 a0 01     MOV     [HL+01H],A
7db5: 14 d8        BR      $7D8FH
7db7: 1c 63        MOVW    AX,0FE63H
7db9: 24 48        MOVW    DE,AX
7dbb: 06 00 06     MOV     A,[DE+06H]
7dbe: 30 99        SHR     A,3
7dc0: ac 07        AND     A,#07H
7dc2: b8 00        MOV     X,#00H
7dc4: d8           XCH     A,X
7dc5: 2f 04 00     CMPW    AX,#0004H
7dc8: 80 0e        BNZ     $7DD8H
7dca: 1c 63        MOVW    AX,0FE63H
7dcc: 24 48        MOVW    DE,AX
7dce: 06 00 06     MOV     A,[DE+06H]
7dd1: ac f8        AND     A,#0F8H
7dd3: ae 04        OR      A,#04H
7dd5: 06 80 06     MOV     [DE+06H],A
7dd8: 1c 90        MOVW    AX,0FE90H
7dda: 64 1e fd     MOVW    DE,#0FD1EH
7ddd: 05 e6        MOVW    [DE],AX
7ddf: 28 ec 94     CALL    !94ECH
7de2: 28 2b 92     CALL    !922BH
7de5: 34           POP     AX
7de6: 37           POP     HL
7de7: 56           RET
7de8: 3f           PUSH    HL
7de9: 11 fc        MOVW    AX,SP
7deb: 24 68        MOVW    HL,AX
7ded: 06 20 04     MOV     A,[HL+04H]
7df0: d8           XCH     A,X
7df1: 06 20 05     MOV     A,[HL+05H]
7df4: 3c           PUSH    AX
7df5: 28 b6 8b     CALL    !8BB6H
7df8: 34           POP     AX
7df9: 24 4a        MOVW    DE,BC
7dfb: 05 e2        MOVW    AX,[DE]
7dfd: 06 a0 05     MOV     [HL+05H],A
7e00: d8           XCH     A,X
7e01: 06 a0 04     MOV     [HL+04H],A
7e04: d8           XCH     A,X
7e05: 1a a4        MOVW    0FEA4H,AX
7e07: 0c a6 12 00  MOVW    0FEA6H,#0012H
7e0b: 28 f7 ab     CALL    Multiply_Thing
7e0e: 1c a4        MOVW    AX,0FEA4H
7e10: 2d 00 c0     ADDW    AX,#0C000H
7e13: 1a 6a        MOVW    0FE6AH,AX
7e15: 37           POP     HL
7e16: 56           RET
7e17: 3f           PUSH    HL
7e18: 05 c9        DECW    SP
7e1a: 05 c9        DECW    SP
7e1c: 11 fc        MOVW    AX,SP
7e1e: 24 68        MOVW    HL,AX
7e20: 8a 08        SUBW    AX,AX
7e22: 55           MOV     [HL],A
7e23: 06 a0 01     MOV     [HL+01H],A
7e26: 1c 90        MOVW    AX,0FE90H
7e28: 3c           PUSH    AX
7e29: 28 b0 82     CALL    !82B0H
7e2c: 34           POP     AX
7e2d: 24 0a        MOVW    AX,BC
7e2f: 1a 90        MOVW    0FE90H,AX
7e31: 2f 40 04     CMPW    AX,#0440H
7e34: 80 04        BNZ     $7E3AH
7e36: 0c 90 00 00  MOVW    0FE90H,#0000H
7e3a: 05 e3        MOVW    AX,[HL]
7e3c: 44           INCW    AX
7e3d: 06 a0 01     MOV     [HL+01H],A
7e40: d8           XCH     A,X
7e41: 55           MOV     [HL],A
7e42: d8           XCH     A,X
7e43: 2f b8 01     CMPW    AX,#01B8H
7e46: 82 09        BNC     $7E51H
7e48: 28 86 7f     CALL    !7F86H
7e4b: 8a 08        SUBW    AX,AX
7e4d: 8f 0a        CMPW    AX,BC
7e4f: 81 d5        BZ      $7E26H
7e51: 34           POP     AX
7e52: 37           POP     HL
7e53: 56           RET
7e54: 3f           PUSH    HL
7e55: 05 c9        DECW    SP
7e57: 05 c9        DECW    SP
7e59: 11 fc        MOVW    AX,SP
7e5b: 24 68        MOVW    HL,AX
7e5d: b9 00        MOV     A,#00H
7e5f: 06 a0 01     MOV     [HL+01H],A
7e62: 8a 08        SUBW    AX,AX
7e64: 1f 90        CMPW    AX,0FE90H
7e66: 80 04        BNZ     $7E6CH
7e68: 0c 90 40 04  MOVW    0FE90H,#0440H
7e6c: 64 90 fe     MOVW    DE,#0FE90H
7e6f: 5c           MOV     A,[DE]
7e70: aa 01        SUB     A,#01H
7e72: 0f           ADJBS
7e73: 54           MOV     [DE],A
7e74: 06 00 01     MOV     A,[DE+01H]
7e77: ab 00        SUBC    A,#00H
7e79: 0f           ADJBS
7e7a: 06 80 01     MOV     [DE+01H],A
7e7d: 06 20 01     MOV     A,[HL+01H]
7e80: c1           INC     A
7e81: 06 a0 01     MOV     [HL+01H],A
7e84: b8 00        MOV     X,#00H
7e86: d8           XCH     A,X
7e87: 2f b8 01     CMPW    AX,#01B8H
7e8a: 82 0c        BNC     $7E98H
7e8c: 28 86 7f     CALL    !7F86H
7e8f: 8a 08        SUBW    AX,AX
7e91: 8f 0a        CMPW    AX,BC
7e93: 80 03        BNZ     $7E98H
7e95: 2c 62 7e     BR      !7E62H
7e98: 34           POP     AX
7e99: 37           POP     HL
7e9a: 56           RET
7e9b: 3f           PUSH    HL
7e9c: 11 fc        MOVW    AX,SP
7e9e: 2e 04 00     SUBW    AX,#0004H
7ea1: 24 68        MOVW    HL,AX
7ea3: 13 fc        MOVW    SP,AX
7ea5: 8a 08        SUBW    AX,AX
7ea7: 06 a0 02     MOV     [HL+02H],A
7eaa: 06 a0 03     MOV     [HL+03H],A
7ead: 06 20 02     MOV     A,[HL+02H]
7eb0: d8           XCH     A,X
7eb1: 06 20 03     MOV     A,[HL+03H]
7eb4: 2f 40 04     CMPW    AX,#0440H
7eb7: 82 3d        BNC     $7EF6H
7eb9: 06 20 02     MOV     A,[HL+02H]
7ebc: d8           XCH     A,X
7ebd: 06 20 03     MOV     A,[HL+03H]
7ec0: 3c           PUSH    AX
7ec1: 28 e8 7d     CALL    !7DE8H
7ec4: 34           POP     AX
7ec5: 1c 6a        MOVW    AX,0FE6AH
7ec7: 3c           PUSH    AX
7ec8: 28 2b 7c     CALL    !7C2BH
7ecb: 34           POP     AX
7ecc: 24 0a        MOVW    AX,BC
7ece: 2f ff 00     CMPW    AX,#00FFH
7ed1: 81 0c        BZ      $7EDFH
7ed3: 1c 6a        MOVW    AX,0FE6AH
7ed5: 3c           PUSH    AX
7ed6: 60 ff 00     MOVW    AX,#00FFH
7ed9: 3c           PUSH    AX
7eda: 28 18 7b     CALL    !7B18H
7edd: 34           POP     AX
7ede: 34           POP     AX
7edf: 06 20 02     MOV     A,[HL+02H]
7ee2: d8           XCH     A,X
7ee3: 06 20 03     MOV     A,[HL+03H]
7ee6: 3c           PUSH    AX
7ee7: 28 b0 82     CALL    !82B0H
7eea: 34           POP     AX
7eeb: 24 0a        MOVW    AX,BC
7eed: 06 a0 03     MOV     [HL+03H],A
7ef0: d8           XCH     A,X
7ef1: 06 a0 02     MOV     [HL+02H],A
7ef4: 14 b7        BR      $7EADH
7ef6: 0c 92 ab 0b  MOVW    0FE92H,#0BABH
7efa: 0c 94 ab 0b  MOVW    0FE94H,#0BABH
7efe: 60 ab 0b     MOVW    AX,#0BABH
7f01: 64 22 fd     MOVW    DE,#0FD22H
7f04: 05 e6        MOVW    [DE],AX
7f06: 64 20 fd     MOVW    DE,#0FD20H
7f09: 05 e6        MOVW    [DE],AX
7f0b: 64 1e fd     MOVW    DE,#0FD1EH
7f0e: 05 e6        MOVW    [DE],AX
7f10: 1a 90        MOVW    0FE90H,AX
7f12: 60 0b 00     MOVW    AX,#000BH
7f15: 3c           PUSH    AX
7f16: 28 6d 8b     CALL    Delay_Loop
7f19: 34           POP     AX
7f1a: 28 ce 7a     CALL    Query_DFBE
7f1d: 64 55 d5     MOVW    DE,#0D555H
7f20: b9 aa        MOV     A,#0AAH
7f22: 54           MOV     [DE],A
7f23: 64 aa ca     MOVW    DE,#0CAAAH
7f26: b9 55        MOV     A,#55H
7f28: 54           MOV     [DE],A
7f29: 64 55 d5     MOVW    DE,#0D555H
7f2c: b9 a0        MOV     A,#0A0H
7f2e: 54           MOV     [DE],A
7f2f: 64 d7 df     MOVW    DE,#0DFD7H
7f32: 60 ab 0b     MOVW    AX,#0BABH
7f35: 05 e6        MOVW    [DE],AX
7f37: 60 99 99     MOVW    AX,#9999H
7f3a: 62 99 19     MOVW    BC,#1999H
7f3d: 1a 9a        MOVW    0FE9AH,AX
7f3f: 25 02        XCH     X,C
7f41: db           XCH     A,B
7f42: 1a 9c        MOVW    0FE9CH,AX
7f44: 8a 08        SUBW    AX,AX
7f46: 24 28        MOVW    BC,AX
7f48: 1a 96        MOVW    0FE96H,AX
7f4a: 25 02        XCH     X,C
7f4c: db           XCH     A,B
7f4d: 1a 98        MOVW    0FE98H,AX
7f4f: b1 69        SET1    0FE69H.1
7f51: b1 68        SET1    0FE68H.1
7f53: b2 68        SET1    0FE68H.2
7f55: a6 67        CLR1    0FE67H.6
7f57: a5 65        CLR1    0FE65H.5
7f59: 34           POP     AX
7f5a: 34           POP     AX
7f5b: 37           POP     HL
7f5c: 56           RET
7f5d: 09 f0 90 fe  MOV     A,!0FE90H
7f61: d8           XCH     A,X
7f62: 09 f0 91 fe  MOV     A,!0FE91H
7f66: 3c           PUSH    AX
7f67: 28 a5 83     CALL    !83A5H
7f6a: 34           POP     AX
7f6b: 09 f0 90 fe  MOV     A,!0FE90H
7f6f: d8           XCH     A,X
7f70: 09 f0 91 fe  MOV     A,!0FE91H
7f74: 3c           PUSH    AX
7f75: 28 e8 7d     CALL    !7DE8H
7f78: 34           POP     AX
7f79: 1c 6a        MOVW    AX,0FE6AH
7f7b: 3c           PUSH    AX
7f7c: 60 ff 00     MOVW    AX,#00FFH
7f7f: 3c           PUSH    AX
7f80: 28 18 7b     CALL    !7B18H
7f83: 34           POP     AX
7f84: 34           POP     AX
7f85: 56           RET
7f86: 3a 6b 00     MOV     0FE6BH,#00H
7f89: 20 91        MOV     A,0FE91H
7f8b: 30 a1        SHR     A,4
7f8d: b8 0a        MOV     X,#0AH
7f8f: 05 08        MULU    X
7f91: 20 91        MOV     A,0FE91H
7f93: ac 0f        AND     A,#0FH
7f95: da           XCH     A,C
7f96: b9 00        MOV     A,#00H
7f98: bb 00        MOV     B,#00H
7f9a: 88 0a        ADDW    AX,BC
7f9c: d0           MOV     A,X
7f9d: 22 6a        MOV     0FE6AH,A
7f9f: 1c 6a        MOVW    AX,0FE6AH
7fa1: 1a a4        MOVW    0FEA4H,AX
7fa3: 0c a6 64 00  MOVW    0FEA6H,#0064H
7fa7: 28 f7 ab     CALL    Multiply_Thing
7faa: 20 90        MOV     A,0FE90H
7fac: 30 a1        SHR     A,4
7fae: b8 0a        MOV     X,#0AH
7fb0: 05 08        MULU    X
7fb2: b9 00        MOV     A,#00H
7fb4: 1d a4        ADDW    AX,0FEA4H
7fb6: 24 28        MOVW    BC,AX
7fb8: 20 90        MOV     A,0FE90H
7fba: ac 0f        AND     A,#0FH
7fbc: b8 00        MOV     X,#00H
7fbe: d8           XCH     A,X
7fbf: 88 0a        ADDW    AX,BC
7fc1: 1a a6        MOVW    0FEA6H,AX
7fc3: 0c a4 12 00  MOVW    0FEA4H,#0012H
7fc7: 28 f7 ab     CALL    Multiply_Thing
7fca: 1c a4        MOVW    AX,0FEA4H
7fcc: 2d 00 c0     ADDW    AX,#0C000H
7fcf: 1a 6a        MOVW    0FE6AH,AX
7fd1: 60 0f 00     MOVW    AX,#000FH
7fd4: 3c           PUSH    AX
7fd5: 28 6d 8b     CALL    Delay_Loop
7fd8: 34           POP     AX
7fd9: 28 ce 7a     CALL    Query_DFBE
7fdc: 08 a6 65 28  BF      0FE65H.6,$8008H
7fe0: 09 f0 97 fd  MOV     A,!0FD97H
7fe4: ac 04        AND     A,#04H
7fe6: af 04        CMP     A,#04H
7fe8: 81 0a        BZ      $7FF4H
7fea: 09 f0 97 fd  MOV     A,!0FD97H
7fee: ac 02        AND     A,#02H
7ff0: af 02        CMP     A,#02H
7ff2: 80 14        BNZ     $8008H
7ff4: 1c 6a        MOVW    AX,0FE6AH
7ff6: 3c           PUSH    AX
7ff7: 28 2b 7c     CALL    !7C2BH
7ffa: 34           POP     AX
7ffb: d2           MOV     A,C
7ffc: ac 03        AND     A,#03H
7ffe: b9 00        MOV     A,#00H
8000: 80 01        BNZ     $8003H
8002: c1           INC     A
8003: bb 00        MOV     B,#00H
8005: da           XCH     A,C
8006: 14 0f        BR      $8017H
8008: 1c 6a        MOVW    AX,0FE6AH
800a: 3c           PUSH    AX
800b: 28 2b 7c     CALL    !7C2BH
800e: 34           POP     AX
800f: d2           MOV     A,C
8010: ac 01        AND     A,#01H
8012: ad 01        XOR     A,#01H
8014: bb 00        MOV     B,#00H
8016: da           XCH     A,C
8017: 56           RET
8018: 3f           PUSH    HL
8019: 05 c9        DECW    SP
801b: 05 c9        DECW    SP
801d: 11 fc        MOVW    AX,SP
801f: 24 68        MOVW    HL,AX
8021: 0c 90 00 00  MOVW    0FE90H,#0000H
8025: 28 17 7e     CALL    !7E17H
8028: 8a 08        SUBW    AX,AX
802a: 1f 90        CMPW    AX,0FE90H
802c: 80 0d        BNZ     $803BH
802e: 28 86 7f     CALL    !7F86H
8031: 8a 08        SUBW    AX,AX
8033: 8f 0a        CMPW    AX,BC
8035: 80 04        BNZ     $803BH
8037: 0c 90 ab 0b  MOVW    0FE90H,#0BABH
803b: 1c 90        MOVW    AX,0FE90H
803d: 64 1e fd     MOVW    DE,#0FD1EH
8040: 05 e6        MOVW    [DE],AX
8042: 34           POP     AX
8043: 37           POP     HL
8044: 56           RET
8045: 3f           PUSH    HL
8046: 11 fc        MOVW    AX,SP
8048: 2e 06 00     SUBW    AX,#0006H
804b: 24 68        MOVW    HL,AX
804d: 13 fc        MOVW    SP,AX
804f: 0c 92 ab 0b  MOVW    0FE92H,#0BABH
8053: 0c 94 ab 0b  MOVW    0FE94H,#0BABH
8057: 8a 08        SUBW    AX,AX
8059: 24 28        MOVW    BC,AX
805b: 1a 96        MOVW    0FE96H,AX
805d: 25 02        XCH     X,C
805f: db           XCH     A,B
8060: 1a 98        MOVW    0FE98H,AX
8062: 60 99 99     MOVW    AX,#9999H
8065: 62 99 19     MOVW    BC,#1999H
8068: 1a 9a        MOVW    0FE9AH,AX
806a: 25 02        XCH     X,C
806c: db           XCH     A,B
806d: 1a 9c        MOVW    0FE9CH,AX
806f: 06 20 0a     MOV     A,[HL+0AH]
8072: d8           XCH     A,X
8073: 06 20 0b     MOV     A,[HL+0BH]
8076: 3c           PUSH    AX
8077: 28 e8 7d     CALL    !7DE8H
807a: 34           POP     AX
807b: 1c 6a        MOVW    AX,0FE6AH
807d: 06 a0 01     MOV     [HL+01H],A
8080: d8           XCH     A,X
8081: 55           MOV     [HL],A
8082: 60 00 c0     MOVW    AX,#0C000H
8085: 06 a0 03     MOV     [HL+03H],A
8088: d8           XCH     A,X
8089: 06 a0 02     MOV     [HL+02H],A
808c: 8a 08        SUBW    AX,AX
808e: 06 a0 04     MOV     [HL+04H],A
8091: 06 a0 05     MOV     [HL+05H],A
8094: 60 0b 00     MOVW    AX,#000BH
8097: 3c           PUSH    AX
8098: 28 6d 8b     CALL    Delay_Loop
809b: 34           POP     AX
809c: 28 ce 7a     CALL    Query_DFBE
809f: 06 20 0a     MOV     A,[HL+0AH]
80a2: d8           XCH     A,X
80a3: 06 20 0b     MOV     A,[HL+0BH]
80a6: 24 28        MOVW    BC,AX
80a8: 06 20 04     MOV     A,[HL+04H]
80ab: d8           XCH     A,X
80ac: 06 20 05     MOV     A,[HL+05H]
80af: 8f 0a        CMPW    AX,BC
80b1: 80 03        BNZ     $80B6H
80b3: 2c 76 82     BR      !8276H
80b6: 06 20 02     MOV     A,[HL+02H]
80b9: d8           XCH     A,X
80ba: 06 20 03     MOV     A,[HL+03H]
80bd: 24 48        MOVW    DE,AX
80bf: 5c           MOV     A,[DE]
80c0: ac 01        AND     A,#01H
80c2: 81 03        BZ      $80C7H
80c4: 2c 76 82     BR      !8276H
80c7: 06 20 02     MOV     A,[HL+02H]
80ca: d8           XCH     A,X
80cb: 06 20 03     MOV     A,[HL+03H]
80ce: 24 48        MOVW    DE,AX
80d0: 06 00 01     MOV     A,[DE+01H]
80d3: d8           XCH     A,X
80d4: 06 00 02     MOV     A,[DE+02H]
80d7: 1a a4        MOVW    0FEA4H,AX
80d9: 06 00 03     MOV     A,[DE+03H]
80dc: d8           XCH     A,X
80dd: 06 00 04     MOV     A,[DE+04H]
80e0: 1a a6        MOVW    0FEA6H,AX
80e2: 05 e3        MOVW    AX,[HL]
80e4: 24 48        MOVW    DE,AX
80e6: 06 00 01     MOV     A,[DE+01H]
80e9: d8           XCH     A,X
80ea: 06 00 02     MOV     A,[DE+02H]
80ed: 1a a8        MOVW    0FEA8H,AX
80ef: 06 00 03     MOV     A,[DE+03H]
80f2: d8           XCH     A,X
80f3: 06 00 04     MOV     A,[DE+04H]
80f6: 1a aa        MOVW    0FEAAH,AX
80f8: 28 ea ab     CALL    Compare_32Bits
80fb: 81 03        BZ      $8100H
80fd: 2c 8c 81     BR      !818CH
8100: 06 20 04     MOV     A,[HL+04H]
8103: d8           XCH     A,X
8104: 06 20 05     MOV     A,[HL+05H]
8107: 24 28        MOVW    BC,AX
8109: 06 20 0a     MOV     A,[HL+0AH]
810c: d8           XCH     A,X
810d: 06 20 0b     MOV     A,[HL+0BH]
8110: 8f 0a        CMPW    AX,BC
8112: 82 38        BNC     $814CH
8114: 05 e3        MOVW    AX,[HL]
8116: 24 48        MOVW    DE,AX
8118: 06 00 01     MOV     A,[DE+01H]
811b: d8           XCH     A,X
811c: 06 00 02     MOV     A,[DE+02H]
811f: 1a a4        MOVW    0FEA4H,AX
8121: 06 00 03     MOV     A,[DE+03H]
8124: d8           XCH     A,X
8125: 06 00 04     MOV     A,[DE+04H]
8128: 1a a6        MOVW    0FEA6H,AX
812a: 1c 96        MOVW    AX,0FE96H
812c: 1a a8        MOVW    0FEA8H,AX
812e: 1c 98        MOVW    AX,0FE98H
8130: 1a aa        MOVW    0FEAAH,AX
8132: 28 ea ab     CALL    Compare_32Bits
8135: 81 05        BZ      $813CH
8137: 2c f2 81     BR      !81F2H
813a: 14 0e        BR      $814AH
813c: 06 20 04     MOV     A,[HL+04H]
813f: d8           XCH     A,X
8140: 06 20 05     MOV     A,[HL+05H]
8143: 1f 92        CMPW    AX,0FE92H
8145: 82 03        BNC     $814AH
8147: 2c f2 81     BR      !81F2H
814a: 14 3d        BR      $8189H
814c: 06 20 02     MOV     A,[HL+02H]
814f: d8           XCH     A,X
8150: 06 20 03     MOV     A,[HL+03H]
8153: 24 48        MOVW    DE,AX
8155: 06 00 01     MOV     A,[DE+01H]
8158: d8           XCH     A,X
8159: 06 00 02     MOV     A,[DE+02H]
815c: 1a a4        MOVW    0FEA4H,AX
815e: 06 00 03     MOV     A,[DE+03H]
8161: d8           XCH     A,X
8162: 06 00 04     MOV     A,[DE+04H]
8165: 1a a6        MOVW    0FEA6H,AX
8167: 1c 9a        MOVW    AX,0FE9AH
8169: 1a a8        MOVW    0FEA8H,AX
816b: 1c 9c        MOVW    AX,0FE9CH
816d: 1a aa        MOVW    0FEAAH,AX
816f: 28 ea ab     CALL    Compare_32Bits
8172: 81 05        BZ      $8179H
8174: 2c 4d 82     BR      !824DH
8177: 14 10        BR      $8189H
8179: 06 20 04     MOV     A,[HL+04H]
817c: d8           XCH     A,X
817d: 06 20 05     MOV     A,[HL+05H]
8180: 1f 94        CMPW    AX,0FE94H
8182: 83 05        BC      $8189H
8184: 81 03        BZ      $8189H
8186: 2c 4d 82     BR      !824DH
8189: 2c 76 82     BR      !8276H
818c: 06 20 02     MOV     A,[HL+02H]
818f: d8           XCH     A,X
8190: 06 20 03     MOV     A,[HL+03H]
8193: 24 48        MOVW    DE,AX
8195: 06 00 01     MOV     A,[DE+01H]
8198: d8           XCH     A,X
8199: 06 00 02     MOV     A,[DE+02H]
819c: 1a a4        MOVW    0FEA4H,AX
819e: 06 00 03     MOV     A,[DE+03H]
81a1: d8           XCH     A,X
81a2: 06 00 04     MOV     A,[DE+04H]
81a5: 1a a6        MOVW    0FEA6H,AX
81a7: 05 e3        MOVW    AX,[HL]
81a9: 24 48        MOVW    DE,AX
81ab: 06 00 01     MOV     A,[DE+01H]
81ae: d8           XCH     A,X
81af: 06 00 02     MOV     A,[DE+02H]
81b2: 1a a8        MOVW    0FEA8H,AX
81b4: 06 00 03     MOV     A,[DE+03H]
81b7: d8           XCH     A,X
81b8: 06 00 04     MOV     A,[DE+04H]
81bb: 1a aa        MOVW    0FEAAH,AX
81bd: 28 ea ab     CALL    Compare_32Bits
81c0: 82 5b        BNC     $821DH
81c2: 06 20 02     MOV     A,[HL+02H]
81c5: d8           XCH     A,X
81c6: 06 20 03     MOV     A,[HL+03H]
81c9: 24 48        MOVW    DE,AX
81cb: 06 00 01     MOV     A,[DE+01H]
81ce: d8           XCH     A,X
81cf: 06 00 02     MOV     A,[DE+02H]
81d2: 1a a4        MOVW    0FEA4H,AX
81d4: 06 00 03     MOV     A,[DE+03H]
81d7: d8           XCH     A,X
81d8: 06 00 04     MOV     A,[DE+04H]
81db: 1a a6        MOVW    0FEA6H,AX
81dd: 1c a4        MOVW    AX,0FEA4H
81df: 1a a8        MOVW    0FEA8H,AX
81e1: 1c a6        MOVW    AX,0FEA6H
81e3: 1a aa        MOVW    0FEAAH,AX
81e5: 1c 96        MOVW    AX,0FE96H
81e7: 1a a4        MOVW    0FEA4H,AX
81e9: 1c 98        MOVW    AX,0FE98H
81eb: 1a a6        MOVW    0FEA6H,AX
81ed: 28 ea ab     CALL    Compare_32Bits
81f0: 82 29        BNC     $821BH
81f2: 06 20 02     MOV     A,[HL+02H]
81f5: d8           XCH     A,X
81f6: 06 20 03     MOV     A,[HL+03H]
81f9: 3c           PUSH    AX
81fa: 36           POP     DE
81fb: 06 00 03     MOV     A,[DE+03H]
81fe: d8           XCH     A,X
81ff: 06 00 04     MOV     A,[DE+04H]
8202: 24 28        MOVW    BC,AX
8204: 06 00 01     MOV     A,[DE+01H]
8207: d8           XCH     A,X
8208: 06 00 02     MOV     A,[DE+02H]
820b: 1a 96        MOVW    0FE96H,AX
820d: 25 02        XCH     X,C
820f: db           XCH     A,B
8210: 1a 98        MOVW    0FE98H,AX
8212: 06 20 04     MOV     A,[HL+04H]
8215: d8           XCH     A,X
8216: 06 20 05     MOV     A,[HL+05H]
8219: 1a 92        MOVW    0FE92H,AX
821b: 14 59        BR      $8276H
821d: 06 20 02     MOV     A,[HL+02H]
8220: d8           XCH     A,X
8221: 06 20 03     MOV     A,[HL+03H]
8224: 24 48        MOVW    DE,AX
8226: 06 00 01     MOV     A,[DE+01H]
8229: d8           XCH     A,X
822a: 06 00 02     MOV     A,[DE+02H]
822d: 1a a4        MOVW    0FEA4H,AX
822f: 06 00 03     MOV     A,[DE+03H]
8232: d8           XCH     A,X
8233: 06 00 04     MOV     A,[DE+04H]
8236: 1a a6        MOVW    0FEA6H,AX
8238: 1c a4        MOVW    AX,0FEA4H
823a: 1a a8        MOVW    0FEA8H,AX
823c: 1c a6        MOVW    AX,0FEA6H
823e: 1a aa        MOVW    0FEAAH,AX
8240: 1c 9a        MOVW    AX,0FE9AH
8242: 1a a4        MOVW    0FEA4H,AX
8244: 1c 9c        MOVW    AX,0FE9CH
8246: 1a a6        MOVW    0FEA6H,AX
8248: 28 ea ab     CALL    Compare_32Bits
824b: 83 29        BC      $8276H
824d: 06 20 02     MOV     A,[HL+02H]
8250: d8           XCH     A,X
8251: 06 20 03     MOV     A,[HL+03H]
8254: 3c           PUSH    AX
8255: 36           POP     DE
8256: 06 00 03     MOV     A,[DE+03H]
8259: d8           XCH     A,X
825a: 06 00 04     MOV     A,[DE+04H]
825d: 24 28        MOVW    BC,AX
825f: 06 00 01     MOV     A,[DE+01H]
8262: d8           XCH     A,X
8263: 06 00 02     MOV     A,[DE+02H]
8266: 1a 9a        MOVW    0FE9AH,AX
8268: 25 02        XCH     X,C
826a: db           XCH     A,B
826b: 1a 9c        MOVW    0FE9CH,AX
826d: 06 20 04     MOV     A,[HL+04H]
8270: d8           XCH     A,X
8271: 06 20 05     MOV     A,[HL+05H]
8274: 1a 94        MOVW    0FE94H,AX
8276: 06 20 02     MOV     A,[HL+02H]
8279: d8           XCH     A,X
827a: 06 20 03     MOV     A,[HL+03H]
827d: 2d 12 00     ADDW    AX,#0012H
8280: 06 a0 03     MOV     [HL+03H],A
8283: d8           XCH     A,X
8284: 06 a0 02     MOV     [HL+02H],A
8287: 06 20 04     MOV     A,[HL+04H]
828a: d8           XCH     A,X
828b: 06 20 05     MOV     A,[HL+05H]
828e: 3c           PUSH    AX
828f: 28 b0 82     CALL    !82B0H
8292: 34           POP     AX
8293: 24 0a        MOVW    AX,BC
8295: 06 a0 05     MOV     [HL+05H],A
8298: d8           XCH     A,X
8299: 06 a0 04     MOV     [HL+04H],A
829c: 06 20 04     MOV     A,[HL+04H]
829f: d8           XCH     A,X
82a0: 06 20 05     MOV     A,[HL+05H]
82a3: 2f 40 04     CMPW    AX,#0440H
82a6: 82 03        BNC     $82ABH
82a8: 2c 9f 80     BR      !809FH
82ab: 34           POP     AX
82ac: 34           POP     AX
82ad: 34           POP     AX
82ae: 37           POP     HL
82af: 56           RET
82b0: 3f           PUSH    HL
82b1: 11 fc        MOVW    AX,SP
82b3: 24 68        MOVW    HL,AX
82b5: 06 20 04     MOV     A,[HL+04H]
82b8: a8 01        ADD     A,#01H
82ba: 0e           ADJBA
82bb: 06 a0 04     MOV     [HL+04H],A
82be: 06 20 05     MOV     A,[HL+05H]
82c1: a9 00        ADDC    A,#00H
82c3: 0e           ADJBA
82c4: 06 a0 05     MOV     [HL+05H],A
82c7: 06 20 04     MOV     A,[HL+04H]
82ca: d8           XCH     A,X
82cb: 06 20 05     MOV     A,[HL+05H]
82ce: 24 28        MOVW    BC,AX
82d0: 37           POP     HL
82d1: 56           RET
82d2: 3f           PUSH    HL
82d3: 11 fc        MOVW    AX,SP
82d5: 24 68        MOVW    HL,AX
82d7: 06 20 04     MOV     A,[HL+04H]
82da: aa 01        SUB     A,#01H
82dc: 0f           ADJBS
82dd: 06 a0 04     MOV     [HL+04H],A
82e0: 06 20 05     MOV     A,[HL+05H]
82e3: ab 00        SUBC    A,#00H
82e5: 0f           ADJBS
82e6: 06 a0 05     MOV     [HL+05H],A
82e9: 06 20 04     MOV     A,[HL+04H]
82ec: d8           XCH     A,X
82ed: 06 20 05     MOV     A,[HL+05H]
82f0: 24 28        MOVW    BC,AX
82f2: 37           POP     HL
82f3: 56           RET
82f4: 3f           PUSH    HL
82f5: 11 fc        MOVW    AX,SP
82f7: 24 68        MOVW    HL,AX
82f9: 06 20 04     MOV     A,[HL+04H]
82fc: d8           XCH     A,X
82fd: 06 20 05     MOV     A,[HL+05H]
8300: 3c           PUSH    AX
8301: 28 45 80     CALL    !8045H
8304: 34           POP     AX
8305: 1c 92        MOVW    AX,0FE92H
8307: 2f ab 0b     CMPW    AX,#0BABH
830a: 80 0c        BNZ     $8318H
830c: 06 20 04     MOV     A,[HL+04H]
830f: d8           XCH     A,X
8310: 06 20 05     MOV     A,[HL+05H]
8313: 64 20 fd     MOVW    DE,#0FD20H
8316: 05 e6        MOVW    [DE],AX
8318: 1c 94        MOVW    AX,0FE94H
831a: 2f ab 0b     CMPW    AX,#0BABH
831d: 80 0c        BNZ     $832BH
831f: 06 20 04     MOV     A,[HL+04H]
8322: d8           XCH     A,X
8323: 06 20 05     MOV     A,[HL+05H]
8326: 64 22 fd     MOVW    DE,#0FD22H
8329: 05 e6        MOVW    [DE],AX
832b: 06 20 04     MOV     A,[HL+04H]
832e: d8           XCH     A,X
832f: 06 20 05     MOV     A,[HL+05H]
8332: 3c           PUSH    AX
8333: 28 e8 7d     CALL    !7DE8H
8336: 34           POP     AX
8337: 1c 6a        MOVW    AX,0FE6AH
8339: 2d 0e 00     ADDW    AX,#000EH
833c: 3c           PUSH    AX
833d: 1c 92        MOVW    AX,0FE92H
833f: 3c           PUSH    AX
8340: 28 63 7b     CALL    !7B63H
8343: 34           POP     AX
8344: 34           POP     AX
8345: 1c 6a        MOVW    AX,0FE6AH
8347: 2d 10 00     ADDW    AX,#0010H
834a: 3c           PUSH    AX
834b: 1c 94        MOVW    AX,0FE94H
834d: 3c           PUSH    AX
834e: 28 63 7b     CALL    !7B63H
8351: 34           POP     AX
8352: 34           POP     AX
8353: 1c 92        MOVW    AX,0FE92H
8355: 2f ab 0b     CMPW    AX,#0BABH
8358: 81 21        BZ      $837BH
835a: 09 f0 92 fe  MOV     A,!0FE92H
835e: d8           XCH     A,X
835f: 09 f0 93 fe  MOV     A,!0FE93H
8363: 3c           PUSH    AX
8364: 28 e8 7d     CALL    !7DE8H
8367: 34           POP     AX
8368: 1c 6a        MOVW    AX,0FE6AH
836a: 2d 10 00     ADDW    AX,#0010H
836d: 3c           PUSH    AX
836e: 06 20 04     MOV     A,[HL+04H]
8371: d8           XCH     A,X
8372: 06 20 05     MOV     A,[HL+05H]
8375: 3c           PUSH    AX
8376: 28 63 7b     CALL    !7B63H
8379: 34           POP     AX
837a: 34           POP     AX
837b: 1c 94        MOVW    AX,0FE94H
837d: 2f ab 0b     CMPW    AX,#0BABH
8380: 81 21        BZ      $83A3H
8382: 09 f0 94 fe  MOV     A,!0FE94H
8386: d8           XCH     A,X
8387: 09 f0 95 fe  MOV     A,!0FE95H
838b: 3c           PUSH    AX
838c: 28 e8 7d     CALL    !7DE8H
838f: 34           POP     AX
8390: 1c 6a        MOVW    AX,0FE6AH
8392: 2d 0e 00     ADDW    AX,#000EH
8395: 3c           PUSH    AX
8396: 06 20 04     MOV     A,[HL+04H]
8399: d8           XCH     A,X
839a: 06 20 05     MOV     A,[HL+05H]
839d: 3c           PUSH    AX
839e: 28 63 7b     CALL    !7B63H
83a1: 34           POP     AX
83a2: 34           POP     AX
83a3: 37           POP     HL
83a4: 56           RET
83a5: 3f           PUSH    HL
83a6: 11 fc        MOVW    AX,SP
83a8: 2e 04 00     SUBW    AX,#0004H
83ab: 24 68        MOVW    HL,AX
83ad: 13 fc        MOVW    SP,AX
83af: 06 20 08     MOV     A,[HL+08H]
83b2: d8           XCH     A,X
83b3: 06 20 09     MOV     A,[HL+09H]
83b6: 3c           PUSH    AX
83b7: 28 e8 7d     CALL    !7DE8H
83ba: 34           POP     AX
83bb: 28 ce 7a     CALL    Query_DFBE
83be: 1c 6a        MOVW    AX,0FE6AH
83c0: 24 48        MOVW    DE,AX
83c2: 06 00 10     MOV     A,[DE+10H]
83c5: d8           XCH     A,X
83c6: 06 00 11     MOV     A,[DE+11H]
83c9: 06 a0 03     MOV     [HL+03H],A
83cc: d8           XCH     A,X
83cd: 06 a0 02     MOV     [HL+02H],A
83d0: 1c 6a        MOVW    AX,0FE6AH
83d2: 24 48        MOVW    DE,AX
83d4: 06 00 0e     MOV     A,[DE+0EH]
83d7: d8           XCH     A,X
83d8: 06 00 0f     MOV     A,[DE+0FH]
83db: 06 a0 01     MOV     [HL+01H],A
83de: d8           XCH     A,X
83df: 55           MOV     [HL],A
83e0: 06 20 02     MOV     A,[HL+02H]
83e3: d8           XCH     A,X
83e4: 06 20 03     MOV     A,[HL+03H]
83e7: 2f ab 0b     CMPW    AX,#0BABH
83ea: 81 37        BZ      $8423H
83ec: 06 20 02     MOV     A,[HL+02H]
83ef: d8           XCH     A,X
83f0: 06 20 03     MOV     A,[HL+03H]
83f3: 3c           PUSH    AX
83f4: 28 e8 7d     CALL    !7DE8H
83f7: 34           POP     AX
83f8: 1c 6a        MOVW    AX,0FE6AH
83fa: 3c           PUSH    AX
83fb: 36           POP     DE
83fc: 06 00 03     MOV     A,[DE+03H]
83ff: d8           XCH     A,X
8400: 06 00 04     MOV     A,[DE+04H]
8403: 24 28        MOVW    BC,AX
8405: 06 00 01     MOV     A,[DE+01H]
8408: d8           XCH     A,X
8409: 06 00 02     MOV     A,[DE+02H]
840c: 1a 9a        MOVW    0FE9AH,AX
840e: 25 02        XCH     X,C
8410: db           XCH     A,B
8411: 1a 9c        MOVW    0FE9CH,AX
8413: 1c 6a        MOVW    AX,0FE6AH
8415: 2d 0e 00     ADDW    AX,#000EH
8418: 3c           PUSH    AX
8419: 05 e3        MOVW    AX,[HL]
841b: 3c           PUSH    AX
841c: 28 63 7b     CALL    !7B63H
841f: 34           POP     AX
8420: 34           POP     AX
8421: 14 14        BR      $8437H
8423: 05 e3        MOVW    AX,[HL]
8425: 64 22 fd     MOVW    DE,#0FD22H
8428: 05 e6        MOVW    [DE],AX
842a: 60 99 99     MOVW    AX,#9999H
842d: 62 99 19     MOVW    BC,#1999H
8430: 1a 9a        MOVW    0FE9AH,AX
8432: 25 02        XCH     X,C
8434: db           XCH     A,B
8435: 1a 9c        MOVW    0FE9CH,AX
8437: 05 e3        MOVW    AX,[HL]
8439: 2f ab 0b     CMPW    AX,#0BABH
843c: 81 3a        BZ      $8478H
843e: 5d           MOV     A,[HL]
843f: d8           XCH     A,X
8440: 06 20 01     MOV     A,[HL+01H]
8443: 3c           PUSH    AX
8444: 28 e8 7d     CALL    !7DE8H
8447: 34           POP     AX
8448: 1c 6a        MOVW    AX,0FE6AH
844a: 3c           PUSH    AX
844b: 36           POP     DE
844c: 06 00 03     MOV     A,[DE+03H]
844f: d8           XCH     A,X
8450: 06 00 04     MOV     A,[DE+04H]
8453: 24 28        MOVW    BC,AX
8455: 06 00 01     MOV     A,[DE+01H]
8458: d8           XCH     A,X
8459: 06 00 02     MOV     A,[DE+02H]
845c: 1a 96        MOVW    0FE96H,AX
845e: 25 02        XCH     X,C
8460: db           XCH     A,B
8461: 1a 98        MOVW    0FE98H,AX
8463: 1c 6a        MOVW    AX,0FE6AH
8465: 2d 10 00     ADDW    AX,#0010H
8468: 3c           PUSH    AX
8469: 06 20 02     MOV     A,[HL+02H]
846c: d8           XCH     A,X
846d: 06 20 03     MOV     A,[HL+03H]
8470: 3c           PUSH    AX
8471: 28 63 7b     CALL    !7B63H
8474: 34           POP     AX
8475: 34           POP     AX
8476: 14 17        BR      $848FH
8478: 06 20 02     MOV     A,[HL+02H]
847b: d8           XCH     A,X
847c: 06 20 03     MOV     A,[HL+03H]
847f: 64 20 fd     MOVW    DE,#0FD20H
8482: 05 e6        MOVW    [DE],AX
8484: 8a 08        SUBW    AX,AX
8486: 24 28        MOVW    BC,AX
8488: 1a 96        MOVW    0FE96H,AX
848a: 25 02        XCH     X,C
848c: db           XCH     A,B
848d: 1a 98        MOVW    0FE98H,AX
848f: 34           POP     AX
8490: 34           POP     AX
8491: 37           POP     HL
8492: 56           RET
8493: 3f           PUSH    HL
8494: 11 fc        MOVW    AX,SP
8496: 2e 04 00     SUBW    AX,#0004H
8499: 24 68        MOVW    HL,AX
849b: 13 fc        MOVW    SP,AX
849d: 60 00 c0     MOVW    AX,#0C000H
84a0: 06 a0 01     MOV     [HL+01H],A
84a3: d8           XCH     A,X
84a4: 55           MOV     [HL],A
84a5: 8a 08        SUBW    AX,AX
84a7: 06 a0 02     MOV     [HL+02H],A
84aa: 06 a0 03     MOV     [HL+03H],A
84ad: 0c 94 ab 0b  MOVW    0FE94H,#0BABH
84b1: 0c 92 ab 0b  MOVW    0FE92H,#0BABH
84b5: 60 ab 0b     MOVW    AX,#0BABH
84b8: 64 22 fd     MOVW    DE,#0FD22H
84bb: 05 e6        MOVW    [DE],AX
84bd: 64 20 fd     MOVW    DE,#0FD20H
84c0: 05 e6        MOVW    [DE],AX
84c2: 8a 08        SUBW    AX,AX
84c4: 24 28        MOVW    BC,AX
84c6: 1a 96        MOVW    0FE96H,AX
84c8: 25 02        XCH     X,C
84ca: db           XCH     A,B
84cb: 1a 98        MOVW    0FE98H,AX
84cd: 60 99 99     MOVW    AX,#9999H
84d0: 62 99 19     MOVW    BC,#1999H
84d3: 1a 9a        MOVW    0FE9AH,AX
84d5: 25 02        XCH     X,C
84d7: db           XCH     A,B
84d8: 1a 9c        MOVW    0FE9CH,AX
84da: 60 0b 00     MOVW    AX,#000BH
84dd: 3c           PUSH    AX
84de: 28 6d 8b     CALL    Delay_Loop
84e1: 34           POP     AX
84e2: 28 ce 7a     CALL    Query_DFBE
84e5: 06 20 02     MOV     A,[HL+02H]
84e8: d8           XCH     A,X
84e9: 06 20 03     MOV     A,[HL+03H]
84ec: 2f 40 04     CMPW    AX,#0440H
84ef: 82 79        BNC     $856AH
84f1: 05 e3        MOVW    AX,[HL]
84f3: 24 48        MOVW    DE,AX
84f5: 5c           MOV     A,[DE]
84f6: ac 01        AND     A,#01H
84f8: b8 00        MOV     X,#00H
84fa: d8           XCH     A,X
84fb: 2f 00 00     CMPW    AX,#0000H
84fe: 80 48        BNZ     $8548H
8500: 05 e3        MOVW    AX,[HL]
8502: 24 48        MOVW    DE,AX
8504: 06 00 0e     MOV     A,[DE+0EH]
8507: d8           XCH     A,X
8508: 06 00 0f     MOV     A,[DE+0FH]
850b: 2f ab 0b     CMPW    AX,#0BABH
850e: 80 0c        BNZ     $851CH
8510: 06 20 02     MOV     A,[HL+02H]
8513: d8           XCH     A,X
8514: 06 20 03     MOV     A,[HL+03H]
8517: 64 20 fd     MOVW    DE,#0FD20H
851a: 05 e6        MOVW    [DE],AX
851c: 05 e3        MOVW    AX,[HL]
851e: 24 48        MOVW    DE,AX
8520: 06 00 10     MOV     A,[DE+10H]
8523: d8           XCH     A,X
8524: 06 00 11     MOV     A,[DE+11H]
8527: 2f ab 0b     CMPW    AX,#0BABH
852a: 80 0c        BNZ     $8538H
852c: 06 20 02     MOV     A,[HL+02H]
852f: d8           XCH     A,X
8530: 06 20 03     MOV     A,[HL+03H]
8533: 64 22 fd     MOVW    DE,#0FD22H
8536: 05 e6        MOVW    [DE],AX
8538: 05 e3        MOVW    AX,[HL]
853a: 3c           PUSH    AX
853b: 06 20 02     MOV     A,[HL+02H]
853e: d8           XCH     A,X
853f: 06 20 03     MOV     A,[HL+03H]
8542: 3c           PUSH    AX
8543: 28 b0 89     CALL    !89B0H
8546: 34           POP     AX
8547: 34           POP     AX
8548: 06 20 02     MOV     A,[HL+02H]
854b: d8           XCH     A,X
854c: 06 20 03     MOV     A,[HL+03H]
854f: 3c           PUSH    AX
8550: 28 b0 82     CALL    !82B0H
8553: 34           POP     AX
8554: 24 0a        MOVW    AX,BC
8556: 06 a0 03     MOV     [HL+03H],A
8559: d8           XCH     A,X
855a: 06 a0 02     MOV     [HL+02H],A
855d: 05 e3        MOVW    AX,[HL]
855f: 2d 12 00     ADDW    AX,#0012H
8562: 06 a0 01     MOV     [HL+01H],A
8565: d8           XCH     A,X
8566: 55           MOV     [HL],A
8567: 2c e5 84     BR      !84E5H
856a: 34           POP     AX
856b: 34           POP     AX
856c: 37           POP     HL
856d: 56           RET
856e: 3f           PUSH    HL
856f: 11 fc        MOVW    AX,SP
8571: 2e 06 00     SUBW    AX,#0006H
8574: 24 68        MOVW    HL,AX
8576: 13 fc        MOVW    SP,AX
8578: 28 ce 7a     CALL    Query_DFBE
857b: 28 14 89     CALL    !8914H
857e: 8a 08        SUBW    AX,AX
8580: 8f 0a        CMPW    AX,BC
8582: 80 03        BNZ     $8587H
8584: 2c 8b 86     BR      !868BH
8587: 1c 94        MOVW    AX,0FE94H
8589: 06 a0 02     MOV     [HL+02H],A
858c: d8           XCH     A,X
858d: 06 a0 01     MOV     [HL+01H],A
8590: 8a 08        SUBW    AX,AX
8592: 06 a0 03     MOV     [HL+03H],A
8595: 06 a0 04     MOV     [HL+04H],A
8598: 09 f0 94 fe  MOV     A,!0FE94H
859c: d8           XCH     A,X
859d: 09 f0 95 fe  MOV     A,!0FE95H
85a1: 3c           PUSH    AX
85a2: 28 e8 7d     CALL    !7DE8H
85a5: 34           POP     AX
85a6: 1c 6a        MOVW    AX,0FE6AH
85a8: 24 48        MOVW    DE,AX
85aa: 06 00 10     MOV     A,[DE+10H]
85ad: d8           XCH     A,X
85ae: 06 00 11     MOV     A,[DE+11H]
85b1: 1a 94        MOVW    0FE94H,AX
85b3: 2f ab 0b     CMPW    AX,#0BABH
85b6: 80 16        BNZ     $85CEH
85b8: 60 99 99     MOVW    AX,#9999H
85bb: 62 99 19     MOVW    BC,#1999H
85be: 1a 9a        MOVW    0FE9AH,AX
85c0: 25 02        XCH     X,C
85c2: db           XCH     A,B
85c3: 1a 9c        MOVW    0FE9CH,AX
85c5: 64 22 fd     MOVW    DE,#0FD22H
85c8: 05 e2        MOVW    AX,[DE]
85ca: 1a 92        MOVW    0FE92H,AX
85cc: 14 29        BR      $85F7H
85ce: 09 f0 94 fe  MOV     A,!0FE94H
85d2: d8           XCH     A,X
85d3: 09 f0 95 fe  MOV     A,!0FE95H
85d7: 3c           PUSH    AX
85d8: 28 e8 7d     CALL    !7DE8H
85db: 34           POP     AX
85dc: 1c 6a        MOVW    AX,0FE6AH
85de: 3c           PUSH    AX
85df: 36           POP     DE
85e0: 06 00 03     MOV     A,[DE+03H]
85e3: d8           XCH     A,X
85e4: 06 00 04     MOV     A,[DE+04H]
85e7: 24 28        MOVW    BC,AX
85e9: 06 00 01     MOV     A,[DE+01H]
85ec: d8           XCH     A,X
85ed: 06 00 02     MOV     A,[DE+02H]
85f0: 1a 9a        MOVW    0FE9AH,AX
85f2: 25 02        XCH     X,C
85f4: db           XCH     A,B
85f5: 1a 9c        MOVW    0FE9CH,AX
85f7: 06 20 03     MOV     A,[HL+03H]
85fa: d8           XCH     A,X
85fb: 06 20 04     MOV     A,[HL+04H]
85fe: 44           INCW    AX
85ff: 06 a0 04     MOV     [HL+04H],A
8602: d8           XCH     A,X
8603: 06 a0 03     MOV     [HL+03H],A
8606: 28 14 89     CALL    !8914H
8609: 8a 08        SUBW    AX,AX
860b: 8f 0a        CMPW    AX,BC
860d: 81 1a        BZ      $8629H
860f: 06 20 01     MOV     A,[HL+01H]
8612: d8           XCH     A,X
8613: 06 20 02     MOV     A,[HL+02H]
8616: 1f 94        CMPW    AX,0FE94H
8618: 81 0f        BZ      $8629H
861a: 06 20 03     MOV     A,[HL+03H]
861d: d8           XCH     A,X
861e: 06 20 04     MOV     A,[HL+04H]
8621: 2f b8 01     CMPW    AX,#01B8H
8624: 82 03        BNC     $8629H
8626: 2c 98 85     BR      !8598H
8629: 1c 94        MOVW    AX,0FE94H
862b: 2f ab 0b     CMPW    AX,#0BABH
862e: 81 1b        BZ      $864BH
8630: 09 f0 94 fe  MOV     A,!0FE94H
8634: d8           XCH     A,X
8635: 09 f0 95 fe  MOV     A,!0FE95H
8639: 3c           PUSH    AX
863a: 28 e8 7d     CALL    !7DE8H
863d: 34           POP     AX
863e: 1c 6a        MOVW    AX,0FE6AH
8640: 24 48        MOVW    DE,AX
8642: 06 00 0e     MOV     A,[DE+0EH]
8645: d8           XCH     A,X
8646: 06 00 0f     MOV     A,[DE+0FH]
8649: 1a 92        MOVW    0FE92H,AX
864b: 1c 92        MOVW    AX,0FE92H
864d: 2f ab 0b     CMPW    AX,#0BABH
8650: 80 0d        BNZ     $865FH
8652: 8a 08        SUBW    AX,AX
8654: 24 28        MOVW    BC,AX
8656: 1a 96        MOVW    0FE96H,AX
8658: 25 02        XCH     X,C
865a: db           XCH     A,B
865b: 1a 98        MOVW    0FE98H,AX
865d: 14 29        BR      $8688H
865f: 09 f0 92 fe  MOV     A,!0FE92H
8663: d8           XCH     A,X
8664: 09 f0 93 fe  MOV     A,!0FE93H
8668: 3c           PUSH    AX
8669: 28 e8 7d     CALL    !7DE8H
866c: 34           POP     AX
866d: 1c 6a        MOVW    AX,0FE6AH
866f: 3c           PUSH    AX
8670: 36           POP     DE
8671: 06 00 03     MOV     A,[DE+03H]
8674: d8           XCH     A,X
8675: 06 00 04     MOV     A,[DE+04H]
8678: 24 28        MOVW    BC,AX
867a: 06 00 01     MOV     A,[DE+01H]
867d: d8           XCH     A,X
867e: 06 00 02     MOV     A,[DE+02H]
8681: 1a 96        MOVW    0FE96H,AX
8683: 25 02        XCH     X,C
8685: db           XCH     A,B
8686: 1a 98        MOVW    0FE98H,AX
8688: 2c 98 87     BR      !8798H
868b: 28 62 89     CALL    !8962H
868e: 8a 08        SUBW    AX,AX
8690: 8f 0a        CMPW    AX,BC
8692: 80 03        BNZ     $8697H
8694: 2c 98 87     BR      !8798H
8697: 1c 92        MOVW    AX,0FE92H
8699: 06 a0 02     MOV     [HL+02H],A
869c: d8           XCH     A,X
869d: 06 a0 01     MOV     [HL+01H],A
86a0: 8a 08        SUBW    AX,AX
86a2: 06 a0 03     MOV     [HL+03H],A
86a5: 06 a0 04     MOV     [HL+04H],A
86a8: 09 f0 92 fe  MOV     A,!0FE92H
86ac: d8           XCH     A,X
86ad: 09 f0 93 fe  MOV     A,!0FE93H
86b1: 3c           PUSH    AX
86b2: 28 e8 7d     CALL    !7DE8H
86b5: 34           POP     AX
86b6: 1c 6a        MOVW    AX,0FE6AH
86b8: 24 48        MOVW    DE,AX
86ba: 06 00 0e     MOV     A,[DE+0EH]
86bd: d8           XCH     A,X
86be: 06 00 0f     MOV     A,[DE+0FH]
86c1: 1a 92        MOVW    0FE92H,AX
86c3: 2f ab 0b     CMPW    AX,#0BABH
86c6: 80 14        BNZ     $86DCH
86c8: 8a 08        SUBW    AX,AX
86ca: 24 28        MOVW    BC,AX
86cc: 1a 96        MOVW    0FE96H,AX
86ce: 25 02        XCH     X,C
86d0: db           XCH     A,B
86d1: 1a 98        MOVW    0FE98H,AX
86d3: 64 20 fd     MOVW    DE,#0FD20H
86d6: 05 e2        MOVW    AX,[DE]
86d8: 1a 94        MOVW    0FE94H,AX
86da: 14 29        BR      $8705H
86dc: 09 f0 92 fe  MOV     A,!0FE92H
86e0: d8           XCH     A,X
86e1: 09 f0 93 fe  MOV     A,!0FE93H
86e5: 3c           PUSH    AX
86e6: 28 e8 7d     CALL    !7DE8H
86e9: 34           POP     AX
86ea: 1c 6a        MOVW    AX,0FE6AH
86ec: 3c           PUSH    AX
86ed: 36           POP     DE
86ee: 06 00 03     MOV     A,[DE+03H]
86f1: d8           XCH     A,X
86f2: 06 00 04     MOV     A,[DE+04H]
86f5: 24 28        MOVW    BC,AX
86f7: 06 00 01     MOV     A,[DE+01H]
86fa: d8           XCH     A,X
86fb: 06 00 02     MOV     A,[DE+02H]
86fe: 1a 96        MOVW    0FE96H,AX
8700: 25 02        XCH     X,C
8702: db           XCH     A,B
8703: 1a 98        MOVW    0FE98H,AX
8705: 06 20 03     MOV     A,[HL+03H]
8708: d8           XCH     A,X
8709: 06 20 04     MOV     A,[HL+04H]
870c: 44           INCW    AX
870d: 06 a0 04     MOV     [HL+04H],A
8710: d8           XCH     A,X
8711: 06 a0 03     MOV     [HL+03H],A
8714: 28 62 89     CALL    !8962H
8717: 8a 08        SUBW    AX,AX
8719: 8f 0a        CMPW    AX,BC
871b: 81 1a        BZ      $8737H
871d: 06 20 01     MOV     A,[HL+01H]
8720: d8           XCH     A,X
8721: 06 20 02     MOV     A,[HL+02H]
8724: 1f 92        CMPW    AX,0FE92H
8726: 81 0f        BZ      $8737H
8728: 06 20 03     MOV     A,[HL+03H]
872b: d8           XCH     A,X
872c: 06 20 04     MOV     A,[HL+04H]
872f: 2f b8 01     CMPW    AX,#01B8H
8732: 82 03        BNC     $8737H
8734: 2c a8 86     BR      !86A8H
8737: 1c 92        MOVW    AX,0FE92H
8739: 2f ab 0b     CMPW    AX,#0BABH
873c: 81 1b        BZ      $8759H
873e: 09 f0 92 fe  MOV     A,!0FE92H
8742: d8           XCH     A,X
8743: 09 f0 93 fe  MOV     A,!0FE93H
8747: 3c           PUSH    AX
8748: 28 e8 7d     CALL    !7DE8H
874b: 34           POP     AX
874c: 1c 6a        MOVW    AX,0FE6AH
874e: 24 48        MOVW    DE,AX
8750: 06 00 10     MOV     A,[DE+10H]
8753: d8           XCH     A,X
8754: 06 00 11     MOV     A,[DE+11H]
8757: 1a 94        MOVW    0FE94H,AX
8759: 1c 94        MOVW    AX,0FE94H
875b: 2f ab 0b     CMPW    AX,#0BABH
875e: 80 0f        BNZ     $876FH
8760: 60 99 99     MOVW    AX,#9999H
8763: 62 99 19     MOVW    BC,#1999H
8766: 1a 9a        MOVW    0FE9AH,AX
8768: 25 02        XCH     X,C
876a: db           XCH     A,B
876b: 1a 9c        MOVW    0FE9CH,AX
876d: 14 29        BR      $8798H
876f: 09 f0 94 fe  MOV     A,!0FE94H
8773: d8           XCH     A,X
8774: 09 f0 95 fe  MOV     A,!0FE95H
8778: 3c           PUSH    AX
8779: 28 e8 7d     CALL    !7DE8H
877c: 34           POP     AX
877d: 1c 6a        MOVW    AX,0FE6AH
877f: 3c           PUSH    AX
8780: 36           POP     DE
8781: 06 00 03     MOV     A,[DE+03H]
8784: d8           XCH     A,X
8785: 06 00 04     MOV     A,[DE+04H]
8788: 24 28        MOVW    BC,AX
878a: 06 00 01     MOV     A,[DE+01H]
878d: d8           XCH     A,X
878e: 06 00 02     MOV     A,[DE+02H]
8791: 1a 9a        MOVW    0FE9AH,AX
8793: 25 02        XCH     X,C
8795: db           XCH     A,B
8796: 1a 9c        MOVW    0FE9CH,AX
8798: 08 a7 65 03  BF      0FE65H.7,$879FH
879c: 2c 55 88     BR      !8855H
879f: 08 a0 67 03  BF      0FE67H.0,$87A6H
87a3: 2c 55 88     BR      !8855H
87a6: 08 a5 67 03  BF      0FE67H.5,$87ADH
87aa: 2c 55 88     BR      !8855H
87ad: 08 a1 67 03  BF      0FE67H.1,$87B4H
87b1: 2c 55 88     BR      !8855H
87b4: 08 a5 65 11  BF      0FE65H.5,$87C9H
87b8: 09 f0 90 fe  MOV     A,!0FE90H
87bc: d8           XCH     A,X
87bd: 09 f0 91 fe  MOV     A,!0FE91H
87c1: 3c           PUSH    AX
87c2: 28 d9 8a     CALL    !8AD9H
87c5: 34           POP     AX
87c6: 2c 55 88     BR      !8855H
87c9: 28 5a 88     CALL    !885AH
87cc: d2           MOV     A,C
87cd: 06 a0 05     MOV     [HL+05H],A
87d0: af 00        CMP     A,#00H
87d2: 81 49        BZ      $881DH
87d4: 06 20 05     MOV     A,[HL+05H]
87d7: af 01        CMP     A,#01H
87d9: 80 04        BNZ     $87DFH
87db: 1c 94        MOVW    AX,0FE94H
87dd: 14 02        BR      $87E1H
87df: 1c 92        MOVW    AX,0FE92H
87e1: 06 a0 02     MOV     [HL+02H],A
87e4: d8           XCH     A,X
87e5: 06 a0 01     MOV     [HL+01H],A
87e8: d8           XCH     A,X
87e9: 06 20 02     MOV     A,[HL+02H]
87ec: 3c           PUSH    AX
87ed: 28 d9 8a     CALL    !8AD9H
87f0: 34           POP     AX
87f1: 09 f0 0c fd  MOV     A,!0FD0CH
87f5: ac 7f        AND     A,#7FH
87f7: b8 00        MOV     X,#00H
87f9: d8           XCH     A,X
87fa: 2f 00 00     CMPW    AX,#0000H
87fd: 80 1c        BNZ     $881BH
87ff: 09 f0 0c fd  MOV     A,!0FD0CH
8803: 30 b9        SHR     A,7
8805: ac 01        AND     A,#01H
8807: b8 00        MOV     X,#00H
8809: d8           XCH     A,X
880a: 2f 00 00     CMPW    AX,#0000H
880d: 80 0c        BNZ     $881BH
880f: 09 f0 0c fd  MOV     A,!0FD0CH
8813: ac 80        AND     A,#80H
8815: ae 0a        OR      A,#0AH
8817: 09 f1 0c fd  MOV     !0FD0CH,A
881b: 14 38        BR      $8855H
881d: 09 f0 0c fd  MOV     A,!0FD0CH
8821: 03 9f        CLR1    A.7
8823: 09 f1 0c fd  MOV     !0FD0CH,A
8827: ac 80        AND     A,#80H
8829: 09 f1 0c fd  MOV     !0FD0CH,A
882d: 09 f0 0f fd  MOV     A,!0FD0FH
8831: af ff        CMP     A,#0FFH
8833: 81 20        BZ      $8855H
8835: b9 ff        MOV     A,#0FFH
8837: 09 f1 15 fd  MOV     !0FD15H,A
883b: 09 f1 14 fd  MOV     !0FD14H,A
883f: 09 f1 13 fd  MOV     !0FD13H,A
8843: 09 f1 12 fd  MOV     !0FD12H,A
8847: 09 f1 11 fd  MOV     !0FD11H,A
884b: 09 f1 10 fd  MOV     !0FD10H,A
884f: 09 f1 0f fd  MOV     !0FD0FH,A
8853: b2 68        SET1    0FE68H.2
8855: 34           POP     AX
8856: 34           POP     AX
8857: 34           POP     AX
8858: 37           POP     HL
8859: 56           RET
885a: 3f           PUSH    HL
885b: 11 fc        MOVW    AX,SP
885d: 2e 08 00     SUBW    AX,#0008H
8860: 24 68        MOVW    HL,AX
8862: 13 fc        MOVW    SP,AX
8864: 0c 6a 9a fe  MOVW    0FE6AH,#0FE9AH
8868: 1c 63        MOVW    AX,0FE63H
886a: 24 08        MOVW    AX,AX
886c: 44           INCW    AX
886d: 1a 6c        MOVW    0FE6CH,AX
886f: 28 dd 98     CALL    !98DDH
8872: 24 0a        MOVW    AX,BC
8874: 06 a0 05     MOV     [HL+05H],A
8877: d8           XCH     A,X
8878: 06 a0 04     MOV     [HL+04H],A
887b: 24 0c        MOVW    AX,DE
887d: 06 a0 07     MOV     [HL+07H],A
8880: d8           XCH     A,X
8881: 06 a0 06     MOV     [HL+06H],A
8884: 1c 63        MOVW    AX,0FE63H
8886: 24 08        MOVW    AX,AX
8888: 44           INCW    AX
8889: 1a 6a        MOVW    0FE6AH,AX
888b: 0c 6c 96 fe  MOVW    0FE6CH,#0FE96H
888f: 28 dd 98     CALL    !98DDH
8892: 24 0a        MOVW    AX,BC
8894: 06 a0 01     MOV     [HL+01H],A
8897: d8           XCH     A,X
8898: 55           MOV     [HL],A
8899: 24 0c        MOVW    AX,DE
889b: 06 a0 03     MOV     [HL+03H],A
889e: d8           XCH     A,X
889f: 06 a0 02     MOV     [HL+02H],A
88a2: 06 20 04     MOV     A,[HL+04H]
88a5: d8           XCH     A,X
88a6: 06 20 05     MOV     A,[HL+05H]
88a9: 1a a4        MOVW    0FEA4H,AX
88ab: 06 20 06     MOV     A,[HL+06H]
88ae: d8           XCH     A,X
88af: 06 20 07     MOV     A,[HL+07H]
88b2: 1a a6        MOVW    0FEA6H,AX
88b4: 0c a8 00 01  MOVW    0FEA8H,#0100H
88b8: 0c aa 00 00  MOVW    0FEAAH,#0000H
88bc: 28 ea ab     CALL    Compare_32Bits
88bf: 83 1a        BC      $88DBH
88c1: 05 e3        MOVW    AX,[HL]
88c3: 1a a4        MOVW    0FEA4H,AX
88c5: 06 20 02     MOV     A,[HL+02H]
88c8: d8           XCH     A,X
88c9: 06 20 03     MOV     A,[HL+03H]
88cc: 1a a6        MOVW    0FEA6H,AX
88ce: 0c a8 00 01  MOVW    0FEA8H,#0100H
88d2: 0c aa 00 00  MOVW    0FEAAH,#0000H
88d6: 28 ea ab     CALL    Compare_32Bits
88d9: 82 30        BNC     $890BH
88db: 06 20 04     MOV     A,[HL+04H]
88de: d8           XCH     A,X
88df: 06 20 05     MOV     A,[HL+05H]
88e2: 1a a4        MOVW    0FEA4H,AX
88e4: 06 20 06     MOV     A,[HL+06H]
88e7: d8           XCH     A,X
88e8: 06 20 07     MOV     A,[HL+07H]
88eb: 1a a6        MOVW    0FEA6H,AX
88ed: 05 e3        MOVW    AX,[HL]
88ef: 1a a8        MOVW    0FEA8H,AX
88f1: 06 20 02     MOV     A,[HL+02H]
88f4: d8           XCH     A,X
88f5: 06 20 03     MOV     A,[HL+03H]
88f8: 1a aa        MOVW    0FEAAH,AX
88fa: 28 ea ab     CALL    Compare_32Bits
88fd: 82 05        BNC     $8904H
88ff: 60 01 00     MOVW    AX,#0001H
8902: 14 03        BR      $8907H
8904: 60 ff 00     MOVW    AX,#00FFH
8907: 24 28        MOVW    BC,AX
8909: 14 03        BR      $890EH
890b: 62 00 00     MOVW    BC,#0000H
890e: 34           POP     AX
890f: 34           POP     AX
8910: 34           POP     AX
8911: 34           POP     AX
8912: 37           POP     HL
8913: 56           RET
8914: 1c 63        MOVW    AX,0FE63H
8916: 2d 04 00     ADDW    AX,#0004H
8919: 1a 6a        MOVW    0FE6AH,AX
891b: 0c 6c 9d fe  MOVW    0FE6CH,#0FE9DH
891f: 3a 6e 04     MOV     0FE6EH,#04H
8922: 1c 6a        MOVW    AX,0FE6AH
8924: 24 48        MOVW    DE,AX
8926: 5c           MOV     A,[DE]
8927: da           XCH     A,C
8928: 1c 6c        MOVW    AX,0FE6CH
892a: 24 48        MOVW    DE,AX
892c: d2           MOV     A,C
892d: 16 4f        CMP     A,[DE]
892f: 80 13        BNZ     $8944H
8931: 6f 6e 00     CMP     0FE6EH,#00H
8934: 81 0e        BZ      $8944H
8936: 1c 6a        MOVW    AX,0FE6AH
8938: 4c           DECW    AX
8939: 1a 6a        MOVW    0FE6AH,AX
893b: 1c 6c        MOVW    AX,0FE6CH
893d: 4c           DECW    AX
893e: 1a 6c        MOVW    0FE6CH,AX
8940: 27 6e        DEC     0FE6EH
8942: 14 de        BR      $8922H
8944: 6f 6e 00     CMP     0FE6EH,#00H
8947: 81 0f        BZ      $8958H
8949: 1c 6a        MOVW    AX,0FE6AH
894b: 24 48        MOVW    DE,AX
894d: 5c           MOV     A,[DE]
894e: da           XCH     A,C
894f: 1c 6c        MOVW    AX,0FE6CH
8951: 24 48        MOVW    DE,AX
8953: 5c           MOV     A,[DE]
8954: 8f 12        CMP     A,C
8956: 83 04        BC      $895CH
8958: 8a 08        SUBW    AX,AX
895a: 14 03        BR      $895FH
895c: 60 01 00     MOVW    AX,#0001H
895f: 24 28        MOVW    BC,AX
8961: 56           RET
8962: 0c 6a 99 fe  MOVW    0FE6AH,#0FE99H
8966: 1c 63        MOVW    AX,0FE63H
8968: 2d 04 00     ADDW    AX,#0004H
896b: 1a 6c        MOVW    0FE6CH,AX
896d: 3a 6e 04     MOV     0FE6EH,#04H
8970: 1c 6a        MOVW    AX,0FE6AH
8972: 24 48        MOVW    DE,AX
8974: 5c           MOV     A,[DE]
8975: da           XCH     A,C
8976: 1c 6c        MOVW    AX,0FE6CH
8978: 24 48        MOVW    DE,AX
897a: d2           MOV     A,C
897b: 16 4f        CMP     A,[DE]
897d: 80 13        BNZ     $8992H
897f: 6f 6e 00     CMP     0FE6EH,#00H
8982: 81 0e        BZ      $8992H
8984: 1c 6a        MOVW    AX,0FE6AH
8986: 4c           DECW    AX
8987: 1a 6a        MOVW    0FE6AH,AX
8989: 1c 6c        MOVW    AX,0FE6CH
898b: 4c           DECW    AX
898c: 1a 6c        MOVW    0FE6CH,AX
898e: 27 6e        DEC     0FE6EH
8990: 14 de        BR      $8970H
8992: 6f 6e 00     CMP     0FE6EH,#00H
8995: 81 0f        BZ      $89A6H
8997: 1c 6a        MOVW    AX,0FE6AH
8999: 24 48        MOVW    DE,AX
899b: 5c           MOV     A,[DE]
899c: da           XCH     A,C
899d: 1c 6c        MOVW    AX,0FE6CH
899f: 24 48        MOVW    DE,AX
89a1: 5c           MOV     A,[DE]
89a2: 8f 12        CMP     A,C
89a4: 83 04        BC      $89AAH
89a6: 8a 08        SUBW    AX,AX
89a8: 14 03        BR      $89ADH
89aa: 60 01 00     MOVW    AX,#0001H
89ad: 24 28        MOVW    BC,AX
89af: 56           RET
89b0: 3f           PUSH    HL
89b1: 11 fc        MOVW    AX,SP
89b3: 24 68        MOVW    HL,AX
89b5: 06 20 06     MOV     A,[HL+06H]
89b8: d8           XCH     A,X
89b9: 06 20 07     MOV     A,[HL+07H]
89bc: 24 48        MOVW    DE,AX
89be: 06 00 01     MOV     A,[DE+01H]
89c1: d8           XCH     A,X
89c2: 06 00 02     MOV     A,[DE+02H]
89c5: 1a a4        MOVW    0FEA4H,AX
89c7: 06 00 03     MOV     A,[DE+03H]
89ca: d8           XCH     A,X
89cb: 06 00 04     MOV     A,[DE+04H]
89ce: 1a a6        MOVW    0FEA6H,AX
89d0: 1c 63        MOVW    AX,0FE63H
89d2: 24 48        MOVW    DE,AX
89d4: 06 00 01     MOV     A,[DE+01H]
89d7: d8           XCH     A,X
89d8: 06 00 02     MOV     A,[DE+02H]
89db: 1a a8        MOVW    0FEA8H,AX
89dd: 06 00 03     MOV     A,[DE+03H]
89e0: d8           XCH     A,X
89e1: 06 00 04     MOV     A,[DE+04H]
89e4: 1a aa        MOVW    0FEAAH,AX
89e6: 39 a8 a4     XCH     0FEA4H,0FEA8H
89e9: 39 a9 a5     XCH     0FEA5H,0FEA9H
89ec: 39 aa a6     XCH     0FEA6H,0FEAAH
89ef: 39 ab a7     XCH     0FEA7H,0FEABH
89f2: 28 ea ab     CALL    Compare_32Bits
89f5: 83 59        BC      $8A50H
89f7: 06 20 06     MOV     A,[HL+06H]
89fa: d8           XCH     A,X
89fb: 06 20 07     MOV     A,[HL+07H]
89fe: 24 48        MOVW    DE,AX
8a00: 06 00 01     MOV     A,[DE+01H]
8a03: d8           XCH     A,X
8a04: 06 00 02     MOV     A,[DE+02H]
8a07: 1a a4        MOVW    0FEA4H,AX
8a09: 06 00 03     MOV     A,[DE+03H]
8a0c: d8           XCH     A,X
8a0d: 06 00 04     MOV     A,[DE+04H]
8a10: 1a a6        MOVW    0FEA6H,AX
8a12: 1c a4        MOVW    AX,0FEA4H
8a14: 1a a8        MOVW    0FEA8H,AX
8a16: 1c a6        MOVW    AX,0FEA6H
8a18: 1a aa        MOVW    0FEAAH,AX
8a1a: 1c 96        MOVW    AX,0FE96H
8a1c: 1a a4        MOVW    0FEA4H,AX
8a1e: 1c 98        MOVW    AX,0FE98H
8a20: 1a a6        MOVW    0FEA6H,AX
8a22: 28 ea ab     CALL    Compare_32Bits
8a25: 82 29        BNC     $8A50H
8a27: 06 20 06     MOV     A,[HL+06H]
8a2a: d8           XCH     A,X
8a2b: 06 20 07     MOV     A,[HL+07H]
8a2e: 3c           PUSH    AX
8a2f: 36           POP     DE
8a30: 06 00 03     MOV     A,[DE+03H]
8a33: d8           XCH     A,X
8a34: 06 00 04     MOV     A,[DE+04H]
8a37: 24 28        MOVW    BC,AX
8a39: 06 00 01     MOV     A,[DE+01H]
8a3c: d8           XCH     A,X
8a3d: 06 00 02     MOV     A,[DE+02H]
8a40: 1a 96        MOVW    0FE96H,AX
8a42: 25 02        XCH     X,C
8a44: db           XCH     A,B
8a45: 1a 98        MOVW    0FE98H,AX
8a47: 06 20 04     MOV     A,[HL+04H]
8a4a: d8           XCH     A,X
8a4b: 06 20 05     MOV     A,[HL+05H]
8a4e: 1a 92        MOVW    0FE92H,AX
8a50: 06 20 06     MOV     A,[HL+06H]
8a53: d8           XCH     A,X
8a54: 06 20 07     MOV     A,[HL+07H]
8a57: 24 48        MOVW    DE,AX
8a59: 06 00 01     MOV     A,[DE+01H]
8a5c: d8           XCH     A,X
8a5d: 06 00 02     MOV     A,[DE+02H]
8a60: 1a a4        MOVW    0FEA4H,AX
8a62: 06 00 03     MOV     A,[DE+03H]
8a65: d8           XCH     A,X
8a66: 06 00 04     MOV     A,[DE+04H]
8a69: 1a a6        MOVW    0FEA6H,AX
8a6b: 1c 63        MOVW    AX,0FE63H
8a6d: 24 48        MOVW    DE,AX
8a6f: 06 00 01     MOV     A,[DE+01H]
8a72: d8           XCH     A,X
8a73: 06 00 02     MOV     A,[DE+02H]
8a76: 1a a8        MOVW    0FEA8H,AX
8a78: 06 00 03     MOV     A,[DE+03H]
8a7b: d8           XCH     A,X
8a7c: 06 00 04     MOV     A,[DE+04H]
8a7f: 1a aa        MOVW    0FEAAH,AX
8a81: 28 ea ab     CALL    Compare_32Bits
8a84: 83 51        BC      $8AD7H
8a86: 06 20 06     MOV     A,[HL+06H]
8a89: d8           XCH     A,X
8a8a: 06 20 07     MOV     A,[HL+07H]
8a8d: 24 48        MOVW    DE,AX
8a8f: 06 00 01     MOV     A,[DE+01H]
8a92: d8           XCH     A,X
8a93: 06 00 02     MOV     A,[DE+02H]
8a96: 1a a4        MOVW    0FEA4H,AX
8a98: 06 00 03     MOV     A,[DE+03H]
8a9b: d8           XCH     A,X
8a9c: 06 00 04     MOV     A,[DE+04H]
8a9f: 1a a6        MOVW    0FEA6H,AX
8aa1: 1c 9a        MOVW    AX,0FE9AH
8aa3: 1a a8        MOVW    0FEA8H,AX
8aa5: 1c 9c        MOVW    AX,0FE9CH
8aa7: 1a aa        MOVW    0FEAAH,AX
8aa9: 28 ea ab     CALL    Compare_32Bits
8aac: 82 29        BNC     $8AD7H
8aae: 06 20 06     MOV     A,[HL+06H]
8ab1: d8           XCH     A,X
8ab2: 06 20 07     MOV     A,[HL+07H]
8ab5: 3c           PUSH    AX
8ab6: 36           POP     DE
8ab7: 06 00 03     MOV     A,[DE+03H]
8aba: d8           XCH     A,X
8abb: 06 00 04     MOV     A,[DE+04H]
8abe: 24 28        MOVW    BC,AX
8ac0: 06 00 01     MOV     A,[DE+01H]
8ac3: d8           XCH     A,X
8ac4: 06 00 02     MOV     A,[DE+02H]
8ac7: 1a 9a        MOVW    0FE9AH,AX
8ac9: 25 02        XCH     X,C
8acb: db           XCH     A,B
8acc: 1a 9c        MOVW    0FE9CH,AX
8ace: 06 20 04     MOV     A,[HL+04H]
8ad1: d8           XCH     A,X
8ad2: 06 20 05     MOV     A,[HL+05H]
8ad5: 1a 94        MOVW    0FE94H,AX
8ad7: 37           POP     HL
8ad8: 56           RET
8ad9: 3f           PUSH    HL
8ada: 1c ac        MOVW    AX,0FEACH
8adc: 3c           PUSH    AX
8add: 11 fc        MOVW    AX,SP
8adf: 24 68        MOVW    HL,AX
8ae1: 06 20 06     MOV     A,[HL+06H]
8ae4: d8           XCH     A,X
8ae5: 06 20 07     MOV     A,[HL+07H]
8ae8: 3c           PUSH    AX
8ae9: 28 e8 7d     CALL    !7DE8H
8aec: 34           POP     AX
8aed: 68 6a 07     ADD     0FE6AH,#07H
8af0: 69 6b 00     ADDC    0FE6BH,#00H
8af3: 3a ac 00     MOV     0FEACH,#00H
8af6: 6f ac 07     CMP     0FEACH,#07H
8af9: 82 37        BNC     $8B32H
8afb: 28 ce 7a     CALL    Query_DFBE
8afe: 20 ac        MOV     A,0FEACH
8b00: b8 00        MOV     X,#00H
8b02: d8           XCH     A,X
8b03: 2d 0f fd     ADDW    AX,#0FD0FH
8b06: 24 48        MOVW    DE,AX
8b08: 5c           MOV     A,[DE]
8b09: da           XCH     A,C
8b0a: 1c 6a        MOVW    AX,0FE6AH
8b0c: 24 48        MOVW    DE,AX
8b0e: d2           MOV     A,C
8b0f: 16 4f        CMP     A,[DE]
8b11: 81 16        BZ      $8B29H
8b13: 1c 6a        MOVW    AX,0FE6AH
8b15: 24 48        MOVW    DE,AX
8b17: 5c           MOV     A,[DE]
8b18: d8           XCH     A,X
8b19: 20 ac        MOV     A,0FEACH
8b1b: 24 20        MOV     C,X
8b1d: b8 00        MOV     X,#00H
8b1f: d8           XCH     A,X
8b20: 2d 0f fd     ADDW    AX,#0FD0FH
8b23: 24 48        MOVW    DE,AX
8b25: d2           MOV     A,C
8b26: 54           MOV     [DE],A
8b27: b2 68        SET1    0FE68H.2
8b29: 1c 6a        MOVW    AX,0FE6AH
8b2b: 44           INCW    AX
8b2c: 1a 6a        MOVW    0FE6AH,AX
8b2e: 26 ac        INC     0FEACH
8b30: 14 c4        BR      $8AF6H
8b32: 34           POP     AX
8b33: 1a ac        MOVW    0FEACH,AX
8b35: 37           POP     HL
8b36: 56           RET
8b37: 3a 7f 00     MOV     0FE7FH,#00H
8b3a: b1 68        SET1    0FE68H.1
8b3c: 56           RET
8b3d: 3a 7f 90     MOV     0FE7FH,#90H
8b40: b1 68        SET1    0FE68H.1
8b42: 56           RET
8b43: 3f           PUSH    HL
8b44: 1c ac        MOVW    AX,0FEACH
8b46: 3c           PUSH    AX
8b47: 11 fc        MOVW    AX,SP
8b49: 24 68        MOVW    HL,AX
8b4b: b9 00        MOV     A,#00H
8b4d: 06 2f 06     CMP     A,[HL+06H]
8b50: 82 16        BNC     $8B68H
8b52: 3a ac ac     MOV     0FEACH,#0ACH
8b55: b9 00        MOV     A,#00H
8b57: 9f ac        CMP     A,0FEACH
8b59: 82 04        BNC     $8B5FH
8b5b: 27 ac        DEC     0FEACH
8b5d: 14 f6        BR      $8B55H
8b5f: 06 20 06     MOV     A,[HL+06H]
8b62: c9           DEC     A
8b63: 06 a0 06     MOV     [HL+06H],A
8b66: 14 e3        BR      $8B4BH
8b68: 34           POP     AX
8b69: 1a ac        MOVW    0FEACH,AX
8b6b: 37           POP     HL
8b6c: 56           RET
Delay_Loop:
8b6d: 3f           PUSH    HL
8b6e: 11 fc        MOVW    AX,SP
8b70: 24 68        MOVW    HL,AX
8b72: b9 00        MOV     A,#00H
8b74: 06 2f 04     CMP     A,[HL+04H]
8b77: 82 09        BNC     $8B82H
8b79: 06 20 04     MOV     A,[HL+04H]
8b7c: c9           DEC     A
8b7d: 06 a0 04     MOV     [HL+04H],A
8b80: 14 f0        BR      $8B72H
8b82: 37           POP     HL
8b83: 56           RET
Cycle_Serial_Clock:
8b84: b6 06        SET1    P6.6    ; set the bit high, but add delay
8b86: b6 06        SET1    P6.6
8b88: b6 06        SET1    P6.6
8b8a: b6 06        SET1    P6.6
8b8c: a6 06        CLR1    P6.6    ; now turn it off
8b8e: 56           RET
8b8f: 3f           PUSH    HL
8b90: 1c ac        MOVW    AX,0FEACH
8b92: 3c           PUSH    AX
8b93: 11 fc        MOVW    AX,SP
8b95: 24 68        MOVW    HL,AX
8b97: 06 20 06     MOV     A,[HL+06H]
8b9a: 30 a1        SHR     A,4
8b9c: b8 0a        MOV     X,#0AH
8b9e: 05 08        MULU    X
8ba0: d0           MOV     A,X
8ba1: 22 ac        MOV     0FEACH,A
8ba3: 06 20 06     MOV     A,[HL+06H]
8ba6: ac 0f        AND     A,#0FH
8ba8: 98 ac        ADD     A,0FEACH
8baa: 22 ac        MOV     0FEACH,A
8bac: 20 ac        MOV     A,0FEACH
8bae: bb 00        MOV     B,#00H
8bb0: da           XCH     A,C
8bb1: 34           POP     AX
8bb2: 1a ac        MOVW    0FEACH,AX
8bb4: 37           POP     HL
8bb5: 56           RET
8bb6: 3f           PUSH    HL
8bb7: 05 c9        DECW    SP
8bb9: 05 c9        DECW    SP
8bbb: 11 fc        MOVW    AX,SP
8bbd: 24 68        MOVW    HL,AX
8bbf: b9 00        MOV     A,#00H
8bc1: 06 a0 01     MOV     [HL+01H],A
8bc4: 24 0e        MOVW    AX,HL
8bc6: 2d 06 00     ADDW    AX,#0006H
8bc9: 24 48        MOVW    DE,AX
8bcb: 06 00 01     MOV     A,[DE+01H]
8bce: b8 00        MOV     X,#00H
8bd0: d8           XCH     A,X
8bd1: 3c           PUSH    AX
8bd2: 28 8f 8b     CALL    !8B8FH
8bd5: 34           POP     AX
8bd6: d2           MOV     A,C
8bd7: 55           MOV     [HL],A
8bd8: 05 e3        MOVW    AX,[HL]
8bda: 1a a4        MOVW    0FEA4H,AX
8bdc: 0c a6 64 00  MOVW    0FEA6H,#0064H
8be0: 28 f7 ab     CALL    Multiply_Thing
8be3: 1c a4        MOVW    AX,0FEA4H
8be5: 3c           PUSH    AX
8be6: 24 0e        MOVW    AX,HL
8be8: 2d 06 00     ADDW    AX,#0006H
8beb: 24 48        MOVW    DE,AX
8bed: 5c           MOV     A,[DE]
8bee: b8 00        MOV     X,#00H
8bf0: d8           XCH     A,X
8bf1: 3c           PUSH    AX
8bf2: 28 8f 8b     CALL    !8B8FH
8bf5: 34           POP     AX
8bf6: 34           POP     AX
8bf7: 1a a4        MOVW    0FEA4H,AX
8bf9: 24 0a        MOVW    AX,BC
8bfb: 1d a4        ADDW    AX,0FEA4H
8bfd: 06 a0 01     MOV     [HL+01H],A
8c00: d8           XCH     A,X
8c01: 55           MOV     [HL],A
8c02: d8           XCH     A,X
8c03: 64 00 fd     MOVW    DE,#0FD00H
8c06: 05 e6        MOVW    [DE],AX
8c08: 62 00 fd     MOVW    BC,#0FD00H
8c0b: 34           POP     AX
8c0c: 37           POP     HL
8c0d: 56           RET
8c0e: b0 66        SET1    0FE66H.0
8c10: 60 01 00     MOVW    AX,#0001H
8c13: 3c           PUSH    AX
8c14: 28 d5 60     CALL    !60D5H
8c17: 34           POP     AX
8c18: 60 02 00     MOVW    AX,#0002H
8c1b: 3c           PUSH    AX
8c1c: 28 d5 60     CALL    !60D5H
8c1f: 34           POP     AX
8c20: 28 16 20     CALL    !2016H
8c23: 08 a3 65 03  BF      0FE65H.3,$8C2AH
8c27: 3a 86 05     MOV     0FE86H,#05H
8c2a: 28 34 79     CALL    !7934H
8c2d: 14 2f        BR      $8C5EH
8c2f: 3a 86 96     MOV     0FE86H,#96H
8c32: 28 f7 6c     CALL    !6CF7H
8c35: b1 66        SET1    0FE66H.1
8c37: 14 3e        BR      $8C77H
8c39: 08 74 66     NOT1    0FE66H.4
8c3c: 14 39        BR      $8C77H
8c3e: 0c 80 c8 00  MOVW    0FE80H,#00C8H
8c42: b6 67        SET1    0FE67H.6
8c44: 14 31        BR      $8C77H
8c46: 0c 80 c8 00  MOVW    0FE80H,#00C8H
8c4a: 14 2b        BR      $8C77H
8c4c: 28 40 6d     CALL    !6D40H
8c4f: 28 5c 33     CALL    !335CH
8c52: b1 69        SET1    0FE69H.1
8c54: a1 66        CLR1    0FE66H.1
8c56: 3a 86 00     MOV     0FE86H,#00H
8c59: 28 16 20     CALL    !2016H
8c5c: 14 19        BR      $8C77H
8c5e: 6f 74 16     CMP     0FE74H,#16H
8c61: 81 e9        BZ      $8C4CH
8c63: 6f 74 1b     CMP     0FE74H,#1BH
8c66: 81 de        BZ      $8C46H
8c68: 6f 74 1a     CMP     0FE74H,#1AH
8c6b: 81 d1        BZ      $8C3EH
8c6d: 6f 74 05     CMP     0FE74H,#05H
8c70: 81 c7        BZ      $8C39H
8c72: 6f 74 11     CMP     0FE74H,#11H
8c75: 81 b8        BZ      $8C2FH
8c77: 6f 74 00     CMP     0FE74H,#00H
8c7a: 81 06        BZ      $8C82H
8c7c: 20 74        MOV     A,0FE74H
8c7e: 09 f1 0a fd  MOV     !0FD0AH,A
8c82: 3a 89 fa     MOV     0FE89H,#0FAH
8c85: 28 39 92     CALL    !9239H
8c88: 56           RET
8c89: 1c ac        MOVW    AX,0FEACH
8c8b: 3c           PUSH    AX
8c8c: a0 66        CLR1    0FE66H.0
8c8e: 28 34 79     CALL    !7934H
8c91: 6f 74 44     CMP     0FE74H,#44H
8c94: 80 24        BNZ     $8CBAH
8c96: 60 bd df     MOVW    AX,#0DFBDH
8c99: 3c           PUSH    AX
8c9a: 28 2b 7c     CALL    !7C2BH
8c9d: 34           POP     AX
8c9e: d2           MOV     A,C
8c9f: ac f3        AND     A,#0F3H
8ca1: d8           XCH     A,X
8ca2: 20 66        MOV     A,0FE66H
8ca4: ac 0c        AND     A,#0CH
8ca6: 8e 01        OR      X,A
8ca8: d0           MOV     A,X
8ca9: 22 ac        MOV     0FEACH,A
8cab: 60 bd df     MOVW    AX,#0DFBDH
8cae: 3c           PUSH    AX
8caf: 20 ac        MOV     A,0FEACH
8cb1: b8 00        MOV     X,#00H
8cb3: d8           XCH     A,X
8cb4: 3c           PUSH    AX
8cb5: 28 18 7b     CALL    !7B18H
8cb8: 34           POP     AX
8cb9: 34           POP     AX
8cba: b4 68        SET1    0FE68H.4
8cbc: b2 68        SET1    0FE68H.2
8cbe: b1 68        SET1    0FE68H.1
8cc0: 0c 80 00 00  MOVW    0FE80H,#0000H
8cc4: 3a 87 00     MOV     0FE87H,#00H
8cc7: 3a 7f 00     MOV     0FE7FH,#00H
8cca: 3a 85 00     MOV     0FE85H,#00H
8ccd: 3a 89 00     MOV     0FE89H,#00H
8cd0: a1 66        CLR1    0FE66H.1
8cd2: a1 72        CLR1    0FE72H.1
8cd4: 3a 86 02     MOV     0FE86H,#02H
8cd7: 09 f0 0d fd  MOV     A,!0FD0DH
8cdb: ac f0        AND     A,#0F0H
8cdd: ae 0f        OR      A,#0FH
8cdf: 09 f1 0d fd  MOV     !0FD0DH,A
8ce3: a6 65        CLR1    0FE65H.6
8ce5: a7 66        CLR1    0FE66H.7
8ce7: 3a 67 00     MOV     0FE67H,#00H
8cea: a2 73        CLR1    0FE73H.2
8cec: 34           POP     AX
8ced: 1a ac        MOVW    0FEACH,AX
8cef: 56           RET
8cf0: 1c 90        MOVW    AX,0FE90H
8cf2: 2f 40 04     CMPW    AX,#0440H
8cf5: 82 27        BNC     $8D1EH
8cf7: 20 90        MOV     A,0FE90H
8cf9: b8 00        MOV     X,#00H
8cfb: d8           XCH     A,X
8cfc: 3c           PUSH    AX
8cfd: 28 3d 8d     CALL    !8D3DH
8d00: 34           POP     AX
8d01: 24 0a        MOVW    AX,BC
8d03: 2f 01 00     CMPW    AX,#0001H
8d06: 80 16        BNZ     $8D1EH
8d08: 20 91        MOV     A,0FE91H
8d0a: b8 00        MOV     X,#00H
8d0c: d8           XCH     A,X
8d0d: 3c           PUSH    AX
8d0e: 28 3d 8d     CALL    !8D3DH
8d11: 34           POP     AX
8d12: 24 0a        MOVW    AX,BC
8d14: 2f 01 00     CMPW    AX,#0001H
8d17: 80 05        BNZ     $8D1EH
8d19: 62 01 00     MOVW    BC,#0001H
8d1c: 14 03        BR      $8D21H
8d1e: 62 00 00     MOVW    BC,#0000H
8d21: 56           RET
8d22: 3f           PUSH    HL
8d23: 11 fc        MOVW    AX,SP
8d25: 24 68        MOVW    HL,AX
8d27: 06 20 04     MOV     A,[HL+04H]
8d2a: ac 0f        AND     A,#0FH
8d2c: b8 09        MOV     X,#09H
8d2e: 8f 01        CMP     X,A
8d30: 82 04        BNC     $8D36H
8d32: 8a 08        SUBW    AX,AX
8d34: 14 03        BR      $8D39H
8d36: 60 01 00     MOVW    AX,#0001H
8d39: 24 28        MOVW    BC,AX
8d3b: 37           POP     HL
8d3c: 56           RET
8d3d: 3f           PUSH    HL
8d3e: 11 fc        MOVW    AX,SP
8d40: 24 68        MOVW    HL,AX
8d42: 06 20 04     MOV     A,[HL+04H]
8d45: 30 a1        SHR     A,4
8d47: ac 0f        AND     A,#0FH
8d49: b8 09        MOV     X,#09H
8d4b: 8f 01        CMP     X,A
8d4d: 82 0f        BNC     $8D5EH
8d4f: 06 20 04     MOV     A,[HL+04H]
8d52: ac 0f        AND     A,#0FH
8d54: b8 09        MOV     X,#09H
8d56: 8f 01        CMP     X,A
8d58: 82 04        BNC     $8D5EH
8d5a: 8a 08        SUBW    AX,AX
8d5c: 14 03        BR      $8D61H
8d5e: 60 01 00     MOVW    AX,#0001H
8d61: 24 28        MOVW    BC,AX
8d63: 37           POP     HL
8d64: 56           RET
8d65: 3f           PUSH    HL
8d66: 05 c9        DECW    SP
8d68: 05 c9        DECW    SP
8d6a: 11 fc        MOVW    AX,SP
8d6c: 24 68        MOVW    HL,AX
8d6e: b9 00        MOV     A,#00H
8d70: 06 a0 01     MOV     [HL+01H],A
8d73: 06 20 06     MOV     A,[HL+06H]
8d76: d8           XCH     A,X
8d77: 06 20 07     MOV     A,[HL+07H]
8d7a: 24 48        MOVW    DE,AX
8d7c: 58           MOV     A,[DE+]
8d7d: d8           XCH     A,X
8d7e: 58           MOV     A,[DE+]
8d7f: 1a a4        MOVW    0FEA4H,AX
8d81: 05 e2        MOVW    AX,[DE]
8d83: 1a a6        MOVW    0FEA6H,AX
8d85: 1c a4        MOVW    AX,0FEA4H
8d87: 1a a8        MOVW    0FEA8H,AX
8d89: 1c a6        MOVW    AX,0FEA6H
8d8b: 1a aa        MOVW    0FEAAH,AX
8d8d: 0c a4 00 00  MOVW    0FEA4H,#0000H
8d91: 0c a6 40 17  MOVW    0FEA6H,#1740H
8d95: 28 ea ab     CALL    Compare_32Bits
8d98: 82 08        BNC     $8DA2H
8d9a: b9 06        MOV     A,#06H
8d9c: 06 a0 01     MOV     [HL+01H],A
8d9f: 2c 6f 8e     BR      !8E6FH
8da2: 06 20 06     MOV     A,[HL+06H]
8da5: d8           XCH     A,X
8da6: 06 20 07     MOV     A,[HL+07H]
8da9: 24 48        MOVW    DE,AX
8dab: 58           MOV     A,[DE+]
8dac: d8           XCH     A,X
8dad: 58           MOV     A,[DE+]
8dae: 1a a4        MOVW    0FEA4H,AX
8db0: 05 e2        MOVW    AX,[DE]
8db2: 1a a6        MOVW    0FEA6H,AX
8db4: 0c a8 00 00  MOVW    0FEA8H,#0000H
8db8: 0c aa 80 10  MOVW    0FEAAH,#1080H
8dbc: 28 ea ab     CALL    Compare_32Bits
8dbf: 83 08        BC      $8DC9H
8dc1: b9 05        MOV     A,#05H
8dc3: 06 a0 01     MOV     [HL+01H],A
8dc6: 2c 6f 8e     BR      !8E6FH
8dc9: 06 20 06     MOV     A,[HL+06H]
8dcc: d8           XCH     A,X
8dcd: 06 20 07     MOV     A,[HL+07H]
8dd0: 24 48        MOVW    DE,AX
8dd2: 58           MOV     A,[DE+]
8dd3: d8           XCH     A,X
8dd4: 58           MOV     A,[DE+]
8dd5: 1a a4        MOVW    0FEA4H,AX
8dd7: 05 e2        MOVW    AX,[DE]
8dd9: 1a a6        MOVW    0FEA6H,AX
8ddb: 1c a4        MOVW    AX,0FEA4H
8ddd: 1a a8        MOVW    0FEA8H,AX
8ddf: 1c a6        MOVW    AX,0FEA6H
8de1: 1a aa        MOVW    0FEAAH,AX
8de3: 0c a4 00 00  MOVW    0FEA4H,#0000H
8de7: 0c a6 50 05  MOVW    0FEA6H,#0550H
8deb: 28 ea ab     CALL    Compare_32Bits
8dee: 82 07        BNC     $8DF7H
8df0: b9 04        MOV     A,#04H
8df2: 06 a0 01     MOV     [HL+01H],A
8df5: 14 78        BR      $8E6FH
8df7: 06 20 06     MOV     A,[HL+06H]
8dfa: d8           XCH     A,X
8dfb: 06 20 07     MOV     A,[HL+07H]
8dfe: 24 48        MOVW    DE,AX
8e00: 58           MOV     A,[DE+]
8e01: d8           XCH     A,X
8e02: 58           MOV     A,[DE+]
8e03: 1a a4        MOVW    0FEA4H,AX
8e05: 05 e2        MOVW    AX,[DE]
8e07: 1a a6        MOVW    0FEA6H,AX
8e09: 0c a8 00 00  MOVW    0FEA8H,#0000H
8e0d: 0c aa 50 03  MOVW    0FEAAH,#0350H
8e11: 28 ea ab     CALL    Compare_32Bits
8e14: 83 07        BC      $8E1DH
8e16: b9 03        MOV     A,#03H
8e18: 06 a0 01     MOV     [HL+01H],A
8e1b: 14 52        BR      $8E6FH
8e1d: 06 20 06     MOV     A,[HL+06H]
8e20: d8           XCH     A,X
8e21: 06 20 07     MOV     A,[HL+07H]
8e24: 24 48        MOVW    DE,AX
8e26: 58           MOV     A,[DE+]
8e27: d8           XCH     A,X
8e28: 58           MOV     A,[DE+]
8e29: 1a a4        MOVW    0FEA4H,AX
8e2b: 05 e2        MOVW    AX,[DE]
8e2d: 1a a6        MOVW    0FEA6H,AX
8e2f: 1c a4        MOVW    AX,0FEA4H
8e31: 1a a8        MOVW    0FEA8H,AX
8e33: 1c a6        MOVW    AX,0FEA6H
8e35: 1a aa        MOVW    0FEAAH,AX
8e37: 0c a4 00 00  MOVW    0FEA4H,#0000H
8e3b: 0c a6 00 03  MOVW    0FEA6H,#0300H
8e3f: 28 ea ab     CALL    Compare_32Bits
8e42: 82 07        BNC     $8E4BH
8e44: b9 02        MOV     A,#02H
8e46: 06 a0 01     MOV     [HL+01H],A
8e49: 14 24        BR      $8E6FH
8e4b: 06 20 06     MOV     A,[HL+06H]
8e4e: d8           XCH     A,X
8e4f: 06 20 07     MOV     A,[HL+07H]
8e52: 24 48        MOVW    DE,AX
8e54: 58           MOV     A,[DE+]
8e55: d8           XCH     A,X
8e56: 58           MOV     A,[DE+]
8e57: 1a a4        MOVW    0FEA4H,AX
8e59: 05 e2        MOVW    AX,[DE]
8e5b: 1a a6        MOVW    0FEA6H,AX
8e5d: 0c a8 00 00  MOVW    0FEA8H,#0000H
8e61: 0c aa 01 00  MOVW    0FEAAH,#0001H
8e65: 28 ea ab     CALL    Compare_32Bits
8e68: 83 05        BC      $8E6FH
8e6a: b9 01        MOV     A,#01H
8e6c: 06 a0 01     MOV     [HL+01H],A
8e6f: 06 20 01     MOV     A,[HL+01H]
8e72: bb 00        MOV     B,#00H
8e74: da           XCH     A,C
8e75: 34           POP     AX
8e76: 37           POP     HL
8e77: 56           RET
8e78: 3f           PUSH    HL
8e79: 11 fc        MOVW    AX,SP
8e7b: 2e 0a 00     SUBW    AX,#000AH
8e7e: 24 68        MOVW    HL,AX
8e80: 13 fc        MOVW    SP,AX
8e82: 76 65 03     BT      0FE65H.6,$8E88H
8e85: 2c cc 8f     BR      !8FCCH
8e88: 64 06 fd     MOVW    DE,#0FD06H
8e8b: 58           MOV     A,[DE+]
8e8c: d8           XCH     A,X
8e8d: 58           MOV     A,[DE+]
8e8e: 1a a4        MOVW    0FEA4H,AX
8e90: 05 e2        MOVW    AX,[DE]
8e92: 1a a6        MOVW    0FEA6H,AX
8e94: 64 02 fd     MOVW    DE,#0FD02H
8e97: 58           MOV     A,[DE+]
8e98: d8           XCH     A,X
8e99: 58           MOV     A,[DE+]
8e9a: 1a a8        MOVW    0FEA8H,AX
8e9c: 05 e2        MOVW    AX,[DE]
8e9e: 1a aa        MOVW    0FEAAH,AX
8ea0: 28 ea ab     CALL    Compare_32Bits
8ea3: 82 3c        BNC     $8EE1H
8ea5: 64 04 fd     MOVW    DE,#0FD04H
8ea8: 05 e2        MOVW    AX,[DE]
8eaa: 24 28        MOVW    BC,AX
8eac: 64 02 fd     MOVW    DE,#0FD02H
8eaf: 05 e2        MOVW    AX,[DE]
8eb1: 06 a0 06     MOV     [HL+06H],A
8eb4: d8           XCH     A,X
8eb5: 06 a0 05     MOV     [HL+05H],A
8eb8: 25 02        XCH     X,C
8eba: db           XCH     A,B
8ebb: 06 a0 08     MOV     [HL+08H],A
8ebe: d8           XCH     A,X
8ebf: 06 a0 07     MOV     [HL+07H],A
8ec2: 64 08 fd     MOVW    DE,#0FD08H
8ec5: 05 e2        MOVW    AX,[DE]
8ec7: 24 28        MOVW    BC,AX
8ec9: 64 06 fd     MOVW    DE,#0FD06H
8ecc: 05 e2        MOVW    AX,[DE]
8ece: 06 a0 02     MOV     [HL+02H],A
8ed1: d8           XCH     A,X
8ed2: 06 a0 01     MOV     [HL+01H],A
8ed5: 25 02        XCH     X,C
8ed7: db           XCH     A,B
8ed8: 06 a0 04     MOV     [HL+04H],A
8edb: d8           XCH     A,X
8edc: 06 a0 03     MOV     [HL+03H],A
8edf: 14 3a        BR      $8F1BH
8ee1: 64 08 fd     MOVW    DE,#0FD08H
8ee4: 05 e2        MOVW    AX,[DE]
8ee6: 24 28        MOVW    BC,AX
8ee8: 64 06 fd     MOVW    DE,#0FD06H
8eeb: 05 e2        MOVW    AX,[DE]
8eed: 06 a0 06     MOV     [HL+06H],A
8ef0: d8           XCH     A,X
8ef1: 06 a0 05     MOV     [HL+05H],A
8ef4: 25 02        XCH     X,C
8ef6: db           XCH     A,B
8ef7: 06 a0 08     MOV     [HL+08H],A
8efa: d8           XCH     A,X
8efb: 06 a0 07     MOV     [HL+07H],A
8efe: 64 04 fd     MOVW    DE,#0FD04H
8f01: 05 e2        MOVW    AX,[DE]
8f03: 24 28        MOVW    BC,AX
8f05: 64 02 fd     MOVW    DE,#0FD02H
8f08: 05 e2        MOVW    AX,[DE]
8f0a: 06 a0 02     MOV     [HL+02H],A
8f0d: d8           XCH     A,X
8f0e: 06 a0 01     MOV     [HL+01H],A
8f11: 25 02        XCH     X,C
8f13: db           XCH     A,B
8f14: 06 a0 04     MOV     [HL+04H],A
8f17: d8           XCH     A,X
8f18: 06 a0 03     MOV     [HL+03H],A
8f1b: 1c 63        MOVW    AX,0FE63H
8f1d: 24 48        MOVW    DE,AX
8f1f: 06 00 01     MOV     A,[DE+01H]
8f22: d8           XCH     A,X
8f23: 06 00 02     MOV     A,[DE+02H]
8f26: 1a a4        MOVW    0FEA4H,AX
8f28: 06 00 03     MOV     A,[DE+03H]
8f2b: d8           XCH     A,X
8f2c: 06 00 04     MOV     A,[DE+04H]
8f2f: 1a a6        MOVW    0FEA6H,AX
8f31: 1c a4        MOVW    AX,0FEA4H
8f33: 1a a8        MOVW    0FEA8H,AX
8f35: 1c a6        MOVW    AX,0FEA6H
8f37: 1a aa        MOVW    0FEAAH,AX
8f39: 06 20 05     MOV     A,[HL+05H]
8f3c: d8           XCH     A,X
8f3d: 06 20 06     MOV     A,[HL+06H]
8f40: 1a a4        MOVW    0FEA4H,AX
8f42: 06 20 07     MOV     A,[HL+07H]
8f45: d8           XCH     A,X
8f46: 06 20 08     MOV     A,[HL+08H]
8f49: 1a a6        MOVW    0FEA6H,AX
8f4b: 28 ea ab     CALL    Compare_32Bits
8f4e: 82 27        BNC     $8F77H
8f50: 1c 63        MOVW    AX,0FE63H
8f52: 24 48        MOVW    DE,AX
8f54: 06 20 03     MOV     A,[HL+03H]
8f57: d8           XCH     A,X
8f58: 06 20 04     MOV     A,[HL+04H]
8f5b: 24 28        MOVW    BC,AX
8f5d: 06 20 01     MOV     A,[HL+01H]
8f60: d8           XCH     A,X
8f61: 06 20 02     MOV     A,[HL+02H]
8f64: 06 80 02     MOV     [DE+02H],A
8f67: d8           XCH     A,X
8f68: 06 80 01     MOV     [DE+01H],A
8f6b: 25 02        XCH     X,C
8f6d: db           XCH     A,B
8f6e: 06 80 04     MOV     [DE+04H],A
8f71: d8           XCH     A,X
8f72: 06 80 03     MOV     [DE+03H],A
8f75: 14 52        BR      $8FC9H
8f77: 1c 63        MOVW    AX,0FE63H
8f79: 24 48        MOVW    DE,AX
8f7b: 06 00 01     MOV     A,[DE+01H]
8f7e: d8           XCH     A,X
8f7f: 06 00 02     MOV     A,[DE+02H]
8f82: 1a a4        MOVW    0FEA4H,AX
8f84: 06 00 03     MOV     A,[DE+03H]
8f87: d8           XCH     A,X
8f88: 06 00 04     MOV     A,[DE+04H]
8f8b: 1a a6        MOVW    0FEA6H,AX
8f8d: 06 20 01     MOV     A,[HL+01H]
8f90: d8           XCH     A,X
8f91: 06 20 02     MOV     A,[HL+02H]
8f94: 1a a8        MOVW    0FEA8H,AX
8f96: 06 20 03     MOV     A,[HL+03H]
8f99: d8           XCH     A,X
8f9a: 06 20 04     MOV     A,[HL+04H]
8f9d: 1a aa        MOVW    0FEAAH,AX
8f9f: 28 ea ab     CALL    Compare_32Bits
8fa2: 82 25        BNC     $8FC9H
8fa4: 1c 63        MOVW    AX,0FE63H
8fa6: 24 48        MOVW    DE,AX
8fa8: 06 20 07     MOV     A,[HL+07H]
8fab: d8           XCH     A,X
8fac: 06 20 08     MOV     A,[HL+08H]
8faf: 24 28        MOVW    BC,AX
8fb1: 06 20 05     MOV     A,[HL+05H]
8fb4: d8           XCH     A,X
8fb5: 06 20 06     MOV     A,[HL+06H]
8fb8: 06 80 02     MOV     [DE+02H],A
8fbb: d8           XCH     A,X
8fbc: 06 80 01     MOV     [DE+01H],A
8fbf: 25 02        XCH     X,C
8fc1: db           XCH     A,B
8fc2: 06 80 04     MOV     [DE+04H],A
8fc5: d8           XCH     A,X
8fc6: 06 80 03     MOV     [DE+03H],A
8fc9: 28 50 91     CALL    !9150H
8fcc: 1c 63        MOVW    AX,0FE63H
8fce: 24 08        MOVW    AX,AX
8fd0: 44           INCW    AX
8fd1: 3c           PUSH    AX
8fd2: 28 65 8d     CALL    !8D65H
8fd5: 34           POP     AX
8fd6: d2           MOV     A,C
8fd7: 06 a0 09     MOV     [HL+09H],A
8fda: ac 01        AND     A,#01H
8fdc: 81 03        BZ      $8FE1H
8fde: 2c 0d 91     BR      !910DH
8fe1: 2c f0 90     BR      !90F0H
8fe4: 64 d7 ff     MOVW    DE,#0FFD7H
8fe7: 5c           MOV     A,[DE]
8fe8: ac 80        AND     A,#80H
8fea: 80 1c        BNZ     $9008H
8fec: 1c 63        MOVW    AX,0FE63H
8fee: 24 48        MOVW    DE,AX
8ff0: 8a 08        SUBW    AX,AX
8ff2: 62 00 03     MOVW    BC,#0300H
8ff5: 06 80 02     MOV     [DE+02H],A
8ff8: d8           XCH     A,X
8ff9: 06 80 01     MOV     [DE+01H],A
8ffc: 25 02        XCH     X,C
8ffe: db           XCH     A,B
8fff: 06 80 04     MOV     [DE+04H],A
9002: d8           XCH     A,X
9003: 06 80 03     MOV     [DE+03H],A
9006: 14 1d        BR      $9025H
9008: 1c 63        MOVW    AX,0FE63H
900a: 24 48        MOVW    DE,AX
900c: 8a 08        SUBW    AX,AX
900e: 62 40 17     MOVW    BC,#1740H
9011: 06 80 02     MOV     [DE+02H],A
9014: d8           XCH     A,X
9015: 06 80 01     MOV     [DE+01H],A
9018: 25 02        XCH     X,C
901a: db           XCH     A,B
901b: 06 80 04     MOV     [DE+04H],A
901e: d8           XCH     A,X
901f: 06 80 03     MOV     [DE+03H],A
9022: 28 16 91     CALL    !9116H
9025: 2c 07 91     BR      !9107H
9028: 06 20 0e     MOV     A,[HL+0EH]
902b: af 00        CMP     A,#00H
902d: 80 28        BNZ     $9057H
902f: 1c 63        MOVW    AX,0FE63H
9031: 24 48        MOVW    DE,AX
9033: 8a 08        SUBW    AX,AX
9035: 62 00 03     MOVW    BC,#0300H
9038: 06 80 02     MOV     [DE+02H],A
903b: d8           XCH     A,X
903c: 06 80 01     MOV     [DE+01H],A
903f: 25 02        XCH     X,C
9041: db           XCH     A,B
9042: 06 80 04     MOV     [DE+04H],A
9045: d8           XCH     A,X
9046: 06 80 03     MOV     [DE+03H],A
9049: 1c 63        MOVW    AX,0FE63H
904b: 24 48        MOVW    DE,AX
904d: 06 00 06     MOV     A,[DE+06H]
9050: ac 3f        AND     A,#3FH
9052: 06 80 06     MOV     [DE+06H],A
9055: 14 41        BR      $9098H
9057: 64 d7 ff     MOVW    DE,#0FFD7H
905a: 5c           MOV     A,[DE]
905b: ac 80        AND     A,#80H
905d: 80 1c        BNZ     $907BH
905f: 1c 63        MOVW    AX,0FE63H
9061: 24 48        MOVW    DE,AX
9063: 8a 08        SUBW    AX,AX
9065: 62 01 00     MOVW    BC,#0001H
9068: 06 80 02     MOV     [DE+02H],A
906b: d8           XCH     A,X
906c: 06 80 01     MOV     [DE+01H],A
906f: 25 02        XCH     X,C
9071: db           XCH     A,B
9072: 06 80 04     MOV     [DE+04H],A
9075: d8           XCH     A,X
9076: 06 80 03     MOV     [DE+03H],A
9079: 14 1d        BR      $9098H
907b: 1c 63        MOVW    AX,0FE63H
907d: 24 48        MOVW    DE,AX
907f: 8a 08        SUBW    AX,AX
9081: 62 50 03     MOVW    BC,#0350H
9084: 06 80 02     MOV     [DE+02H],A
9087: d8           XCH     A,X
9088: 06 80 01     MOV     [DE+01H],A
908b: 25 02        XCH     X,C
908d: db           XCH     A,B
908e: 06 80 04     MOV     [DE+04H],A
9091: d8           XCH     A,X
9092: 06 80 03     MOV     [DE+03H],A
9095: 28 16 91     CALL    !9116H
9098: 14 6d        BR      $9107H
909a: 06 20 0e     MOV     A,[HL+0EH]
909d: af 01        CMP     A,#01H
909f: 80 07        BNZ     $90A8H
90a1: 8a 08        SUBW    AX,AX
90a3: 62 80 10     MOVW    BC,#1080H
90a6: 14 05        BR      $90ADH
90a8: 8a 08        SUBW    AX,AX
90aa: 62 50 05     MOVW    BC,#0550H
90ad: 3c           PUSH    AX
90ae: 3d           PUSH    BC
90af: 1c 63        MOVW    AX,0FE63H
90b1: 24 48        MOVW    DE,AX
90b3: 35           POP     BC
90b4: 34           POP     AX
90b5: 06 80 02     MOV     [DE+02H],A
90b8: d8           XCH     A,X
90b9: 06 80 01     MOV     [DE+01H],A
90bc: 25 02        XCH     X,C
90be: db           XCH     A,B
90bf: 06 80 04     MOV     [DE+04H],A
90c2: d8           XCH     A,X
90c3: 06 80 03     MOV     [DE+03H],A
90c6: 14 3f        BR      $9107H
90c8: 1c 63        MOVW    AX,0FE63H
90ca: 24 48        MOVW    DE,AX
90cc: 8a 08        SUBW    AX,AX
90ce: 62 01 00     MOVW    BC,#0001H
90d1: 06 80 02     MOV     [DE+02H],A
90d4: d8           XCH     A,X
90d5: 06 80 01     MOV     [DE+01H],A
90d8: 25 02        XCH     X,C
90da: db           XCH     A,B
90db: 06 80 04     MOV     [DE+04H],A
90de: d8           XCH     A,X
90df: 06 80 03     MOV     [DE+03H],A
90e2: 1c 63        MOVW    AX,0FE63H
90e4: 24 48        MOVW    DE,AX
90e6: 06 00 06     MOV     A,[DE+06H]
90e9: ac 3f        AND     A,#3FH
90eb: 06 80 06     MOV     [DE+06H],A
90ee: 14 17        BR      $9107H
90f0: 06 20 09     MOV     A,[HL+09H]
90f3: af 04        CMP     A,#04H
90f5: 81 a3        BZ      $909AH
90f7: af 02        CMP     A,#02H
90f9: 80 03        BNZ     $90FEH
90fb: 2c 28 90     BR      !9028H
90fe: af 00        CMP     A,#00H
9100: 80 03        BNZ     $9105H
9102: 2c e4 8f     BR      !8FE4H
9105: 14 c1        BR      $90C8H
9107: 28 50 91     CALL    !9150H
910a: 28 16 20     CALL    !2016H
910d: 24 0e        MOVW    AX,HL
910f: 2d 0a 00     ADDW    AX,#000AH
9112: 13 fc        MOVW    SP,AX
9114: 37           POP     HL
9115: 56           RET
9116: 1c 63        MOVW    AX,0FE63H
9118: 24 48        MOVW    DE,AX
911a: 06 00 06     MOV     A,[DE+06H]
911d: 30 b1        SHR     A,6
911f: ac 03        AND     A,#03H
9121: b8 00        MOV     X,#00H
9123: d8           XCH     A,X
9124: 2f 01 00     CMPW    AX,#0001H
9127: 81 18        BZ      $9141H
9129: 1c 63        MOVW    AX,0FE63H
912b: 24 48        MOVW    DE,AX
912d: 06 00 05     MOV     A,[DE+05H]
9130: 03 9b        CLR1    A.3
9132: 06 80 05     MOV     [DE+05H],A
9135: 1c 63        MOVW    AX,0FE63H
9137: 24 48        MOVW    DE,AX
9139: 06 00 05     MOV     A,[DE+05H]
913c: 03 9a        CLR1    A.2
913e: 06 80 05     MOV     [DE+05H],A
9141: 1c 63        MOVW    AX,0FE63H
9143: 24 48        MOVW    DE,AX
9145: 06 00 06     MOV     A,[DE+06H]
9148: ac 3f        AND     A,#3FH
914a: ae 40        OR      A,#40H
914c: 06 80 06     MOV     [DE+06H],A
914f: 56           RET
9150: 1c 63        MOVW    AX,0FE63H
9152: 24 48        MOVW    DE,AX
9154: 06 00 01     MOV     A,[DE+01H]
9157: d8           XCH     A,X
9158: 06 00 02     MOV     A,[DE+02H]
915b: 1a a4        MOVW    0FEA4H,AX
915d: 06 00 03     MOV     A,[DE+03H]
9160: d8           XCH     A,X
9161: 06 00 04     MOV     A,[DE+04H]
9164: 1a a6        MOVW    0FEA6H,AX
9166: 1c a4        MOVW    AX,0FEA4H
9168: 1a a8        MOVW    0FEA8H,AX
916a: 1c a6        MOVW    AX,0FEA6H
916c: 1a aa        MOVW    0FEAAH,AX
916e: 0c a4 00 00  MOVW    0FEA4H,#0000H
9172: 0c a6 00 03  MOVW    0FEA6H,#0300H
9176: 28 ea ab     CALL    Compare_32Bits
9179: 82 05        BNC     $9180H
917b: 28 16 91     CALL    !9116H
917e: 14 1f        BR      $919FH
9180: 1c 63        MOVW    AX,0FE63H
9182: 24 48        MOVW    DE,AX
9184: 06 00 06     MOV     A,[DE+06H]
9187: 30 b1        SHR     A,6
9189: ac 03        AND     A,#03H
918b: b8 00        MOV     X,#00H
918d: d8           XCH     A,X
918e: 2f 01 00     CMPW    AX,#0001H
9191: 80 0c        BNZ     $919FH
9193: 1c 63        MOVW    AX,0FE63H
9195: 24 48        MOVW    DE,AX
9197: 06 00 06     MOV     A,[DE+06H]
919a: ac 3f        AND     A,#3FH
919c: 06 80 06     MOV     [DE+06H],A
919f: 56           RET
91a0: 3f           PUSH    HL
91a1: 05 c9        DECW    SP
91a3: 05 c9        DECW    SP
91a5: 11 fc        MOVW    AX,SP
91a7: 24 68        MOVW    HL,AX
91a9: b9 00        MOV     A,#00H
91ab: 06 a0 01     MOV     [HL+01H],A
91ae: b9 03        MOV     A,#03H
91b0: 06 2f 01     CMP     A,[HL+01H]
91b3: 83 4d        BC      $9202H
91b5: 06 20 01     MOV     A,[HL+01H]
91b8: b8 00        MOV     X,#00H
91ba: d8           XCH     A,X
91bb: 2d 8c fe     ADDW    AX,#0FE8CH
91be: 24 48        MOVW    DE,AX
91c0: 5c           MOV     A,[DE]
91c1: ac f0        AND     A,#0F0H
91c3: af b0        CMP     A,#0B0H
91c5: 80 10        BNZ     $91D7H
91c7: 06 20 01     MOV     A,[HL+01H]
91ca: b8 00        MOV     X,#00H
91cc: d8           XCH     A,X
91cd: 2d 8c fe     ADDW    AX,#0FE8CH
91d0: 24 48        MOVW    DE,AX
91d2: b9 0f        MOV     A,#0FH
91d4: 16 4c        AND     A,[DE]
91d6: 54           MOV     [DE],A
91d7: 06 20 01     MOV     A,[HL+01H]
91da: b8 00        MOV     X,#00H
91dc: d8           XCH     A,X
91dd: 2d 8c fe     ADDW    AX,#0FE8CH
91e0: 24 48        MOVW    DE,AX
91e2: 5c           MOV     A,[DE]
91e3: ac 0f        AND     A,#0FH
91e5: af 0b        CMP     A,#0BH
91e7: 80 10        BNZ     $91F9H
91e9: 06 20 01     MOV     A,[HL+01H]
91ec: b8 00        MOV     X,#00H
91ee: d8           XCH     A,X
91ef: 2d 8c fe     ADDW    AX,#0FE8CH
91f2: 24 48        MOVW    DE,AX
91f4: b9 f0        MOV     A,#0F0H
91f6: 16 4c        AND     A,[DE]
91f8: 54           MOV     [DE],A
91f9: 06 20 01     MOV     A,[HL+01H]
91fc: c1           INC     A
91fd: 06 a0 01     MOV     [HL+01H],A
9200: 14 ac        BR      $91AEH
9202: 34           POP     AX
9203: 37           POP     HL
9204: 56           RET
9205: 20 6a        MOV     A,0FE6AH
9207: 98 6c        ADD     A,0FE6CH
9209: 0e           ADJBA
920a: 22 6a        MOV     0FE6AH,A
920c: 20 6b        MOV     A,0FE6BH
920e: 99 6d        ADDC    A,0FE6DH
9210: 0e           ADJBA
9211: 22 6b        MOV     0FE6BH,A
9213: 1c 6a        MOVW    AX,0FE6AH
9215: 24 28        MOVW    BC,AX
9217: 56           RET
9218: 20 6a        MOV     A,0FE6AH
921a: 9a 6c        SUB     A,0FE6CH
921c: 0f           ADJBS
921d: 22 6a        MOV     0FE6AH,A
921f: 20 6b        MOV     A,0FE6BH
9221: 9b 6d        SUBC    A,0FE6DH
9223: 0f           ADJBS
9224: 22 6b        MOV     0FE6BH,A
9226: 1c 6a        MOVW    AX,0FE6AH
9228: 24 28        MOVW    BC,AX
922a: 56           RET
922b: 3a 89 64     MOV     0FE89H,#64H
922e: 28 39 92     CALL    !9239H
9231: 56           RET
9232: 3a 89 19     MOV     0FE89H,#19H
9235: 28 39 92     CALL    !9239H
9238: 56           RET
9239: b4 68        SET1    0FE68H.4
923b: 1c 63        MOVW    AX,0FE63H
923d: 24 08        MOVW    AX,AX
923f: 44           INCW    AX
9240: 24 48        MOVW    DE,AX
9242: 5c           MOV     A,[DE]
9243: 22 6a        MOV     0FE6AH,A
9245: 1c 63        MOVW    AX,0FE63H
9247: 24 08        MOVW    AX,AX
9249: 44           INCW    AX
924a: 44           INCW    AX
924b: 24 48        MOVW    DE,AX
924d: 5c           MOV     A,[DE]
924e: 22 6b        MOV     0FE6BH,A
9250: 0c 6c 20 00  MOVW    0FE6CH,#0020H
9254: 28 05 92     CALL    !9205H
9257: 24 0a        MOVW    AX,BC
9259: 1a a4        MOVW    0FEA4H,AX
925b: 1c 63        MOVW    AX,0FE63H
925d: 24 08        MOVW    AX,AX
925f: 44           INCW    AX
9260: 24 48        MOVW    DE,AX
9262: 5c           MOV     A,[DE]
9263: 22 6a        MOV     0FE6AH,A
9265: 1c 63        MOVW    AX,0FE63H
9267: 24 08        MOVW    AX,AX
9269: 44           INCW    AX
926a: 44           INCW    AX
926b: 24 48        MOVW    DE,AX
926d: 5c           MOV     A,[DE]
926e: 22 6b        MOV     0FE6BH,A
9270: 28 18 92     CALL    !9218H
9273: 24 0a        MOVW    AX,BC
9275: 1a a2        MOVW    0FEA2H,AX
9277: 56           RET
9278: 2b 23 05     MOV     PM3,#05H
927b: 01 6e 40 08  OR      PUO,#08H
927f: 2b 43 43     MOV     PMC3,#43H
9282: 2b 34 18     MOV     CRC2,#18H
9285: 2b 31 20     MOV     TOC,#20H
9288: 2b 5e 37     MOV     PRM1,#37H
928b: 3a 15 00     MOV     CR20,#00H
928e: 3a 87 04     MOV     0FE87H,#04H
9291: 3a 16 94     MOV     CR21,#94H
9294: 08 a1 69 06  BF      0FE69H.1,$929EH
9298: 3a 87 11     MOV     0FE87H,#11H
929b: 3a 16 4e     MOV     CR21,#4EH
929e: 08 a2 69 06  BF      0FE69H.2,$92A8H
92a2: 3a 87 13     MOV     0FE87H,#13H
92a5: 3a 16 ae     MOV     CR21,#0AEH
92a8: 6c 69 f8     AND     0FE69H,#0F8H
92ab: 08 a5 66 04  BF      0FE66H.5,$92B3H
92af: 01 6e 5f 80  OR      TMC1,#80H
92b3: 56           RET
92b4: 60 0b 00     MOVW    AX,#000BH
92b7: 3c           PUSH    AX
92b8: 28 6d 8b     CALL    Delay_Loop
92bb: 34           POP     AX
92bc: 28 ce 7a     CALL    Query_DFBE
92bf: 64 55 d5     MOVW    DE,#0D555H
92c2: b9 aa        MOV     A,#0AAH
92c4: 54           MOV     [DE],A
92c5: 64 aa ca     MOVW    DE,#0CAAAH
92c8: b9 55        MOV     A,#55H
92ca: 54           MOV     [DE],A
92cb: 64 55 d5     MOVW    DE,#0D555H
92ce: b9 a0        MOV     A,#0A0H
92d0: 54           MOV     [DE],A
92d1: 64 d0 df     MOVW    DE,#0DFD0H
92d4: 20 65        MOV     A,0FE65H
92d6: 54           MOV     [DE],A
92d7: 64 d1 df     MOVW    DE,#0DFD1H
92da: 20 66        MOV     A,0FE66H
92dc: 54           MOV     [DE],A
92dd: 64 d2 df     MOVW    DE,#0DFD2H
92e0: 20 72        MOV     A,0FE72H
92e2: 54           MOV     [DE],A
92e3: 64 d3 df     MOVW    DE,#0DFD3H
92e6: 20 73        MOV     A,0FE73H
92e8: 54           MOV     [DE],A
92e9: 64 d4 df     MOVW    DE,#0DFD4H
92ec: 20 a1        MOV     A,0FEA1H
92ee: 54           MOV     [DE],A
92ef: 64 d5 df     MOVW    DE,#0DFD5H
92f2: 09 f0 97 fd  MOV     A,!0FD97H
92f6: 54           MOV     [DE],A
92f7: 64 d6 df     MOVW    DE,#0DFD6H
92fa: 09 f0 a3 fd  MOV     A,!0FDA3H
92fe: 54           MOV     [DE],A
92ff: 64 d7 df     MOVW    DE,#0DFD7H
9302: 1c 90        MOVW    AX,0FE90H
9304: 05 e6        MOVW    [DE],AX
9306: 60 14 00     MOVW    AX,#0014H
9309: 3c           PUSH    AX
930a: 28 6d 8b     CALL    Delay_Loop
930d: 34           POP     AX
930e: 28 ce 7a     CALL    Query_DFBE
9311: 64 55 d5     MOVW    DE,#0D555H
9314: b9 aa        MOV     A,#0AAH
9316: 54           MOV     [DE],A
9317: 64 aa ca     MOVW    DE,#0CAAAH
931a: b9 55        MOV     A,#55H
931c: 54           MOV     [DE],A
931d: 64 55 d5     MOVW    DE,#0D555H
9320: b9 a0        MOV     A,#0A0H
9322: 54           MOV     [DE],A
9323: 60 c0 df     MOVW    AX,#0DFC0H
9326: 3c           PUSH    AX
9327: 64 55 fe     MOVW    DE,#0FE55H
932a: 3e           PUSH    DE
932b: 28 a8 9a     CALL    !9AA8H
932e: 34           POP     AX
932f: 34           POP     AX
9330: 60 c7 df     MOVW    AX,#0DFC7H
9333: 3c           PUSH    AX
9334: 1c 63        MOVW    AX,0FE63H
9336: 3c           PUSH    AX
9337: 28 db 7b     CALL    !7BDBH
933a: 34           POP     AX
933b: 34           POP     AX
933c: 60 c9 df     MOVW    AX,#0DFC9H
933f: 3c           PUSH    AX
9340: 64 5c fe     MOVW    DE,#0FE5CH
9343: 3e           PUSH    DE
9344: 28 a8 9a     CALL    !9AA8H
9347: 34           POP     AX
9348: 34           POP     AX
9349: 8a 08        SUBW    AX,AX
934b: 64 b4 fd     MOVW    DE,@NMI_FLAG_WORD
934e: 05 e6        MOVW    [DE],AX
9350: 28 20 58     CALL    !5820H
9353: 60 00 00     MOVW    AX,#0000H
9356: 3c           PUSH    AX
9357: 28 be 08     CALL    Puzzle_Piece1
935a: 34           POP     AX
935b: 60 50 1b     MOVW    AX,#1B50H
935e: 3c           PUSH    AX
935f: 28 98 08     CALL    !Interpret_Thing
9362: 34           POP     AX
9363: 60 94 0d     MOVW    AX,#0D94H
9366: 3c           PUSH    AX
9367: 28 2d 6f     CALL    !6F2DH
936a: 34           POP     AX
936b: 3d           PUSH    BC
936c: 28 98 08     CALL    !Interpret_Thing
936f: 34           POP     AX
9370: 60 54 1b     MOVW    AX,#1B54H
9373: 3c           PUSH    AX
9374: 28 98 08     CALL    !Interpret_Thing
9377: 34           POP     AX
9378: 60 00 1b     MOVW    AX,#1B00H
937b: 3c           PUSH    AX
937c: 28 2d 6f     CALL    !6F2DH
937f: 34           POP     AX
9380: 3d           PUSH    BC
9381: 28 98 08     CALL    !Interpret_Thing
9384: 34           POP     AX
9385: 60 d0 1b     MOVW    AX,#1BD0H
9388: 3c           PUSH    AX
9389: 28 98 08     CALL    !Interpret_Thing
938c: 34           POP     AX
938d: 60 02 d0     MOVW    AX,#0D002H
9390: 3c           PUSH    AX
9391: 28 2d 6f     CALL    !6F2DH
9394: 34           POP     AX
9395: 3d           PUSH    BC
9396: 28 98 08     CALL    !Interpret_Thing
9399: 34           POP     AX
939a: 60 00 89     MOVW    AX,#8900H
939d: 3c           PUSH    AX
939e: 28 98 08     CALL    !Interpret_Thing
93a1: 34           POP     AX
93a2: 28 d7 6d     CALL    !6DD7H
93a5: 14 fe        BR      $93A5H
93a7: 56           RET
93a8: 3f           PUSH    HL
93a9: 11 fc        MOVW    AX,SP
93ab: 2e 04 00     SUBW    AX,#0004H
93ae: 24 68        MOVW    HL,AX
93b0: 13 fc        MOVW    SP,AX
93b2: 1c 63        MOVW    AX,0FE63H
93b4: 24 48        MOVW    DE,AX
93b6: 06 00 05     MOV     A,[DE+05H]
93b9: d8           XCH     A,X
93ba: 06 00 06     MOV     A,[DE+06H]
93bd: 30 f8        SHRW    AX,7
93bf: 30 c8        SHRW    AX,1
93c1: d8           XCH     A,X
93c2: ac 07        AND     A,#07H
93c4: d8           XCH     A,X
93c5: 24 28        MOVW    BC,AX
93c7: 06 20 03     MOV     A,[HL+03H]
93ca: ac f8        AND     A,#0F8H
93cc: 8e 12        OR      A,C
93ce: 06 a0 03     MOV     [HL+03H],A
93d1: 1c 63        MOVW    AX,0FE63H
93d3: 24 48        MOVW    DE,AX
93d5: 06 00 05     MOV     A,[DE+05H]
93d8: d8           XCH     A,X
93d9: 06 00 06     MOV     A,[DE+06H]
93dc: 30 e0        SHRW    AX,4
93de: d8           XCH     A,X
93df: ac 03        AND     A,#03H
93e1: d8           XCH     A,X
93e2: ac 00        AND     A,#00H
93e4: 24 28        MOVW    BC,AX
93e6: 06 20 03     MOV     A,[HL+03H]
93e9: 31 9a        SHL     C,3
93eb: ac e7        AND     A,#0E7H
93ed: 8e 12        OR      A,C
93ef: 06 a0 03     MOV     [HL+03H],A
93f2: 14 4a        BR      $943EH
93f4: 60 de df     MOVW    AX,#0DFDEH
93f7: 06 a0 02     MOV     [HL+02H],A
93fa: d8           XCH     A,X
93fb: 06 a0 01     MOV     [HL+01H],A
93fe: 14 6a        BR      $946AH
9400: 60 e0 df     MOVW    AX,#0DFE0H
9403: 06 a0 02     MOV     [HL+02H],A
9406: d8           XCH     A,X
9407: 06 a0 01     MOV     [HL+01H],A
940a: 14 5e        BR      $946AH
940c: 60 e2 df     MOVW    AX,#0DFE2H
940f: 06 a0 02     MOV     [HL+02H],A
9412: d8           XCH     A,X
9413: 06 a0 01     MOV     [HL+01H],A
9416: 14 52        BR      $946AH
9418: 60 e4 df     MOVW    AX,#0DFE4H
941b: 06 a0 02     MOV     [HL+02H],A
941e: d8           XCH     A,X
941f: 06 a0 01     MOV     [HL+01H],A
9422: 14 46        BR      $946AH
9424: 60 e8 df     MOVW    AX,#0DFE8H
9427: 06 a0 02     MOV     [HL+02H],A
942a: d8           XCH     A,X
942b: 06 a0 01     MOV     [HL+01H],A
942e: 14 3a        BR      $946AH
9430: 60 e6 df     MOVW    AX,#0DFE6H
9433: 06 a0 02     MOV     [HL+02H],A
9436: d8           XCH     A,X
9437: 06 a0 01     MOV     [HL+01H],A
943a: 14 2e        BR      $946AH
943c: 14 2c        BR      $946AH
943e: 1c 63        MOVW    AX,0FE63H
9440: 24 48        MOVW    DE,AX
9442: 06 00 06     MOV     A,[DE+06H]
9445: 30 99        SHR     A,3
9447: ac 07        AND     A,#07H
9449: b8 00        MOV     X,#00H
944b: d8           XCH     A,X
944c: 2f 01 00     CMPW    AX,#0001H
944f: 81 df        BZ      $9430H
9451: 2f 00 00     CMPW    AX,#0000H
9454: 81 ce        BZ      $9424H
9456: 2f 02 00     CMPW    AX,#0002H
9459: 81 bd        BZ      $9418H
945b: 2f 03 00     CMPW    AX,#0003H
945e: 81 ac        BZ      $940CH
9460: 2f 04 00     CMPW    AX,#0004H
9463: 81 9b        BZ      $9400H
9465: 2f 05 00     CMPW    AX,#0005H
9468: 81 8a        BZ      $93F4H
946a: 60 0f 00     MOVW    AX,#000FH
946d: 3c           PUSH    AX
946e: 28 6d 8b     CALL    Delay_Loop
9471: 34           POP     AX
9472: 28 ce 7a     CALL    Query_DFBE
9475: 06 20 01     MOV     A,[HL+01H]
9478: d8           XCH     A,X
9479: 06 20 02     MOV     A,[HL+02H]
947c: 24 48        MOVW    DE,AX
947e: 5c           MOV     A,[DE]
947f: 06 2f 03     CMP     A,[HL+03H]
9482: 81 1f        BZ      $94A3H
9484: 64 55 d5     MOVW    DE,#0D555H
9487: b9 aa        MOV     A,#0AAH
9489: 54           MOV     [DE],A
948a: 64 aa ca     MOVW    DE,#0CAAAH
948d: b9 55        MOV     A,#55H
948f: 54           MOV     [DE],A
9490: 64 55 d5     MOVW    DE,#0D555H
9493: b9 a0        MOV     A,#0A0H
9495: 54           MOV     [DE],A
9496: 06 20 01     MOV     A,[HL+01H]
9499: d8           XCH     A,X
949a: 06 20 02     MOV     A,[HL+02H]
949d: 24 48        MOVW    DE,AX
949f: 06 20 03     MOV     A,[HL+03H]
94a2: 54           MOV     [DE],A
94a3: 60 0f 00     MOVW    AX,#000FH
94a6: 3c           PUSH    AX
94a7: 28 6d 8b     CALL    Delay_Loop
94aa: 34           POP     AX
94ab: 28 ce 7a     CALL    Query_DFBE
94ae: 06 20 01     MOV     A,[HL+01H]
94b1: d8           XCH     A,X
94b2: 06 20 02     MOV     A,[HL+02H]
94b5: 44           INCW    AX
94b6: 06 a0 02     MOV     [HL+02H],A
94b9: d8           XCH     A,X
94ba: 06 a0 01     MOV     [HL+01H],A
94bd: d8           XCH     A,X
94be: 24 48        MOVW    DE,AX
94c0: 09 f0 a3 fd  MOV     A,!0FDA3H
94c4: 16 4f        CMP     A,[DE]
94c6: 81 20        BZ      $94E8H
94c8: 64 55 d5     MOVW    DE,#0D555H
94cb: b9 aa        MOV     A,#0AAH
94cd: 54           MOV     [DE],A
94ce: 64 aa ca     MOVW    DE,#0CAAAH
94d1: b9 55        MOV     A,#55H
94d3: 54           MOV     [DE],A
94d4: 64 55 d5     MOVW    DE,#0D555H
94d7: b9 a0        MOV     A,#0A0H
94d9: 54           MOV     [DE],A
94da: 06 20 01     MOV     A,[HL+01H]
94dd: d8           XCH     A,X
94de: 06 20 02     MOV     A,[HL+02H]
94e1: 24 48        MOVW    DE,AX
94e3: 09 f0 a3 fd  MOV     A,!0FDA3H
94e7: 54           MOV     [DE],A
94e8: 34           POP     AX
94e9: 34           POP     AX
94ea: 37           POP     HL
94eb: 56           RET
94ec: 3f           PUSH    HL
94ed: 11 fc        MOVW    AX,SP
94ef: 2e 04 00     SUBW    AX,#0004H
94f2: 24 68        MOVW    HL,AX
94f4: 13 fc        MOVW    SP,AX
94f6: 71 65 03     BT      0FE65H.1,$94FCH
94f9: 2c c6 95     BR      !95C6H
94fc: 14 3e        BR      $953CH
94fe: 60 de df     MOVW    AX,#0DFDEH
9501: 06 a0 01     MOV     [HL+01H],A
9504: d8           XCH     A,X
9505: 55           MOV     [HL],A
9506: 14 60        BR      $9568H
9508: 60 e0 df     MOVW    AX,#0DFE0H
950b: 06 a0 01     MOV     [HL+01H],A
950e: d8           XCH     A,X
950f: 55           MOV     [HL],A
9510: 14 56        BR      $9568H
9512: 60 e2 df     MOVW    AX,#0DFE2H
9515: 06 a0 01     MOV     [HL+01H],A
9518: d8           XCH     A,X
9519: 55           MOV     [HL],A
951a: 14 4c        BR      $9568H
951c: 60 e4 df     MOVW    AX,#0DFE4H
951f: 06 a0 01     MOV     [HL+01H],A
9522: d8           XCH     A,X
9523: 55           MOV     [HL],A
9524: 14 42        BR      $9568H
9526: 60 e8 df     MOVW    AX,#0DFE8H
9529: 06 a0 01     MOV     [HL+01H],A
952c: d8           XCH     A,X
952d: 55           MOV     [HL],A
952e: 14 38        BR      $9568H
9530: 60 e6 df     MOVW    AX,#0DFE6H
9533: 06 a0 01     MOV     [HL+01H],A
9536: d8           XCH     A,X
9537: 55           MOV     [HL],A
9538: 14 2e        BR      $9568H
953a: 14 2c        BR      $9568H
953c: 1c 63        MOVW    AX,0FE63H
953e: 24 48        MOVW    DE,AX
9540: 06 00 06     MOV     A,[DE+06H]
9543: 30 99        SHR     A,3
9545: ac 07        AND     A,#07H
9547: b8 00        MOV     X,#00H
9549: d8           XCH     A,X
954a: 2f 01 00     CMPW    AX,#0001H
954d: 81 e1        BZ      $9530H
954f: 2f 00 00     CMPW    AX,#0000H
9552: 81 d2        BZ      $9526H
9554: 2f 02 00     CMPW    AX,#0002H
9557: 81 c3        BZ      $951CH
9559: 2f 03 00     CMPW    AX,#0003H
955c: 81 b4        BZ      $9512H
955e: 2f 04 00     CMPW    AX,#0004H
9561: 81 a5        BZ      $9508H
9563: 2f 05 00     CMPW    AX,#0005H
9566: 81 96        BZ      $94FEH
9568: 60 0f 00     MOVW    AX,#000FH
956b: 3c           PUSH    AX
956c: 28 6d 8b     CALL    Delay_Loop
956f: 34           POP     AX
9570: 28 ce 7a     CALL    Query_DFBE
9573: 05 e3        MOVW    AX,[HL]
9575: 44           INCW    AX
9576: 06 a0 01     MOV     [HL+01H],A
9579: d8           XCH     A,X
957a: 55           MOV     [HL],A
957b: d8           XCH     A,X
957c: 4c           DECW    AX
957d: 24 48        MOVW    DE,AX
957f: 5c           MOV     A,[DE]
9580: 06 a0 03     MOV     [HL+03H],A
9583: 05 e3        MOVW    AX,[HL]
9585: 24 48        MOVW    DE,AX
9587: 5c           MOV     A,[DE]
9588: 06 a0 02     MOV     [HL+02H],A
958b: 1c 63        MOVW    AX,0FE63H
958d: 24 48        MOVW    DE,AX
958f: 06 20 03     MOV     A,[HL+03H]
9592: ac 07        AND     A,#07H
9594: b8 00        MOV     X,#00H
9596: d8           XCH     A,X
9597: 24 28        MOVW    BC,AX
9599: 06 00 06     MOV     A,[DE+06H]
959c: ac f8        AND     A,#0F8H
959e: 8e 12        OR      A,C
95a0: 06 80 06     MOV     [DE+06H],A
95a3: 1c 63        MOVW    AX,0FE63H
95a5: 24 48        MOVW    DE,AX
95a7: 06 20 03     MOV     A,[HL+03H]
95aa: 30 99        SHR     A,3
95ac: ac 03        AND     A,#03H
95ae: b8 00        MOV     X,#00H
95b0: d8           XCH     A,X
95b1: 24 28        MOVW    BC,AX
95b3: 06 00 05     MOV     A,[DE+05H]
95b6: 31 a2        SHL     C,4
95b8: ac cf        AND     A,#0CFH
95ba: 8e 12        OR      A,C
95bc: 06 80 05     MOV     [DE+05H],A
95bf: 06 20 02     MOV     A,[HL+02H]
95c2: 09 f1 a3 fd  MOV     !0FDA3H,A
95c6: 34           POP     AX
95c7: 34           POP     AX
95c8: 37           POP     HL
95c9: 56           RET
95ca: 10 6a        MOV     A,ADCR
95cc: 09 f1 a5 fd  MOV     !0FDA5H,A
95d0: 60 0b 00     MOVW    AX,#000BH
95d3: 3c           PUSH    AX
95d4: 28 6d 8b     CALL    Delay_Loop
95d7: 34           POP     AX
95d8: 28 ce 7a     CALL    Query_DFBE
95db: 0c 70 a1 df  MOVW    0FE70H,#0DFA1H
95df: 64 a1 df     MOVW    DE,#0DFA1H
95e2: 5c           MOV     A,[DE]
95e3: 22 6c        MOV     0FE6CH,A
95e5: 77 02 04     BT      P2.7,$95ECH
95e8: 2c 83 96     BR      !9683H
95eb: 64 a1 df     MOVW    DE,#0DFA1H
95ee: 5c           MOV     A,[DE]
95ef: 22 6c        MOV     0FE6CH,A
95f1: 09 f0 a5 fd  MOV     A,!0FDA5H
95f5: 9f 6c        CMP     A,0FE6CH
95f7: 83 02        BC      $95FBH
95f9: 80 06        BNZ     $9601H
95fb: 0c 6c 00 00  MOVW    0FE6CH,#0000H
95ff: 14 7c        BR      $967DH
9601: 3a 6d 00     MOV     0FE6DH,#00H
9604: 1c 70        MOVW    AX,0FE70H
9606: 44           INCW    AX
9607: 1a 70        MOVW    0FE70H,AX
9609: 24 48        MOVW    DE,AX
960b: 5c           MOV     A,[DE]
960c: 22 6c        MOV     0FE6CH,A
960e: 60 aa df     MOVW    AX,#0DFAAH
9611: 44           INCW    AX
9612: 24 28        MOVW    BC,AX
9614: 1c 70        MOVW    AX,0FE70H
9616: 8f 0a        CMPW    AX,BC
9618: 82 0a        BNC     $9624H
961a: 09 f0 a5 fd  MOV     A,!0FDA5H
961e: 9f 6c        CMP     A,0FE6CH
9620: 83 02        BC      $9624H
9622: 80 e0        BNZ     $9604H
9624: 1c 70        MOVW    AX,0FE70H
9626: 4c           DECW    AX
9627: 3c           PUSH    AX
9628: 28 2b 7c     CALL    !7C2BH
962b: 34           POP     AX
962c: 24 0a        MOVW    AX,BC
962e: 1a 6e        MOVW    0FE6EH,AX
9630: 60 aa df     MOVW    AX,#0DFAAH
9633: 1f 70        CMPW    AX,0FE70H
9635: 82 0b        BNC     $9642H
9637: 09 f0 a5 fd  MOV     A,!0FDA5H
963b: a8 0a        ADD     A,#0AH
963d: b8 00        MOV     X,#00H
963f: d8           XCH     A,X
9640: 1a 6c        MOVW    0FE6CH,AX
9642: 09 f0 a5 fd  MOV     A,!0FDA5H
9646: b8 00        MOV     X,#00H
9648: d8           XCH     A,X
9649: 1e 6e        SUBW    AX,0FE6EH
964b: 1a a6        MOVW    0FEA6H,AX
964d: 0c a4 19 00  MOVW    0FEA4H,#0019H
9651: 28 f7 ab     CALL    Multiply_Thing
9654: 1c 6c        MOVW    AX,0FE6CH
9656: 1e 6e        SUBW    AX,0FE6EH
9658: 1a a6        MOVW    0FEA6H,AX
965a: 28 1b ac     CALL    !0AC1BH
965d: 1c 70        MOVW    AX,0FE70H
965f: 2e a2 df     SUBW    AX,#0DFA2H
9662: 1a a6        MOVW    0FEA6H,AX
9664: 1c a4        MOVW    AX,0FEA4H
9666: 1a a8        MOVW    0FEA8H,AX
9668: 0c a4 19 00  MOVW    0FEA4H,#0019H
966c: 28 f7 ab     CALL    Multiply_Thing
966f: 1c a8        MOVW    AX,0FEA8H
9671: 1d a4        ADDW    AX,0FEA4H
9673: 1a 6c        MOVW    0FE6CH,AX
9675: 6f 6d 00     CMP     0FE6DH,#00H
9678: 81 03        BZ      $967DH
967a: 3a 6c ff     MOV     0FE6CH,#0FFH
967d: 20 6c        MOV     A,0FE6CH
967f: 09 f1 a5 fd  MOV     !0FDA5H,A
9683: 56           RET
9684: 28 40 2d     CALL    !2D40H
9687: 08 a5 65 08  BF      0FE65H.5,$9693H
968b: 28 54 7e     CALL    !7E54H
968e: 28 43 7d     CALL    !7D43H
9691: 14 2e        BR      $96C1H
9693: a5 65        CLR1    0FE65H.5
9695: 28 2b 97     CALL    !972BH
9698: 8a 08        SUBW    AX,AX
969a: 8f 0a        CMPW    AX,BC
969c: 81 05        BZ      $96A3H
969e: 28 0c 21     CALL    !210CH
96a1: 14 13        BR      $96B6H
96a3: 60 00 00     MOVW    AX,#0000H
96a6: 3c           PUSH    AX
96a7: 28 00 97     CALL    !9700H
96aa: 34           POP     AX
96ab: 28 f1 20     CALL    !Decimal_Subtract
96ae: 60 00 00     MOVW    AX,#0000H
96b1: 3c           PUSH    AX
96b2: 28 96 aa     CALL    !0AA96H
96b5: 34           POP     AX
96b6: 60 00 00     MOVW    AX,#0000H
96b9: 3c           PUSH    AX
96ba: 28 78 8e     CALL    !8E78H
96bd: 34           POP     AX
96be: 28 2b 92     CALL    !922BH
96c1: 56           RET
96c2: 28 40 2d     CALL    !2D40H
96c5: 08 a5 65 08  BF      0FE65H.5,$96D1H
96c9: 28 17 7e     CALL    !7E17H
96cc: 28 43 7d     CALL    !7D43H
96cf: 14 2e        BR      $96FFH
96d1: a5 65        CLR1    0FE65H.5
96d3: 28 2b 97     CALL    !972BH
96d6: 8a 08        SUBW    AX,AX
96d8: 8f 0a        CMPW    AX,BC
96da: 81 05        BZ      $96E1H
96dc: 28 db 20     CALL    !Decimal_Add
96df: 14 13        BR      $96F4H
96e1: 60 01 00     MOVW    AX,#0001H
96e4: 3c           PUSH    AX
96e5: 28 00 97     CALL    !9700H
96e8: 34           POP     AX
96e9: 28 c0 20     CALL    !20C0H
96ec: 60 01 00     MOVW    AX,#0001H
96ef: 3c           PUSH    AX
96f0: 28 96 aa     CALL    !0AA96H
96f3: 34           POP     AX
96f4: 60 01 00     MOVW    AX,#0001H
96f7: 3c           PUSH    AX
96f8: 28 78 8e     CALL    !8E78H
96fb: 34           POP     AX
96fc: 28 2b 92     CALL    !922BH
96ff: 56           RET
9700: 3f           PUSH    HL
9701: 11 fc        MOVW    AX,SP
9703: 24 68        MOVW    HL,AX
9705: 3a 6a 05     MOV     0FE6AH,#05H
9708: 06 20 04     MOV     A,[HL+04H]
970b: b8 00        MOV     X,#00H
970d: d8           XCH     A,X
970e: 3c           PUSH    AX
970f: 28 4e 97     CALL    !974EH
9712: 34           POP     AX
9713: 24 0a        MOVW    AX,BC
9715: 2f 01 00     CMPW    AX,#0001H
9718: 80 0f        BNZ     $9729H
971a: 08 a4 66 05  BF      0FE66H.4,$9723H
971e: 60 10 00     MOVW    AX,#0010H
9721: 14 03        BR      $9726H
9723: 60 09 00     MOVW    AX,#0009H
9726: d0           MOV     A,X
9727: 22 6a        MOV     0FE6AH,A
9729: 37           POP     HL
972a: 56           RET
972b: 6f 7f 00     CMP     0FE7FH,#00H
972e: 81 03        BZ      $9733H
9730: 3a 7f 90     MOV     0FE7FH,#90H
9733: 6f 7f 00     CMP     0FE7FH,#00H
9736: 81 04        BZ      $973CH
9738: 08 a3 72 09  BF      0FE72H.3,$9745H
973c: 6f 7f 00     CMP     0FE7FH,#00H
973f: 80 09        BNZ     $974AH
9741: 08 a3 72 05  BF      0FE72H.3,$974AH
9745: 62 01 00     MOVW    BC,#0001H
9748: 14 03        BR      $974DH
974a: 62 00 00     MOVW    BC,#0000H
974d: 56           RET
974e: 3f           PUSH    HL
974f: 11 fc        MOVW    AX,SP
9751: 24 68        MOVW    HL,AX
9753: 06 20 04     MOV     A,[HL+04H]
9756: af 01        CMP     A,#01H
9758: 80 67        BNZ     $97C1H
975a: 1c 63        MOVW    AX,0FE63H
975c: 24 48        MOVW    DE,AX
975e: 06 00 06     MOV     A,[DE+06H]
9761: 30 99        SHR     A,3
9763: ac 07        AND     A,#07H
9765: b8 00        MOV     X,#00H
9767: d8           XCH     A,X
9768: 2f 05 00     CMPW    AX,#0005H
976b: 80 4d        BNZ     $97BAH
976d: 1c 63        MOVW    AX,0FE63H
976f: 24 48        MOVW    DE,AX
9771: 06 00 01     MOV     A,[DE+01H]
9774: d8           XCH     A,X
9775: 06 00 02     MOV     A,[DE+02H]
9778: 1a a4        MOVW    0FEA4H,AX
977a: 06 00 03     MOV     A,[DE+03H]
977d: d8           XCH     A,X
977e: 06 00 04     MOV     A,[DE+04H]
9781: 1a a6        MOVW    0FEA6H,AX
9783: 0c a8 00 40  MOVW    0FEA8H,#4000H
9787: 0c aa 05 00  MOVW    0FEAAH,#0005H
978b: 28 ea ab     CALL    Compare_32Bits
978e: 83 2a        BC      $97BAH
9790: 1c 63        MOVW    AX,0FE63H
9792: 24 48        MOVW    DE,AX
9794: 06 00 01     MOV     A,[DE+01H]
9797: d8           XCH     A,X
9798: 06 00 02     MOV     A,[DE+02H]
979b: 1a a4        MOVW    0FEA4H,AX
979d: 06 00 03     MOV     A,[DE+03H]
97a0: d8           XCH     A,X
97a1: 06 00 04     MOV     A,[DE+04H]
97a4: 1a a6        MOVW    0FEA6H,AX
97a6: 0c a8 00 00  MOVW    0FEA8H,#0000H
97aa: 0c aa 18 00  MOVW    0FEAAH,#0018H
97ae: 28 ea ab     CALL    Compare_32Bits
97b1: 82 07        BNC     $97BAH
97b3: 62 01 00     MOVW    BC,#0001H
97b6: 14 7c        BR      $9834H
97b8: 14 05        BR      $97BFH
97ba: 62 00 00     MOVW    BC,#0000H
97bd: 14 75        BR      $9834H
97bf: 14 73        BR      $9834H
97c1: 1c 63        MOVW    AX,0FE63H
97c3: 24 48        MOVW    DE,AX
97c5: 06 00 06     MOV     A,[DE+06H]
97c8: 30 99        SHR     A,3
97ca: ac 07        AND     A,#07H
97cc: b8 00        MOV     X,#00H
97ce: d8           XCH     A,X
97cf: 2f 05 00     CMPW    AX,#0005H
97d2: 80 5d        BNZ     $9831H
97d4: 1c 63        MOVW    AX,0FE63H
97d6: 24 48        MOVW    DE,AX
97d8: 06 00 01     MOV     A,[DE+01H]
97db: d8           XCH     A,X
97dc: 06 00 02     MOV     A,[DE+02H]
97df: 1a a4        MOVW    0FEA4H,AX
97e1: 06 00 03     MOV     A,[DE+03H]
97e4: d8           XCH     A,X
97e5: 06 00 04     MOV     A,[DE+04H]
97e8: 1a a6        MOVW    0FEA6H,AX
97ea: 1c a4        MOVW    AX,0FEA4H
97ec: 1a a8        MOVW    0FEA8H,AX
97ee: 1c a6        MOVW    AX,0FEA6H
97f0: 1a aa        MOVW    0FEAAH,AX
97f2: 0c a4 00 40  MOVW    0FEA4H,#4000H
97f6: 0c a6 05 00  MOVW    0FEA6H,#0005H
97fa: 28 ea ab     CALL    Compare_32Bits
97fd: 82 32        BNC     $9831H
97ff: 1c 63        MOVW    AX,0FE63H
9801: 24 48        MOVW    DE,AX
9803: 06 00 01     MOV     A,[DE+01H]
9806: d8           XCH     A,X
9807: 06 00 02     MOV     A,[DE+02H]
980a: 1a a4        MOVW    0FEA4H,AX
980c: 06 00 03     MOV     A,[DE+03H]
980f: d8           XCH     A,X
9810: 06 00 04     MOV     A,[DE+04H]
9813: 1a a6        MOVW    0FEA6H,AX
9815: 1c a4        MOVW    AX,0FEA4H
9817: 1a a8        MOVW    0FEA8H,AX
9819: 1c a6        MOVW    AX,0FEA6H
981b: 1a aa        MOVW    0FEAAH,AX
981d: 0c a4 00 00  MOVW    0FEA4H,#0000H
9821: 0c a6 18 00  MOVW    0FEA6H,#0018H
9825: 28 ea ab     CALL    Compare_32Bits
9828: 83 07        BC      $9831H
982a: 62 01 00     MOVW    BC,#0001H
982d: 14 05        BR      $9834H
982f: 14 03        BR      $9834H
9831: 62 00 00     MOVW    BC,#0000H
9834: 37           POP     HL
9835: 56           RET
9836: 3f           PUSH    HL
9837: 05 c9        DECW    SP
9839: 05 c9        DECW    SP
983b: 11 fc        MOVW    AX,SP
983d: 24 68        MOVW    HL,AX
983f: b9 00        MOV     A,#00H
9841: 55           MOV     [HL],A
9842: 06 20 06     MOV     A,[HL+06H]
9845: d8           XCH     A,X
9846: 06 20 07     MOV     A,[HL+07H]
9849: 3c           PUSH    AX
984a: 28 65 8d     CALL    !8D65H
984d: 34           POP     AX
984e: d2           MOV     A,C
984f: 06 a0 01     MOV     [HL+01H],A
9852: ac 01        AND     A,#01H
9854: 81 71        BZ      $98C7H
9856: 06 20 01     MOV     A,[HL+01H]
9859: af 01        CMP     A,#01H
985b: 80 23        BNZ     $9880H
985d: 1c 63        MOVW    AX,0FE63H
985f: 24 48        MOVW    DE,AX
9861: 06 00 06     MOV     A,[DE+06H]
9864: 30 b1        SHR     A,6
9866: ac 03        AND     A,#03H
9868: b8 00        MOV     X,#00H
986a: d8           XCH     A,X
986b: 2f 01 00     CMPW    AX,#0001H
986e: 80 0c        BNZ     $987CH
9870: 1c 63        MOVW    AX,0FE63H
9872: 24 48        MOVW    DE,AX
9874: 06 00 06     MOV     A,[DE+06H]
9877: ac 3f        AND     A,#3FH
9879: 06 80 06     MOV     [DE+06H],A
987c: 14 0d        BR      $988BH
987e: 14 3f        BR      $98BFH
9880: 64 d7 ff     MOVW    DE,#0FFD7H
9883: 5c           MOV     A,[DE]
9884: ac 80        AND     A,#80H
9886: 81 35        BZ      $98BDH
9888: 28 16 91     CALL    !9116H
988b: 3f           PUSH    HL
988c: 06 20 06     MOV     A,[HL+06H]
988f: d8           XCH     A,X
9890: 06 20 07     MOV     A,[HL+07H]
9893: 3c           PUSH    AX
9894: 1c 63        MOVW    AX,0FE63H
9896: 24 48        MOVW    DE,AX
9898: 37           POP     HL
9899: 06 20 02     MOV     A,[HL+02H]
989c: d8           XCH     A,X
989d: 06 20 03     MOV     A,[HL+03H]
98a0: 24 28        MOVW    BC,AX
98a2: 05 e3        MOVW    AX,[HL]
98a4: 06 80 02     MOV     [DE+02H],A
98a7: d8           XCH     A,X
98a8: 06 80 01     MOV     [DE+01H],A
98ab: 25 02        XCH     X,C
98ad: db           XCH     A,B
98ae: 06 80 04     MOV     [DE+04H],A
98b1: d8           XCH     A,X
98b2: 06 80 03     MOV     [DE+03H],A
98b5: 37           POP     HL
98b6: b9 01        MOV     A,#01H
98b8: 55           MOV     [HL],A
98b9: a5 65        CLR1    0FE65H.5
98bb: 14 02        BR      $98BFH
98bd: 14 08        BR      $98C7H
98bf: 28 2b 92     CALL    !922BH
98c2: 28 16 20     CALL    !2016H
98c5: 14 0f        BR      $98D6H
98c7: 06 20 06     MOV     A,[HL+06H]
98ca: d8           XCH     A,X
98cb: 06 20 07     MOV     A,[HL+07H]
98ce: 2f 8c fe     CMPW    AX,#0FE8CH
98d1: 80 03        BNZ     $98D6H
98d3: 28 d2 6b     CALL    !6BD2H
98d6: 5d           MOV     A,[HL]
98d7: bb 00        MOV     B,#00H
98d9: da           XCH     A,C
98da: 34           POP     AX
98db: 37           POP     HL
98dc: 56           RET
98dd: 3f           PUSH    HL
98de: 1c 6a        MOVW    AX,0FE6AH
98e0: 24 68        MOVW    HL,AX
98e2: 1c 6c        MOVW    AX,0FE6CH
98e4: 24 48        MOVW    DE,AX
98e6: 5d           MOV     A,[HL]
98e7: 40           CLR1    CY
98e8: 16 4b        SUBC    A,[DE]
98ea: 0f           ADJBS
98eb: 24 21        MOV     C,A
98ed: 06 20 01     MOV     A,[HL+01H]
98f0: 06 0b 01     SUBC    A,[DE+01H]
98f3: 0f           ADJBS
98f4: 24 31        MOV     B,A
98f6: 06 20 02     MOV     A,[HL+02H]
98f9: 06 0b 02     SUBC    A,[DE+02H]
98fc: 0f           ADJBS
98fd: 3c           PUSH    AX
98fe: 06 20 03     MOV     A,[HL+03H]
9901: 06 0b 03     SUBC    A,[DE+03H]
9904: 0f           ADJBS
9905: 36           POP     DE
9906: 24 41        MOV     E,A
9908: 25 54        XCH     D,E
990a: 37           POP     HL
990b: 56           RET
990c: 3f           PUSH    HL
990d: 1c ac        MOVW    AX,0FEACH
990f: 3c           PUSH    AX
9910: 05 c9        DECW    SP
9912: 05 c9        DECW    SP
9914: 11 fc        MOVW    AX,SP
9916: 24 68        MOVW    HL,AX
9918: 70 66 03     BT      0FE66H.0,$991EH
991b: 2c e9 99     BR      !99E9H
991e: 1c 63        MOVW    AX,0FE63H
9920: 24 48        MOVW    DE,AX
9922: 06 00 06     MOV     A,[DE+06H]
9925: 30 99        SHR     A,3
9927: ac 07        AND     A,#07H
9929: b8 00        MOV     X,#00H
992b: d8           XCH     A,X
992c: d0           MOV     A,X
992d: 22 ac        MOV     0FEACH,A
992f: 10 6a        MOV     A,ADCR
9931: b8 00        MOV     X,#00H
9933: d8           XCH     A,X
9934: 06 a0 01     MOV     [HL+01H],A
9937: d8           XCH     A,X
9938: 55           MOV     [HL],A
9939: 08 a6 73 04  BF      0FE73H.6,$9941H
993d: a6 73        CLR1    0FE73H.6
993f: 14 3d        BR      $997EH
9941: 09 f0 b3 fd  MOV     A,!0FDB3H
9945: af 03        CMP     A,#03H
9947: 82 0b        BNC     $9954H
9949: b9 04        MOV     A,#04H
994b: 16 5f        CMP     A,[HL]
994d: 82 02        BNC     $9951H
994f: 14 2d        BR      $997EH
9951: 2c e9 99     BR      !99E9H
9954: 09 f0 b3 fd  MOV     A,!0FDB3H
9958: af fd        CMP     A,#0FDH
995a: 83 0c        BC      $9968H
995c: 81 0a        BZ      $9968H
995e: 5d           MOV     A,[HL]
995f: af fc        CMP     A,#0FCH
9961: 82 02        BNC     $9965H
9963: 14 19        BR      $997EH
9965: 2c e9 99     BR      !99E9H
9968: 09 f0 b3 fd  MOV     A,!0FDB3H
996c: a8 02        ADD     A,#02H
996e: 16 5f        CMP     A,[HL]
9970: 83 0c        BC      $997EH
9972: 09 f0 b3 fd  MOV     A,!0FDB3H
9976: aa 02        SUB     A,#02H
9978: d8           XCH     A,X
9979: 5d           MOV     A,[HL]
997a: 8f 10        CMP     A,X
997c: 82 6b        BNC     $99E9H
997e: 5d           MOV     A,[HL]
997f: 09 f1 b3 fd  MOV     !0FDB3H,A
9983: af 80        CMP     A,#80H
9985: 82 04        BNC     $998BH
9987: 5d           MOV     A,[HL]
9988: ad ff        XOR     A,#0FFH
998a: 55           MOV     [HL],A
998b: b9 7f        MOV     A,#7FH
998d: 16 5c        AND     A,[HL]
998f: 55           MOV     [HL],A
9990: b9 00        MOV     A,#00H
9992: 06 a0 01     MOV     [HL+01H],A
9995: 20 ac        MOV     A,0FEACH
9997: b8 00        MOV     X,#00H
9999: d8           XCH     A,X
999a: 88 08        ADDW    AX,AX
999c: 2d a1 11     ADDW    AX,#11A1H
999f: 24 48        MOVW    DE,AX
99a1: 05 e2        MOVW    AX,[DE]
99a3: 1a a4        MOVW    0FEA4H,AX
99a5: 05 e3        MOVW    AX,[HL]
99a7: 1a a6        MOVW    0FEA6H,AX
99a9: 28 f7 ab     CALL    Multiply_Thing
99ac: 20 ac        MOV     A,0FEACH
99ae: b8 00        MOV     X,#00H
99b0: d8           XCH     A,X
99b1: 88 08        ADDW    AX,AX
99b3: 2d ad 11     ADDW    AX,#11ADH
99b6: 24 48        MOVW    DE,AX
99b8: 05 e2        MOVW    AX,[DE]
99ba: 1a a6        MOVW    0FEA6H,AX
99bc: 28 1b ac     CALL    !0AC1BH
99bf: 1c a4        MOVW    AX,0FEA4H
99c1: 1a 6a        MOVW    0FE6AH,AX
99c3: 09 f0 b3 fd  MOV     A,!0FDB3H
99c7: af 80        CMP     A,#80H
99c9: 83 0c        BC      $99D7H
99cb: 09 f0 0b fd  MOV     A,!0FD0BH
99cf: 98 6a        ADD     A,0FE6AH
99d1: 64 d3 ff     MOVW    DE,#0FFD3H
99d4: 54           MOV     [DE],A
99d5: 14 0a        BR      $99E1H
99d7: 09 f0 0b fd  MOV     A,!0FD0BH
99db: 9a 6a        SUB     A,0FE6AH
99dd: 64 d3 ff     MOVW    DE,#0FFD3H
99e0: 54           MOV     [DE],A
99e1: 6f 89 00     CMP     0FE89H,#00H
99e4: 80 03        BNZ     $99E9H
99e6: 28 32 92     CALL    !9232H
99e9: 34           POP     AX
99ea: 34           POP     AX
99eb: 1a ac        MOVW    0FEACH,AX
99ed: 37           POP     HL
99ee: 56           RET
99ef: 1c ac        MOVW    AX,0FEACH
99f1: 3c           PUSH    AX
99f2: 3a ac 01     MOV     0FEACH,#01H
99f5: 20 62        MOV     A,0FE62H
99f7: 30 99        SHR     A,3
99f9: ac 07        AND     A,#07H
99fb: b8 00        MOV     X,#00H
99fd: d8           XCH     A,X
99fe: 24 28        MOVW    BC,AX
9a00: 20 5b        MOV     A,0FE5BH
9a02: 30 99        SHR     A,3
9a04: ac 07        AND     A,#07H
9a06: b8 00        MOV     X,#00H
9a08: d8           XCH     A,X
9a09: 8f 0a        CMPW    AX,BC
9a0b: 80 15        BNZ     $9A22H
9a0d: 1c 56        MOVW    AX,0FE56H
9a0f: 1a a4        MOVW    0FEA4H,AX
9a11: 1c 58        MOVW    AX,0FE58H
9a13: 1a a6        MOVW    0FEA6H,AX
9a15: 1c 5d        MOVW    AX,0FE5DH
9a17: 1a a8        MOVW    0FEA8H,AX
9a19: 1c 5f        MOVW    AX,0FE5FH
9a1b: 1a aa        MOVW    0FEAAH,AX
9a1d: 28 ea ab     CALL    Compare_32Bits
9a20: 81 03        BZ      $9A25H
9a22: 3a ac 00     MOV     0FEACH,#00H
9a25: 6f ac 01     CMP     0FEACH,#01H
9a28: 80 09        BNZ     $9A33H
9a2a: 77 72 04     BT      0FE72H.7,$9A31H
9a2d: b7 72        SET1    0FE72H.7
9a2f: b1 68        SET1    0FE68H.1
9a31: 14 08        BR      $9A3BH
9a33: 08 a7 72 04  BF      0FE72H.7,$9A3BH
9a37: a7 72        CLR1    0FE72H.7
9a39: b1 68        SET1    0FE68H.1
9a3b: 34           POP     AX
9a3c: 1a ac        MOVW    0FEACH,AX
9a3e: 56           RET
9a3f: 3f           PUSH    HL
9a40: 1c ac        MOVW    AX,0FEACH
9a42: 3c           PUSH    AX
9a43: 11 fc        MOVW    AX,SP
9a45: 24 68        MOVW    HL,AX
9a47: 60 0b 00     MOVW    AX,#000BH
9a4a: 3c           PUSH    AX
9a4b: 28 6d 8b     CALL    Delay_Loop
9a4e: 34           POP     AX
9a4f: 0c ac 00 00  MOVW    0FEACH,#0000H
9a53: 1c ac        MOVW    AX,0FEACH
9a55: 2f 07 00     CMPW    AX,#0007H
9a58: 82 46        BNC     $9AA0H
9a5a: 28 ce 7a     CALL    Query_DFBE
9a5d: 64 55 d5     MOVW    DE,#0D555H
9a60: b9 aa        MOV     A,#0AAH
9a62: 54           MOV     [DE],A
9a63: 64 aa ca     MOVW    DE,#0CAAAH
9a66: b9 55        MOV     A,#55H
9a68: 54           MOV     [DE],A
9a69: 64 55 d5     MOVW    DE,#0D555H
9a6c: b9 a0        MOV     A,#0A0H
9a6e: 54           MOV     [DE],A
9a6f: 1c ac        MOVW    AX,0FEACH
9a71: 24 28        MOVW    BC,AX
9a73: 06 20 06     MOV     A,[HL+06H]
9a76: d8           XCH     A,X
9a77: 06 20 07     MOV     A,[HL+07H]
9a7a: 88 0a        ADDW    AX,BC
9a7c: 24 48        MOVW    DE,AX
9a7e: 5c           MOV     A,[DE]
9a7f: da           XCH     A,C
9a80: 1c ac        MOVW    AX,0FEACH
9a82: 24 48        MOVW    DE,AX
9a84: 06 20 08     MOV     A,[HL+08H]
9a87: d8           XCH     A,X
9a88: 06 20 09     MOV     A,[HL+09H]
9a8b: 88 0c        ADDW    AX,DE
9a8d: 24 48        MOVW    DE,AX
9a8f: d2           MOV     A,C
9a90: 54           MOV     [DE],A
9a91: 60 0b 00     MOVW    AX,#000BH
9a94: 3c           PUSH    AX
9a95: 28 6d 8b     CALL    Delay_Loop
9a98: 34           POP     AX
9a99: 1c ac        MOVW    AX,0FEACH
9a9b: 44           INCW    AX
9a9c: 1a ac        MOVW    0FEACH,AX
9a9e: 14 b3        BR      $9A53H
9aa0: 28 ce 7a     CALL    Query_DFBE
9aa3: 34           POP     AX
9aa4: 1a ac        MOVW    0FEACH,AX
9aa6: 37           POP     HL
9aa7: 56           RET
9aa8: 3f           PUSH    HL
9aa9: 1c ac        MOVW    AX,0FEACH
9aab: 3c           PUSH    AX
9aac: 11 fc        MOVW    AX,SP
9aae: 24 68        MOVW    HL,AX
9ab0: 0c ac 00 00  MOVW    0FEACH,#0000H
9ab4: 1c ac        MOVW    AX,0FEACH
9ab6: 2f 07 00     CMPW    AX,#0007H
9ab9: 82 29        BNC     $9AE4H
9abb: 1c ac        MOVW    AX,0FEACH
9abd: 24 28        MOVW    BC,AX
9abf: 06 20 06     MOV     A,[HL+06H]
9ac2: d8           XCH     A,X
9ac3: 06 20 07     MOV     A,[HL+07H]
9ac6: 88 0a        ADDW    AX,BC
9ac8: 24 48        MOVW    DE,AX
9aca: 5c           MOV     A,[DE]
9acb: da           XCH     A,C
9acc: 1c ac        MOVW    AX,0FEACH
9ace: 24 48        MOVW    DE,AX
9ad0: 06 20 08     MOV     A,[HL+08H]
9ad3: d8           XCH     A,X
9ad4: 06 20 09     MOV     A,[HL+09H]
9ad7: 88 0c        ADDW    AX,DE
9ad9: 24 48        MOVW    DE,AX
9adb: d2           MOV     A,C
9adc: 54           MOV     [DE],A
9add: 1c ac        MOVW    AX,0FEACH
9adf: 44           INCW    AX
9ae0: 1a ac        MOVW    0FEACH,AX
9ae2: 14 d0        BR      $9AB4H
9ae4: 34           POP     AX
9ae5: 1a ac        MOVW    0FEACH,AX
9ae7: 37           POP     HL
9ae8: 56           RET
9ae9: 6f b2 30     CMP     I2C_OutputBuffer,#30H
9aec: 83 0b        BC      $9AF9H
9aee: b9 39        MOV     A,#39H
9af0: 9f b2        CMP     A,I2C_OutputBuffer
9af2: 83 05        BC      $9AF9H
9af4: 6c b2 0f     AND     I2C_OutputBuffer,#0FH
9af7: 14 1d        BR      $9B16H
9af9: 6f b2 2d     CMP     I2C_OutputBuffer,#2DH
9afc: 80 05        BNZ     $9B03H
9afe: 3a b2 0a     MOV     I2C_OutputBuffer,#0AH
9b01: 14 13        BR      $9B16H
9b03: 6f b2 41     CMP     I2C_OutputBuffer,#41H
9b06: 83 0b        BC      $9B13H
9b08: b9 5a        MOV     A,#5AH
9b0a: 9f b2        CMP     A,I2C_OutputBuffer
9b0c: 83 05        BC      $9B13H
9b0e: 6a b2 35     SUB     I2C_OutputBuffer,#35H
9b11: 14 03        BR      $9B16H
9b13: 3a b2 0b     MOV     I2C_OutputBuffer,#0BH
9b16: 20 b2        MOV     A,I2C_OutputBuffer
9b18: bb 00        MOV     B,#00H
9b1a: da           XCH     A,C
9b1b: 56           RET
9b1c: b9 09        MOV     A,#09H
9b1e: 9f b2        CMP     A,I2C_OutputBuffer
9b20: 83 05        BC      $9B27H
9b22: 6e b2 30     OR      I2C_OutputBuffer,#30H
9b25: 14 21        BR      $9B48H
9b27: 6f b2 0a     CMP     I2C_OutputBuffer,#0AH
9b2a: 80 05        BNZ     $9B31H
9b2c: 3a b2 2d     MOV     I2C_OutputBuffer,#2DH
9b2f: 14 17        BR      $9B48H
9b31: 6f b2 0b     CMP     I2C_OutputBuffer,#0BH
9b34: 80 05        BNZ     $9B3BH
9b36: 3a b2 20     MOV     I2C_OutputBuffer,#20H
9b39: 14 0d        BR      $9B48H
9b3b: 6f b2 ff     CMP     I2C_OutputBuffer,#0FFH
9b3e: 80 05        BNZ     $9B45H
9b40: 3a b2 00     MOV     I2C_OutputBuffer,#00H
9b43: 14 03        BR      $9B48H
9b45: 68 b2 35     ADD     I2C_OutputBuffer,#35H
9b48: 20 b2        MOV     A,I2C_OutputBuffer
9b4a: bb 00        MOV     B,#00H
9b4c: da           XCH     A,C
9b4d: 56           RET
9b4e: 60 0b 00     MOVW    AX,#000BH
9b51: 3c           PUSH    AX
9b52: 28 6d 8b     CALL    Delay_Loop
9b55: 34           POP     AX
9b56: 28 ce 7a     CALL    Query_DFBE
9b59: 64 55 d5     MOVW    DE,#0D555H
9b5c: b9 aa        MOV     A,#0AAH
9b5e: 54           MOV     [DE],A
9b5f: 64 aa ca     MOVW    DE,#0CAAAH
9b62: b9 55        MOV     A,#55H
9b64: 54           MOV     [DE],A
9b65: 64 55 d5     MOVW    DE,#0D555H
9b68: b9 a0        MOV     A,#0A0H
9b6a: 54           MOV     [DE],A
9b6b: 1c 63        MOVW    AX,0FE63H
9b6d: 64 b6 df     MOVW    DE,#0DFB6H
9b70: 3f           PUSH    HL
9b71: 24 68        MOVW    HL,AX
9b73: 3c           PUSH    AX
9b74: ba 07        MOV     C,#07H
9b76: 59           MOV     A,[HL+]
9b77: 50           MOV     [DE+],A
9b78: 32 fc        DBNZ    C,$9B76H
9b7a: 34           POP     AX
9b7b: 37           POP     HL
9b7c: 60 0b 00     MOVW    AX,#000BH
9b7f: 3c           PUSH    AX
9b80: 28 6d 8b     CALL    Delay_Loop
9b83: 34           POP     AX
9b84: 28 ce 7a     CALL    Query_DFBE
9b87: 62 ea df     MOVW    BC,#0DFEAH
9b8a: 1c 63        MOVW    AX,0FE63H
9b8c: 24 48        MOVW    DE,AX
9b8e: 3f           PUSH    HL
9b8f: 24 6a        MOVW    HL,BC
9b91: 3d           PUSH    BC
9b92: ba 07        MOV     C,#07H
9b94: 59           MOV     A,[HL+]
9b95: 50           MOV     [DE+],A
9b96: 32 fc        DBNZ    C,$9B94H
9b98: 35           POP     BC
9b99: 37           POP     HL
9b9a: 56           RET
9b9b: 60 0b 00     MOVW    AX,#000BH
9b9e: 3c           PUSH    AX
9b9f: 28 6d 8b     CALL    Delay_Loop
9ba2: 34           POP     AX
9ba3: 28 ce 7a     CALL    Query_DFBE
9ba6: 64 55 d5     MOVW    DE,#0D555H
9ba9: b9 aa        MOV     A,#0AAH
9bab: 54           MOV     [DE],A
9bac: 64 aa ca     MOVW    DE,#0CAAAH
9baf: b9 55        MOV     A,#55H
9bb1: 54           MOV     [DE],A
9bb2: 64 55 d5     MOVW    DE,#0D555H
9bb5: b9 a0        MOV     A,#0A0H
9bb7: 54           MOV     [DE],A
9bb8: 1c 63        MOVW    AX,0FE63H
9bba: 64 ea df     MOVW    DE,#0DFEAH
9bbd: 3f           PUSH    HL
9bbe: 24 68        MOVW    HL,AX
9bc0: 3c           PUSH    AX
9bc1: ba 07        MOV     C,#07H
9bc3: 59           MOV     A,[HL+]
9bc4: 50           MOV     [DE+],A
9bc5: 32 fc        DBNZ    C,$9BC3H
9bc7: 34           POP     AX
9bc8: 37           POP     HL
9bc9: b6 72        SET1    0FE72H.6
9bcb: 60 0b 00     MOVW    AX,#000BH
9bce: 3c           PUSH    AX
9bcf: 28 6d 8b     CALL    Delay_Loop
9bd2: 34           POP     AX
9bd3: 28 ce 7a     CALL    Query_DFBE
9bd6: 62 b6 df     MOVW    BC,#0DFB6H
9bd9: 1c 63        MOVW    AX,0FE63H
9bdb: 24 48        MOVW    DE,AX
9bdd: 3f           PUSH    HL
9bde: 24 6a        MOVW    HL,BC
9be0: 3d           PUSH    BC
9be1: ba 07        MOV     C,#07H
9be3: 59           MOV     A,[HL+]
9be4: 50           MOV     [DE+],A
9be5: 32 fc        DBNZ    C,$9BE3H
9be7: 35           POP     BC
9be8: 37           POP     HL
9be9: 1c 63        MOVW    AX,0FE63H
9beb: 24 48        MOVW    DE,AX
9bed: 5c           MOV     A,[DE]
9bee: 03 8c        SET1    A.4
9bf0: 54           MOV     [DE],A
9bf1: 28 16 91     CALL    !9116H
9bf4: 56           RET
9bf5: 08 a7 02 04  BF      P2.7,$9BFDH
9bf9: 8a 08        SUBW    AX,AX
9bfb: 14 03        BR      $9C00H
9bfd: 60 01 00     MOVW    AX,#0001H
9c00: 24 28        MOVW    BC,AX
9c02: 56           RET
9c03: 3f           PUSH    HL
9c04: 05 c9        DECW    SP
9c06: 05 c9        DECW    SP
9c08: 11 fc        MOVW    AX,SP
9c0a: 24 68        MOVW    HL,AX
9c0c: b9 01        MOV     A,#01H
9c0e: 06 a0 01     MOV     [HL+01H],A
9c11: 14 51        BR      $9C64H
9c13: 1c 63        MOVW    AX,0FE63H
9c15: 24 48        MOVW    DE,AX
9c17: 06 00 06     MOV     A,[DE+06H]
9c1a: 30 b1        SHR     A,6
9c1c: ac 03        AND     A,#03H
9c1e: b8 00        MOV     X,#00H
9c20: d8           XCH     A,X
9c21: 2f 02 00     CMPW    AX,#0002H
9c24: 81 0c        BZ      $9C32H
9c26: 1c 63        MOVW    AX,0FE63H
9c28: 24 48        MOVW    DE,AX
9c2a: 06 00 06     MOV     A,[DE+06H]
9c2d: ac 3f        AND     A,#3FH
9c2f: 06 80 06     MOV     [DE+06H],A
9c32: 14 41        BR      $9C75H
9c34: 64 d7 ff     MOVW    DE,#0FFD7H
9c37: 5c           MOV     A,[DE]
9c38: ac 80        AND     A,#80H
9c3a: 81 18        BZ      $9C54H
9c3c: 1c 63        MOVW    AX,0FE63H
9c3e: 24 48        MOVW    DE,AX
9c40: 06 00 06     MOV     A,[DE+06H]
9c43: ac 3f        AND     A,#3FH
9c45: ae 40        OR      A,#40H
9c47: 06 80 06     MOV     [DE+06H],A
9c4a: 1c 63        MOVW    AX,0FE63H
9c4c: 24 48        MOVW    DE,AX
9c4e: 5c           MOV     A,[DE]
9c4f: 03 8c        SET1    A.4
9c51: 54           MOV     [DE],A
9c52: 14 05        BR      $9C59H
9c54: b9 00        MOV     A,#00H
9c56: 06 a0 01     MOV     [HL+01H],A
9c59: 14 1a        BR      $9C75H
9c5b: b9 00        MOV     A,#00H
9c5d: 06 a0 01     MOV     [HL+01H],A
9c60: 14 13        BR      $9C75H
9c62: 14 11        BR      $9C75H
9c64: 06 20 06     MOV     A,[HL+06H]
9c67: af 05        CMP     A,#05H
9c69: 81 c9        BZ      $9C34H
9c6b: af 03        CMP     A,#03H
9c6d: 81 c5        BZ      $9C34H
9c6f: af 01        CMP     A,#01H
9c71: 81 a0        BZ      $9C13H
9c73: 14 e6        BR      $9C5BH
9c75: 06 20 01     MOV     A,[HL+01H]
9c78: af 00        CMP     A,#00H
9c7a: 80 03        BNZ     $9C7FH
9c7c: 2c 6b 9d     BR      !9D6BH
9c7f: 1c 63        MOVW    AX,0FE63H
9c81: 24 48        MOVW    DE,AX
9c83: 06 00 06     MOV     A,[DE+06H]
9c86: ac 07        AND     A,#07H
9c88: b8 00        MOV     X,#00H
9c8a: d8           XCH     A,X
9c8b: 24 28        MOVW    BC,AX
9c8d: 60 04 00     MOVW    AX,#0004H
9c90: 8f 0a        CMPW    AX,BC
9c92: 82 0e        BNC     $9CA2H
9c94: 1c 63        MOVW    AX,0FE63H
9c96: 24 48        MOVW    DE,AX
9c98: 06 00 06     MOV     A,[DE+06H]
9c9b: ac f8        AND     A,#0F8H
9c9d: ae 04        OR      A,#04H
9c9f: 06 80 06     MOV     [DE+06H],A
9ca2: 1c 63        MOVW    AX,0FE63H
9ca4: 24 48        MOVW    DE,AX
9ca6: 06 00 05     MOV     A,[DE+05H]
9ca9: 30 89        SHR     A,1
9cab: ac 01        AND     A,#01H
9cad: b8 00        MOV     X,#00H
9caf: d8           XCH     A,X
9cb0: 2f 01 00     CMPW    AX,#0001H
9cb3: 80 1f        BNZ     $9CD4H
9cb5: 1c 63        MOVW    AX,0FE63H
9cb7: 24 48        MOVW    DE,AX
9cb9: 06 00 06     MOV     A,[DE+06H]
9cbc: 30 99        SHR     A,3
9cbe: ac 07        AND     A,#07H
9cc0: b8 00        MOV     X,#00H
9cc2: d8           XCH     A,X
9cc3: 2f 04 00     CMPW    AX,#0004H
9cc6: 80 0c        BNZ     $9CD4H
9cc8: 1c 63        MOVW    AX,0FE63H
9cca: 24 48        MOVW    DE,AX
9ccc: 06 00 05     MOV     A,[DE+05H]
9ccf: 03 99        CLR1    A.1
9cd1: 06 80 05     MOV     [DE+05H],A
9cd4: 1c 63        MOVW    AX,0FE63H
9cd6: 24 48        MOVW    DE,AX
9cd8: 06 00 06     MOV     A,[DE+06H]
9cdb: 30 99        SHR     A,3
9cdd: ac 07        AND     A,#07H
9cdf: b8 00        MOV     X,#00H
9ce1: d8           XCH     A,X
9ce2: 24 28        MOVW    BC,AX
9ce4: 60 05 00     MOVW    AX,#0005H
9ce7: 8f 0a        CMPW    AX,BC
9ce9: 82 0e        BNC     $9CF9H
9ceb: 1c 63        MOVW    AX,0FE63H
9ced: 24 48        MOVW    DE,AX
9cef: 06 00 06     MOV     A,[DE+06H]
9cf2: ac c7        AND     A,#0C7H
9cf4: ae 28        OR      A,#28H
9cf6: 06 80 06     MOV     [DE+06H],A
9cf9: 1c 63        MOVW    AX,0FE63H
9cfb: 24 48        MOVW    DE,AX
9cfd: 06 00 05     MOV     A,[DE+05H]
9d00: 30 b1        SHR     A,6
9d02: ac 03        AND     A,#03H
9d04: b8 00        MOV     X,#00H
9d06: d8           XCH     A,X
9d07: 2f 02 00     CMPW    AX,#0002H
9d0a: 80 0c        BNZ     $9D18H
9d0c: 1c 63        MOVW    AX,0FE63H
9d0e: 24 48        MOVW    DE,AX
9d10: 06 00 05     MOV     A,[DE+05H]
9d13: ac 3f        AND     A,#3FH
9d15: 06 80 05     MOV     [DE+05H],A
9d18: 1c 63        MOVW    AX,0FE63H
9d1a: 24 48        MOVW    DE,AX
9d1c: 06 00 05     MOV     A,[DE+05H]
9d1f: 30 a1        SHR     A,4
9d21: ac 03        AND     A,#03H
9d23: b8 00        MOV     X,#00H
9d25: d8           XCH     A,X
9d26: 2f 01 00     CMPW    AX,#0001H
9d29: 80 0e        BNZ     $9D39H
9d2b: 1c 63        MOVW    AX,0FE63H
9d2d: 24 48        MOVW    DE,AX
9d2f: 06 00 05     MOV     A,[DE+05H]
9d32: ac cf        AND     A,#0CFH
9d34: ae 30        OR      A,#30H
9d36: 06 80 05     MOV     [DE+05H],A
9d39: 1c 63        MOVW    AX,0FE63H
9d3b: 24 48        MOVW    DE,AX
9d3d: 06 00 05     MOV     A,[DE+05H]
9d40: 30 91        SHR     A,2
9d42: ac 01        AND     A,#01H
9d44: b8 00        MOV     X,#00H
9d46: d8           XCH     A,X
9d47: 2f 01 00     CMPW    AX,#0001H
9d4a: 80 1f        BNZ     $9D6BH
9d4c: 1c 63        MOVW    AX,0FE63H
9d4e: 24 48        MOVW    DE,AX
9d50: 06 00 05     MOV     A,[DE+05H]
9d53: 30 99        SHR     A,3
9d55: ac 01        AND     A,#01H
9d57: b8 00        MOV     X,#00H
9d59: d8           XCH     A,X
9d5a: 2f 01 00     CMPW    AX,#0001H
9d5d: 80 0c        BNZ     $9D6BH
9d5f: 1c 63        MOVW    AX,0FE63H
9d61: 24 48        MOVW    DE,AX
9d63: 06 00 05     MOV     A,[DE+05H]
9d66: 03 9b        CLR1    A.3
9d68: 06 80 05     MOV     [DE+05H],A
9d6b: 06 20 01     MOV     A,[HL+01H]
9d6e: bb 00        MOV     B,#00H
9d70: da           XCH     A,C
9d71: 34           POP     AX
9d72: 37           POP     HL
9d73: 56           RET
9d74: 3f           PUSH    HL
9d75: 11 fc        MOVW    AX,SP
9d77: 24 68        MOVW    HL,AX
9d79: 06 20 04     MOV     A,[HL+04H]
9d7c: ac 0f        AND     A,#0FH
9d7e: b8 09        MOV     X,#09H
9d80: 8f 01        CMP     X,A
9d82: 83 0b        BC      $9D8FH
9d84: 06 20 04     MOV     A,[HL+04H]
9d87: ac f0        AND     A,#0F0H
9d89: b8 90        MOV     X,#90H
9d8b: 8f 01        CMP     X,A
9d8d: 82 07        BNC     $9D96H
9d8f: 62 00 00     MOVW    BC,#0000H
9d92: 14 05        BR      $9D99H
9d94: 14 03        BR      $9D99H
9d96: 62 01 00     MOVW    BC,#0001H
9d99: 37           POP     HL
9d9a: 56           RET
9d9b: 1c 63        MOVW    AX,0FE63H
9d9d: 24 48        MOVW    DE,AX
9d9f: 60 01 00     MOVW    AX,#0001H
9da2: 88 0c        ADDW    AX,DE
9da4: 2d 03 00     ADDW    AX,#0003H
9da7: 24 48        MOVW    DE,AX
9da9: 5c           MOV     A,[DE]
9daa: ac 0f        AND     A,#0FH
9dac: da           XCH     A,C
9dad: 1c 63        MOVW    AX,0FE63H
9daf: 24 48        MOVW    DE,AX
9db1: 60 01 00     MOVW    AX,#0001H
9db4: 88 0c        ADDW    AX,DE
9db6: 2d 03 00     ADDW    AX,#0003H
9db9: 24 48        MOVW    DE,AX
9dbb: 5c           MOV     A,[DE]
9dbc: ac f0        AND     A,#0F0H
9dbe: 30 a1        SHR     A,4
9dc0: bb 00        MOV     B,#00H
9dc2: b8 00        MOV     X,#00H
9dc4: d8           XCH     A,X
9dc5: 88 0a        ADDW    AX,BC
9dc7: 24 28        MOVW    BC,AX
9dc9: 1c 63        MOVW    AX,0FE63H
9dcb: 24 48        MOVW    DE,AX
9dcd: 60 01 00     MOVW    AX,#0001H
9dd0: 88 0c        ADDW    AX,DE
9dd2: 44           INCW    AX
9dd3: 44           INCW    AX
9dd4: 24 48        MOVW    DE,AX
9dd6: 5c           MOV     A,[DE]
9dd7: ac 0f        AND     A,#0FH
9dd9: b8 00        MOV     X,#00H
9ddb: d8           XCH     A,X
9ddc: 88 0a        ADDW    AX,BC
9dde: 24 28        MOVW    BC,AX
9de0: 1c 63        MOVW    AX,0FE63H
9de2: 24 48        MOVW    DE,AX
9de4: 60 01 00     MOVW    AX,#0001H
9de7: 88 0c        ADDW    AX,DE
9de9: 44           INCW    AX
9dea: 44           INCW    AX
9deb: 24 48        MOVW    DE,AX
9ded: 5c           MOV     A,[DE]
9dee: ac f0        AND     A,#0F0H
9df0: 30 a1        SHR     A,4
9df2: b8 00        MOV     X,#00H
9df4: d8           XCH     A,X
9df5: 88 0a        ADDW    AX,BC
9df7: 24 28        MOVW    BC,AX
9df9: 1c 63        MOVW    AX,0FE63H
9dfb: 24 48        MOVW    DE,AX
9dfd: 60 01 00     MOVW    AX,#0001H
9e00: 88 0c        ADDW    AX,DE
9e02: 44           INCW    AX
9e03: 24 48        MOVW    DE,AX
9e05: 5c           MOV     A,[DE]
9e06: ac 0f        AND     A,#0FH
9e08: b8 00        MOV     X,#00H
9e0a: d8           XCH     A,X
9e0b: 88 0a        ADDW    AX,BC
9e0d: 24 28        MOVW    BC,AX
9e0f: 1c 63        MOVW    AX,0FE63H
9e11: 24 48        MOVW    DE,AX
9e13: 60 01 00     MOVW    AX,#0001H
9e16: 88 0c        ADDW    AX,DE
9e18: 44           INCW    AX
9e19: 24 48        MOVW    DE,AX
9e1b: 5c           MOV     A,[DE]
9e1c: ac f0        AND     A,#0F0H
9e1e: 30 a1        SHR     A,4
9e20: b8 00        MOV     X,#00H
9e22: d8           XCH     A,X
9e23: 88 0a        ADDW    AX,BC
9e25: 24 28        MOVW    BC,AX
9e27: 56           RET
9e28: 3f           PUSH    HL
9e29: 05 c9        DECW    SP
9e2b: 05 c9        DECW    SP
9e2d: 11 fc        MOVW    AX,SP
9e2f: 24 68        MOVW    HL,AX
9e31: 08 a0 72 02  BF      0FE72H.0,$9E37H
9e35: b4 03        SET1    P3.4
9e37: 10 6a        MOV     A,ADCR
9e39: 09 f1 a6 fd  MOV     !0FDA6H,A
9e3d: 2b 68 97     MOV     ADM,#97H
9e40: a0 68        CLR1    0FE68H.0
9e42: 6f a0 00     CMP     0FEA0H,#00H
9e45: 81 04        BZ      $9E4BH
9e47: 27 a0        DEC     0FEA0H
9e49: 14 02        BR      $9E4DH
9e4b: b1 a1        SET1    0FEA1H.1
9e4d: 28 3a 59     CALL    !593AH
9e50: 20 77        MOV     A,0FE77H
9e52: ac 0f        AND     A,#0FH
9e54: b8 00        MOV     X,#00H
9e56: d8           XCH     A,X
9e57: 2f 00 00     CMPW    AX,#0000H
9e5a: 81 14        BZ      $9E70H
9e5c: 20 77        MOV     A,0FE77H
9e5e: ac 0f        AND     A,#0FH
9e60: b8 00        MOV     X,#00H
9e62: d8           XCH     A,X
9e63: 4c           DECW    AX
9e64: 24 28        MOVW    BC,AX
9e66: 20 77        MOV     A,0FE77H
9e68: ac f0        AND     A,#0F0H
9e6a: 8e 12        OR      A,C
9e6c: 22 77        MOV     0FE77H,A
9e6e: 14 10        BR      $9E80H
9e70: 20 76        MOV     A,0FE76H
9e72: ac c7        AND     A,#0C7H
9e74: 22 76        MOV     0FE76H,A
9e76: ac f8        AND     A,#0F8H
9e78: 22 76        MOV     0FE76H,A
9e7a: 20 77        MOV     A,0FE77H
9e7c: 03 9c        CLR1    A.4
9e7e: 22 77        MOV     0FE77H,A
9e80: 72 03 13     BT      P3.2,$9E96H           ; if power NOT pushed, branch
9e83: 76 69 0e     BT      0FE69H.6,$9E94H
9e86: b6 69        SET1    0FE69H.6
9e88: 08 a0 66 05  BF      0FE66H.0,$9E91H
9e8c: 28 89 8c     CALL    !8C89H
9e8f: 14 03        BR      $9E94H
9e91: 28 0e 8c     CALL    !8C0EH
9e94: 14 02        BR      $9E98H
9e96: a6 69        CLR1    0FE69H.6
9e98: 70 66 03     BT      0FE66H.0,$9E9EH
9e9b: 2c 3a 9f     BR      !9F3AH
9e9e: 28 34 79     CALL    !7934H
9ea1: 09 f0 0a fd  MOV     A,!0FD0AH
9ea5: 9f 74        CMP     A,0FE74H
9ea7: 81 04        BZ      $9EADH
9ea9: 0c 80 00 00  MOVW    0FE80H,#0000H
9ead: 75 65 11     BT      0FE65H.5,$9EC1H
9eb0: 08 a6 66 0d  BF      0FE66H.6,$9EC1H
9eb4: 6f 74 19     CMP     0FE74H,#19H
9eb7: 81 08        BZ      $9EC1H
9eb9: 6f 74 36     CMP     0FE74H,#36H
9ebc: 81 03        BZ      $9EC1H
9ebe: 3a 74 00     MOV     0FE74H,#00H
9ec1: 6f 78 00     CMP     0FE78H,#00H
9ec4: 81 08        BZ      $9ECEH
9ec6: 6f 74 00     CMP     0FE74H,#00H
9ec9: 80 03        BNZ     $9ECEH
9ecb: 38 78 74     MOV     0FE74H,0FE78H
9ece: 3a 78 00     MOV     0FE78H,#00H
9ed1: 8a 08        SUBW    AX,AX
9ed3: 1f 80        CMPW    AX,0FE80H
9ed5: 80 50        BNZ     $9F27H
9ed7: 09 f0 0a fd  MOV     A,!0FD0AH
9edb: 9f 74        CMP     A,0FE74H
9edd: 81 0a        BZ      $9EE9H
9edf: 6f 84 00     CMP     0FE84H,#00H
9ee2: 81 0a        BZ      $9EEEH
9ee4: 6f 84 07     CMP     0FE84H,#07H
9ee7: 81 05        BZ      $9EEEH
9ee9: 3a 74 00     MOV     0FE74H,#00H
9eec: 14 37        BR      $9F25H
9eee: 6f 74 36     CMP     0FE74H,#36H
9ef1: 80 14        BNZ     $9F07H
9ef3: 75 65 11     BT      0FE65H.5,$9F07H
9ef6: 08 a5 72 07  BF      0FE72H.5,$9F01H
9efa: 08 76 66     NOT1    0FE66H.6
9efd: b0 69        SET1    0FE69H.0
9eff: 14 06        BR      $9F07H
9f01: 28 d2 6b     CALL    !6BD2H
9f04: 3a 74 00     MOV     0FE74H,#00H
9f07: 6f 74 00     CMP     0FE74H,#00H
9f0a: 81 0b        BZ      $9F17H
9f0c: 6f 74 19     CMP     0FE74H,#19H
9f0f: 80 04        BNZ     $9F15H
9f11: b5 72        SET1    0FE72H.5
9f13: 14 02        BR      $9F17H
9f15: a5 72        CLR1    0FE72H.5
9f17: 20 74        MOV     A,0FE74H
9f19: 09 f1 0a fd  MOV     !0FD0AH,A
9f1d: 6f 74 00     CMP     0FE74H,#00H
9f20: 81 03        BZ      $9F25H
9f22: 28 c5 11     CALL    !11C5H
9f25: 14 0d        BR      $9F34H
9f27: 1c 80        MOVW    AX,0FE80H
9f29: 4c           DECW    AX
9f2a: 1a 80        MOVW    0FE80H,AX
9f2c: 2f 00 00     CMPW    AX,#0000H
9f2f: 80 03        BNZ     $9F34H
9f31: 28 eb 1e     CALL    !1EEBH
9f34: 08 a1 73 02  BF      0FE73H.1,$9F3AH
9f38: b4 68        SET1    0FE68H.4
9f3a: 28 0c 99     CALL    !990CH
9f3d: 2b 68 91     MOV     ADM,#91H
9f40: 27 7e        DEC     0FE7EH
9f42: 20 7e        MOV     A,0FE7EH
9f44: ac 01        AND     A,#01H
9f46: 80 03        BNZ     $9F4BH
9f48: 2c a2 a2     BR      !0A2A2H
9f4b: 6f 83 00     CMP     0FE83H,#00H
9f4e: 81 23        BZ      $9F73H
9f50: 27 83        DEC     0FE83H
9f52: 6f 83 00     CMP     0FE83H,#00H
9f55: 80 1c        BNZ     $9F73H
9f57: 2b 68 95     MOV     ADM,#95H
9f5a: 60 05 00     MOVW    AX,#0005H
9f5d: 3c           PUSH    AX
9f5e: 28 6d 8b     CALL    Delay_Loop
9f61: 34           POP     AX
9f62: 28 6e 75     CALL    !756EH
9f65: 28 2d 61     CALL    !612DH
9f68: b6 72        SET1    0FE72H.6
9f6a: b9 ff        MOV     A,#0FFH
9f6c: 09 f1 a7 fd  MOV     !0FDA7H,A
9f70: 28 16 20     CALL    !2016H
9f73: 6f 88 00     CMP     0FE88H,#00H
9f76: 81 09        BZ      $9F81H
9f78: 27 88        DEC     0FE88H
9f7a: 6f 88 00     CMP     0FE88H,#00H
9f7d: 80 02        BNZ     $9F81H
9f7f: b2 68        SET1    0FE68H.2
9f81: 6f 86 00     CMP     0FE86H,#00H
9f84: 81 28        BZ      $9FAEH
9f86: 27 86        DEC     0FE86H
9f88: 6f 86 00     CMP     0FE86H,#00H
9f8b: 80 21        BNZ     $9FAEH
9f8d: a7 66        CLR1    0FE66H.7
9f8f: a1 66        CLR1    0FE66H.1
9f91: b2 68        SET1    0FE68H.2
9f93: 73 65 09     BT      0FE65H.3,$9F9FH
9f96: 08 a0 66 05  BF      0FE66H.0,$9F9FH
9f9a: 6f 88 00     CMP     0FE88H,#00H
9f9d: 81 03        BZ      $9FA2H
9f9f: 3a 86 05     MOV     0FE86H,#05H
9fa2: 08 a3 67 08  BF      0FE67H.3,$9FAEH
9fa6: 6f 8c 44     CMP     0FE8CH,#44H
9fa9: 83 03        BC      $9FAEH
9fab: 3a 8c aa     MOV     0FE8CH,#0AAH
9fae: 6f 85 00     CMP     0FE85H,#00H
9fb1: 81 77        BZ      $0A02AH
9fb3: 27 85        DEC     0FE85H
9fb5: 6f 85 00     CMP     0FE85H,#00H
9fb8: 80 70        BNZ     $0A02AH
9fba: 70 67 04     BT      0FE67H.0,$9FC1H
9fbd: 08 a7 65 44  BF      0FE65H.7,$0A005H
9fc1: 09 f0 0d fd  MOV     A,!0FD0DH
9fc5: ac 0f        AND     A,#0FH
9fc7: b8 00        MOV     X,#00H
9fc9: d8           XCH     A,X
9fca: 2f 0f 00     CMPW    AX,#000FH
9fcd: 81 36        BZ      $0A005H
9fcf: 28 f0 8c     CALL    !8CF0H
9fd2: 8a 08        SUBW    AX,AX
9fd4: 8f 0a        CMPW    AX,BC
9fd6: 81 21        BZ      $9FF9H
9fd8: 08 a7 65 08  BF      0FE65H.7,$9FE4H
9fdc: 28 7b 7c     CALL    !7C7BH
9fdf: 28 71 2d     CALL    !2D71H
9fe2: 14 13        BR      $9FF7H
9fe4: 28 86 7f     CALL    !7F86H
9fe7: 8a 08        SUBW    AX,AX
9fe9: 8f 0a        CMPW    AX,BC
9feb: 81 08        BZ      $9FF5H
9fed: 28 43 7d     CALL    !7D43H
9ff0: 28 16 20     CALL    !2016H
9ff3: 14 02        BR      $9FF7H
9ff5: 14 02        BR      $9FF9H
9ff7: 14 0a        BR      $0A003H
9ff9: 28 d2 6b     CALL    !6BD2H
9ffc: 64 1e fd     MOVW    DE,#0FD1EH
9fff: 05 e2        MOVW    AX,[DE]
a001: 1a 90        MOVW    0FE90H,AX
a003: 14 0f        BR      $0A014H
a005: 08 a1 67 0b  BF      0FE67H.1,$0A014H
a009: 28 a0 91     CALL    !91A0H
a00c: 64 8c fe     MOVW    DE,#0FE8CH
a00f: 3e           PUSH    DE
a010: 28 36 98     CALL    !9836H
a013: 34           POP     AX
a014: a4 72        CLR1    0FE72H.4
a016: a1 67        CLR1    0FE67H.1
a018: a7 65        CLR1    0FE65H.7
a01a: a0 67        CLR1    0FE67H.0
a01c: 09 f0 0d fd  MOV     A,!0FD0DH
a020: ac f0        AND     A,#0F0H
a022: ae 0f        OR      A,#0FH
a024: 09 f1 0d fd  MOV     !0FD0DH,A
a028: b1 68        SET1    0FE68H.1
a02a: 6f 7f 00     CMP     0FE7FH,#00H
a02d: 81 0a        BZ      $0A039H
a02f: 27 7f        DEC     0FE7FH
a031: 6f 7f 00     CMP     0FE7FH,#00H
a034: 80 03        BNZ     $0A039H
a036: 28 37 8b     CALL    !8B37H
a039: 6f 89 00     CMP     0FE89H,#00H
a03c: 81 1c        BZ      $0A05AH
a03e: 27 89        DEC     0FE89H
a040: 6f 89 00     CMP     0FE89H,#00H
a043: 80 15        BNZ     $0A05AH
a045: 1c 63        MOVW    AX,0FE63H
a047: 24 48        MOVW    DE,AX
a049: 5c           MOV     A,[DE]
a04a: 30 91        SHR     A,2
a04c: ac 01        AND     A,#01H
a04e: b8 00        MOV     X,#00H
a050: d8           XCH     A,X
a051: 2f 01 00     CMPW    AX,#0001H
a054: 80 04        BNZ     $0A05AH
a056: b4 68        SET1    0FE68H.4
a058: b1 68        SET1    0FE68H.1
a05a: 09 f0 0c fd  MOV     A,!0FD0CH
a05e: ac 7f        AND     A,#7FH
a060: b8 00        MOV     X,#00H
a062: d8           XCH     A,X
a063: 2f 00 00     CMPW    AX,#0000H
a066: 81 2e        BZ      $0A096H
a068: 09 f0 0c fd  MOV     A,!0FD0CH
a06c: ac 7f        AND     A,#7FH
a06e: b8 00        MOV     X,#00H
a070: d8           XCH     A,X
a071: 4c           DECW    AX
a072: 24 28        MOVW    BC,AX
a074: 09 f0 0c fd  MOV     A,!0FD0CH
a078: ac 80        AND     A,#80H
a07a: 8e 12        OR      A,C
a07c: 09 f1 0c fd  MOV     !0FD0CH,A
a080: ac 7f        AND     A,#7FH
a082: b8 00        MOV     X,#00H
a084: d8           XCH     A,X
a085: 2f 00 00     CMPW    AX,#0000H
a088: 80 0c        BNZ     $0A096H
a08a: 09 f0 0c fd  MOV     A,!0FD0CH
a08e: 03 8f        SET1    A.7
a090: 09 f1 0c fd  MOV     !0FD0CH,A
a094: b2 68        SET1    0FE68H.2
a096: 76 65 03     BT      0FE65H.6,$0A09CH
a099: 2c 76 a2     BR      !0A276H
a09c: 09 f0 92 fd  MOV     A,!0FD92H
a0a0: d8           XCH     A,X
a0a1: 09 f0 91 fd  MOV     A,!0FD91H
a0a5: 8f 10        CMP     A,X
a0a7: 81 03        BZ      $0A0ACH
a0a9: 2c 74 a2     BR      !0A274H
a0ac: 6f 82 00     CMP     0FE82H,#00H
a0af: 81 30        BZ      $0A0E1H
a0b1: 09 f0 98 fd  MOV     A,!0FD98H
a0b5: 30 a9        SHR     A,5
a0b7: ac 01        AND     A,#01H
a0b9: b8 00        MOV     X,#00H
a0bb: d8           XCH     A,X
a0bc: 2f 01 00     CMPW    AX,#0001H
a0bf: 80 04        BNZ     $0A0C5H
a0c1: 27 82        DEC     0FE82H
a0c3: 14 19        BR      $0A0DEH
a0c5: 20 7e        MOV     A,0FE7EH
a0c7: ac 01        AND     A,#01H
a0c9: 81 13        BZ      $0A0DEH
a0cb: 27 82        DEC     0FE82H
a0cd: 09 f0 97 fd  MOV     A,!0FD97H
a0d1: ac 80        AND     A,#80H
a0d3: af 80        CMP     A,#80H
a0d5: 80 07        BNZ     $0A0DEH
a0d7: 08 a1 07 03  BF      P7.1,$0A0DEH
a0db: 3a 82 fa     MOV     0FE82H,#0FAH
a0de: 2c 74 a2     BR      !0A274H
a0e1: 09 f0 98 fd  MOV     A,!0FD98H
a0e5: 30 a9        SHR     A,5
a0e7: ac 01        AND     A,#01H
a0e9: b8 00        MOV     X,#00H
a0eb: d8           XCH     A,X
a0ec: 2f 01 00     CMPW    AX,#0001H
a0ef: 80 7c        BNZ     $0A16DH
a0f1: 6f 8a 00     CMP     0FE8AH,#00H
a0f4: 81 03        BZ      $0A0F9H
a0f6: 28 1c 4a     CALL    !4A1CH
a0f9: 08 a1 07 61  BF      P7.1,$0A15EH
a0fd: 09 f0 97 fd  MOV     A,!0FD97H
a101: ac 20        AND     A,#20H
a103: af 20        CMP     A,#20H
a105: 80 13        BNZ     $0A11AH
a107: a6 65        CLR1    0FE65H.6
a109: 3a 82 00     MOV     0FE82H,#00H
a10c: 09 f0 97 fd  MOV     A,!0FD97H
a110: ac 08        AND     A,#08H
a112: 81 03        BZ      $0A117H
a114: 28 b3 2c     CALL    !2CB3H
a117: 2c 71 a2     BR      !0A271H
a11a: 09 f0 98 fd  MOV     A,!0FD98H
a11e: 30 b1        SHR     A,6
a120: ac 01        AND     A,#01H
a122: b8 00        MOV     X,#00H
a124: d8           XCH     A,X
a125: 2f 01 00     CMPW    AX,#0001H
a128: 80 0c        BNZ     $0A136H
a12a: 09 f0 97 fd  MOV     A,!0FD97H
a12e: ac 0e        AND     A,#0EH
a130: af 08        CMP     A,#08H
a132: 80 02        BNZ     $0A136H
a134: 14 3d        BR      $0A173H
a136: b4 00        SET1    P0.4
a138: 09 f0 a3 fd  MOV     A,!0FDA3H
a13c: af 04        CMP     A,#04H
a13e: 81 0a        BZ      $0A14AH
a140: 09 f0 98 fd  MOV     A,!0FD98H
a144: 03 8e        SET1    A.6
a146: 09 f1 98 fd  MOV     !0FD98H,A
a14a: 3a 82 fa     MOV     0FE82H,#0FAH
a14d: 09 f0 98 fd  MOV     A,!0FD98H
a151: 03 9d        CLR1    A.5
a153: 09 f1 98 fd  MOV     !0FD98H,A
a157: b1 68        SET1    0FE68H.1
a159: b2 68        SET1    0FE68H.2
a15b: 2c 89 a2     BR      !0A289H
a15e: 09 f0 98 fd  MOV     A,!0FD98H
a162: 03 9e        CLR1    A.6
a164: 09 f1 98 fd  MOV     !0FD98H,A
a168: 3a 82 00     MOV     0FE82H,#00H
a16b: 14 03        BR      $0A170H
a16d: 3a 82 19     MOV     0FE82H,#19H
a170: 2c 4a a2     BR      !0A24AH
a173: 09 f0 98 fd  MOV     A,!0FD98H
a177: 30 a1        SHR     A,4
a179: ac 01        AND     A,#01H
a17b: b8 00        MOV     X,#00H
a17d: d8           XCH     A,X
a17e: 2f 01 00     CMPW    AX,#0001H
a181: 80 04        BNZ     $0A187H
a183: b5 69        SET1    0FE69H.5
a185: 14 02        BR      $0A189H
a187: a5 69        CLR1    0FE69H.5
a189: 3a 75 01     MOV     Wheel_Count,#01H
a18c: 2c 65 a2     BR      !0A265H
a18f: 09 f0 98 fd  MOV     A,!0FD98H
a193: 30 a1        SHR     A,4
a195: ac 01        AND     A,#01H
a197: b8 00        MOV     X,#00H
a199: d8           XCH     A,X
a19a: 2f 01 00     CMPW    AX,#0001H
a19d: 80 05        BNZ     $0A1A4H
a19f: 28 17 7e     CALL    !7E17H
a1a2: 14 03        BR      $0A1A7H
a1a4: 28 54 7e     CALL    !7E54H
a1a7: 14 03        BR      $0A1ACH
a1a9: 28 6b 27     CALL    !276BH
a1ac: 1c 63        MOVW    AX,0FE63H
a1ae: 24 08        MOVW    AX,AX
a1b0: 2d 06 00     ADDW    AX,#0006H
a1b3: 24 48        MOVW    DE,AX
a1b5: 5c           MOV     A,[DE]
a1b6: ac 3f        AND     A,#3FH
a1b8: 06 a0 01     MOV     [HL+01H],A
a1bb: 1c 63        MOVW    AX,0FE63H
a1bd: 24 08        MOVW    AX,AX
a1bf: 2d 05 00     ADDW    AX,#0005H
a1c2: 24 48        MOVW    DE,AX
a1c4: 5c           MOV     A,[DE]
a1c5: ac 0c        AND     A,#0CH
a1c7: 55           MOV     [HL],A
a1c8: 28 43 7d     CALL    !7D43H
a1cb: 1c 63        MOVW    AX,0FE63H
a1cd: 24 48        MOVW    DE,AX
a1cf: 06 00 05     MOV     A,[DE+05H]
a1d2: ac cf        AND     A,#0CFH
a1d4: ae 20        OR      A,#20H
a1d6: 06 80 05     MOV     [DE+05H],A
a1d9: 06 20 01     MOV     A,[HL+01H]
a1dc: ac 38        AND     A,#38H
a1de: da           XCH     A,C
a1df: 1c 63        MOVW    AX,0FE63H
a1e1: 24 08        MOVW    AX,AX
a1e3: 2d 06 00     ADDW    AX,#0006H
a1e6: 24 48        MOVW    DE,AX
a1e8: 5c           MOV     A,[DE]
a1e9: ac 38        AND     A,#38H
a1eb: 8f 21        CMP     C,A
a1ed: 81 03        BZ      $0A1F2H
a1ef: 3a 82 03     MOV     0FE82H,#03H
a1f2: 06 20 01     MOV     A,[HL+01H]
a1f5: ac 07        AND     A,#07H
a1f7: da           XCH     A,C
a1f8: 1c 63        MOVW    AX,0FE63H
a1fa: 24 08        MOVW    AX,AX
a1fc: 2d 06 00     ADDW    AX,#0006H
a1ff: 24 48        MOVW    DE,AX
a201: 5c           MOV     A,[DE]
a202: ac 07        AND     A,#07H
a204: 8f 21        CMP     C,A
a206: 81 03        BZ      $0A20BH
a208: 68 82 03     ADD     0FE82H,#03H
a20b: 1c 63        MOVW    AX,0FE63H
a20d: 24 48        MOVW    DE,AX
a20f: 06 00 06     MOV     A,[DE+06H]
a212: 30 99        SHR     A,3
a214: ac 07        AND     A,#07H
a216: b8 00        MOV     X,#00H
a218: d8           XCH     A,X
a219: 2f 04 00     CMPW    AX,#0004H
a21c: 80 0e        BNZ     $0A22CH
a21e: 1c 63        MOVW    AX,0FE63H
a220: 24 48        MOVW    DE,AX
a222: 06 00 06     MOV     A,[DE+06H]
a225: ac f8        AND     A,#0F8H
a227: ae 04        OR      A,#04H
a229: 06 80 06     MOV     [DE+06H],A
a22c: 1c 63        MOVW    AX,0FE63H
a22e: 24 08        MOVW    AX,AX
a230: 2d 05 00     ADDW    AX,#0005H
a233: 24 48        MOVW    DE,AX
a235: 5c           MOV     A,[DE]
a236: ac f3        AND     A,#0F3H
a238: 16 5e        OR      A,[HL]
a23a: da           XCH     A,C
a23b: 1c 63        MOVW    AX,0FE63H
a23d: 24 08        MOVW    AX,AX
a23f: 2d 05 00     ADDW    AX,#0005H
a242: 24 48        MOVW    DE,AX
a244: d2           MOV     A,C
a245: 54           MOV     [DE],A
a246: 14 1d        BR      $0A265H
a248: 14 1b        BR      $0A265H
a24a: 09 f0 97 fd  MOV     A,!0FD97H
a24e: ac 0e        AND     A,#0EH
a250: af 04        CMP     A,#04H
a252: 80 03        BNZ     $0A257H
a254: 2c a9 a1     BR      !0A1A9H
a257: af 02        CMP     A,#02H
a259: 80 03        BNZ     $0A25EH
a25b: 2c 8f a1     BR      !0A18FH
a25e: af 08        CMP     A,#08H
a260: 80 03        BNZ     $0A265H
a262: 2c 73 a1     BR      !0A173H
a265: 09 f0 98 fd  MOV     A,!0FD98H
a269: 03 8d        SET1    A.5
a26b: 09 f1 98 fd  MOV     !0FD98H,A
a26f: a4 00        CLR1    P0.4
a271: 28 16 20     CALL    !2016H
a274: 14 13        BR      $0A289H
a276: 6f 8a 00     CMP     0FE8AH,#00H
a279: 81 0e        BZ      $0A289H
a27b: 27 8a        DEC     0FE8AH
a27d: 6f 8a 00     CMP     0FE8AH,#00H
a280: 80 07        BNZ     $0A289H
a282: 08 a0 66 03  BF      0FE66H.0,$0A289H
a286: 28 1c 4a     CALL    !4A1CH
a289: 1c 63        MOVW    AX,0FE63H
a28b: 24 48        MOVW    DE,AX
a28d: 06 00 06     MOV     A,[DE+06H]
a290: 30 b1        SHR     A,6
a292: ac 03        AND     A,#03H
a294: b8 00        MOV     X,#00H
a296: d8           XCH     A,X
a297: 2f 01 00     CMPW    AX,#0001H
a29a: 81 06        BZ      $0A2A2H
a29c: b9 ff        MOV     A,#0FFH
a29e: 09 f1 a7 fd  MOV     !0FDA7H,A
a2a2: 6f 84 00     CMP     0FE84H,#00H
a2a5: 81 02        BZ      $0A2A9H
a2a7: 27 84        DEC     0FE84H
a2a9: 6f 87 00     CMP     0FE87H,#00H
a2ac: 81 0b        BZ      $0A2B9H
a2ae: 27 87        DEC     0FE87H
a2b0: 6f 87 00     CMP     0FE87H,#00H
a2b3: 80 04        BNZ     $0A2B9H
a2b5: 01 6c 5f 7f  AND     TMC1,#7FH
a2b9: 20 69        MOV     A,0FE69H
a2bb: ac 07        AND     A,#07H
a2bd: 81 03        BZ      $0A2C2H
a2bf: 28 78 92     CALL    !9278H
a2c2: 28 fc 6d     CALL    !6DFCH
a2c5: 28 ca 95     CALL    !95CAH
a2c8: 2b 68 93     MOV     ADM,#93H
a2cb: 08 a0 72 02  BF      0FE72H.0,$0A2D1H
a2cf: a4 03        CLR1    P3.4
a2d1: 34           POP     AX
a2d2: 37           POP     HL
a2d3: 56           RET
a2d4: 08 a4 69 12  BF      0FE69H.4,$0A2EAH
a2d8: 09 f0 b2 fd  MOV     A,!0FDB2H
a2dc: af 0a        CMP     A,#0AH
a2de: 82 08        BNC     $0A2E8H
a2e0: 64 b2 fd     MOVW    DE,#0FDB2H
a2e3: 5c           MOV     A,[DE]
a2e4: c1           INC     A
a2e5: 54           MOV     [DE],A
a2e6: 14 02        BR      $0A2EAH
a2e8: b2 68        SET1    0FE68H.2
a2ea: 73 69 07     BT      0FE69H.3,$0A2F4H
a2ed: 74 69 04     BT      0FE69H.4,$0A2F4H
a2f0: 08 a6 72 0b  BF      0FE72H.6,$0A2FFH
a2f4: 28 90 a4     CALL    !0A490H
a2f7: 28 b0 a4     CALL    !0A4B0H
a2fa: 28 d0 a4     CALL    !0A4D0H
a2fd: a6 72        CLR1    0FE72H.6
a2ff: 1c 63        MOVW    AX,0FE63H
a301: 24 48        MOVW    DE,AX
a303: 06 00 06     MOV     A,[DE+06H]
a306: 30 b1        SHR     A,6
a308: ac 03        AND     A,#03H
a30a: b8 00        MOV     X,#00H
a30c: d8           XCH     A,X
a30d: 2f 01 00     CMPW    AX,#0001H
a310: 80 05        BNZ     $0A317H
a312: 28 b8 5e     CALL    !5EB8H
a315: 14 21        BR      $0A338H
a317: 1c 63        MOVW    AX,0FE63H
a319: 24 48        MOVW    DE,AX
a31b: 06 00 03     MOV     A,[DE+03H]
a31e: d8           XCH     A,X
a31f: 06 00 04     MOV     A,[DE+04H]
a322: 24 28        MOVW    BC,AX
a324: 06 00 01     MOV     A,[DE+01H]
a327: d8           XCH     A,X
a328: 06 00 02     MOV     A,[DE+02H]
a32b: 64 1a fd     MOVW    DE,#0FD1AH
a32e: 05 e6        MOVW    [DE],AX
a330: 25 02        XCH     X,C
a332: db           XCH     A,B
a333: 64 1c fd     MOVW    DE,#0FD1CH
a336: 05 e6        MOVW    [DE],AX
a338: 09 f0 16 fd  MOV     A,!0FD16H
a33c: d8           XCH     A,X
a33d: 09 f0 1a fd  MOV     A,!0FD1AH
a341: 8f 10        CMP     A,X
a343: 80 04        BNZ     $0A349H
a345: 08 a4 69 06  BF      0FE69H.4,$0A34FH
a349: 28 a9 a3     CALL    !0A3A9H
a34c: 28 09 62     CALL    !6209H
a34f: 09 f0 17 fd  MOV     A,!0FD17H
a353: d8           XCH     A,X
a354: 09 f0 1b fd  MOV     A,!0FD1BH
a358: 8f 10        CMP     A,X
a35a: 80 04        BNZ     $0A360H
a35c: 08 a4 69 06  BF      0FE69H.4,$0A366H
a360: 28 df a3     CALL    !0A3DFH
a363: 28 09 62     CALL    !6209H
a366: 09 f0 18 fd  MOV     A,!0FD18H
a36a: d8           XCH     A,X
a36b: 09 f0 1c fd  MOV     A,!0FD1CH
a36f: 8f 10        CMP     A,X
a371: 80 11        BNZ     $0A384H
a373: 09 f0 19 fd  MOV     A,!0FD19H
a377: d8           XCH     A,X
a378: 09 f0 1d fd  MOV     A,!0FD1DH
a37c: 8f 10        CMP     A,X
a37e: 80 04        BNZ     $0A384H
a380: 08 a4 69 06  BF      0FE69H.4,$0A38AH
a384: 28 19 a4     CALL    !0A419H
a387: 28 09 62     CALL    !6209H
a38a: 28 9d a6     CALL    !0A69DH
a38d: 64 1c fd     MOVW    DE,#0FD1CH
a390: 05 e2        MOVW    AX,[DE]
a392: 24 28        MOVW    BC,AX
a394: 64 1a fd     MOVW    DE,#0FD1AH
a397: 05 e2        MOVW    AX,[DE]
a399: 64 16 fd     MOVW    DE,#0FD16H
a39c: 05 e6        MOVW    [DE],AX
a39e: 25 02        XCH     X,C
a3a0: db           XCH     A,B
a3a1: 64 18 fd     MOVW    DE,#0FD18H
a3a4: 05 e6        MOVW    [DE],AX
a3a6: a3 68        CLR1    0FE68H.3
a3a8: 56           RET
a3a9: 3f           PUSH    HL
a3aa: 05 c9        DECW    SP
a3ac: 05 c9        DECW    SP
a3ae: 11 fc        MOVW    AX,SP
a3b0: 24 68        MOVW    HL,AX
a3b2: 09 f0 1a fd  MOV     A,!0FD1AH
a3b6: b8 00        MOV     X,#00H
a3b8: d8           XCH     A,X
a3b9: 3c           PUSH    AX
a3ba: 28 8f 8b     CALL    !8B8FH
a3bd: 34           POP     AX
a3be: 24 0a        MOVW    AX,BC
a3c0: 06 a0 01     MOV     [HL+01H],A
a3c3: d8           XCH     A,X
a3c4: 55           MOV     [HL],A
a3c5: d8           XCH     A,X
a3c6: 2d 24 13     ADDW    AX,#1324H
a3c9: 88 08        ADDW    AX,AX
a3cb: 06 a0 01     MOV     [HL+01H],A
a3ce: d8           XCH     A,X
a3cf: 55           MOV     [HL],A
a3d0: d8           XCH     A,X
a3d1: 06 20 01     MOV     A,[HL+01H]
a3d4: 3c           PUSH    AX
a3d5: 28 62 a4     CALL    !0A462H
a3d8: 34           POP     AX
a3d9: 28 05 a5     CALL    !0A505H
a3dc: 34           POP     AX
a3dd: 37           POP     HL
a3de: 56           RET
a3df: 3f           PUSH    HL
a3e0: 05 c9        DECW    SP
a3e2: 05 c9        DECW    SP
a3e4: 11 fc        MOVW    AX,SP
a3e6: 24 68        MOVW    HL,AX
a3e8: 09 f0 1b fd  MOV     A,!0FD1BH
a3ec: b8 00        MOV     X,#00H
a3ee: d8           XCH     A,X
a3ef: 3c           PUSH    AX
a3f0: 28 8f 8b     CALL    !8B8FH
a3f3: 34           POP     AX
a3f4: 24 0a        MOVW    AX,BC
a3f6: 06 a0 01     MOV     [HL+01H],A
a3f9: d8           XCH     A,X
a3fa: 55           MOV     [HL],A
a3fb: d8           XCH     A,X
a3fc: 24 28        MOVW    BC,AX
a3fe: 60 5d 01     MOVW    AX,#015DH
a401: 8a 0a        SUBW    AX,BC
a403: 88 08        ADDW    AX,AX
a405: 06 a0 01     MOV     [HL+01H],A
a408: d8           XCH     A,X
a409: 55           MOV     [HL],A
a40a: d8           XCH     A,X
a40b: 06 20 01     MOV     A,[HL+01H]
a40e: 3c           PUSH    AX
a40f: 28 62 a4     CALL    !0A462H
a412: 34           POP     AX
a413: 28 11 a5     CALL    !0A511H
a416: 34           POP     AX
a417: 37           POP     HL
a418: 56           RET
a419: 3f           PUSH    HL
a41a: 05 c9        DECW    SP
a41c: 05 c9        DECW    SP
a41e: 11 fc        MOVW    AX,SP
a420: 24 68        MOVW    HL,AX
a422: 09 f0 1d fd  MOV     A,!0FD1DH
a426: 06 a0 01     MOV     [HL+01H],A
a429: 09 f0 1c fd  MOV     A,!0FD1CH
a42d: 55           MOV     [HL],A
a42e: d8           XCH     A,X
a42f: 06 20 01     MOV     A,[HL+01H]
a432: 3c           PUSH    AX
a433: 28 b6 8b     CALL    !8BB6H
a436: 34           POP     AX
a437: 24 4a        MOVW    DE,BC
a439: 05 e2        MOVW    AX,[DE]
a43b: 06 a0 01     MOV     [HL+01H],A
a43e: d8           XCH     A,X
a43f: 55           MOV     [HL],A
a440: d8           XCH     A,X
a441: 2d 28 00     ADDW    AX,#0028H
a444: 06 a0 01     MOV     [HL+01H],A
a447: d8           XCH     A,X
a448: 55           MOV     [HL],A
a449: 06 20 01     MOV     A,[HL+01H]
a44c: 22 a6        MOV     0FEA6H,A
a44e: 91 5e        CALLF   Serial_Output_Thing
a450: 5d           MOV     A,[HL]
a451: 22 a6        MOV     0FEA6H,A
a453: 91 5e        CALLF   Serial_Output_Thing
a455: b7 06        SET1    P6.7
a457: 28 84 8b     CALL    Cycle_Serial_Clock
a45a: a7 06        CLR1    P6.7
a45c: 28 1d a5     CALL    !0A51DH
a45f: 34           POP     AX
a460: 37           POP     HL
a461: 56           RET
a462: 3f           PUSH    HL
a463: 11 fc        MOVW    AX,SP
a465: 24 68        MOVW    HL,AX
a467: 3a bb 40     MOV     0FEBBH,#40H
a46a: 24 0e        MOVW    AX,HL
a46c: 2d 04 00     ADDW    AX,#0004H
a46f: 24 48        MOVW    DE,AX
a471: 06 00 01     MOV     A,[DE+01H]
a474: 22 ba        MOV     0FEBAH,A
a476: 1c b2        MOVW    AX,I2C_OutputBuffer
a478: 3c           PUSH    AX
a479: 1c ba        MOVW    AX,0FEBAH
a47b: 1a b2        MOVW    I2C_OutputBuffer,AX
a47d: 91 84        CALLF   !0984H
a47f: 34           POP     AX
a480: 1a b2        MOVW    I2C_OutputBuffer,AX
a482: 24 0e        MOVW    AX,HL
a484: 2d 04 00     ADDW    AX,#0004H
a487: 24 48        MOVW    DE,AX
a489: 5c           MOV     A,[DE]
a48a: 22 a6        MOV     0FEA6H,A
a48c: 91 5e        CALLF   Serial_Output_Thing
a48e: 37           POP     HL
a48f: 56           RET
a490: 3f           PUSH    HL
a491: 05 c9        DECW    SP
a493: 05 c9        DECW    SP
a495: 11 fc        MOVW    AX,SP
a497: 24 68        MOVW    HL,AX
a499: 60 ad 0d     MOVW    AX,#0DADH
a49c: 06 a0 01     MOV     [HL+01H],A
a49f: d8           XCH     A,X
a4a0: 55           MOV     [HL],A
a4a1: d8           XCH     A,X
a4a2: 06 20 01     MOV     A,[HL+01H]
a4a5: 3c           PUSH    AX
a4a6: 28 62 a4     CALL    !0A462H
a4a9: 34           POP     AX
a4aa: 28 05 a5     CALL    !0A505H
a4ad: 34           POP     AX
a4ae: 37           POP     HL
a4af: 56           RET
a4b0: 3f           PUSH    HL
a4b1: 05 c9        DECW    SP
a4b3: 05 c9        DECW    SP
a4b5: 11 fc        MOVW    AX,SP
a4b7: 24 68        MOVW    HL,AX
a4b9: 60 bd 02     MOVW    AX,#02BDH
a4bc: 06 a0 01     MOV     [HL+01H],A
a4bf: d8           XCH     A,X
a4c0: 55           MOV     [HL],A
a4c1: d8           XCH     A,X
a4c2: 06 20 01     MOV     A,[HL+01H]
a4c5: 3c           PUSH    AX
a4c6: 28 62 a4     CALL    !0A462H
a4c9: 34           POP     AX
a4ca: 28 11 a5     CALL    !0A511H
a4cd: 34           POP     AX
a4ce: 37           POP     HL
a4cf: 56           RET
a4d0: 3f           PUSH    HL
a4d1: 05 c9        DECW    SP
a4d3: 05 c9        DECW    SP
a4d5: 11 fc        MOVW    AX,SP
a4d7: 24 68        MOVW    HL,AX
a4d9: 60 5e 01     MOVW    AX,#015EH
a4dc: 06 a0 01     MOV     [HL+01H],A
a4df: d8           XCH     A,X
a4e0: 55           MOV     [HL],A
a4e1: 3a bb 02     MOV     0FEBBH,#02H
a4e4: 06 20 01     MOV     A,[HL+01H]
a4e7: 22 ba        MOV     0FEBAH,A
a4e9: 1c b2        MOVW    AX,I2C_OutputBuffer
a4eb: 3c           PUSH    AX
a4ec: 1c ba        MOVW    AX,0FEBAH
a4ee: 1a b2        MOVW    I2C_OutputBuffer,AX
a4f0: 91 84        CALLF   !0984H
a4f2: 34           POP     AX
a4f3: 1a b2        MOVW    I2C_OutputBuffer,AX
a4f5: 5d           MOV     A,[HL]
a4f6: 22 a6        MOV     0FEA6H,A
a4f8: 91 5e        CALLF   Serial_Output_Thing
a4fa: a7 06        CLR1    P6.7
a4fc: 28 84 8b     CALL    Cycle_Serial_Clock
a4ff: 28 1d a5     CALL    !0A51DH
a502: 34           POP     AX
a503: 37           POP     HL
a504: 56           RET
a505: 20 06        MOV     A,P6
a507: ac f8        AND     A,#0F8H
a509: ae 06        OR      A,#06H
a50b: 22 06        MOV     P6,A
a50d: 6c 06 f8     AND     P6,#0F8H
a510: 56           RET
a511: 20 06        MOV     A,P6
a513: ac f8        AND     A,#0F8H
a515: ae 05        OR      A,#05H
a517: 22 06        MOV     P6,A
a519: 6c 06 f8     AND     P6,#0F8H
a51c: 56           RET
a51d: 20 06        MOV     A,P6
a51f: ac f8        AND     A,#0F8H
a521: ae 04        OR      A,#04H
a523: 22 06        MOV     P6,A
a525: 6c 06 f8     AND     P6,#0F8H
a528: 56           RET
a529: 3f           PUSH    HL
a52a: 1c ac        MOVW    AX,0FEACH
a52c: 3c           PUSH    AX
a52d: 05 c9        DECW    SP
a52f: 05 c9        DECW    SP
a531: 11 fc        MOVW    AX,SP
a533: 24 68        MOVW    HL,AX
a535: a4 68        CLR1    0FE68H.4
a537: 28 09 62     CALL    !6209H
a53a: 70 66 03     BT      0FE66H.0,$0A540H
a53d: 2c 78 a6     BR      !0A678H
a540: 6f 83 00     CMP     0FE83H,#00H
a543: 81 03        BZ      $0A548H
a545: 2c 78 a6     BR      !0A678H
a548: 14 1b        BR      $0A565H
a54a: 3a ac 0f     MOV     0FEACH,#0FH
a54d: 14 3b        BR      $0A58AH
a54f: 3a ac 1e     MOV     0FEACH,#1EH
a552: 14 36        BR      $0A58AH
a554: 3a ac 3c     MOV     0FEACH,#3CH
a557: 14 31        BR      $0A58AH
a559: 3a ac 58     MOV     0FEACH,#58H
a55c: 14 2c        BR      $0A58AH
a55e: 3a ac 70     MOV     0FEACH,#70H
a561: 14 27        BR      $0A58AH
a563: 14 25        BR      $0A58AH
a565: 1c 63        MOVW    AX,0FE63H
a567: 24 48        MOVW    DE,AX
a569: 06 00 06     MOV     A,[DE+06H]
a56c: ac 07        AND     A,#07H
a56e: b8 00        MOV     X,#00H
a570: d8           XCH     A,X
a571: 2f 04 00     CMPW    AX,#0004H
a574: 81 e8        BZ      $0A55EH
a576: 2f 03 00     CMPW    AX,#0003H
a579: 81 de        BZ      $0A559H
a57b: 2f 02 00     CMPW    AX,#0002H
a57e: 81 d4        BZ      $0A554H
a580: 2f 01 00     CMPW    AX,#0001H
a583: 81 ca        BZ      $0A54FH
a585: 2f 00 00     CMPW    AX,#0000H
a588: 81 c0        BZ      $0A54AH
a58a: 1c 63        MOVW    AX,0FE63H
a58c: 24 48        MOVW    DE,AX
a58e: 06 00 06     MOV     A,[DE+06H]
a591: 30 99        SHR     A,3
a593: ac 07        AND     A,#07H
a595: b8 00        MOV     X,#00H
a597: d8           XCH     A,X
a598: 24 28        MOVW    BC,AX
a59a: 60 03 00     MOVW    AX,#0003H
a59d: 8f 0a        CMPW    AX,BC
a59f: 83 03        BC      $0A5A4H
a5a1: 6e ac 80     OR      0FEACH,#80H
a5a4: 64 d0 ff     MOVW    DE,#0FFD0H
a5a7: 20 ac        MOV     A,0FEACH
a5a9: 54           MOV     [DE],A
a5aa: 3a ac 10     MOV     0FEACH,#10H
a5ad: 14 27        BR      $0A5D6H
a5af: 1c 63        MOVW    AX,0FE63H
a5b1: 24 48        MOVW    DE,AX
a5b3: 5c           MOV     A,[DE]
a5b4: 30 91        SHR     A,2
a5b6: ac 01        AND     A,#01H
a5b8: b8 00        MOV     X,#00H
a5ba: d8           XCH     A,X
a5bb: 2f 01 00     CMPW    AX,#0001H
a5be: 80 0a        BNZ     $0A5CAH
a5c0: 6f 89 00     CMP     0FE89H,#00H
a5c3: 81 03        BZ      $0A5C8H
a5c5: 6e ac 80     OR      0FEACH,#80H
a5c8: 14 03        BR      $0A5CDH
a5ca: 6e ac 81     OR      0FEACH,#81H
a5cd: 14 21        BR      $0A5F0H
a5cf: 14 1f        BR      $0A5F0H
a5d1: 6e ac 01     OR      0FEACH,#01H
a5d4: 14 1a        BR      $0A5F0H
a5d6: 1c 63        MOVW    AX,0FE63H
a5d8: 24 48        MOVW    DE,AX
a5da: 06 00 06     MOV     A,[DE+06H]
a5dd: 30 99        SHR     A,3
a5df: ac 07        AND     A,#07H
a5e1: b8 00        MOV     X,#00H
a5e3: d8           XCH     A,X
a5e4: 2f 04 00     CMPW    AX,#0004H
a5e7: 81 e6        BZ      $0A5CFH
a5e9: 2f 05 00     CMPW    AX,#0005H
a5ec: 81 c1        BZ      $0A5AFH
a5ee: 14 e1        BR      $0A5D1H
a5f0: 1c 63        MOVW    AX,0FE63H
a5f2: 24 48        MOVW    DE,AX
a5f4: 06 00 05     MOV     A,[DE+05H]
a5f7: 30 89        SHR     A,1
a5f9: ac 01        AND     A,#01H
a5fb: b8 00        MOV     X,#00H
a5fd: d8           XCH     A,X
a5fe: 2f 01 00     CMPW    AX,#0001H
a601: 80 03        BNZ     $0A606H
a603: 6e ac 08     OR      0FEACH,#08H
a606: 3a ad 04     MOV     0FEADH,#04H
a609: 14 0a        BR      $0A615H
a60b: 3a ad 00     MOV     0FEADH,#00H
a60e: 14 1d        BR      $0A62DH
a610: 3a ad 02     MOV     0FEADH,#02H
a613: 14 18        BR      $0A62DH
a615: 1c 63        MOVW    AX,0FE63H
a617: 24 48        MOVW    DE,AX
a619: 06 00 05     MOV     A,[DE+05H]
a61c: 30 a1        SHR     A,4
a61e: ac 03        AND     A,#03H
a620: b8 00        MOV     X,#00H
a622: d8           XCH     A,X
a623: 2f 03 00     CMPW    AX,#0003H
a626: 81 e8        BZ      $0A610H
a628: 2f 02 00     CMPW    AX,#0002H
a62b: 81 de        BZ      $0A60BH
a62d: 7e ad ac     OR      0FEACH,0FEADH
a630: 72 72 08     BT      0FE72H.2,$0A63BH
a633: 08 a1 73 07  BF      0FE73H.1,$0A63EH
a637: 08 a1 07 03  BF      P7.1,$0A63EH
a63b: 6e ac 20     OR      0FEACH,#20H
a63e: 1c 63        MOVW    AX,0FE63H
a640: 24 48        MOVW    DE,AX
a642: 06 00 06     MOV     A,[DE+06H]
a645: 30 99        SHR     A,3
a647: ac 07        AND     A,#07H
a649: b8 00        MOV     X,#00H
a64b: d8           XCH     A,X
a64c: 2f 04 00     CMPW    AX,#0004H
a64f: 80 03        BNZ     $0A654H
a651: 6e ac 40     OR      0FEACH,#40H
a654: 1c 63        MOVW    AX,0FE63H
a656: 24 48        MOVW    DE,AX
a658: 5c           MOV     A,[DE]
a659: 30 91        SHR     A,2
a65b: ac 01        AND     A,#01H
a65d: b8 00        MOV     X,#00H
a65f: d8           XCH     A,X
a660: 2f 01 00     CMPW    AX,#0001H
a663: 80 08        BNZ     $0A66DH
a665: 6f 89 00     CMP     0FE89H,#00H
a668: 80 03        BNZ     $0A66DH
a66a: 6c ac 7f     AND     0FEACH,#7FH
a66d: 64 d1 ff     MOVW    DE,#0FFD1H
a670: 20 ac        MOV     A,0FEACH
a672: 54           MOV     [DE],A
a673: 28 9d a6     CALL    !0A69DH
a676: 14 1f        BR      $0A697H
a678: 64 d5 ff     MOVW    DE,#0FFD5H
a67b: b9 00        MOV     A,#00H
a67d: 54           MOV     [DE],A
a67e: 64 d2 ff     MOVW    DE,#0FFD2H
a681: 54           MOV     [DE],A
a682: 64 d1 ff     MOVW    DE,#0FFD1H
a685: 54           MOV     [DE],A
a686: 64 d0 ff     MOVW    DE,#0FFD0H
a689: 54           MOV     [DE],A
a68a: 60 bd df     MOVW    AX,#0DFBDH
a68d: 3c           PUSH    AX
a68e: 28 2b 7c     CALL    !7C2BH
a691: 34           POP     AX
a692: d2           MOV     A,C
a693: ac 0c        AND     A,#0CH
a695: 22 00        MOV     P0,A
a697: 34           POP     AX
a698: 34           POP     AX
a699: 1a ac        MOVW    0FEACH,AX
a69b: 37           POP     HL
a69c: 56           RET
a69d: 3f           PUSH    HL
a69e: 1c ac        MOVW    AX,0FEACH
a6a0: 3c           PUSH    AX
a6a1: 1c ae        MOVW    AX,0FEAEH
a6a3: 3c           PUSH    AX
a6a4: 05 c9        DECW    SP
a6a6: 05 c9        DECW    SP
a6a8: 11 fc        MOVW    AX,SP
a6aa: 24 68        MOVW    HL,AX
a6ac: 3a ac 02     MOV     0FEACH,#02H
a6af: 1c 63        MOVW    AX,0FE63H
a6b1: 24 48        MOVW    DE,AX
a6b3: 06 00 05     MOV     A,[DE+05H]
a6b6: 30 99        SHR     A,3
a6b8: ac 01        AND     A,#01H
a6ba: b8 00        MOV     X,#00H
a6bc: d8           XCH     A,X
a6bd: 2f 01 00     CMPW    AX,#0001H
a6c0: 80 03        BNZ     $0A6C5H
a6c2: 6e ac 01     OR      0FEACH,#01H
a6c5: 1c 63        MOVW    AX,0FE63H
a6c7: 24 48        MOVW    DE,AX
a6c9: 06 00 05     MOV     A,[DE+05H]
a6cc: 30 91        SHR     A,2
a6ce: ac 01        AND     A,#01H
a6d0: b8 00        MOV     X,#00H
a6d2: d8           XCH     A,X
a6d3: 2f 01 00     CMPW    AX,#0001H
a6d6: 80 03        BNZ     $0A6DBH
a6d8: 6c ac fd     AND     0FEACH,#0FDH
a6db: 3a ad 00     MOV     0FEADH,#00H
a6de: 14 0a        BR      $0A6EAH
a6e0: 3a ad 08     MOV     0FEADH,#08H
a6e3: 14 1d        BR      $0A702H
a6e5: 3a ad 04     MOV     0FEADH,#04H
a6e8: 14 18        BR      $0A702H
a6ea: 1c 63        MOVW    AX,0FE63H
a6ec: 24 48        MOVW    DE,AX
a6ee: 06 00 06     MOV     A,[DE+06H]
a6f1: 30 b1        SHR     A,6
a6f3: ac 03        AND     A,#03H
a6f5: b8 00        MOV     X,#00H
a6f7: d8           XCH     A,X
a6f8: 2f 01 00     CMPW    AX,#0001H
a6fb: 81 e8        BZ      $0A6E5H
a6fd: 2f 02 00     CMPW    AX,#0002H
a700: 81 de        BZ      $0A6E0H
a702: 7e ad ac     OR      0FEACH,0FEADH
a705: 1c 63        MOVW    AX,0FE63H
a707: 24 08        MOVW    AX,AX
a709: 2d 03 00     ADDW    AX,#0003H
a70c: 24 48        MOVW    DE,AX
a70e: 5c           MOV     A,[DE]
a70f: 55           MOV     [HL],A
a710: 1c 63        MOVW    AX,0FE63H
a712: 24 08        MOVW    AX,AX
a714: 2d 04 00     ADDW    AX,#0004H
a717: 24 48        MOVW    DE,AX
a719: 5c           MOV     A,[DE]
a71a: 06 a0 01     MOV     [HL+01H],A
a71d: 09 f0 1c fd  MOV     A,!0FD1CH
a721: 55           MOV     [HL],A
a722: 09 f0 1d fd  MOV     A,!0FD1DH
a726: 06 a0 01     MOV     [HL+01H],A
a729: 3a ae 00     MOV     0FEAEH,#00H
a72c: 3a ad 20     MOV     0FEADH,#20H
a72f: 05 e3        MOVW    AX,[HL]
a731: 2f 20 02     CMPW    AX,#0220H
a734: 82 06        BNC     $0A73CH
a736: 3a ad a0     MOV     0FEADH,#0A0H
a739: 3a ae 80     MOV     0FEAEH,#80H
a73c: 05 e3        MOVW    AX,[HL]
a73e: 2f 50 01     CMPW    AX,#0150H
a741: 82 06        BNC     $0A749H
a743: 3a ad 60     MOV     0FEADH,#60H
a746: 3a ae 40     MOV     0FEAEH,#40H
a749: 05 e3        MOVW    AX,[HL]
a74b: 2f 05 01     CMPW    AX,#0105H
a74e: 82 03        BNC     $0A753H
a750: 3a ad e0     MOV     0FEADH,#0E0H
a753: 05 e3        MOVW    AX,[HL]
a755: 2f 75 00     CMPW    AX,#0075H
a758: 82 06        BNC     $0A760H
a75a: 3a ad 10     MOV     0FEADH,#10H
a75d: 3a ae 20     MOV     0FEAEH,#20H
a760: 05 e3        MOVW    AX,[HL]
a762: 2f 40 00     CMPW    AX,#0040H
a765: 82 03        BNC     $0A76AH
a767: 3a ad c0     MOV     0FEADH,#0C0H
a76a: 05 e3        MOVW    AX,[HL]
a76c: 2f 25 00     CMPW    AX,#0025H
a76f: 82 03        BNC     $0A774H
a771: 3a ad 40     MOV     0FEADH,#40H
a774: 05 e3        MOVW    AX,[HL]
a776: 2f 15 00     CMPW    AX,#0015H
a779: 82 03        BNC     $0A77EH
a77b: 3a ad 80     MOV     0FEADH,#80H
a77e: 05 e3        MOVW    AX,[HL]
a780: 2f 05 00     CMPW    AX,#0005H
a783: 82 03        BNC     $0A788H
a785: 3a ad 00     MOV     0FEADH,#00H
a788: 7e ad ac     OR      0FEACH,0FEADH
a78b: 64 d2 ff     MOVW    DE,#0FFD2H
a78e: 20 ac        MOV     A,0FEACH
a790: 54           MOV     [DE],A
a791: 08 a0 66 2d  BF      0FE66H.0,$0A7C2H
a795: 1c 63        MOVW    AX,0FE63H
a797: 24 48        MOVW    DE,AX
a799: 06 00 05     MOV     A,[DE+05H]
a79c: 30 b1        SHR     A,6
a79e: ac 03        AND     A,#03H
a7a0: b8 00        MOV     X,#00H
a7a2: ad 03        XOR     A,#03H
a7a4: d8           XCH     A,X
a7a5: 24 28        MOVW    BC,AX
a7a7: 20 ae        MOV     A,0FEAEH
a7a9: b8 00        MOV     X,#00H
a7ab: 8e 21        OR      C,A
a7ad: 8e 30        OR      B,X
a7af: d2           MOV     A,C
a7b0: 22 ac        MOV     0FEACH,A
a7b2: 20 66        MOV     A,0FE66H
a7b4: ac 0c        AND     A,#0CH
a7b6: 9e ac        OR      A,0FEACH
a7b8: 22 ac        MOV     0FEACH,A
a7ba: 20 00        MOV     A,P0
a7bc: ac 10        AND     A,#10H
a7be: 9e ac        OR      A,0FEACH
a7c0: 22 00        MOV     P0,A
a7c2: 34           POP     AX
a7c3: 34           POP     AX
a7c4: 1a ae        MOVW    0FEAEH,AX
a7c6: 34           POP     AX
a7c7: 1a ac        MOVW    0FEACH,AX
a7c9: 37           POP     HL
a7ca: 56           RET
a7cb: 4a           DI
a7cc: 3f           PUSH    HL
a7cd: 1c ac        MOVW    AX,0FEACH
a7cf: 3c           PUSH    AX
a7d0: 05 c9        DECW    SP
a7d2: 05 c9        DECW    SP
a7d4: 11 fc        MOVW    AX,SP
a7d6: 24 68        MOVW    HL,AX
a7d8: 3a ac 00     MOV     0FEACH,#00H
a7db: 08 a5 69 03  BF      0FE69H.5,$0A7E2H
a7df: 3a ac 01     MOV     0FEACH,#01H
a7e2: 20 75        MOV     A,Wheel_Count
a7e4: 55           MOV     [HL],A
a7e5: b9 00        MOV     A,#00H
a7e7: 06 a0 01     MOV     [HL+01H],A
a7ea: 3a 75 00     MOV     Wheel_Count,#00H
a7ed: 4b           EI
a7ee: 5d           MOV     A,[HL]
a7ef: af 00        CMP     A,#00H
a7f1: 80 03        BNZ     $0A7F6H
a7f3: 2c 59 aa     BR      !0AA59H
a7f6: 6f 88 00     CMP     0FE88H,#00H
a7f9: 81 03        BZ      $0A7FEH
a7fb: 3a 88 01     MOV     0FE88H,#01H
a7fe: b9 00        MOV     A,#00H
a800: 9f 7f        CMP     A,0FE7FH
a802: 82 03        BNC     $0A807H
a804: 3a 7f 90     MOV     0FE7FH,#90H
a807: 08 a7 66 08  BF      0FE66H.7,$0A813H
a80b: a7 66        CLR1    0FE66H.7
a80d: 3a 86 01     MOV     0FE86H,#01H
a810: 2c 59 aa     BR      !0AA59H
a813: 08 a2 7d 23  BF      0FE7DH.2,$0A83AH
a817: 6f ac 01     CMP     0FEACH,#01H
a81a: 80 05        BNZ     $0A821H
a81c: 60 01 00     MOVW    AX,#0001H
a81f: 14 03        BR      $0A824H
a821: 60 ff 00     MOVW    AX,#00FFH
a824: 64 0b fd     MOVW    DE,#0FD0BH
a827: 5c           MOV     A,[DE]
a828: 88 10        ADD     A,X
a82a: 54           MOV     [DE],A
a82b: 09 f0 b3 fd  MOV     A,!0FDB3H
a82f: ad ff        XOR     A,#0FFH
a831: a8 05        ADD     A,#05H
a833: 09 f1 b3 fd  MOV     !0FDB3H,A
a837: 2c 59 aa     BR      !0AA59H
a83a: 75 67 03     BT      0FE67H.5,$0A840H
a83d: 2c c4 a8     BR      !0A8C4H
a840: 3a 7e 10     MOV     0FE7EH,#10H
a843: 64 aa fd     MOVW    DE,#0FDAAH
a846: 5c           MOV     A,[DE]
a847: c1           INC     A
a848: 54           MOV     [DE],A
a849: b8 03        MOV     X,#03H
a84b: 8f 01        CMP     X,A
a84d: 82 72        BNC     $0A8C1H
a84f: b9 00        MOV     A,#00H
a851: 09 f1 aa fd  MOV     !0FDAAH,A
a855: 09 f0 a9 fd  MOV     A,!0FDA9H
a859: b8 00        MOV     X,#00H
a85b: d8           XCH     A,X
a85c: 2d ab fd     ADDW    AX,#0FDABH
a85f: 24 48        MOVW    DE,AX
a861: 5c           MOV     A,[DE]
a862: af ff        CMP     A,#0FFH
a864: 80 0f        BNZ     $0A875H
a866: 09 f0 a9 fd  MOV     A,!0FDA9H
a86a: b8 00        MOV     X,#00H
a86c: d8           XCH     A,X
a86d: 2d ab fd     ADDW    AX,#0FDABH
a870: 24 48        MOVW    DE,AX
a872: b9 0a        MOV     A,#0AH
a874: 54           MOV     [DE],A
a875: 6f ac 01     CMP     0FEACH,#01H
a878: 80 05        BNZ     $0A87FH
a87a: 60 01 00     MOVW    AX,#0001H
a87d: 14 03        BR      $0A882H
a87f: 60 ff 00     MOVW    AX,#00FFH
a882: 24 28        MOVW    BC,AX
a884: 09 f0 a9 fd  MOV     A,!0FDA9H
a888: b8 00        MOV     X,#00H
a88a: d8           XCH     A,X
a88b: 2d ab fd     ADDW    AX,#0FDABH
a88e: 24 48        MOVW    DE,AX
a890: d2           MOV     A,C
a891: 16 48        ADD     A,[DE]
a893: 54           MOV     [DE],A
a894: 09 f0 a9 fd  MOV     A,!0FDA9H
a898: b8 00        MOV     X,#00H
a89a: d8           XCH     A,X
a89b: 2d ab fd     ADDW    AX,#0FDABH
a89e: 24 48        MOVW    DE,AX
a8a0: 5c           MOV     A,[DE]
a8a1: af 26        CMP     A,#26H
a8a3: 83 1c        BC      $0A8C1H
a8a5: 6f ac 01     CMP     0FEACH,#01H
a8a8: 80 04        BNZ     $0A8AEH
a8aa: 8a 08        SUBW    AX,AX
a8ac: 14 03        BR      $0A8B1H
a8ae: 60 25 00     MOVW    AX,#0025H
a8b1: 24 28        MOVW    BC,AX
a8b3: 09 f0 a9 fd  MOV     A,!0FDA9H
a8b7: b8 00        MOV     X,#00H
a8b9: d8           XCH     A,X
a8ba: 2d ab fd     ADDW    AX,#0FDABH
a8bd: 24 48        MOVW    DE,AX
a8bf: d2           MOV     A,C
a8c0: 54           MOV     [DE],A
a8c1: 2c 59 aa     BR      !0AA59H
a8c4: 08 a5 65 2b  BF      0FE65H.5,$0A8F3H
a8c8: 74 65 28     BT      0FE65H.4,$0A8F3H
a8cb: 64 aa fd     MOVW    DE,#0FDAAH
a8ce: 5c           MOV     A,[DE]
a8cf: c1           INC     A
a8d0: 54           MOV     [DE],A
a8d1: b8 03        MOV     X,#03H
a8d3: 8f 01        CMP     X,A
a8d5: 82 19        BNC     $0A8F0H
a8d7: b9 00        MOV     A,#00H
a8d9: 09 f1 aa fd  MOV     !0FDAAH,A
a8dd: 6f ac 01     CMP     0FEACH,#01H
a8e0: 80 05        BNZ     $0A8E7H
a8e2: 28 17 7e     CALL    !7E17H
a8e5: 14 03        BR      $0A8EAH
a8e7: 28 54 7e     CALL    !7E54H
a8ea: 28 43 7d     CALL    !7D43H
a8ed: 28 16 20     CALL    !2016H
a8f0: 2c 59 aa     BR      !0AA59H
a8f3: 09 f0 0c fd  MOV     A,!0FD0CH
a8f7: 30 b9        SHR     A,7
a8f9: ac 01        AND     A,#01H
a8fb: b8 00        MOV     X,#00H
a8fd: d8           XCH     A,X
a8fe: 2f 00 00     CMPW    AX,#0000H
a901: 80 05        BNZ     $0A908H
a903: 60 0a 00     MOVW    AX,#000AH
a906: 14 03        BR      $0A90BH
a908: 60 64 00     MOVW    AX,#0064H
a90b: 24 28        MOVW    BC,AX
a90d: 09 f0 0c fd  MOV     A,!0FD0CH
a911: ac 80        AND     A,#80H
a913: 8e 12        OR      A,C
a915: 09 f1 0c fd  MOV     !0FD0CH,A
a919: 08 a5 65 04  BF      0FE65H.5,$0A921H
a91d: a5 65        CLR1    0FE65H.5
a91f: b1 68        SET1    0FE68H.1
a921: b9 09        MOV     A,#09H
a923: 16 5f        CMP     A,[HL]
a925: 82 03        BNC     $0A92AH
a927: b9 09        MOV     A,#09H
a929: 55           MOV     [HL],A
a92a: 5d           MOV     A,[HL]
a92b: d8           XCH     A,X
a92c: 5d           MOV     A,[HL]
a92d: 05 08        MULU    X
a92f: d0           MOV     A,X
a930: 55           MOV     [HL],A
a931: b9 01        MOV     A,#01H
a933: 16 5f        CMP     A,[HL]
a935: 83 03        BC      $0A93AH
a937: 2c 48 a9     BR      !0A948H
a93a: 5d           MOV     A,[HL]
a93b: 16 58        ADD     A,[HL]
a93d: 0e           ADJBA
a93e: 55           MOV     [HL],A
a93f: 06 20 01     MOV     A,[HL+01H]
a942: a9 00        ADDC    A,#00H
a944: 0e           ADJBA
a945: 06 a0 01     MOV     [HL+01H],A
a948: 3a ad 01     MOV     0FEADH,#01H
a94b: 09 f0 a3 fd  MOV     A,!0FDA3H
a94f: af 02        CMP     A,#02H
a951: 80 09        BNZ     $0A95CH
a953: 05 e3        MOVW    AX,[HL]
a955: 31 e0        SHLW    AX,4
a957: 06 a0 01     MOV     [HL+01H],A
a95a: d8           XCH     A,X
a95b: 55           MOV     [HL],A
a95c: 09 f0 a3 fd  MOV     A,!0FDA3H
a960: af 04        CMP     A,#04H
a962: 80 4a        BNZ     $0A9AEH
a964: 20 ac        MOV     A,0FEACH
a966: b8 00        MOV     X,#00H
a968: d8           XCH     A,X
a969: 3c           PUSH    AX
a96a: 28 4e 97     CALL    !974EH
a96d: 34           POP     AX
a96e: 24 0a        MOVW    AX,BC
a970: 2f 01 00     CMPW    AX,#0001H
a973: 80 27        BNZ     $0A99CH
a975: 08 a6 65 23  BF      0FE65H.6,$0A99CH
a979: 08 a4 66 0b  BF      0FE66H.4,$0A988H
a97d: 05 e3        MOVW    AX,[HL]
a97f: 31 e0        SHLW    AX,4
a981: 06 a0 01     MOV     [HL+01H],A
a984: d8           XCH     A,X
a985: 55           MOV     [HL],A
a986: 14 12        BR      $0A99AH
a988: 05 e3        MOVW    AX,[HL]
a98a: 1a a4        MOVW    0FEA4H,AX
a98c: 0c a6 09 00  MOVW    0FEA6H,#0009H
a990: 28 f7 ab     CALL    Multiply_Thing
a993: 1c a4        MOVW    AX,0FEA4H
a995: 06 a0 01     MOV     [HL+01H],A
a998: d8           XCH     A,X
a999: 55           MOV     [HL],A
a99a: 14 12        BR      $0A9AEH
a99c: 05 e3        MOVW    AX,[HL]
a99e: 1a a4        MOVW    0FEA4H,AX
a9a0: 0c a6 05 00  MOVW    0FEA6H,#0005H
a9a4: 28 f7 ab     CALL    Multiply_Thing
a9a7: 1c a4        MOVW    AX,0FEA4H
a9a9: 06 a0 01     MOV     [HL+01H],A
a9ac: d8           XCH     A,X
a9ad: 55           MOV     [HL],A
a9ae: 09 f0 a3 fd  MOV     A,!0FDA3H
a9b2: af 03        CMP     A,#03H
a9b4: 83 03        BC      $0A9B9H
a9b6: 3a ad 02     MOV     0FEADH,#02H
a9b9: 6f ac 01     CMP     0FEACH,#01H
a9bc: 81 03        BZ      $0A9C1H
a9be: 2c fb a9     BR      !0A9FBH
a9c1: 64 63 fe     MOVW    DE,#0FE63H
a9c4: 05 e2        MOVW    AX,[DE]
a9c6: 24 48        MOVW    DE,AX
a9c8: 20 ad        MOV     A,0FEADH
a9ca: b8 00        MOV     X,#00H
a9cc: d8           XCH     A,X
a9cd: 88 0c        ADDW    AX,DE
a9cf: 24 48        MOVW    DE,AX
a9d1: 5d           MOV     A,[HL]
a9d2: 16 48        ADD     A,[DE]
a9d4: 0e           ADJBA
a9d5: 54           MOV     [DE],A
a9d6: 06 20 01     MOV     A,[HL+01H]
a9d9: 06 09 01     ADDC    A,[DE+01H]
a9dc: 0e           ADJBA
a9dd: 06 80 01     MOV     [DE+01H],A
a9e0: 49           PUSH    PSW
a9e1: 46           INCW    DE
a9e2: 20 ad        MOV     A,0FEADH
a9e4: c1           INC     A
a9e5: 22 ad        MOV     0FEADH,A
a9e7: b8 04        MOV     X,#04H
a9e9: 8f 01        CMP     X,A
a9eb: 81 0a        BZ      $0A9F7H
a9ed: 46           INCW    DE
a9ee: 5c           MOV     A,[DE]
a9ef: 48           POP     PSW
a9f0: a9 00        ADDC    A,#00H
a9f2: 0e           ADJBA
a9f3: 49           PUSH    PSW
a9f4: 54           MOV     [DE],A
a9f5: 14 eb        BR      $0A9E2H
a9f7: 48           POP     PSW
a9f8: 2c 32 aa     BR      !0AA32H
a9fb: 64 63 fe     MOVW    DE,#0FE63H
a9fe: 05 e2        MOVW    AX,[DE]
aa00: 24 48        MOVW    DE,AX
aa02: 20 ad        MOV     A,0FEADH
aa04: b8 00        MOV     X,#00H
aa06: d8           XCH     A,X
aa07: 88 0c        ADDW    AX,DE
aa09: 24 48        MOVW    DE,AX
aa0b: 5c           MOV     A,[DE]
aa0c: 16 5a        SUB     A,[HL]
aa0e: 0f           ADJBS
aa0f: 54           MOV     [DE],A
aa10: 06 00 01     MOV     A,[DE+01H]
aa13: 06 2b 01     SUBC    A,[HL+01H]
aa16: 0f           ADJBS
aa17: 06 80 01     MOV     [DE+01H],A
aa1a: 49           PUSH    PSW
aa1b: 46           INCW    DE
aa1c: 20 ad        MOV     A,0FEADH
aa1e: c1           INC     A
aa1f: 22 ad        MOV     0FEADH,A
aa21: b8 04        MOV     X,#04H
aa23: 8f 01        CMP     X,A
aa25: 81 0a        BZ      $0AA31H
aa27: 46           INCW    DE
aa28: 5c           MOV     A,[DE]
aa29: 48           POP     PSW
aa2a: ab 00        SUBC    A,#00H
aa2c: 0f           ADJBS
aa2d: 49           PUSH    PSW
aa2e: 54           MOV     [DE],A
aa2f: 14 eb        BR      $0AA1CH
aa31: 48           POP     PSW
aa32: 09 f0 a3 fd  MOV     A,!0FDA3H
aa36: af 04        CMP     A,#04H
aa38: 80 0a        BNZ     $0AA44H
aa3a: 20 ac        MOV     A,0FEACH
aa3c: b8 00        MOV     X,#00H
aa3e: d8           XCH     A,X
aa3f: 3c           PUSH    AX
aa40: 28 96 aa     CALL    !0AA96H
aa43: 34           POP     AX
aa44: 20 ac        MOV     A,0FEACH
aa46: b8 00        MOV     X,#00H
aa48: d8           XCH     A,X
aa49: 3c           PUSH    AX
aa4a: 28 78 8e     CALL    !8E78H
aa4d: 34           POP     AX
aa4e: 28 5f aa     CALL    !0AA5FH
aa51: b2 68        SET1    0FE68H.2
aa53: b4 68        SET1    0FE68H.4
aa55: b3 68        SET1    0FE68H.3
aa57: b1 68        SET1    0FE68H.1
aa59: 34           POP     AX
aa5a: 34           POP     AX
aa5b: 1a ac        MOVW    0FEACH,AX
aa5d: 37           POP     HL
aa5e: 56           RET
aa5f: b9 00        MOV     A,#00H
aa61: 9f 89        CMP     A,0FE89H
aa63: 82 05        BNC     $0AA6AH
aa65: 28 83 aa     CALL    !0AA83H
aa68: 14 18        BR      $0AA82H
aa6a: 1c 63        MOVW    AX,0FE63H
aa6c: 24 08        MOVW    AX,AX
aa6e: 44           INCW    AX
aa6f: 24 48        MOVW    DE,AX
aa71: 5c           MOV     A,[DE]
aa72: 22 6a        MOV     0FE6AH,A
aa74: 1c 63        MOVW    AX,0FE63H
aa76: 24 08        MOVW    AX,AX
aa78: 44           INCW    AX
aa79: 44           INCW    AX
aa7a: 24 48        MOVW    DE,AX
aa7c: 5c           MOV     A,[DE]
aa7d: 22 6b        MOV     0FE6BH,A
aa7f: 28 83 aa     CALL    !0AA83H
aa82: 56           RET
aa83: 09 f0 a3 fd  MOV     A,!0FDA3H
aa87: af 03        CMP     A,#03H
aa89: 83 07        BC      $0AA92H
aa8b: 81 05        BZ      $0AA92H
aa8d: 28 2b 92     CALL    !922BH
aa90: 14 03        BR      $0AA95H
aa92: 28 32 92     CALL    !9232H
aa95: 56           RET
aa96: 3f           PUSH    HL
aa97: 1c ac        MOVW    AX,0FEACH
aa99: 3c           PUSH    AX
aa9a: 11 fc        MOVW    AX,SP
aa9c: 24 68        MOVW    HL,AX
aa9e: 1c 63        MOVW    AX,0FE63H
aaa0: 24 48        MOVW    DE,AX
aaa2: 60 01 00     MOVW    AX,#0001H
aaa5: 88 0c        ADDW    AX,DE
aaa7: 24 48        MOVW    DE,AX
aaa9: 5c           MOV     A,[DE]
aaaa: 22 6c        MOV     0FE6CH,A
aaac: 1c 63        MOVW    AX,0FE63H
aaae: 24 48        MOVW    DE,AX
aab0: 60 01 00     MOVW    AX,#0001H
aab3: 88 0c        ADDW    AX,DE
aab5: 44           INCW    AX
aab6: 24 48        MOVW    DE,AX
aab8: 5c           MOV     A,[DE]
aab9: ac 0f        AND     A,#0FH
aabb: 22 6d        MOV     0FE6DH,A
aabd: 1c 63        MOVW    AX,0FE63H
aabf: 24 48        MOVW    DE,AX
aac1: 60 01 00     MOVW    AX,#0001H
aac4: 88 0c        ADDW    AX,DE
aac6: 24 48        MOVW    DE,AX
aac8: b9 00        MOV     A,#00H
aaca: 54           MOV     [DE],A
aacb: 06 20 06     MOV     A,[HL+06H]
aace: b8 00        MOV     X,#00H
aad0: d8           XCH     A,X
aad1: 3c           PUSH    AX
aad2: 28 4e 97     CALL    !974EH
aad5: 34           POP     AX
aad6: 24 0a        MOVW    AX,BC
aad8: 2f 01 00     CMPW    AX,#0001H
aadb: 80 62        BNZ     $0AB3FH
aadd: 08 a4 66 26  BF      0FE66H.4,$0AB07H
aae1: 8a 08        SUBW    AX,AX
aae3: 1f 6c        CMPW    AX,0FE6CH
aae5: 81 1e        BZ      $0AB05H
aae7: 1c 63        MOVW    AX,0FE63H
aae9: 24 48        MOVW    DE,AX
aaeb: 60 01 00     MOVW    AX,#0001H
aaee: 88 0c        ADDW    AX,DE
aaf0: 44           INCW    AX
aaf1: 24 48        MOVW    DE,AX
aaf3: b9 f0        MOV     A,#0F0H
aaf5: 16 4c        AND     A,[DE]
aaf7: 54           MOV     [DE],A
aaf8: 06 20 06     MOV     A,[HL+06H]
aafb: af 00        CMP     A,#00H
aafd: 80 06        BNZ     $0AB05H
aaff: 3a 6a 10     MOV     0FE6AH,#10H
ab02: 28 c0 20     CALL    !20C0H
ab05: 14 35        BR      $0AB3CH
ab07: 28 9b 9d     CALL    !9D9BH
ab0a: bb 00        MOV     B,#00H
ab0c: bc 09        MOV     E,#09H
ab0e: 24 0a        MOVW    AX,BC
ab10: 05 1c        DIVUW   E
ab12: d4           MOV     A,E
ab13: 22 ac        MOV     0FEACH,A
ab15: 6f ac 00     CMP     0FEACH,#00H
ab18: 81 22        BZ      $0AB3CH
ab1a: 14 15        BR      $0AB31H
ab1c: 38 ac 6a     MOV     0FE6AH,0FEACH
ab1f: 28 f1 20     CALL    !Decimal_Subtract
ab22: 14 18        BR      $0AB3CH
ab24: b9 09        MOV     A,#09H
ab26: 9a ac        SUB     A,0FEACH
ab28: 22 6a        MOV     0FE6AH,A
ab2a: 28 c0 20     CALL    !20C0H
ab2d: 14 0d        BR      $0AB3CH
ab2f: 14 0b        BR      $0AB3CH
ab31: 06 20 06     MOV     A,[HL+06H]
ab34: af 00        CMP     A,#00H
ab36: 81 ec        BZ      $0AB24H
ab38: af 01        CMP     A,#01H
ab3a: 81 e0        BZ      $0AB1CH
ab3c: 2c e5 ab     BR      !0ABE5H
ab3f: 6f 6c 00     CMP     0FE6CH,#00H
ab42: 80 10        BNZ     $0AB54H
ab44: 6f 6d 00     CMP     0FE6DH,#00H
ab47: 80 03        BNZ     $0AB4CH
ab49: 2c e5 ab     BR      !0ABE5H
ab4c: 6f 6d 05     CMP     0FE6DH,#05H
ab4f: 80 03        BNZ     $0AB54H
ab51: 2c e5 ab     BR      !0ABE5H
ab54: 2c d7 ab     BR      !0ABD7H
ab57: 6f 6d 00     CMP     0FE6DH,#00H
ab5a: 81 40        BZ      $0AB9CH
ab5c: 6f 6d 01     CMP     0FE6DH,#01H
ab5f: 83 19        BC      $0AB7AH
ab61: b9 04        MOV     A,#04H
ab63: 9f 6d        CMP     A,0FE6DH
ab65: 83 13        BC      $0AB7AH
ab67: 1c 63        MOVW    AX,0FE63H
ab69: 24 48        MOVW    DE,AX
ab6b: 60 01 00     MOVW    AX,#0001H
ab6e: 88 0c        ADDW    AX,DE
ab70: 44           INCW    AX
ab71: 24 48        MOVW    DE,AX
ab73: b9 f0        MOV     A,#0F0H
ab75: 16 4c        AND     A,[DE]
ab77: 54           MOV     [DE],A
ab78: 14 22        BR      $0AB9CH
ab7a: 1c 63        MOVW    AX,0FE63H
ab7c: 24 48        MOVW    DE,AX
ab7e: 60 01 00     MOVW    AX,#0001H
ab81: 88 0c        ADDW    AX,DE
ab83: 44           INCW    AX
ab84: 24 48        MOVW    DE,AX
ab86: b9 f0        MOV     A,#0F0H
ab88: 16 4c        AND     A,[DE]
ab8a: 54           MOV     [DE],A
ab8b: 1c 63        MOVW    AX,0FE63H
ab8d: 24 48        MOVW    DE,AX
ab8f: 60 01 00     MOVW    AX,#0001H
ab92: 88 0c        ADDW    AX,DE
ab94: 44           INCW    AX
ab95: 24 48        MOVW    DE,AX
ab97: b9 05        MOV     A,#05H
ab99: 16 4e        OR      A,[DE]
ab9b: 54           MOV     [DE],A
ab9c: 14 47        BR      $0ABE5H
ab9e: 1c 63        MOVW    AX,0FE63H
aba0: 24 48        MOVW    DE,AX
aba2: 60 01 00     MOVW    AX,#0001H
aba5: 88 0c        ADDW    AX,DE
aba7: 44           INCW    AX
aba8: 24 48        MOVW    DE,AX
abaa: b9 f0        MOV     A,#0F0H
abac: 16 4c        AND     A,[DE]
abae: 54           MOV     [DE],A
abaf: 8a 08        SUBW    AX,AX
abb1: 1f 6c        CMPW    AX,0FE6CH
abb3: 81 20        BZ      $0ABD5H
abb5: 60 00 05     MOVW    AX,#0500H
abb8: 1f 6c        CMPW    AX,0FE6CH
abba: 82 08        BNC     $0ABC4H
abbc: 3a 6a 10     MOV     0FE6AH,#10H
abbf: 28 c0 20     CALL    !20C0H
abc2: 14 11        BR      $0ABD5H
abc4: 1c 63        MOVW    AX,0FE63H
abc6: 24 48        MOVW    DE,AX
abc8: 60 01 00     MOVW    AX,#0001H
abcb: 88 0c        ADDW    AX,DE
abcd: 44           INCW    AX
abce: 24 48        MOVW    DE,AX
abd0: b9 05        MOV     A,#05H
abd2: 16 4e        OR      A,[DE]
abd4: 54           MOV     [DE],A
abd5: 14 0e        BR      $0ABE5H
abd7: 06 20 06     MOV     A,[HL+06H]
abda: af 00        CMP     A,#00H
abdc: 81 c0        BZ      $0AB9EH
abde: af 01        CMP     A,#01H
abe0: 80 03        BNZ     $0ABE5H
abe2: 2c 57 ab     BR      !0AB57H
abe5: 34           POP     AX
abe6: 1a ac        MOVW    0FEACH,AX
abe8: 37           POP     HL
abe9: 56           RET
Compare_32Bits:
abea: 3c           PUSH    AX            ; compare High order word first
abeb: 1c a6        MOVW    AX,0FEA6H
abed: 1f aa        CMPW    AX,0FEAAH
abef: 80 04        BNZ     $0ABF5H       ; if not equal, skip to cleanup
abf1: 1c a4        MOVW    AX,0FEA4H     ; otherwise compare lower order word
abf3: 1f a8        CMPW    AX,0FEA8H
abf5: 34           POP     AX
abf6: 56           RET
Multiply_Thing:
abf7: 3c           PUSH    AX
abf8: 3e           PUSH    DE
abf9: 20 a4        MOV     A,0FEA4H
abfb: d8           XCH     A,X
abfc: 20 a6        MOV     A,0FEA6H
abfe: 05 08        MULU    X
ac00: 24 48        MOVW    DE,AX
ac02: 20 a4        MOV     A,0FEA4H
ac04: d8           XCH     A,X
ac05: 20 a7        MOV     A,0FEA7H
ac07: 05 08        MULU    X
ac09: 88 50        ADD     D,X
ac0b: 20 a5        MOV     A,0FEA5H
ac0d: d8           XCH     A,X
ac0e: 20 a6        MOV     A,0FEA6H
ac10: 05 08        MULU    X
ac12: 88 50        ADD     D,X
ac14: 24 0c        MOVW    AX,DE
ac16: 1a a4        MOVW    0FEA4H,AX
ac18: 36           POP     DE
ac19: 34           POP     AX
ac1a: 56           RET
ac1b: 3c           PUSH    AX
ac1c: 3d           PUSH    BC
ac1d: 3e           PUSH    DE
ac1e: 8a 08        SUBW    AX,AX
ac20: 1f a6        CMPW    AX,0FEA6H
ac22: 80 05        BNZ     $0AC29H
ac24: 60 ff ff     MOVW    AX,#0FFFFH
ac27: 14 1a        BR      $0AC43H
ac29: ba 10        MOV     C,#10H
ac2b: 1c a4        MOVW    AX,0FEA4H
ac2d: 24 48        MOVW    DE,AX
ac2f: 60 00 00     MOVW    AX,#0000H
ac32: 31 cc        SHLW    DE,1
ac34: 31 08        ROLC    X,1
ac36: 31 09        ROLC    A,1
ac38: 1f a6        CMPW    AX,0FEA6H
ac3a: 83 03        BC      $0AC3FH
ac3c: 1e a6        SUBW    AX,0FEA6H
ac3e: 46           INCW    DE
ac3f: 32 f1        DBNZ    C,$0AC32H
ac41: 24 0c        MOVW    AX,DE
ac43: 1a a4        MOVW    0FEA4H,AX
ac45: 36           POP     DE
ac46: 35           POP     BC
ac47: 34           POP     AX
ac48: 56           RET
ac49: 00           NOP
ac4a: 00           NOP
ac4b: 00           NOP
ac4c: 00           NOP
ac4d: 00           NOP
ac4e: 00           NOP
ac4f: 00           NOP
ac50: 00           NOP
ac51: 00           NOP
ac52: 00           NOP
ac53: 00           NOP
ac54: 00           NOP
ac55: 00           NOP
ac56: 00           NOP
ac57: 00           NOP
ac58: 00           NOP
ac59: 00           NOP
ac5a: 00           NOP
ac5b: 00           NOP
ac5c: 00           NOP
ac5d: 00           NOP
ac5e: 00           NOP
ac5f: 00           NOP
ac60: 00           NOP
ac61: 00           NOP
ac62: 00           NOP
ac63: 00           NOP
ac64: 00           NOP
ac65: 00           NOP
ac66: 00           NOP
ac67: 00           NOP
ac68: 00           NOP
ac69: 00           NOP
ac6a: 00           NOP
ac6b: 00           NOP
ac6c: 00           NOP
ac6d: 00           NOP
ac6e: 00           NOP
ac6f: 00           NOP
ac70: 00           NOP
ac71: 00           NOP
ac72: 00           NOP
ac73: 00           NOP
ac74: 00           NOP
ac75: 00           NOP
ac76: 00           NOP
ac77: 00           NOP
ac78: 00           NOP
ac79: 00           NOP
ac7a: 00           NOP
ac7b: 00           NOP
ac7c: 00           NOP
ac7d: 00           NOP
ac7e: 00           NOP
ac7f: 00           NOP
ac80: 00           NOP
ac81: 00           NOP
ac82: 00           NOP
ac83: 00           NOP
ac84: 00           NOP
ac85: 00           NOP
ac86: 00           NOP
ac87: 00           NOP
ac88: 00           NOP
ac89: 00           NOP
ac8a: 00           NOP
ac8b: 00           NOP
ac8c: 00           NOP
ac8d: 00           NOP
ac8e: 00           NOP
ac8f: 00           NOP
ac90: 00           NOP
ac91: 00           NOP
ac92: 00           NOP
ac93: 00           NOP
ac94: 00           NOP
ac95: 00           NOP
ac96: 00           NOP
ac97: 00           NOP
ac98: 00           NOP
ac99: 00           NOP
ac9a: 00           NOP
ac9b: 00           NOP
ac9c: 00           NOP
ac9d: 00           NOP
ac9e: 00           NOP
ac9f: 00           NOP
aca0: 00           NOP
aca1: 00           NOP
aca2: 00           NOP
aca3: 00           NOP
aca4: 00           NOP
aca5: 00           NOP
aca6: 00           NOP
aca7: 00           NOP
aca8: 00           NOP
aca9: 00           NOP
acaa: 00           NOP
acab: 00           NOP
acac: 00           NOP
acad: 00           NOP
acae: 00           NOP
acaf: 00           NOP
acb0: 00           NOP
acb1: 00           NOP
acb2: 00           NOP
acb3: 00           NOP
acb4: 00           NOP
acb5: 00           NOP
acb6: 00           NOP
acb7: 00           NOP
acb8: 00           NOP
acb9: 00           NOP
acba: 00           NOP
acbb: 00           NOP
acbc: 00           NOP
acbd: 00           NOP
acbe: 00           NOP
acbf: 00           NOP
acc0: 00           NOP
acc1: 00           NOP
acc2: 00           NOP
acc3: 00           NOP
acc4: 00           NOP
acc5: 00           NOP
acc6: 00           NOP
acc7: 00           NOP
acc8: 00           NOP
acc9: 00           NOP
acca: 00           NOP
accb: 00           NOP
accc: 00           NOP
accd: 00           NOP
acce: 00           NOP
accf: 00           NOP
acd0: 00           NOP
acd1: 00           NOP
acd2: 00           NOP
acd3: 00           NOP
acd4: 00           NOP
acd5: 00           NOP
acd6: 00           NOP
acd7: 00           NOP
acd8: 00           NOP
acd9: 00           NOP
acda: 00           NOP
acdb: 00           NOP
acdc: 00           NOP
acdd: 00           NOP
acde: 00           NOP
acdf: 00           NOP
ace0: 00           NOP
ace1: 00           NOP
ace2: 00           NOP
ace3: 00           NOP
ace4: 00           NOP
ace5: 00           NOP
ace6: 00           NOP
ace7: 00           NOP
ace8: 00           NOP
ace9: 00           NOP
acea: 00           NOP
aceb: 00           NOP
acec: 00           NOP
aced: 00           NOP
acee: 00           NOP
acef: 00           NOP
acf0: 00           NOP
acf1: 00           NOP
acf2: 00           NOP
acf3: 00           NOP
acf4: 00           NOP
acf5: 00           NOP
acf6: 00           NOP
acf7: 00           NOP
acf8: 00           NOP
acf9: 00           NOP
acfa: 00           NOP
acfb: 00           NOP
acfc: 00           NOP
acfd: 00           NOP
acfe: 00           NOP
acff: 00           NOP
ad00: 00           NOP
ad01: 00           NOP
ad02: 00           NOP
ad03: 00           NOP
ad04: 00           NOP
ad05: 00           NOP
ad06: 00           NOP
ad07: 00           NOP
ad08: 00           NOP
ad09: 00           NOP
ad0a: 00           NOP
ad0b: 00           NOP
ad0c: 00           NOP
ad0d: 00           NOP
ad0e: 00           NOP
ad0f: 00           NOP
ad10: 00           NOP
ad11: 00           NOP
ad12: 00           NOP
ad13: 00           NOP
ad14: 00           NOP
ad15: 00           NOP
ad16: 00           NOP
ad17: 00           NOP
ad18: 00           NOP
ad19: 00           NOP
ad1a: 00           NOP
ad1b: 00           NOP
ad1c: 00           NOP
ad1d: 00           NOP
ad1e: 00           NOP
ad1f: 00           NOP
ad20: 00           NOP
ad21: 00           NOP
ad22: 00           NOP
ad23: 00           NOP
ad24: 00           NOP
ad25: 00           NOP
ad26: 00           NOP
ad27: 00           NOP
ad28: 00           NOP
ad29: 00           NOP
ad2a: 00           NOP
ad2b: 00           NOP
ad2c: 00           NOP
ad2d: 00           NOP
ad2e: 00           NOP
ad2f: 00           NOP
ad30: 00           NOP
ad31: 00           NOP
ad32: 00           NOP
ad33: 00           NOP
ad34: 00           NOP
ad35: 00           NOP
ad36: 00           NOP
ad37: 00           NOP
ad38: 00           NOP
ad39: 00           NOP
ad3a: 00           NOP
ad3b: 00           NOP
ad3c: 00           NOP
ad3d: 00           NOP
ad3e: 00           NOP
ad3f: 00           NOP
ad40: 00           NOP
ad41: 00           NOP
ad42: 00           NOP
ad43: 00           NOP
ad44: 00           NOP
ad45: 00           NOP
ad46: 00           NOP
ad47: 00           NOP
ad48: 00           NOP
ad49: 00           NOP
ad4a: 00           NOP
ad4b: 00           NOP
ad4c: 00           NOP
ad4d: 00           NOP
ad4e: 00           NOP
ad4f: 00           NOP
ad50: 00           NOP
ad51: 00           NOP
ad52: 00           NOP
ad53: 00           NOP
ad54: 00           NOP
; ad55-ffff   Empty EPROM (FF)