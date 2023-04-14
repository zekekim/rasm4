// CONSTANTS

// For open
.equ    cwd, 	-101
.equ	open,   56
.equ	flags,  0100
.equ	mode,   0644

// For close
.equ    close,	57

// For read
.equ	read,   63

// For write
.equ	write,  64

// MACROS

// push
.macro push
stp	x29,	x30,	[sp,	#-16]!
stp	x27,	x28,	[sp,	#-16]!
stp	x25,	x26,	[sp,	#-16]!
stp	x23,	x24,	[sp,	#-16]!
stp	x21,	x22,	[sp,	#-16]!
stp	x19,	x20,	[sp,	#-16]!
.endm

// pop
.macro pop
ldp	x19,	x20,	[sp],	#16
ldp	x21,	x22,	[sp],	#16
ldp	x23,	x24,	[sp],	#16
ldp	x25,	x26,	[sp],	#16
ldp	x27,	x28,	[sp],	#16
ldp	x29,	x30,	[sp],	#16
.endm
