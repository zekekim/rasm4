/****************************
 * Routine:	Menu
 * Params:
 * 	- None
 * Return:
 *	- None
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
	.include	"../include/macros.inc"
	.data:
		szMsg1:		.asciz	"RASM4 TEXT EDITOR\n"
		szMsg2:		.asciz	"Data Structure Heap Memory Consumption: "
		// Output num of bytes
		szMsg3: 	.asciz	"bytes\n"
		szMsg4:		.asciz	"Number of nodes: "
		// Output num of nodes
		szMsg5:		.asciz	"\n<1> View all strings\n\n"
		szMsg6:		.asciz	"<2> Add String\n\t<a> from Keyboard\n\t<b> From File. Static file named input.txt\n\n"
		szMsg7:		.asciz	"<3> Delete string. Given an index #, delete the entire string and de-alocate memory (including the node).\n\n"
		szMsg8:		.asciz	"<4> Edit string. Given an index #, replace old string w/ new string. Allocate/ De-allocate as needed.\n\n"
		szMsg9:		.asciz	"<5> String search. Regardless of case, return all Striings that match the substring given.\n\n"
		szMsg10:	.asciz	"<6> Save File (output.txt)\n\n"
		szMsg11:	.asciz	"<7> Quit\n\n"

	Menu:
		push
		ldr	x0,	=szMsg1
		bl	putstring
		ldr	x0,	=szMsg2
		bl	putstring
		// TODO: output num of bytes in heap
		ldr	x0,	=szMsg3
		bl	putstring
		ldr	x0,	=szMsg4
		bl	putstring
		// TODO: output num of nodes
		ldr	x0,	=szMsg5
		bl	putstring
		ldr	x0,	=szMsg6
		bl	putstring
		ldr	x0,	=szMsg7
		bl	putstring
		ldr	x0,	=szMsg8
		bl	putstring
		ldr	x0,	=szMsg9
		bl	putstring
		ldr	x0,	=szMsg10
		bl	putstring
		ldr	x0,	=szMsg11
		bl	putstring
		pop
		ret
