/****************************
 * Object:	LinkedList
 * Params:
 * 	- None
 * Return:
 *	- None
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

	.include	"../includes/macros.inc"

	.data:
		szLine:	.asciz	"Line "
		szSemi:	.asciz	": \""
		szQuot:	.asciz	"\"\n"
		szBuff:	.skip	21

/****************************
 * Routine:	LL_isEmpty
 * Params:
 * 	- x0:	int head
 * Return:
 *	- x0:	bool empty
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

LL_isEmpty:
	push
	mov	x19,	x0
	mov	x0,	#0
	ldr	x19,	[x19]
	cmp	x19,	#0	// If head is a null pointer
	b.eq	LL_isEmpty_true
	b	LL_isEmpty_end
	
	LL_isEmpty_true:
		mov	x0,	#1
		b	LL_isEmpty_end
	
	LL_isEmpty_end:
		pop
		ret

/****************************
 * Routine:	LL_add
 * Params:
 * 	- x0:	int head
	- x1:	int tail
	- x2:	ptr string
 * Return:
	- None
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

LL_add:
	push
	mov	x19,	x0	// Head
	mov	x20,	x1	// Tail
	mov	x0,	x2	// ptr string
	bl	String_copy
	mov	x21,	x0	// new ptr string
	mov	x0,	x19	// Check if empty
	bl	LL_isEmpty
	cmp	x0,	#1
	b.eq	LL_add_createHead
	b	LL_add_toTail

	LL_add_createHead:
		mov	x0,	#16
		bl malloc
		str	x21,	[x0]	// Load new ptr into node
		str	x0,	[x19]	// Make head
		str	x0,	[x20]	// Make tail
		b	LL_add_end
		
	
	LL_add_toTail:
		mov	x0,	#16
		bl malloc
		str	x21,	[x0]	// Load new ptr into node
		mov	x22,	x20	// Tail pointer in x22
		ldr	x20,	[x20]	// Dereference tail, now pointer to tail node
		str	x21,	[x20,	#8]	// Put into tail
		str	x21,	[x22]	// New tail to end
		b	LL_add_end

	LL_add_end:
		pop
		ret

/****************************
 * Routine:	LL_numNodes
 * Params:
 * 	- x0:	int head
 * Return:
	- x0:	int counter
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

LL_numNodes:
	push
	mov	x19,	x0	// Head
	bl	LL_isEmpty	// Check is empty
	cmp	x0,	#1
	b.eq	LL_numNodes_end
	ldr	x19,	[x19]	// Get first node
	mov	x0,	#0	// Counter


	LL_numNodes_loop:
		ldr	x21,	[x19]		// Current pointer
		ldr	x22,	[x19,	#8]	// Current pointer next
		add	x0,	x0,	#1	// Add one to count current node
		cmp	x22,	#0		// Check if next is null
		b.eq	LL_numNodes_end
		mov	x19,	x22
		b	LL_numNodes_loop

	LL_numNodes_end:
		pop
		ret

/****************************
 * Routine:	LL_delete
 * Params:
 * 	- x0:	int head
 *	- x1:	int index
 * Return:
 *	- Nothing
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

LL_delete:
	push
	mov	x19,	x0	// Head
	mov	x21,	x1	// Search Index
	bl	LL_isEmpty
	cmp	x0,	#1
	b.eq	LL_delete_end
	ldr	x19,	[x19]		// Get head pointing to first node
	mov	x0,	#0	// Current index

	
	LL_delete_loop:
		ldr	x22,	[x19]		// Current pointer
		ldr	x23,	[x19,	#8]	// Current pointer next
		add	x0,	x0,	#1	// Add one to count current node
		cmp	x0,	x21
		b.eq	LL_delete_found
		cmp	x23,	#0		// Check if next is null
		b.eq	LL_delete_end
		mov	x24,	x19		// Store previous poiner in x24
		mov	x19,	x23		// Start on next
		b	LL_delete_loop
	
	LL_delete_found:
		mov	x0,	x22	// Free string
		bl	free
		str	x23,	[x24,	#8]	// Store next in previous next
		mov	x0,	x19	// Delete node
		bl	free
		b	LL_delete_end
	
	LL_delete_end:
		pop
		ret

/****************************
 * Routine:	LL_print
 * Params:
 * 	- x0:	int head
 * Return:
 *	- Nothing
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

LL_print:
	push
	mov	x19,	x0	//Head
	bl	LL_isEmpty
	cmp	x0,	#1
	b.eq	LL_print_end
	ldr	x19,	[x19]
	mov	x22,	#0
	
	LL_print_loop:
		ldr	x20,	[x19]
		ldr	x21,	[x19,	#8]
		mov	x0,	x22
		mov	x1,	x20
		bl	LL_printNode
		cmp	x21,	#0
		b.eq	LL_print_end
		mov	x19,	x21
		add	x22,	x22,	#1
		b	LL_print_loop

	LL_print_end:
		pop
		ret
		

/****************************
 * Routine:	LL_print
 * Params:
 * 	- x0:	int index
 *	- x1:	ptr string
 * Return:
 *	- Nothing
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

LL_printNode:
	push
	mov	x19,	x1
	mov	x20,	x0
	ldr	x0,	=szLine
	// TODO print to output.txt
	bl	putstring
	mov	x0,	x20
	ldr	x1,	=szBuff
	bl	int64asc
	ldr	x0,	=szBuff
	bl	putstring
	ldr	x0,	=szSemi
	bl	putstring
	mov	x0,	x19
	bl	putstring
	mov	x0,	=szQuot
	bl	putstring
	pop
	ret

/****************************
 * Routine:	LL_replace
 * Params:
 * 	- x0:	head
 *	- x1:	index
 *	- x2: 	ptr string
 * Return:
 *	- Nothing
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

LL_replace:
	push
	mov	x19,	x0	// Head
	mov	x21,	x1	// Search Index
	mov	x25,	x2	// String to replace
	bl	LL_isEmpty
	cmp	x0,	#1
	b.eq	LL_replace_end
	ldr	x19,	[x19]		// Get head pointing to first node
	mov	x0,	#0	// Current index

	
	LL_replace_loop:
		ldr	x22,	[x19]		// Current pointer
		ldr	x23,	[x19,	#8]	// Current pointer next
		add	x0,	x0,	#1	// Add one to count current node
		cmp	x0,	x21
		b.eq	LL_replace_found
		cmp	x23,	#0		// Check if next is null
		b.eq	LL_replace_end
		mov	x24,	x19		// Store previous poiner in x24
		mov	x19,	x23		// Start on next
		b	LL_replace_loop
	
	LL_replace_found:
		mov	x0,	x22	// Free string
		bl	free
		ldr	x25,	[x19]	
		b	LL_replace_end
	
	LL_replace_end:
		pop
		ret

/****************************
 * Routine:	LL_search
 * Params:
 * 	- x0:	head
 *	- x1:	ptr substr
 * Return:
 *	- Nothing
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/

LL_search:
	push
	mov	x19,	x0	// Head
	mov	x20,	x1	// Substr
	mov	x21,	#0	// Current Index
	bl	LL_isEmpty
	cmp	x0,	#1
	b.eq	LL_search_end
	ldr	x19,	[x19]

	LL_search_loop:
		ldr	x22,	[x19]
		ldr	x23,	[x19,	#8]
		mov	x0,	x22
		mov	x1,	x20
		add	x21,	x21,	#1
		bl	String_substr
		cmp	x0,	#0
		b.eq	LL_search_loop
		sub	x0,	x21,	#1	// Index
		mov	x1,	x22	// Ptr String
		bl	LL_printNode
		mov	x19,	x23
		b	LL_search_loop


		
