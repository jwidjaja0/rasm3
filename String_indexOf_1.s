/* -- String_indexOf_1.s -- */

@ Required Functions:
@ String_indexOf_2.s

@ String_indexOf_1(string1:String, ch:char): int
@ return index of specified char in string1, starting from 0

@ R0: 	Address to string
@ R1:	Character to search
@ LR: 	Contains the return address

@ Returned register contents:
@ R0: index of character, -1 if not found

@ AAPCS v2020Q2 Required registers are preserved.

	.global String_indexOf_1
	.text

String_indexOf_1:
	@ Preserve AAPCS required registers
	push	{r4-r8, r10, r11}
	push	{sp}

	push	{lr}			@ Preserve LR of calling function

	push	{r2}			@ preserve original r2
	mov	r2, #0			@ initial index to search from

	bl	String_indexOf_2	@ call String_indexOf_2

	pop	{r2}			@ restore original r2
	
	pop	{lr}			@ restore original LR of calling function
	pop	{sp}
	pop	{r4-r8, r10, r11}

	bx 	lr
	.end
