/****************************
 * Object:	LinkedList
 * Params:
 * 	- None
 * Return:
 *	- None
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

	.include	"macros.inc"


/****************************
 * Routine:	File_open	
 * Params:
 * 	- x0,	ptr fileName
 * Return:
 *	- x0:	fd
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.global File_open_write
File_open_write:
	push
	mov	x8,	open
	mov	x1,	x0
	mov	x0,	#-100
	mov	x2,	#01101
	mov	x3,	#0600
	svc	0
	pop
	ret

.global File_open_read
File_open_read:
	push
	mov	x8,	open
	mov	x1,	x0
	mov	x0,	#-100
	mov	x2,	#0100
	mov x3,	#0600
	svc 0
	pop
	ret

/****************************
 * Routine:	File_close
 * Params:
 * 	- x0,	int fd
 * Return:
 *	- Nothing
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.global File_close
File_close:
	push
	mov	x8,	close
	svc	0
	pop
	ret

/****************************
 * Routine:	File_readln
 * Params:
 * 	- x0,	int fd
 *	- x1,	ptr result
 * Return:
 *	- None
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.global File_readln
File_readln:
	push
	mov	x19,	x0
	ldr	x20,	=szChar
	mov	x21,	x1
	mov x2,		#0
	mov x3,		#0
	clearLoop:
		str x2,	[x21,	x3]
		add	x3,	x3,	#8
		cmp	x3,	#128
		b.lt clearLoop
	str	x2,		[x20]
	
	File_readln_loop:
		mov	x8,	read
		mov	x2,	#1
		mov	x0,	x19
		mov	x1,	x20
		svc	0
		
		// Compare the current character
		ldrb	w3,	[x20]
		cmp	x0,	#0
		b.eq	File_readln_done
		strb	w3,	[x21],	#1
		cmp	w3,	#'\n'
		b.eq	File_readln_done
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
.global File_writeln
File_writeln:
	push
	mov	x19,	x0
	mov	x20,	x1
	mov	x0,		x1
	bl String_length
	// Write string
	sub	x2,		x0,	#1
	mov	x8,		write
	mov	x1,		x20
	mov	x0,		x19
	svc	0
	// Write newline character
	mov	x2,	#1
	ldr	x1,	=chCr
	mov	x0,	x19
	svc 0
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
.global File_write
File_write:
	push
	mov	x8,		write
	mov	x19,	x0
	mov	x20,	x1
	mov	x0,		x1
	bl String_length
	// Write string
	mov x8,		#64
	sub	x2,		x0,	#1
	mov	x1,		x20
	mov	x0,		x19
	svc	0
	pop
	ret

/****************************
 * Routine:	File_readAll
 * Params:
 * 	- x0,	int fd
 * 	- x1,	ptr head
 *	- x2,	ptr tail
 * Return:
 *	- None
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.global File_readAll
File_readAll:
	push
	mov	x20,	x0	// fd
	mov	x21,	x1	// head
	mov	x22,	x2	// tail
	ldr	x24,	=szRes
	mov x27,	#0
	
	File_readAll_loop:
		str	x27,	[x24]
		mov	x0,	x20
		mov	x1,	x24
		bl 	File_readln
		ldr	x0,	[x24]
		cmp	x0,	#0
		b.eq	File_readAll_end
		mov x0,	x21
		mov	x1,	x22
		mov	x2,	x24
		bl	LL_add
		b	File_readAll_loop
	
	File_readAll_end:
		pop
		ret


	.data
		szChar:	.skip	21
		szRes:	.skip	128
		chCr:	.byte	10
