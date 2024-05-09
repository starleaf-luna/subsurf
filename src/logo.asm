
INCLUDE "src/macros/code.asm"

SECTION "Logo", ROMX

Logo::
	call WhiteOutPalettes
	ld c, 5
	call DelayFrames
	call FadeInFromBlack
	ld hl, $8800
	ldh a, [hConsoleType]
	and a
	jr nz, .dmg1
	ld de, LogoGFX
	ld bc, LogoDMGGFX - LogoGFX
	call LCDMemcpy
	ld de, LogoTilemap
	lb bc, 20, 18
	ld hl, $9800
	call LoadTilemap
	ld de, LogoAttrmap
	lb bc, 20, 18
	ld hl, $9800
	call LoadAttrmap
	jr .cont
.dmg1:
	ld de, LogoDMGGFX
	ld bc, LogoGFX_Pal - LogoDMGGFX
	call LCDMemcpy
	ld de, LogoTilemap_DMG
	lb bc, 20, 18
	ld hl, $9800
	call LoadTilemap
.cont:
	; we have arguments for both DMG & CGB.
	ld hl, LogoGFX_Pal
	ld d, %11100100
	ld c, 32
	call LoadBGPals
	ld c, 90
	call DelayFrames
	call FadeOutToBlack
	ld c, 40
	call DelayFrames
	jp LogoJumpToEngine

LogoGFX: INCBIN "assets/logo.2bpp"
LogoDMGGFX: INCBIN "assets/logo-dmg.2bpp"

LogoGFX_Pal: INCBIN "assets/logo.pal"

LogoTilemap: INCBIN "assets/logo.tilemap"
LogoAttrmap: INCBIN "assets/logo.attrmap"
LogoTilemap_DMG: INCBIN "assets/logo-dmg.tilemap"
LogoGFX_End:

SECTION "Bankswitch Handlers - logo.asm", ROM0

LogoJumpToEngine::
	ld a, BANK(LevelEngine)
	ldh [hCurROMBank], a
	ld [rROMB0], a
	jp LevelEngine
