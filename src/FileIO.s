/****************************
 * Object:	LinkedList
 * Params:
 * 	- None
 * Return:
 *	- None
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

	.include	"../include/macros.inc"
	.data
		chCr:	.byte	10

/****************************
 * Routine:	File_open	
 * Params:
 * 	- x0,	ptr fileName
 * Return:
 *	- x0:	fd
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

File_open:
	push
	mov	x8,	open
	mov	x1,	x0
	mov	x0,	cwd
	mov	x2,	flags
	mov	x3,	mode
	svc	0
	pop
	ret

/****************************
 * Routine:	File_readln
 * Params:
 * 	- x0,	int fd
 *	- x1,	ptr char
 *	- x2,	ptr result
 * Return:
 *	- None
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

File_readln:
	push
	mov	x19,	x0
	mov	x20,	x1
	mov	x21,	x2
	
	File_readln_loop:
		mov	x8,	read
		mov	x2,	#1
		mov	x0,	x19
		mov	x1,	x20
		svc	0
		
		// Compare the current character
		ldrb	w3,	[x20]
		cmp	w3.	#0
		b.eq	File_readln_done
		cmp	w3,	#10
		b.eq	File_readln_done
		strb	w3,	[x21],	#1
		b	File_readln_loop
	
	File_readln_done:
		pop
		ret
/****************************
 * Routine:	File_writeln
 * Params:
 * 	- x0,	int fd
 * 	- x1,	ptr string
 * Return:
 *	- None
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

File_writeln:
	mov	x8,		write
	mov	x19,	x0
	mov	x20,	x1
	mov	x0,		x1
	bl String_length
	// Write string
	sub	x2,		x0,	#1
	mov	x1,		x20
	mov	x0,		x19
	svc	0
	// Write newline character
	mov	x2,	#1
	mov	x1,	=chCr
	mov	x0,	x19
	svc 0


	
		

	
	
