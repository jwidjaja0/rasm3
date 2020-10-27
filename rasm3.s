/* -- rasm3.s -- */
@@ DRIVER PROGRAM @@
@@ test with archive file for functions @@

	.data 
str1:	.asciz 	"Green eggs and ham."
sub0:	.asciz	"thee"
sub1:	.asciz	"Cat"
sub2:	.asciz	"hat"
sub3:	.asciz	" the"

str2:	.asciz	"my egg in egg noo egg in "
sub4:	.asciz	"egg"
sub5:	.asciz	"inn"
sub6:	.asciz	"my"

str3:	.asciz	"John "
str4:	.asciz	"Doe"

ch1:	.ascii	"o"
ch2:	.ascii	"i"


crCr:	.byte	10
pA:	.space	13			@ space to print

	.text
	.global	_start

_start:	
	ldr	r0, =str1
	mov	r1, #'g'
	mov	r2, #6
	bl	String_lastIndexOf_2

/*
	ldr	r1, =str2
	
	ldr	r0, =crCr
	bl	putch
	
	ldr	r0, =str1
	bl	String_toUpperCase
	bl	putstring
	
	ldr	r0, =crCr
	bl	putch
	
	ldr	r0, =str3
	ldr	r1, =ch1
	ldrb	r1, [r1]
	ldr	r2, =ch2
	ldrb	r2, [r2]

	bl	String_replace
	bl	putstring
	

	ldr	r0, =crCr
	bl	putch

	ldr	r0, =str3
	ldr	r1, =str4
	bl	String_concat
	bl	putstring

	ldr	r0, =crCr
	bl	putch

	ldr	r0, =str2
	bl	putstring
	ldr	r0, =crCr
	bl	putch
	
	ldr	r0, =str2
	ldr	r1, =sub5

	bl	String_lastIndexOf_3
	
	ldr	r1, =pA
	bl	intasc32
	mov	r0, r1
	bl	putstring

	ldr	r0, =crCr
	bl	putch
	

	@@@ TEST STRING_LENGTH
	ldr	r0, =str1
	bl	String_Length
	ldr	r1, =pA
	bl	intasc32
	mov	r0, r1
	bl	putstring

	ldr	r0, =crCr
	bl	putch

	@@@ TEST String_indexOf_2 @@@

	ldr	r0, =str1
	mov	r1, #'n'		@ search for 'n'
	mov	r2, #20			@ start search from index 1

	bl	String_indexOf_2

	ldr	r1, =pA			@ load r1 pointer to pA
	bl	intasc32		@ call intasc32
	mov	r0, r1			@ move r1 to r0
	bl	putstring

	ldr	r0, =crCr
	bl	putch

	@@@ TEST String_indexOf_1 @@@

	ldr	r0, =str1
	mov	r1, #'t'
	bl	String_indexOf_1
	ldr	r1, =pA
	bl	intasc32
	mov	r0, r1
	bl 	putstring

	ldr	r0, =crCr
	bl	putch

	@@@@ TEST String_indexOf_3 @@@

	ldr	r0, =str1
	ldr	r1, =sub0
	bl	String_indexOf_3
	
	ldr	r1, =pA
	bl	intasc32
	mov	r0, r1
	bl	putstring

	ldr	r0, =crCr
	bl	putch

	@@@ TEST String_lastIndexOf_2 @@@

	ldr	r0, =str1
	mov	r1, #'a'
	mov	r2, #1

	bl	String_lastIndexOf_2

	ldr	r1, =pA
	bl	intasc32
	mov	r0, r1
	bl	putstring
	ldr	r0, =crCr
	bl	putch

	@@@ TEST String_lastIndexOf_1 @@@

*/

	

@@ END @@
	ldr	r0, =crCr
	bl	putch
	
	mov	r0, #0
	mov	r7, #1
	svc	0

	.end
