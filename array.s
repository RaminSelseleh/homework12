/*
 * array.s
 * Contains two entries called set and get
 *
 * set - sets the value of array
 * R0 = row index
 * R1 = column index
 * R2 = value to set in that index
 * Returns R0 = -1 if index value is out of bounds
 *
 * get - gets the value from array
 * R0 = row index
 * R1 = column index
 * Returns R0 = value if no error or -1 if index value is out of bounds
 * memory location = ( row * column ) + column
 *
 * dump - displays the values in the memory location called array
 */

	.global set
	.global get
	.global dump
set:
	STMFD SP!, {R4, LR}
@ Check for valid index
	CMP R0, #row
	BGE _invalid
	CMP R1, #col
	BGE _invalid
@ Calculate array element to set
	MOV R3, #col
	MUL R4, R0, R3	@ row index * col
	ADD R4, R4, R1
@ Save value in array
	LDR R1, =array
	STRB R2, [R1, R4]
	BAL _set_exit
_invalid:
	MOV R0, #-1
_set_exit:
	LDMFD SP!, {R4, PC}

get:
	STMFD SP!, {R4, LR}
@ Check for valid index
	CMP R0, #row
	BGE _invalid2
	CMP R1, #col
	BGE _invalid2
@ Calculate array element to get
	MOV R3, #col
	MUL R4, R0, R3	@ row index * col
	ADD R4, R4, R1
@ Get value in array
	LDR R1, =array
	LDRB R0, [R1, R4]
	BAL _get_exit
_invalid2:
	MOV R0, #-1
_get_exit:
	LDMFD SP!, {R4, PC}

dump:
/*
 * R4 = address of array
 * R5 = index
 * R6 = array size in bytes
 */
	STMFD SP!, {R4, R5, R6, LR}
	@ Calculate number of bytes
	MOV R0, #row
	MOV R1, #col
	MUL R6, R0, R1
	@ set R4 and R5 to access bytes in array
	LDR R4, =array
	MOV R5, #0
        @ display the first value
	LDRB R1, [R4, R5]
	LDR R0, =data_first
	BL printf
	ADD R5, R5, #1
	@ do
_do:
	LDRB R1, [R4, R5]
	LDR R0, =data_byte
	BL printf
	ADD R5, R5, #1
	@ while R5 < R6
	CMP R5, R6
	BLT _do
	LDR R0, =data_end
	BL printf
	LDMFD SP!, {R4, R5, R6, PC}

.data
data_first:
	.asciz "%d"
data_byte:
	.asciz ", %d"
data_end:
	.asciz "\n"

	.equ row, 2
	.equ col, 4
array:
	.space 100, 0
