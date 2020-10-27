/* -- String_lastIndexOf_2.s --*/

/*
Redoing String_lastIndexOf_2

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
	mov	r5, r1			@ move r1 to r5, r5 has char to search
	mov	r6, r2			@ r6 has index from original

	mov	r10, #-1		@ initialize r10 to -1

	@@ Check for index validity on length
	mov 	r0, r4			@ move origial string to r0
	bl 	String_Length		@ call String_Length
	
	mov	r8, r0			@ r8 has length of string
	
	cmp	r6, r8			@ compare index to length
	movgt	r6, r8			@ if index greater than length, use length instead

	@@ Check if index less than 0
	cmp	r6, #0			@ compare r6 to 0
	blt	Sli2final		@ go to final if index <0

	add	r7, r4, r6		@ r7 = index address + index
	ldrb	r11, [r7]		@ load byte pointed by r7 to r11
	cmp	r11, r5			@ compare byte at r11 to char
	moveq	r10, r6			@ if equal, update r10 to index held in r6
	beq	Sli2final		@ go to Sli2final

	@@ not equal at this point, so decrement index	
	sub	r6, r6, #1		@ decrement index by 1

Sli2final:
	mov	r0, r10			@ move r10 to r0 to return result

	pop	{lr}
	pop	{sp}
	pop	{r4-r8, r10, r11}

	bx	lr
	.end
