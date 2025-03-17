# --------------------------------
# CS106 Practical Assignment 2(a)
# Pointers
# --------------------------------

# sample input data

.data
P:    .word 99
Q:    .word 101
.text
      la    $a0, P
      la    $a1, Q

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Registers $a0 and $a1 will contain pointers to words in memory.
# Read the words at memory locations $a0 and $a1, and place their
# product back into memory location $a0.

# • Multiply the two words together and store the resulting value back into the memory
#location pointed to by $a0. (thank for not putting this in comments)
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

      lw $t0, ($a0)     # Load word at address in $a0 (P)
      lw $t1, ($a1)     # Load word at address in $a1 (Q)
      mul $t2, $t0, $t1 # Multiply the values and store the result in $t2
      sw $t2, ($a0)     # Store the result back into the memory location pointed to by $a0


# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-2a-Tests.asm"
