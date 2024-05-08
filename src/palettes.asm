SECTION "Palette Tools", ROM0

SetDefaultPalettes::
	ldh a, [hConsoleType]
	and a
	jr z, .cgb
	
	; if we're here, we're not on CGB
	ld a, %11100100
	ldh [hBGP], a
	ldh [hOBP0], a
	ldh [hOBP1], a
	ret
	
.cgb:
	ld hl, DefaultCGBPals
	ld c, 32
	push bc
	call LoadBGPals.cgb ; skip checking console type
	pop bc
	ld hl, DefaultCGBPals.obj
	jr LoadOBJPalsCGB ; skip checking console type
	
; -------------------
; | ROUTINE         |
; -------------------
; LoadBGPals
; the arguments for this one vary
; depending on the system.

; DMG:
; [IN]   D   palettes to write
; [OUT]  A   destroyed

; CGB:
; [IN]   HL  palettes to write
; [IN]   C   how many palette slots to write to
; [OUT]  DE  destroyed
LoadBGPals::
	ldh a, [hConsoleType]
	and a
	jr z, .cgb
	
	ld a, d
	ldh [hBGP], a
	ret
	
.cgb:
	; double the palette slot amount (1 slot = 2 bytes)
	ld a, c
	add c
	ld c, a
	
	ld de, wBGP
.loop:
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret
	
; -------------------
; | ROUTINE         |
; -------------------
; LoadOBJ0Pals
; the arguments for this one vary
; depending on the system.

; DMG:
; [IN]   D   palettes to write
; [OUT]  A   destroyed

; CGB:
; [IN]   HL  palettes to write
; [IN]   C   how many palette slots to write to
; [OUT]  DE  destroyed
LoadOBJ0Pals::
	; failsafe!
	; you're meant to call LoadOBJPalsCGB 
	; on CGB systems instead
	ldh a, [hConsoleType]
	and a
	jr z, LoadOBJPalsCGB
	
	ld a, d
	ldh [hOBP0], a
	ret
	
; -------------------
; | ROUTINE         |
; -------------------
; LoadOBJ1Pals
; the arguments for this one vary
; depending on the system.

; DMG:
; [IN]   D   palettes to write
; [OUT]  A   destroyed

; CGB:
; [IN]   HL  palettes to write
; [IN]   C   how many palette slots to write to
; [OUT]  DE  destroyed
LoadOBJ1Pals::
	; failsafe!
	; you're meant to call LoadOBJPalsCGB 
	; on CGB systems instead
	ldh a, [hConsoleType]
	and a
	jr z, LoadOBJPalsCGB
	
	ld a, d
	ldh [hOBP1], a
	ret
	
LoadOBJPalsCGB::
	; double the palette slot amount (1 slot = 2 bytes)
	sla c
	
	ld de, wOBP
.loop:
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

; data
DefaultCGBPals::
	; BG0
	rgb 00, 00, 00
	rgb 16, 16, 16
	rgb 22, 22, 22
	rgb 31, 31, 31
	; BG1
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG2
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG3
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG4
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG5
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG6
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; BG7
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
.obj:
	; OB0
	rgb 00, 00, 00
	rgb 16, 16, 16
	rgb 22, 22, 22
	rgb 31, 31, 31
	; OB1
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OB2
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OB3
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OB4
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OB5
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OB6
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	; OB7
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
	rgb 00, 00, 00
