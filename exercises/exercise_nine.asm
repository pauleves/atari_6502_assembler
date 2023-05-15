    PROCESSOR 6502
    SEG Code    ; Define a new segment named "Code"
    ORG $F000   ; Define the origin of the ROM code at memory address $F000

Start:
    ; TODO
    JMP Start;

    ORG $FFFC ; End the ROM by adding required values to memory position $FFFC
    .word Start ; Put 2 bytes with the reset address at memory position $FFFC
    .word Start ; Put 2 bytes with the break address at memory position $FFFE