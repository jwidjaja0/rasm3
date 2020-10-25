/* -- String_lastIndexOf_2.s --*/

/*
Required functions:
String_indexOf_2

description:
String_lastIndexOf_2(string1:String, ch:char, fromIndex:int):int
returns the last occurence of the character ch in the string, start from fromIndex

R0: 	Address to string1
R1:	Character to find
R2:	int index to start search from

Returned register contents:
R0:	index of last occurence of ch, -1 if not found
*/

@ AAPCS v2020Q2 Required registers are preserved. 

	.global	String_lastIndexOf_2
	
String_lastIndexOf_2:
	@ Preserve AAPCS required registers
	push	{r4-r8, r10, r11}
	push	{sp}

	push	{lr}			@ Preserve LR of calling function
	
	mov	r10, #-1		@ initialize result to -1

	mov	r4, r0			@ move original string1 to r4
	mov	r5, r2			@ move fromIndex to r5, r5 has fromIndex original	

Sli2loop:
	mov	r0, r4
	mov	r2, r5
	bl	String_indexOf_2
	
	@@ check if r0 is -1, if so exit
	cmp	r0, #-1
	beq	Sli2final

	@@ not -1, so found an index, store to r10
	mov	r10, r0

	@@ check next, if null then already hit last char in string
	mov	r6, r4			@ r6 has original string
	add	r5, r0, #1		@ r5 = index found + 1
	add	r6, r6, r5		@ r6 points to next char in string after index found


	ldrb	r6, [r6]
	cmp	r6, #0x00		@ compare null
	beq	Sli2final

	@@ if next not null, continue searching, make returned index to be next search
	b	Sli2loop

	
Sli2final:
	mov	r0, r10			@ move r10 to r0 to return result

	pop	{lr}
	pop	{sp}
	pop	{r4-r8, r10, r11}

	bx	lr
	.end
