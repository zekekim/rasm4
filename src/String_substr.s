/****************************
 * Routine:	String_length
 * Params:
 * 	- x0:	ptr string
 * Return:
 *	- x0:	int length
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

.include "../include/macros.inc"

String_substr:
	push
	mov	x19,	x0
	mov	x20,	x1
	mov	x21,	#0
	mov	x0,	#0	
	
	String_substr_loop:
		ldrb	w22,	[x19],	#1
		ldrb	w23,	[x20,	x21]
		cmp	w23,	#0
		b.eq	String_substr_found
		cmp	w22,	#0
		b.eq	String_substr_end
		cmp	w23,	w22
		b.ne	String_substr_reset
		add	x21,	x21,	#1
		b	String_substr_loop

	String_substr_found:
		mov	x0,	#1
		b	String_substr_end
	
	String_substr_reset:
		mov	x21,	#0
		b	String_substr_loop

	String_substr_end:
		pop
		ret

