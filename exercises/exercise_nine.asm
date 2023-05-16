    PROCESSOR 6502
    SEG Code    ; Define a new segment named "Code"
    ORG $F000   ; Define the origin of the ROM code at memory address $F000

Start:
    LDA #1      ; Load A with 1
Loop:
    CLC
    ADC #1      ; Increment A
    CMP #10     ; Compare the value in A with the decimal value 10
    BNE Loop    ; Branch back to loop if the comparison was not equals (to zero)

    JMP Start   ;

    ORG $FFFC ; End the ROM by adding required values to memory position $FFFC
    .word Start ; Put 2 bytes with the reset address at memory position $FFFC
    .word Start ; Put 2 bytes with the break address at memory position $FFFE