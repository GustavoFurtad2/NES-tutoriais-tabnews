.segment "HEADER"
.byte $4e, $45, $53, $1a
.byte $02
.byte $01
.byte %00000000
.byte %00000000
.byte $00
.byte $00

.segment "CODE"

.proc irqHandler
    RTI
.endproc

.proc nmiHandler
    RTI
.endproc

.proc resetHandler

    SEI
    CLD
    LDX #$40
    STX $4017
    LDX #$FF
    TXS
    INX
    STX $2000
    STX $2001
    STX $4010
    BIT $2002

vblankwait:

    BIT $2002
    BPL vblankwait

vblankwait2:
    BIT $2002
    BPL vblankwait2
    JMP main
.endproc

.proc main

    LDA $2002

    LDX #$3f
    STX $2006
    LDX #$10
    STX $2006
    LDA #$06
    STA $2007

vblankwait:

    BIT $2002
    BPL vblankwait

forever:

    JMP forever

.endproc

.segment "VECTORS"
.addr nmiHandler, resetHandler, irqHandler

.segment "STARTUP"