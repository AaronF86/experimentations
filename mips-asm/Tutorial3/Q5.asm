# Implement the code shown below in MIPS.
# you should assume that A is a is a array of ints whose base address is stored in $a0 and that the vars
# j is storaged at $a1
# evenCount is storaged at $s0 
# oddCount is storaged at $s1
#
# if (isOdd(A[j]))
# oddCount = oddCount + 1;
# else
# evenCount = evenCount + 1

.data
A:    .word 1, 2, 3, 4, 5, 6, 7, 8 # Example data

.text
main:
    la $a0, A          # Load base address of array A into $a0
    li $a1, 2          # Load index j = 2 (can be any value)
    li $s0, 0          # Initialize evenCount = 0
    li $s1, 0          # Initialize oddCount = 0
    
    # Get the word at A[j]
    sll $t0, $a1, 2    # Multiply j by 4 to get byte offset
    add $t1, $a0, $t0  # Get address of A[j]
    lw $t2, 0($t1)     # Load value of A[j] into $t2
    
    # Check if A[j] is odd
    andi $t3, $t2, 1   # t3 = A[j] & 1 (if last bit is 1, it's odd)
    beqz $t3, even_case # If 0, it's even
    
    # If odd
    addi $s1, $s1, 1   # Increment oddCount
    j done

even_case:
    addi $s0, $s0, 1   # Increment evenCount

done:
    # Exit
    li $v0, 10
    syscall
