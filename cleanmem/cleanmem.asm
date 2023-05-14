    processor 6502

    SEG code
    ORG $F000       ; Define the code origin at $F000

Start:
    SEI             ; Disable interrupts
    CLD             ; Disable the BCD decimal math mode
    LDX #$FF        ; Loads the X register with #$FF
    TXS             ; Transfer the X register to the (S)tack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Page Zero region ($00 to $FF)
; Meaning the enitre RAM and also the entire TIA registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDA #0          ; A = 0
    LDX #$FF        ; X = #$FF
    STA $FF
MemLoop:
    DEX             ; X--
    STA $0,X        ; Store the value of A inside memory adress $0 + X
    BNE MemLoop     ; Loop until X is equal to zero (z-flag is set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size to exacty 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ORG $FFFC
    .word Start     ; Reset vector at $FFFC (Where the program starts)
    .word Start     ; Interrupt vector at $FFFE (unused in the VCS)
