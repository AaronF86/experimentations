# --------------------------------
# CS106 Practical Assignment 5(a)
# Unsigned overflow
# --------------------------------

.data
A:    .half 99 101
.text
      la    $a0, A
      la    $a1, A+2

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Add the unsigned 16-bit numbers at the addresses in $a0 and $a1.
# If no overflow (as 16-bit unsigned integers) occurred, place their sum in $v0.
# If overflow did occur, place the minimum possible 32-bit signed value in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

      lhu    $t0, 0($a0)   # Load the first 16-bit unsigned number from the address in $a0 into $t0
      lhu    $t1, 0($a1)   # Load the second 16-bit unsigned number from the address in $a1 into $t1

      add  $t2, $t0, $t1   # Add the two numbers. The result (sum) is stored in $t2

      # Check for unsigned overflow (16-bit overflow check).
      # If the sum exceeds 0xFFFF (the maximum value for a 16-bit unsigned integer), it will overflow.
      bleu  $t2, 0xFFFF, no_overflow  # If $t2 <= 0xFFFF, jump to 'no_overflow'

      li     $v0, 0x80000000  # Load the minimum signed 32-bit value (0x80000000) into $v0 to signal overflow
      j     done               # Jump to the 'done' label to exit

no_overflow:
      # If no overflow, store the sum in $v0
      move  $v0, $t2        # Move the sum from $t2 into $v0, which will hold the result

done:
# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-5a-Tests.asm"
