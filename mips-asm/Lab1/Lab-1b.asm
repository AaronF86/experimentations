# --------------------------------
# CS106 Practical Assignment 1(b)
# ax^2 + bx + c
# --------------------------------

# sample input data

.data
A:    .word 100
B:    .word 10
C:    .word 1
.text
      li    $a0, 3

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Write code to evaluate ax^2 + bx + c.
# a, b and c are in memory addresses A, B and C.
# x is in register $a0.
# Place the result in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE
	
    # Load Data into registers
    lw $t0, A         # Load A into $t0
    lw $t1, B         # Load B into $t1
    lw $t2, C         # Load C into $t2
    
    # Calculate bx
    mul $t1, $t1, $a0 # t1 = bx
    
    # Calculate ax^2
    mul $t3, $a0, $a0 # t3 = x^2
        # Could have palced x^2 in to a0 to save space but not sure how tests effect value so I
        # not done that.
    mul $t0, $t3, $t0 # t0 = ax^2 
    
    #
    addu $v0, $t0, $t1  # v0 = ax^2 + bx
    addu $v0, $v0, $t2  # v0 = ax^2 + bx + c
        

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-1b-Tests.asm"
