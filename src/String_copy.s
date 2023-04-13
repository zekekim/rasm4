/****************************
 * Routine:	String_copy
 * Params:
 * 	- x0:	ptr string
 * Return:
 *	- x0:	ptr dest
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.include	"../include/macros.inc"

String_copy:
	push
	bl	String_length
	mov	x19,	x0
	bl	malloc
	mov	x20,	#0
	mov	x21,	#0
	
	String_copy_loop:
		ldrb	w1,	[x2,	x20]
		strb	w1,	[x0,	x21]
		cmp	w1,	#0
		b.eq	String_copy_end
		add	x20,	x20,	#1
		add	x21,	x21,	#1
		b	String_copy_loop

	String_copy_end:
		pop
		ret
	
