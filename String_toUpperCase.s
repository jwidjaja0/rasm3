/* -- String_toUpperCase.s -- */

@ Purpose: returns the upper case of given string

@ R0:	Address to string
@ LR: 	Contains the return address

@ Returned register contents:
@ R0: 	Address of lower case string

@ AAPCS v2020Q2 Required registers are preserved.

	.data

str:	.asciz	"HoUse bIg"
bUpper:	.byte	0x7a	@ "z"
bLower:	.byte	0x61	@ "a"
strNew:	.space	128
nl:	.byte	0

	.global _start 		@ Provide program starting address to linker
		@Change to String_toUpperCase in the end
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

_start:
@String_toLowerCase:
	@ Preserve APPCS Required Registers
	@ push	{r4-r8, r10, r11}
	@ push	{sp}
	@ -----------------------------

	@ EXAMPLE, ONLY TO TEST, R0 WILL BE PROVIDED BY CALLING PROGRAM
	ldr	r0, =str	@ test, preloaded string
	
	ldr	r4, =bUpper
	ldrb	r4, [r4]

	ldr	r5, =bLower
	ldrb	r5, [r5]

	mov 	r6, r0		@ move r0 to r4
	ldrb	r7, [r6]	@ get first character
	
	ldr	r8, =strNew	@ load r8 pointer to strNew

loop:
	@ check if null
	cmp	r7, #0x00	
	beq	final
	
	cmp 	r7, r4		@ check if less than upper
	
	ble	checkLower
	b	inc		@ increment up	
	
final:
	ldr	r0, =strNew

ending:	
	@ -----------------------------
	@ Restoring our APPCS mandated registers 
	@ pop	{sp}
	@ pop	{r4-r8, r10, r11}

	@ONLY USE THIS FOR TESTING (ENDING FUNCT)
	mov	r0, #0
	mov	r7, #1
	svc	0

	@RESTORE BELOW FOR EXTERNAL FUNCTION
	@bx	lr
	.end
