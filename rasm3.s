/* -- rasm3.s -- */
@@ DRIVER PROGRAM @@

	.data 
str1:	.asciz 	"Cat in the hat"
crCr:	.byte	10
pA:	.space	13			@ space to print

	.text
	.globl	_start

_start:	
	ldr	r0, =str1		@ load r0 pointer to str1
	bl	putstring		@ call putstring
	ldr	r0, =crCr
	bl	putch
	ldr	r0, =str1		@ load r0 pointer to str1
	
	bl	String_toUpperCase
	mov	r4, r0			@ move string to r4	

	bl	putstring	
	ldr	r0, =crCr
	bl	putch

	mov	r0, r4			@ restore all uppercase string
	bl	String_toLowerCase
	bl	putstring

	ldr	r0, =crCr
	bl	putch

	ldr	r0, =str1
	mov	r1, #'n'		@ search for 'n'
	mov	r2, #4			@ start search from index 1

	bl	String_indexOf_2
	ldr	r1, =pA			@ load r1 pointer to pA
	bl	intasc32		@ call intasc32
	mov	r0, r1			@ move r1 to r0
	bl	putstring

	ldr	r0, =crCr
	bl	putch

	ldr	r0, =str1
	mov	r1, #'t'
	bl	String_indexOf_1
	ldr	r1, =pA
	bl	intasc32
	mov	r0, r1
	bl 	putstring
	


@@ END @@
	ldr	r0, =crCr
	bl	putch
	
	mov	r0, #0
	mov	r7, #1
	svc	0

	.end
