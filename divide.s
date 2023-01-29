/*
 * divide.s
 * Implement long division as described in
 * text Chapter 12 Division and Remainder
 * This code works on all Raspberry Pi.
 * R0 = dividend
 * R1 = divisor
 * Return R0 = quotient
 * Return R1 = remainder
 */

	.global divide
divide:
	STMFD SP!, {R4, LR}	@ Preserve R4 and Link Register
	MOV R2, R1	@ Divisor is in R2
	MOV R1, R0	@ Dividend is in R1
	MOV R4, R2
	CMP R4, R1, LSR #1
Div1:	MOVLS R4, R4, LSL #1
	CMP R4, R1, LSR #1
	BLS Div1
	MOV R3, #0

Div2:	CMP R1, R4
	SUBCS R1, R1, R4
	ADC R3, R3, R3
	MOV R4, R4, LSR #1
	CMP R4, R2
	BHS Div2
	MOV R0, R3
	LDMFD SP!, {R4, PC}
