; Test routines

Start_of_RAM:   equ     0800h
        org     00000h
        jp      Count_to_a_million      ;Get_address     ;Skip over message

        org     0100h
Get_address:
        in      a,(0)           ;Get address from input ports
        ld      l,a
        in      a,(1)
        ld      h,a
        jp      (hl)            ;Jump to the address

Port_Reflector:
        in      a,(0)           ;Simple program to test ports
        out 	(0),a
        in 	a,(1)
        out 	(1),a
        jp 	Port_Reflector

        org     0120h
Simple_Counter:
        ld      a,000h          ;One-byte counter for slow clock
Loop_1:
        out 	(0),a
        inc 	a
        jp 	Loop_1

        org     140h
Count_to_a_million:
        ld      hl, 0000h

Loop_2:
        ld      a,00h           ;Count 256 times, then

Loop_3:
        dec     a
        jp      nz,Loop_3

        inc     hl      ;increment the 16-bit number
        ld      a,l
;        in      a, (0)
        out     (0),a   

        ;Output the 16-bit number
        ld      a,h
        out     (1),a
        
        jp      Loop_2  ;Do it again

