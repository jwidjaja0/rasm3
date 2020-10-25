/* -- String_concat.s -- */

/* 
Required functions:
String_Length

Description:
String_concat.s(string1:String, str:String):String
Concatenates the specified string "str" at the end of the string.

R0:	Address to string1
R1:	Address of str

Returned register contents:
R0:	new concatenated string of string1 and str
*/

@ AAPCS v2020Q2 Required registers are preserved.

	.global String_concat

String_concat:
	@ Preserve AAPCS required registers
	push	{r4-r8, r10, r11}
	push	{sp}
	push	{lr}

	mov 	r4, r0	@ move address of string1 to r4
	mov	r5, r1	@ move address of str to r5
	mov	r10, #0x00	@ initialize null for r10

	@@ FIND LENGTH REQUIRED TO ASK FOR MALLOC
	mov 	r0, r4		@ move address of string1 to r0 as argument to String_Length
	bl	String_Length	@ call String_Length
	mov	r6, r0		@ move result of to r6
	
	mov	r0, r5		@ move address of str to r0 for argument
	bl	String_Length	@ call String_Length
	add	r6, r6, r0	@ add result to r6, r6 now has length of string1 + str
	add	r6, r6, #1	@ add 1 to r6 for null at the end

	@@ CALL MALLOC
	mov	r0, r6		@ move total bytes required to r0
	bl	malloc		@ call malloc
	mov	r10, r0		@ r10 has address of new string to return later

copy_string1:
	@@ Copy the first string1 to new string
	ldrb	r7, [r4]	@ load byte pointed at r4 to r7
	cmp	r7, #0x00	@ compare to null
	beq	copy_substr	@ reach end of string1, go to copy_substr
	strb	r7, [r0]	@ store byte at r7 to new string
	add	r0, r0, #1	@ go to next byte
	add	r4, r4, #1	@ go to next byte of string1
	b	copy_string1	@ keep looping to copy	

copy_substr:
	ldrb	r7, [r5]	@ load byte pointed at r5 to r7
	cmp	r7, #0x00	@ compare to null
	beq	final		@ go to end if reach end of substr
	strb	r7, [r0]	@ store byte at r7 to new string
	add	r0, r0, #1	@ go to next byte
	add	r5, r5, #1	@ go to next byte of substr
	b	copy_string1	@ keep looping to copy substr

final:
	mov	r0, r10		@ move address at r10 to r0

	pop	{lr}
	pop 	{sp}
	pop	{r4-r8, r10, r11}

	bx	lr
	.end
