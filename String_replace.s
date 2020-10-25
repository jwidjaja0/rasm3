/* -- String_replace.s -- */

/*
Required functions:
String_Length
malloc

Description:
String_replace(string1:String, oldChar:ch, newChar:ch):String
Returns the new updated string after changing all the occurences of oldChar with newChar

R0: 	Address to String1
R1:	oldChar
R2:	newChar

Returned register contents:
R0: 	index of last occurence of str
*/

@ AAPCS v2020Q2 Required registers are preserved.

	.global String_replace

String_replace:
	@ Preserve AAPCS required registers
	push	{r4-r8, r10, r11}
	push	{sp}
	push	{lr}

	mov	r4, r0		@ move address of string1 to r4
	mov	r5, r1		@ move oldChar to r5
	mov	r6, r2		@ move newChar to r6
	mov	r10, #0x00	@ initialize r10

	mov	r0, r4		@ move r4 to r0 for argument to stringlength
	bl	String_Length
	add	r0, r0, #1	@ add 1 to account for null at end
	bl	malloc		@ call malloc
	mov	r10, r0		@ r10 has address to new string allocated in heap

strLoop:
	ldrb	r7, [r4]	@ load byte pointed by r4 to r7
	cmp	r7, #0x00	@ check if null
	beq	final		@ end of string
	
	cmp	r7, r5		@ check if byte match oldChar
	strne	r7, [r0]	@ if not equal, store that byte to new string
	streq	r6, [r0]	@ if equal, copy newChar instead

	add	r4, r4, #1	@ go to next byte in string1
	add	r0, r0, #1 	@ go to next byte in new string
	b	strLoop		@ keep replacing until null


final:
	mov	r0, r10		@ move address of new string to return to calling program

	pop	{lr}
	pop	{sp}
	pop	{r4-r8, r10, r11}

	bx	lr
	.end
