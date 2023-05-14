    PROCESSOR 6502
    SEG code
    ORG $F000       ; Define the code origin at $F000

Start:
    LDA #$82
    LDX #82
    LDY $82

    ORG $FFFC
    .word Start     ; Reset vector at $FFFC (Where the program starts)
    .word Start     ; Interrupt vector at $FFFE (unused in the VCS)