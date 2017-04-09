; Test routines

Start_of_RAM:   equ     0800h
STACK_TOP       equ     0FF0h

        org     00000h
        LD      SP, STACK_TOP
        jp      Get_address     ;Skip over message

        nop
Get_address:
        in      a,(0)           ;Get address from input ports
        cp      0FFh
        jp      Z, Count_to_a_million
        ld      l,a
        in      a,(1)
        ld      h,a
        jp      (hl)            ;Jump to the address

        org     120h
Port_Reflector:
        in      a,(0)           ;Simple program to test ports
        out 	(0),a
        in 	a,(1)
        out 	(1),a
        jp 	Port_Reflector

; Misc incremental counter
        org     0130h
Simple_Counter:
        ld      a,000h          ;One-byte counter for slow clock
Loop_1:
        out 	(0),a
        inc 	a
        jp 	Loop_1

; Primary incremental counter
        org     140h
Count_to_a_million:
        ld      hl, 0000h
        
Loop_2:
        push    hl              ; Test the RAM
        ld      hl, 0A5A5h      ; Mess up hl
        ld      b, 20h
Loop_2b:                        ; Outer loop
        ld      a,00h           ;Count 256 times, then
Loop_3:                         ; Inner loop
        dec     a
        jp      nz,Loop_3
        djnz    Loop_2b
        pop     hl              ; Restore HL from RAM
        inc     hl      ;increment the 16-bit number
        ;Output the 16-bit number
        ld      a,l
;        in      a, (0)
        out     (0),a   
        ld      a,h
        out     (1),a
        jp      Loop_2  ;Do it again

