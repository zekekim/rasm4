// DRIVER

.include "macros.inc"

.global _start


getInt:
		push
		ldr x0, =szInt
		bl	putstring
		ldr	x0,	=szBuff
		bl 	getstring
		ldr	x0,	=szBuff
		bl	ascint64
		pop
		ret

_start:
	bl	openFiles
	input:
		ldr	x0,	=ptrHead
		bl	Menu
		bl	getInt
		cmp w0,	#1
		b.eq	printAll
		cmp w0, #2
		b.eq	num2
		cmp	w0,	#3
		b.eq	delete
		cmp w0, #4
		b.eq	replace
		cmp w0, #5
		b.eq 	search
		cmp w0,	#6
		b.eq	save
		cmp w0, #7
		b.eq	quit
		b	input

	openFiles:
		push
		ldr	x0,	=inputFile
		bl	File_open_read
		ldr x1,	=fdIn
		str	x0,	[x1]
		ldr	x0,	=outputFile
		bl	File_open_write
		ldr	x1,	=fdOut
		str	x0,	[x1]
		pop
		ret
	
	printAll:
		ldr x0,	=ptrHead
		ldr x1,	=fdOut
		ldr x1,	[x1]
		bl	LL_print
		b	input

	num2:
		ldr x0,	=szCharIn
		bl 	putstring
		ldr x0,	=szBuff
		bl 	getstring
		ldr	x0,	=szBuff
		ldrb	w0,	[x0]
		cmp	w0,	#'a'
		b.eq 	addFromKeyb
		cmp	w0,	#'b'
		b.eq	addAll
		b	input

	    addFromKeyb:
			ldr x0, =szString
			bl putstring
        	ldr x0, =szBuff
        	bl  getstring 
			ldr	x0,	=ptrHead
			ldr x1, =ptrTail      
			ldr	x2,	=szBuff
			bl	LL_add
			b	input
	
		addAll:
			ldr	x0,	=fdIn
			ldr	x0,	[x0]
			ldr	x1,	=ptrHead
			ldr	x2,	=ptrTail
			bl	File_readAll
			b	input
	
	delete:
		bl	getInt
		mov	x1,	x0
		ldr	x0,	=ptrHead
		bl	LL_delete
		b	input

	replace:
		bl getInt
		mov	x19,	x0
		ldr x0,	=szString
		bl	putstring
		ldr	x0,	=szBuff
		bl	getstring
		ldr	x0,	=ptrHead
		mov	x1,	x19
		ldr	x2,	=szBuff
		bl	LL_replace
		b	input

	search:
		ldr x0,	=szString
		bl	putstring
		ldr	x0,	=szBuff
		bl	getstring
		ldr	x0,	=ptrHead
		ldr	x1,	=szBuff
		ldr x2,	=fdOut
		ldr x2,	[x2]
		bl	LL_search
		b 	input

	save:
		ldr	x0,	=fdOut
		ldr	x0,	[x0]
		bl	File_close
		b	input
	
	quit:
		ldr	x0,	=fdOut
		ldr	x0,	[x0]
		bl	File_close
		ldr	x0,	=fdIn
		ldr	x0,	[x0]
		bl	File_close
		ldr	x0,	=ptrHead
		ldr	x1,	=ptrTail
		bl	LL_deleteAll

		// Setup the parameters to exit the program and then call Linux to do it.
		mov	x0,	#0	// Sets return code to 0
		mov	x8,	#93	// Service command code 93 terminates
		svc	0	// Call linux to terminate the program

.data
	inputFile:		    .asciz	"input.txt"
	fdIn:				.quad	0
	outputFile:		    .asciz	"output.txt"
	fdOut:				.quad	0
	szBuff:				.skip	100
	ptrHead:			.quad	0
	ptrTail:			.quad	0
	szInt:				.asciz  "Enter an int > "
	szString:			.asciz	"Enter a string > "
	szCharIn:			.asciz	"Enter a char > "
	
.end

	
