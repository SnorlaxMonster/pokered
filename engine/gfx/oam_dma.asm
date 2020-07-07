WriteDMACodeToHRAM::
; Since no other memory is available during OAM DMA,
; DMARoutine is copied to HRAM and executed there.
	ld c, LOW(hDMARoutine)
	ld b, DMARoutineEnd - DMARoutine
	ld hl, DMARoutine
.copy
	ld a, [hli]
	ldh [c], a
	inc c
	dec b
	jr nz, .copy
	ret

DMARoutine:
	; initiate DMA
	ld a, HIGH(wOAMBuffer)
	ldh [rDMA], a

	; wait for DMA to finish
	ld a, $28
.wait
	dec a
	jr nz, .wait
	ret
DMARoutineEnd: