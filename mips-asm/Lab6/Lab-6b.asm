# --------------------------------
# CS106 Practical Assignment 6(b)
# Vector dot product by shifting and adding
# --------------------------------

# sample input data

.data
A:    .half     1    2   3  4 5
B:    .half 10000 1000 100 10 1
.text
      la    $a0, A
      la    $a1, B
      li    $a2, 5

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Calculate the dot product of the halfword vectors at $a0 and $a1.
# The vector length is given in $a2.
# Place the result in $v0.
# Do not use mul or div.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

    li $v0, 0              # Initialize sum to 0
    li $t0, 0              # i = 0

loop:
    bge $t0, $a2, end      # while i < n

    # Load half-words from arrays
    lh $t1, 0($a0)         # Load u[i] into $t1
    lh $t2, 0($a1)         # Load v[i] into $t2
    
    # Simulate multiplication using shifting and addition
    li $t3, 0              # product = 0
    li $t4, 0              # bit index
    
multiply:
    andi $t5, $t2, 1        # Check if LSB of v[i] is 1
    beqz $t5, skip_add      # If LSB is 0, skip addition
    
    addu $t3, $t3, $t1      # Add u[i] to product
    
skip_add:
    sll $t1, $t1, 1         # Left shift u[i] by 1
    srl $t2, $t2, 1         # Right shift v[i] by 1
    addi $t4, $t4, 1        # Increment bit index
    bnez $t2, multiply      # If v[i] != 0, repeat multiplication
    
    # Add product to sum
    addu $v0, $v0, $t3

    # Increment array pointers and loop index
    addi $a0, $a0, 2        # Move to next element of u
    addi $a1, $a1, 2        # Move to next element of v
    addi $t0, $t0, 1        # i++

    j loop
end:

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-6b-Tests.asm"
