/* -- String_indexOf_3.s --*/

/*
Required Functions:
String_indexOf_2()
malloc()
free()

description:
String_indexOf_3(string1: String, str:String): int
return index of first occurence specified substring str

R0: 	Address to string1
R1:	Address to substring

Returned register contents:
R0:	index of first occurence, -1 if not found

*/

@ AAPCS v2020Q2 Required registers are preserved.

	.data
iInd:	.word	0
pStr1:	.byte	0
pSub1:	.byte	0

	.global	String_indexOf_3
	.text

String_indexOf_3:
	@ Preserve AAPCS required registers
	push	{r4-r8, r10, r11}
	push	{sp}

	push	{lr}			@ Preserve LR of calling function

	@ store original addressed to memory
	ldr	r4, =pStr1
	str	r0, [r4]

	ldr	r4, =pSub1
	str	r1, [r4]

	@ move original addresses to r4 and r5
	mov	r10, r0			@ r10 has address of string1
	mov	r11, r1			@ r11 has address of substring1

	ldr	r7, =iInd
	ldr	r7, [r7]
	@mov	r7, #0			@ index of finding first char	


searchFirst:
	@ Find first occurence of character
	mov	r1, r11
	ldrb	r6, [r1]		@ load first byte of substring to r6
	mov	r1, r6			@ move char to r1
	
	mov	r2, r7			@ start search from index in r7
	mov	r0, r10			@ move address of string1 to r0

	bl	String_indexOf_2	
	
	@ if doesn't exist, r0 will have -1
	cmp	r0, #-1			@ if doesn't exist
	beq	notFound	
	
	@ char is found, now compare one by one with substring
	ldr	r8, =iInd		
	str	r0, [r8]		@ store original index to iInd


	@ldr	r4, =pStr1		@ load r4 pointer to str1
	@ldrb	r4, [r4]		@ dereference, now r4 points to original string1
	
	mov	r4, r10			@ move r10 to r4, r4 has address to string1
	add	r4, r4, r0		@ add r4 by offset of char found
	
	mov	r5, r11			@ move r11 to r5, r5 has address of substring
	b	subLoop

	@ldr	r5, =pSub1
	@ldrb	r5, [r5]		@ derefernce, now r5 points to original substring

subLoop:
	@ since first character is already found to match, compare next character
	add	r4, r4, #1		@ r4 points to string1, go to next byte
	add	r5, r5, #1		@ r5 points to substring, go to next byte

	ldrb 	r7, [r4]		@ dereference byte to r7
	ldrb	r8, [r5]		@ dereference byte to r8

	@Check if substring is null, if null and we never break, that means our search ends
	cmp	r8, #0x00		@ compare with null
	beq	subFound		@ go to subFound

	@Check if string is null, if null and we never break, then string ends and return -1
	cmp	r7, #0x00		@ compare with null
	beq	notFound

	cmp	r7, r8			@ compare if next char is equal
	
	bne	incNext			@ not equal, break, increment up next search in main string. 

	b	subLoop			@ go back subloop to compare next char in substring
	
incNext:
	ldr	r7, =iInd		@ index first character found, need to increment up to search for the rest of the string
	ldr	r7, [r7]		@ dereference byte to r7
	add	r7, r7, #1		@ add 1 to address, start searching at next char in string1
	b	searchFirst		@ go to searchFirst


notFound:
	mov	r0, #-1			@ -1 for default error value
	b	final			@ go to final

subFound:
	ldr 	r0, =iInd		@ load r0 pointer to iInd, has index where first matching char is found
	ldr	r0, [r0]		@ derefernce
	b	final			@ go to final

final:
	pop	{lr}
	pop	{sp}
	pop	{r4-r8, r10, r11}

	bx	lr

