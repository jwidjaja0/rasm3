/* -- String_toLowerCase.s -- */

@ Purpose: returns the lower case of given string

@ R0:	Address to string
@ LR: 	Contains the return address

@ Returned register contents:
@ R0: 	Address of lower case string

@ AAPCS v2020Q2 Required registers are preserved.

	.data

iUpper:	.byte	0x5a	@ "Z"
iLower:	.byte	0x41	@ "A"
nl:	.byte	0

	.global String_toLowerCase	@ Provide program starting address to linker
		@Change to String_toLowerCase in the end
	.text

checkLower:
	cmp	r7, r5		@ check if more than lower bound
	bge	toLower		@ toLower if ch is in between
	b	inc		@ if doesn't go tolower, go to inc

toLower:
	add	r7, r7, #32	@ add decimal 32 to turn upper to lower case ascii
	b	inc		@ go to inc

inc:
	str	r7, [r8]	@ store r7 to address in r8
	add	r6, r6, #1
	ldrb	r7, [r6]
	add	r8, r8, #1
	b	loop

String_toLowerCase:
	@ Preserve APPCS Required Registers
	push	{r4-r8, r10, r11}
	push	{sp}
	@ -----------------------------
	push	{lr}		@ preserve LR of calling function

	@ EXAMPLE, ONLY TO TEST, R0 WILL BE PROVIDED BY CALLING PROGRAM
	@ldr	r0, =str	@ test, preloaded string
	mov	r6, r0		@ move string to r6
	
	@ Call String_Length to get number of char
	bl	String_Length	@ call String_Length

	@ Now allocate memory, add 1 result to add null at end
	add 	r0, r0, #1	@ add 1 to length count
	bl	malloc		@ call malloc

	mov	r8, r0		@ r8 now has allocated dynamic memory

	@@ PREP FOR ACTUAL FUNCTION
	mov	r4, #'Z'
	mov	r5, #'A'

	ldrb	r7, [r6]	@ get first character
	

loop:
	@ check if null
	cmp	r7, #0x00	
	beq	final
	
	cmp 	r7, r4		@ check if less than upper
	
	ble	checkLower
	b	inc		@ increment up	
	
final:

	pop	{lr}		@ restore LR of calling function
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
