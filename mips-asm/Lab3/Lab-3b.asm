# --------------------------------
# CS106 Practical Assignment 3(b)
# Bitfields: Modifying data
# --------------------------------

# sample input data

.data

A:    .half 0x5555 0x7777 0x3EEF 0x7ACE 0x2BCD 0x1234

.text
CodeToTest:                   # label for running tests
# ----------------------------------------------------------------
# Data format (16 bits): JPGRYMMMMMMMMxxx
# MMMMMMMM is the magic number.
# Write code to load A[1] and change its magic number to PG0YPG1Y.
# Place the modified A[1] in $v0.
# ----------------------------------------------------------------
# YOUR CODE STARTS HERE

    la   $t0, A            # Load Address of A into t0
    lh   $t1, 2($t0)       # Load A[1] in to t1
    andi $t1, $t1, 0xF807  # Isolate non Magic values
    
    srl  $t2, $t1, 4       # Shift values to the right to get first 4 bits of magic number
    andi $t2, $t2, 0x680   # mask out values that are not the 4 MSB of magic number
 
    srl  $t3, $t2, 4       # Shift first 4 bits to the last LSB of magic number
    or   $t3, $t3, 0x10    # mask 2nd LSB of magic number to 1
    
    or   $t2, $t2, $t3     #combine to get full magic numnber
    or   $v0, $t2, $t1     # add back reset of values
    
# YOUR CODE ENDS HERE
# ----------------------------------------------------------------

# UNCOMMENT THE FOLLOWING LINE TO TEST YOUR CODE
.include "Lab-3b-Tests.asm"
