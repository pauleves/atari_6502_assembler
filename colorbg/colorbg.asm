    PROCESSOR 6502

    INCLUDE "vcs.h"
    INCLUDE "macro.h"

    SEG code        ; Define a new segment named "Code"
    ORG $F000       ; Define the origin of the ROM code at memory address $F000

START:
    CLEAN_START     ; Macro to safely clear the memory
LOOP:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Set backgorund luminosity colour
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDA #$1E        ; Load colour into ($1E is NTSC yellow)
    STA COLUBK      ; Store A to BackgroundColor Adress $09

    JMP LOOP       ; Repeat from START

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ORG $FFFC       ; Defines origin to $FFFC
    .word START     ; Reset vector at $FFFC (Where prgram starts)
    .word START     ; Interrupt vector at $FFFE (unused in the VCS)
