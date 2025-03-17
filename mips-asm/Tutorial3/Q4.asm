# Implement the code shown below in MIPS. You may assume that y is stored in $a2.
#
# if (y > 0)
# {
# // action if test is true
# }
# else
# {
# // action if test is false
# }
# // either way, continue here

.data
    true_msg: .asciiz "Test is true\n"
    false_msg: .asciiz "Test is false\n"

.text

main:
    # Check if y > 0
    blez $a2, else_case   # If y <= 0, branch to else_case
    
    # Action if test is true
    li $v0, 4              # Load system call code for print string
    la $a0, true_msg       # Load address of true_msg
    syscall
    
    j continue_case        # Jump to continue_case
    
else_case:
    # Action if test is false
    li $v0, 4              # Load system call code for print string
    la $a0, false_msg      # Load address of false_msg
    syscall
    
continue_case:
    # Code to continue execution after the if-else block
    
    li $v0, 10             # Load system call code for exit
    syscall
