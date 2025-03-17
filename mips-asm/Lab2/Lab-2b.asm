# --------------------------------
# CS106 Practical Assignment 2(b)
# Array indexing
# --------------------------------

# sample input data

.data
A:    .half     1    2   3  4 5
B:    .half 10000 1000 100 10 1
.text
      la    $a0, A
      la    $a1, B
      li    $a2, 5            # length of arrays

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Register $a0 contains the address of an array A of halfwords.
# Register $a1 contains the address of an array B of halfwords.
# Place B[A[1]] in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

       # Load A[1]
       lh    $t0, 2($a0)         # Load the second element of A into $t0 (index value)
       
       # Compute offset in B (index * 2 because halfword = 2 bytes)
       sll   $t0, $t0, 1         # Multiply index by 2
       
       # Compute effective address for B[A[1]]
       addu  $t1, $a1, $t0       # Add base address of B and offset
       
       # Load B[A[1]]
       lh    $v0, 0($t1)         # Load B[A[1]] into $v0



# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-2b-Tests.asm"
