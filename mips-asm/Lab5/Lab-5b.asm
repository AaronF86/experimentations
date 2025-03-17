# --------------------------------
# CS106 Practical Assignment 5(b)
# Signed overflow
# --------------------------------

.data
A:    .half -32768 32767  # Two 16-bit signed integers
newLine: .asciiz "\n"     # Newline string for printing

.text
      la    $a0, A    # Load address of A into $a0
      la    $a1, A+2  # Load address of A+2 into $a1

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Add the signed 16-bit numbers at the addresses in $a0 and $a1.
# If no overflow (as 16-bit signed integers) occurred, place their sum in $v0.
# If overflow did occur, place the minimum possible 32-bit signed value in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

      lh    $a0, 0($a0)   # Load the first 16-bit signed number from the address in $a0
      lh    $a1, 0($a1)   # Load the second 16-bit signed number from the address in $a1

      add  $s0, $a0, $a1  # Add the two numbers together

      # Check for signed overflow:
      # Overflow occurs when the result of addition exceeds the signed 16-bit range (-32768 to 32767)

      # Check if both operands have the same sign and if the result has a different sign
      andi $t0, $a0, 0x8000    # Get sign bit of $a0 (0x8000)
      andi $t1, $a1, 0x8000    # Get sign bit of $a1 (0x8000)
      andi $t2, $s0, 0x8000    # Get sign bit of result (0x8000)

      # If both operands have the same sign but the result has a different sign, overflow occurred
      and  $t3, $t0, $t1        # Check if operands have the same sign 0
      xor  $t4, $t3, $t2        # Check if result sign differs from operand sign 

      and   $t5, $t3, $t4        # If either condition is true, overflow occurred
      bnez $t5, overflow         # If overflow detected, branch to overflow label

      move $v0, $s0             # No overflow, move the sum to $v0
      j done                    # Jump to done

overflow:
      li   $v0, 0x80000000      # Load the minimum signed 32-bit value (overflow value)

done:
# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-5b-Tests.asm"  # Include test cases
