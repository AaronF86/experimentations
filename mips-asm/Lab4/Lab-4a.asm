# --------------------------------
# CS106 Practical Assignment 4(a)
# Making a character uppercase
# --------------------------------

# sample input data

.data
S:    .asciiz "x"
.text
      la    $a0, S

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# The address of an ASCII character will be in $a0. If the
# character is a lower case letter, replace it (in memory) with
# its upper case version. Otherwise don't change it.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE
    lb    $t0, 0($a0)      # Load the character from memory into $t0
    # Check if character is between 'a' and 'z'
    blt   $t0, 0x61, NotLowerCase # If character is less than 'a', skip
    bgt   $t0, 0x7A, NotLowerCase # If character is greater than 'z', skip
    
    # Convert to uppercase by subtracting 0x20
    subi   $t0, $t0, 0x20     # Subtract 0x20 from the character to make it uppercase
    
    sb    $t0, 0($a0)       # Store the updated character back to memory
NotLowerCase:

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-4a-Tests.asm"
