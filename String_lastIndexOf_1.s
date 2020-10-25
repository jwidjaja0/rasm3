/* -- String_lastIndexOf_1.s -- */

/*
Required functions:
String_lastIndexOf_2.s

Description:
String_lastIndexOf_1(string1:String, ch:char):int

R0: 	Address to string1
R1:	ch to search

Returned register contents:
R0:	last index of character
*/

@ AAPCS v2020Q2 Required registers are preserved

	.global String_lastIndexOf_1

String_lastIndexOf_1:
	@ Preserve AAPCS required registers
	push	{r4-r8, r10, r11}
	push 	{sp}
	push	{lr}

	push	{r2}
	mov	r2, #0		@ will call String_lastIndexOf_2 but start at 0
	bl	String_lastIndexOf_2
	
	pop	{r2}

	pop	{lr}
	pop	{sp}
	pop	{r4-r8, r10, r11}

	bx	lr
	.end
