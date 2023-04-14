/****************************
 * Routine:	String_length
 * Params:
 * 	- x0:	ptr string
 * Return:
 *	- x0:	int length
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

.include "macros.inc"

.global String_substr
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
		bl	String_compareChar
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


String_compareChar:
	push
	String_compareChar_sub:
		cmp	w23,	'a'
		b.ge	String_toUpper_Three
		cmp	w22,	'a'
		b.ge	String_toUpper_Two
		cmp w22,	w23
		pop
		ret

	String_toUpper_Three:
		sub	x23,	x23,	#32
		b String_compareChar_sub
	
	String_toUpper_Two:
		sub	x22,	x22,	#32
		b String_compareChar_sub

