/* -- String_lastIndexOf_3.s -- */

/*
Required functions:
String_indexOf_3

Description:
String_lastIndexOf_3(string1:String, str:String):int
Returns the index of last occurence of string str

R0:	Address to string1
R1: 	Address to str

Returned register contents:
R0: 	index of last occurence of str
*/

@ AAPCS v2020Q2 Required registers are preserved. 

	.global	String_lastIndexOf_3

String_lastIndexOf_3:
	@ Preserve AAPCS required registers
	push	{r4-r8, r10, r11}
	push	{sp}
	push	{lr}

	mov	r4, r0	@ move address of string1 to r4
	mov	r8, r0	@ same
	mov	r5, r1	@ move address of str to r5
	mov	r6, #-1 	@ initialize return value to -1

loop:
	ldrb	r7, [r8] 	@ dereference byte pointed by r4, to be checked if null
	cmp	r7, #0x00	@ compare to null
	beq	final		@ go to final
	
	mov	r0, r8		@ put pointer of string to search in r0
	mov	r1, r5		@ put pointer of str to r1	

	bl	String_indexOf_3	@ call function

	cmp	r0, #-1		@ check if -1 (not found)
	beq	final		@ go to final if no more substring is found

	addne	r6, r0
	addne	r6, r6, #1
	moveq	r6, r0		@ update new result to r6
	add	r8, r4, r6	@ string1 now points to location of substring found
	add	r8, r8, #1	@ pointer now points to the next byte
	b	loop		@ keep looping

final:
	mov	r0, r6		@ move result to r0

	pop	{lr}
	pop	{sp}
	pop	{r4-r8, r10, r11}

	bx	lr
	.end
