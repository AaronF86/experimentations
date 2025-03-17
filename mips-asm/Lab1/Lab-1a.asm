# --------------------------------
# CS106 Practical Assignment 1(a)
# a + 2b + 3c
# --------------------------------

# sample input data

.data
A:    .word 100
B:    .word 10
C:    .word 1

.text
CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Write code to evaluate a + 2b + 3c.
# a, b and c are in memory addresses A, B and C.
# Place the result in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

    # Load Data into registers
    lw $t0, A         # Load A into $t0
    lw $t1, B         # Load B into $t1
    lw $t2, C         # Load C into $t2
    
    # Calculate 2b
    addu $t1, $t1, $t1  # t1 = 2b
    
    # Calculate 3c
    mul $t2, $t2, 3     # t2 = 3c
    
    # Compute a + 2b + 3c
    addu $v0, $t0, $t1  # v0 = a + 2b
    addu $v0, $v0, $t2  # v0 = a + 2b + 3c

	

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-1a-Tests.asm"
