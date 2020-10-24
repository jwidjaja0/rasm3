/* -- String_Length.s -- */

@ Purpose: returns the number of character in a string excluding null

@ R0:	Address to string
@ LR: 	Contains the return address
@ ERROR CHECKING:
@ What is upper limit of string count? limit of int?

@ Returned register contents:
@ R0: 	Number of characters in the string

@ AAPCS v2020Q2 Required registers are preserved.

	.data

	.global String_Length 		@ Provide program starting address to linker
	.text

String_Length:
	@ Preserve APPCS Required Registers
	push	{r4-r8, r10, r11}
	push	{sp}
	@ -----------------------------

	mov 	r4, r0		@ move r0 to r4
	mov	r0, #0		@ initialize count to zero
	
loop:
	ldrb	r5, [r4]	@ load byte from address in r4 to r5
	add	r4, #1		@ add 1 byte

	cmp	r5, #0x00	@ compare to null
	addne	r0, r0, #1	@ add 1 to counter
	bne	loop		@ keep looping if not null

	@@ REDUCE 1 FOR LENGTH
	sub	r0, r0, #1	

	@ -----------------------------
	@ Restoring our APPCS mandated registers 
	pop	{sp}
	pop	{r4-r8, r10, r11}

	@ONLY USE THIS FOR TESTING (ENDING FUNCT)
	@mov	r0, #0
	@mov	r7, #1
	@svc	0

	@RESTORE BELOW FOR EXTERNAL FUNCTION
	bx	lr
	.end
