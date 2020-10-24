/* -- String_indexOf_2.s --  */

@ Required Functions:
@ String_Length.o

@ String_indexOf_2(string1:String, ch:char, fromIndex:int): int
@ return index of specified character in the string, starting search from initial index, return index from beginning
@ R0: 	Address to string
@ LR: 	Contains the return address

@ Returned register contents:
@ R0: 	index of character, -1 if not found
@ R1:	character to search
@ R2: 	fromIndex

@ AAPCS v2020Q2 Required registers are preserved.

	.global String_indexOf_2

	.text

String_indexOf_2:
	@ Preserve AAPCS required registers
	push	{r4-r8, r10, r11}
	push	{sp}
	@ ---------------------------------
	push 	{lr}		@ Preserve LR of calling function

	@ R0 contains address to string
	mov	r4, r0		@ move argument to r4	
	mov	r5, r1		@ move char to r5
	mov	r6, r2		@ move fIndex to r6

	@ Error  check if fIndex < 0
	cmp	r6, #0		@ compare to 0
	blt	notFound	@ if negIndex, the go notFound

	@ Error check if fromIndex > string length
	bl	String_Length
	cmp	r6, r0		@ compare r0 r6
	bge	notFound	@ if fIndex >= length, then go to notFound

	add	r4, r4, r6	@ add starting address with fIndex, to first char begin search
	mov	r0, #0		@ initialize result
	add	r0, r0, r2	@ add fIndex to result

loop:
	ldrb	r8, [r4]	@ load byte from address in r4 to r8
	cmp	r5, r8		@ compare if byte value is the same
	beq	final		@ go to final if equal
	
	add	r4, r4, #1	@ increment up
	add	r0, r0, #1	@ increment result up as well
	cmp	r8, #0x00	@ compare to null, if null then search end and not found
	beq	notFound	@ branch to notFound
	b	loop		@ else, go back to loop
		

notFound:
	mov	r0, #-1		@ default value for not found or fromIndex too big

final:
	pop	{lr}		@ Restore calling function's LR
	@ Restoring our AAPCS mandated registers
	pop	{sp}
	pop	{r4-r8, r10, r11}

	bx	lr	
