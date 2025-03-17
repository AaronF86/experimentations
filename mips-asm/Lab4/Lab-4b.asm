# --------------------------------
# CS106 Practical Assignment 4(b)
# Making a string uppercase
# --------------------------------

# sample input data

.data
S:    .asciiz "Convert this string from lower to upper case!"
.text
      la    $a0, S

CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# The address of the first character of a null-terminated string
# will be in $a0. Convert the string to uppercase.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE
    lb    $t0, 0($a0)          # Load the character from memory into $t0
    beqz  $t0, Done            # If character is null terminator, stop

    # Check if character is between 'a' and 'z'
    blt   $t0, 0x61, NotLowerCase # If less than 'a', skip
    bgt   $t0, 0x7A, NotLowerCase # If greater than 'z', skip
    
    # Convert to uppercase by subtracting 0x20
    subi  $t0, $t0, 0x20        # Subtract 0x20 to make uppercase
    
    sb    $t0, 0($a0)           # Store back the updated character

NotLowerCase:
    addi  $a0, $a0, 1           # Move to next character
    j     CodeToTest            # Repeat for the next character

Done:
    # Exit or return to caller

# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-4b-Tests.asm"
