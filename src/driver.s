// DRIVER

	.global _start
	.data
		inputFile:		.asciz	"input.txt"
		outputFile:		.asciz	"output.txt"
		szBuff:				.skip	21
		szChar:				.skip	21
		ptrHead:			.quad	0
		ptrTail:			.quad	0

		
	bl Menu