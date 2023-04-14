/****************************
 * Routine:	String_copy
 * Params:
 * 	- x0:	ptr string
 * Return:
 *	- x0:	ptr dest
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.include	"macros.inc"

.global String_copy
String_copy:
	push
	mov	x22,	x0
	bl	String_length
	mov	x19,	x0
	bl	malloc
	mov	x20,	#0
	mov	x21,	#0
	
	String_copy_loop:
		ldrb	w1,	[x22,	x20]
		strb	w1,	[x0,	x21]
		cmp	w1,	#0
		b.eq	String_copy_end
		add	x20,	x20,	#1
		add	x21,	x21,	#1
		b	String_copy_loop

	String_copy_end:
		pop
		ret
	
.global String_copyln
String_copyln:
	push
	mov	x22,	x0
	bl	String_length
	add	x0,	x0,	#1
	bl	malloc
	mov	x20,	#0
	mov	x21,	#0
	
	String_copyln_loop:
		ldrb	w1,	[x22,	x20]
		strb	w1,	[x0,	x21]
		cmp	w1,	#0
		b.eq	String_copyln_end
		add	x20,	x20,	#1
		add	x21,	x21,	#1
		b	String_copyln_loop

	String_copyln_end:
		mov 	w1,	#10
		strb	w1,	[x0,	x21]
		pop
		ret
