    PROCESSOR 6502
    INCLUDE "vcs.h"
    INCLUDE "macro.h"

    SEG code
    ORG $F000

Start:
    CLEAN_START     ; macro to safely clear memory and TIA

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start a new frame by turning on VBLANK and VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NextFrame:
    LDA #2          ; same as binary value %00000010
    STA VBLANK      ; turn on VBLANK
    STA VSYNC       ; turn on VSYNC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate the three lines of VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    STA WSYNC       ; first scanline
    STA WSYNC       ; second scanline
    STA WSYNC       ; third scanline

    LDA #0
    STA VSYNC       ; turn of VSYNC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Let the TIA output the recommended 37 lines of VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDX #37         ; X = 37 (to count 37 scanlines)
LoopVBlank:
    STA WSYNC       ; hit WSYNC and wait for the next scanline
    DEX             ; X--
    BNE LoopVBlank  ; loop while X != 0

    LDA #0
    STA VBLANK      ; turn off VBLANK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Draw 192 visible scanlines (kernel)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDX #192        ; counter for 192 visible scanlines
LoopVisible:
    STX COLUBK      ; set the background color
    STA WSYNC       ; wait for the next scanline
    DEX             ; X--
    BNE LoopVisible ; loop while X != 0

    LDA #2          ; hit and turn on VBLANK again
    STA VBLANK

    LDX #30         ; counter for 30 scanlines
LoopOverscan:
    STA WSYNC       ; hit WSYNC and wait for the next scanline
    DEX             ; X--
    BNE LoopOverscan  ; loop while X != 0

    JMP NextFrame

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Complete my ROM size to 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ORG $FFFC
    .word Start
    .word Start