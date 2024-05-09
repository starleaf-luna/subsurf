
SECTION "Fade Routines", ROM0

; --------------
; | ROUTINE    |
; --------------
; FadeOutToBlack
; fades screen out with
; method dependant on the
; hardware

FadeOutToBlack::
	ldh a, [hConsoleType]
	and a
	jr nz, .dmg
	; fade here
	ret
	
.dmg:
	ld a, %11100100
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %10010000
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %01000000
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	xor a
	call ApplyDMGPal
	ld c, 3
	jp DelayFrames
	
; --------------
; | ROUTINE    |
; --------------
; FadeInFromBlack
; fades screen in with
; method dependant on the
; hardware

FadeInFromBlack::
	ldh a, [hConsoleType]
	and a
	jr nz, .dmg
	; fade here
	ret
	
.dmg:
	xor a
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %01000000
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %10010000
	call ApplyDMGPal
	ld c, 3
	call DelayFrames
	ld a, %11100100
	call ApplyDMGPal
	ld c, 3
	jp DelayFrames
	
; --------------
; | SUBROUTINE |
; --------------
; ApplyDMGPal
; applies the palettes
; in the DMG way
	
ApplyDMGPal:
	ldh [hBGP], a
	ldh [hOBP0], a
	ldh [hOBP1], a
	ret
	