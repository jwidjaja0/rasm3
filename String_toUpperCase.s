/* -- String_toUpperCase.s -- */

@ Purpose: returns the upper case of given string
@ R0:	Address to string
@ LR: 	Contains the return address

@ Returned register contents:
@ R0: 	Address of lower case string

@ AAPCS v2020Q2 Required registers are preserved.

	.data

bUpper:	.byte	0x7a	@ "z"
bLower:	.byte	0x61	@ "a"
nl:	.byte	0

	.global String_toUpperCase 		@ Provide program starting address to linker

	.extern	malloc

	.text

checkLower:
	cmp	r7, r5		@ check if more than lower bound
	bge	toUpper		@ toLower if ch is in between
	b	inc		@ if doesn't go tolower, go to inc

toUpper:
	sub	r7, r7, #32	@ add decimal 32 to turn upper to lower case ascii
	b	inc		@ go to inc

inc:
	str	r7, [r8]	@ store r7 to address in r8
	add	r6, r6, #1
	ldrb	r7, [r6]
	add	r8, r8, #1
	b	loop

String_toUpperCase:
	@ Preserve APPCS Required Registers
	push	{r4-r8, r10, r11}
	push	{sp}
	@ -----------------------------
	push 	{lr}		@ preserve lr from calling function

	@ EXAMPLE, ONLY TO TEST, R0 WILL BE PROVIDED BY CALLING PROGRAM
	@ldr	r0, =str	@ test, preloaded string
	mov	r6, r0		@ move string to r6

	@Call String_Length to get number of char
	bl	String_Length	@ call String_Length

	@@ AFTER CALLING STRING_LENGTH, ADD 1 TO RESULT TO ADD NULL AT END
	add	r0,r0,#1	@ add 1 to length count
	bl	malloc		@ call malloc

	mov	r8, r0		@ r8 now has allocated dynamic memory

	@@ PREP TO UPPER	
	ldr	r4, =bUpper
	ldrb	r4, [r4]

	ldr	r5, =bLower
	ldrb	r5, [r5]

	ldrb	r7, [r6]	@ get first character
	

loop:
	@ check if null
	cmp	r7, #0x00	@ check if character is null
	beq	final		@ string is done if null
	
	cmp 	r7, r4		@ check if less than upper
	
	ble	checkLower
	b	inc		@ increment up to next character
	
final:
	pop	{lr}		@ restore calling function's lr
	@ -----------------------------
	@ Restoring our APPCS mandated registers 
	pop	{sp}
	pop	{r4-r8, r10, r11}

	bx	lr
	.end
