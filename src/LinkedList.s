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
 * Routine:	LL_isEmpty
 * Params:
 * 	- x0:	int head
 * Return:
 *	- x0:	bool empty
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.global LL_isEmpty
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
.global LL_add
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
		bl new
		mov	x22,	#0
		str	x21,	[x0]	// Load new ptr into node
		str	x22,	[x0,	#8]
		str	x0,	[x19]	// Make head
		str	x0,	[x20]	// Make tail
		b	LL_add_end
		
	
	LL_add_toTail:
		mov	x0,	#16
		bl new
		mov	x22,	#0
		str	x21,	[x0]	// Load new ptr into node
		str	x22,	[x0,	#8]
		ldr	x22,	[x20]
		str	x0,		[x22,	#8]	// Put into tail
		str	x0,		[x20]	// New tail to end
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
.global LL_numNodes
LL_numNodes:
	push
	mov	x19,	x0	// Head
	bl	LL_isEmpty	// Check is empty
	cmp	x0,	#1
	mov x0,	#0
	b.eq	LL_numNodes_end
	ldr	x19,	[x19]	// Get first node


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
.global LL_delete
LL_delete:
	push
	mov	x19,	x0	// Head
	mov	x21,	x1	// Search Index
	bl	LL_isEmpty
	cmp	x0,	#1
	b.eq	LL_delete_end
	mov	x25,	x19
	ldr	x19,	[x19]		// Get head pointing to first node
	mov	x0,	#0	// Current index
	mov x24,	#0

	
	LL_delete_loop:
		ldr	x22,	[x19]		// Current pointer
		ldr	x23,	[x19,	#8]	// Current pointer next
		cmp	x0,	x21
		b.eq	LL_delete_found
		cmp	x23,	#0		// Check if next is null
		b.eq	LL_delete_end
		add	x0,	x0,	#1	// Add one to count current node
		mov	x24,	x19		// Store previous pointer in x24
		mov	x19,	x23		// Start on next
		b	LL_delete_loop
	
	LL_delete_found:
		mov	x0,	x22	// Free string
		bl	String_length
		mov	x1,	x0
		mov	x0,	x22
		bl	delete
		cmp x24,	#0
		b.eq	LL_delete_found_head
		str	x23,	[x24,	#8]	// Store next in previous next
		b	LL_delete_found_two
	
	LL_delete_found_head:
		str x23,	[x25]
		b	LL_delete_found_two
	
	LL_delete_found_two:
		mov	x0,	x19	// Delete node
		mov	x1,	#16
		bl	delete
		b	LL_delete_end
	
	LL_delete_end:
		pop
		ret

/****************************
 * Routine:	LL_print
 * Params:
 * 	- x0:	int head
 *	- x1:	int fd
 * Return:
 *	- Nothing
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.global LL_print
LL_print:
	push
	mov	x19,	x0	//Head
	mov	x23,	x1
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
		mov	x2,	x23
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
 *	- x2:	int fd
 * Return:
 *	- Nothing
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.global LL_printNode
LL_printNode:
	push
	mov	x19,	x1
	mov	x20,	x0
	mov	x21,	x2
	mov	x0,	x21
	ldr	x1,	=szLine
	bl	File_write
	mov	x0,	x20
	ldr	x1,	=szBuff
	bl	int64asc
	mov	x0,	x21
	ldr	x1,	=szBuff
	bl	File_write
	mov	x0,	x21
	ldr	x1,	=szSemi
	bl	File_write
	mov	x0,	x21
	mov	x1,	x19
	bl	File_write
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
.global LL_replace
LL_replace:
	push
	mov	x19,	x0	// Head
	mov	x21,	x1	// Search Index
	mov	x0,	x2		// String to replace
	bl	String_copyln
	mov	x22,	x0
	bl	LL_isEmpty
	cmp	x0,	#1
	b.eq	LL_replace_end
	ldr	x19,	[x19]		// Get head pointing to first node
	mov	x0,	#0	// Current index

	
	LL_replace_loop:
		ldr	x23,	[x19]		// Current pointer
		ldr	x24,	[x19,	#8]	// Current pointer next
		cmp	x0,	x21
		b.eq	LL_replace_found
		add	x0,	x0,	#1	// Add one to count current node
		cmp	x24,	#0		// Check if next is null
		b.eq	LL_replace_end
		mov	x25,	x19		// Store previous poiner in x24
		mov	x19,	x24		// Start on next
		b	LL_replace_loop
	
	LL_replace_found:
		mov	x0,		x23	// Free string
		bl	String_length
		mov	x1,	x0
		mov	x0,	x23
		bl	delete
		str	x22,	[x19]	
		b	LL_replace_end
	
	LL_replace_end:
		pop
		ret

/****************************
 * Routine:	LL_search
 * Params:
 * 	- x0:	head
 *	- x1:	ptr substr
 *	- x2:	fd
 * Return:
 *	- Nothing
 * Author: 	Ezekiel Kim
 * Professor: 	Barnett
 ***************************/
.global LL_search
LL_search:
	push
	mov	x19,	x0	// Head
	mov	x20,	x1	// Substr
	mov	x24,	x2	// fd
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
		b.ne	LL_search_found
		mov	x19,	x23
		cmp x19,	#0
		b.eq	LL_search_end
		b	LL_search_loop

	LL_search_found:
		sub	x0,	x21,	#1	// Index
		mov	x1,	x22	// Ptr String
		mov x2,	x24
		bl	LL_printNode
		mov	x19,	x23
		cmp x19,	#0
		b.eq LL_search_end
		b	LL_search_loop
	
	LL_search_end:
		pop
		ret



.global LL_deleteAll
LL_deleteAll:
	push
	mov	x19,	x0	// Head
	mov x21,	x0	// Actual Head
	mov	x20,	x1	// Tail
	bl	LL_isEmpty
	cmp	x0,	#1
	b.eq	LL_deleteAll_end
	ldr	x19,	[x19]		// Get head pointing to first node

	
	LL_deleteAll_loop:
		ldr	x22,	[x19]		// Current pointer
		ldr	x23,	[x19,	#8]	// Current pointer next
		mov	x0,	x22	// Free string
		bl	free
		mov	x0,	x19	// Free node
		bl	free
		cmp	x23,	#0		// Check if next is null
		b.eq	LL_deleteAll_end
		mov	x19,	x23		// Start on next
		b	LL_deleteAll_loop
	
	LL_deleteAll_end:
		mov	x0,	#0
		str	x0,	[x21]
		str x0,	[x20]
		pop
		ret

.global new
new:
	push
	mov	x19,	x0
	bl malloc
	ldr	x1,	=dbSp
	ldr	x1,	[x1]
	add	x1,	x1,	x19
	ldr	x2,	=dbSp
	str	x1,	[x2]
	pop
	ret

.global getHeapSize
getHeapSize:
	push
	ldr	x0,	=dbSp
	ldr	x0,	[x0]
	pop
	ret

.global delete
delete:
	push
	mov	x19,	x1
	bl	free
	ldr	x1,	=dbSp
	ldr	x1,	[x1]
	sub	x1,	x1,	x19
	ldr	x2,	=dbSp
	str	x1,	[x2]	
	pop
	ret
		
	.data
		szLine:	.asciz	"Line "
		szSemi:	.asciz	": "
		dbSp:	.quad	0
		szBuff:	.skip	128

.end
