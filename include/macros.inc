// CONSTANTS

// For open
cwd 	equ 	-101
open	equ	56
flags	equ	0100
mode	equ	0600

// For close
close	equ	57

// For read
read	equ	63

// For write
write	equ	40

// MACROS

// push
MACRO
push
stp	x29,	x30,	[sp,	#-16]!
stp	x27,	x28,	[sp,	#-16]!
stp	x25,	x26,	[sp,	#-16]!
stp	x23,	x24,	[sp,	#-16]!
stp	x21,	x22,	[sp,	#-16]!
stp	x19,	x20,	[sp,	#-16]!
MEND

// pop
MACRO
pop
ldp	x19,	x20,	[sp],	#16
ldp	x21,	x22,	[sp],	#16
ldp	x23,	x24,	[sp],	#16
ldp	x25,	x26,	[sp],	#16
ldp	x27,	x28,	[sp],	#16
ldp	x29,	x30,	[sp],	#16
MEND

