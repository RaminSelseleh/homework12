/*
 * Ramin Selseleh
 * Homework 12
 * theia
 */

@ homework 12 register useage and details
@ r0, r1, r2 used for storing in the first part of the assignemnt

@ r4 = row index 
    ROWS         .req r4

@ r5 = column index 
    COLS         .req r5

@ r8 = holds the sum
    the_sum     .req r8


 .global main
main:
        @ display name
	    LDR R0, =name
	    BL printf

    @ show the date and time
date_and_Time:
	    LDR R0, =date
	    BL system

@ getting the day of the year 
	    LDR R0, =epoch
	    BL localtime
	    LDR R1, =broken_down
	    STR R0, [R1]
	    LDR R1, [R0, #28]
	    ADD R1, R1, #1

    @ seeding the rand function using BL sand
	    MOV R0, R1
	    BL srand


@ create a 2 x 4 and fill woth random numbers
@ numbers should be 0-127
/*    
    * Register usage
    * R3 = random
    * R4 = row index 
    * R5 = column index
    */

	    MOV ROWS, #0      @ R4 is the row index
	
outer_loop:

	    MOV COLS, #0	        @ R5 is the colum index
	

inner_loop:

	    BL rand
	    mov R1, #max_amount     @ max_amount set in the .data section
	    BL divide
	    MOV R3, R1         
	
    @ store the numbers in array
    	mov R0, ROWS
	    mov R1, COLS
	    mov R2, R3
	    BL set

    @ get next column
	    ADD COLS, COLS, #1

    @ if less then, loop again
	    CMP COLS, #col
	    BLT inner_loop              @ Are we on the last column of the row?
	
    @ else get next row
	    ADD ROWS, ROWS, #1

    @ if less then r4, get next row
	    CMP ROWS, #row
	    BLT outer_loop              @ Have we finised last row?
	
    @ dump the values using array.s
	    BL dump

get_sum:
	MOV the_sum, #0		@ set sum to zero 
                        @ using r8, labled as the_sum

    @ get sum for (0,0)
	MOV R0, #0
	MOV R1, #0
	BL get

    @ add and store in r8 or the_sum
	ADD the_sum, the_sum, R0

    @ get sum for (0,2)
	MOV R0, #0
	MOV R1, #2
	BL get

    @ add and store in r8 or the_sum
	ADD the_sum, the_sum, R0

    @ get sum for (1,1)
	MOV R0, #1
	MOV R1, #1
	BL get

    @ add and store in r8 or the_sum
	ADD the_sum, the_sum, R0

    @ get sum for (1,3)
	MOV R0, #1
	MOV R1, #3
	BL get
    
    @ add and store in r8 or the_sum
	ADD the_sum, the_sum, R0


    @ display the sum here  
display:
	    MOV R1, the_sum
	    LDR R0, =sum
	    BL printf

exit:					
	    MOV R7, #1
	    SWI 0
	

.data
	.equ max_amount, 128        @ using .equ

name:
	.asciz "Ramin Selseleh\n"

date:
	.asciz "date"

format:
	.asciz "Row: %d  Column: %d  Value: %d\n"
	
	.equ row, 2
	.equ col, 4

sum:
    .asciz "The sum of (0,0), (0, 2), (1,1) and (1,3) is: %d\n"

epoch:
    .word 0

broken_down:
    .word 0





