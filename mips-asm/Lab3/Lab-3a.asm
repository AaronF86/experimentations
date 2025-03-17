# --------------------------------
# CS106 Practical Assignment 3(a)
# Bitfields: Extracting data
# --------------------------------

# sample input data

.data

A:    .half 0x5555 0x7777 0x3EEF 0x7ACE 0x2BCD 0x1234

.text
CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Data format (16 bits): JPGRYMMMMMMMMxxx
# MMMMMMMM is the magic number.
# Write code to extract the magic number from A[0] into $v0
# and the magic number from A[5] into $v1.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE 

     la   $t1, A            # Load address of array into $t1
    
    # Extract magic number from A[0]
    lh   $v0, 0($t1)       # Load halfword at A[0] into $v0
    srl  $v0, $v0, 3       # Shift right by 3 bits to remove trailing bits
    andi $v0, $v0, 0xFF    # Mask out the high bits to keep only 8 bits of the magic number
    
    # Extract magic number from A[5] (little-endian)
    lh   $v1, 10($t1)      # Load halfword at A[5] into $v1 (offset 10 bytes)
    srl  $v1, $v1, 3       # Shift right by 3 bits to remove trailing bits
    andi $v1, $v1, 0xFF    # Mask out the high bits to keep only 8 bits of the magic number



    



# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-3a-Tests.asm"
