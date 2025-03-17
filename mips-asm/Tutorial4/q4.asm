# Implement in Mips
#
# repeat
# {
# // loop body
# }
# until (z > 0);
# // continue here

.text
Loop:
    #Loop Body
    
    beqz $t1,Loop
    # continue here
        
 