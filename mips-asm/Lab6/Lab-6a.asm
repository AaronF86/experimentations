# --------------------------------
# CS106 Practical Assignment 6(a)
# Multiplication by shifting and adding
# --------------------------------

# sample input data

.data
A:    .half 99 101
.text
      la    $a0, A # M 
      la    $a1, A+2 # Q

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Multiply the 16-bit numbers at the addresses in $a0 and $a1.
# Place the result in $v0.
# Do not use mul or div.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

      # Load values into registers
      lh $t0, 0($a0)     # Load multiplicand M into $t0
      lh $t1, 0($a1)     # Load multiplier Q into $t1
      move $v0, $zero    # Clear the result register

loop:
      # Check if multiplier is zero (end condition)
      beqz $t1, end      # If $t1 (multiplier) is 0, end the loop

      # If the least significant bit of $t1 is 1, add $t0 to the result
      andi $t2, $t1, 1   # Check the least significant bit of the multiplier
      beqz $t2, skip_add # If LSB of $t1 is 0, skip adding

      addu $v0, $v0, $t0  # Add the multiplicand to result

skip_add:
      # Shift multiplicand and multiplier
      sll $t0, $t0, 1    # Shift multiplicand left by 1
      srl $t1, $t1, 1    # Shift multiplier right by 1

      j loop             # Jump to loop for next iteration
end:
# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-6a-Tests.asm"
