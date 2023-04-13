/****************************
 * Routine:	String_length
 * Params:
 * 	- x0:	ptr string
 * Return:
 *	- x0:	int length
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.include	"../include/macros.inc"

String_length:
	push
	mov	x19,	x0
	mov	x0,	#0	// counter

	String_length_loop:
		ldrb	w20	[x19,	x0]
		cmp	w20,	#0
		add	x0,	x0,	#1
		b.eq	String_length_end
		b	String_length_loop
	
	String_length_end:
		pop
		ret

