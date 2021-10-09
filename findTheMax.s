#########################################################################
#Program to find the maximum among a list using Max 3 procedure		#
#									#
#########################################################################

 .data


T20numbers:  .word    -15, -13 , -19 , -8, -7 , -10 , -8 , -110 , -20 , -14  # The five numbers

max:        .space 4 		                  # space reserved for the maximum


.text


	#Load the first 3 numbers to the register
		
	la $t1 , T20numbers # $t1 = 0x10010040
	lw $t2 , 0($t1)     # $t2 = 12 from 0x10010040
	lw $t3 , 4($t1)     # $t3 = 20 from 0x10010044
	lw $t4 , 8($t1)     # $t4 = -9 from 0x10010048
	lw $t5 , 12($t1)    # $t5 = 13  
	lw $t6 , 16($t1)    # $t6 = 15  
	lw $t7 , 20($t1)    # $t7 = 18  
	lw $t8 , 24($t1)    # $t8 = -8  
	lw $t9 , 28($t1)    # $t9 = 10  
	lw $s0 , 32($t1)    # $s0 = 20
	lw $s1 , 36($t1)    # $s1 = -14    	
	#transfer the temp register to the parameters 
	ori $a0, $t2 ,0 # a0 = 12
	ori $a1, $t3 ,0 # a1 = 20
	ori $a2, $t4 ,0 # a2 = -9
	jal  Max3
	################
	move $t0, $v0
	ori $a0, $t0 ,0 
	ori $a1, $t5 ,0 
	ori $a2, $t6 ,0 
	jal  Max3
	#################
	move $t0, $v0
	ori $a0, $t0 ,0 
	ori $a1, $t7 ,0 
	ori $a2, $t8 ,0
	jal  Max3
	#################
	move $t0, $v0
	ori $a0, $t0 ,0 
	ori $a1, $t9 ,0 
	ori $a2, $s0 ,0 
	jal  Max3
	#################
	move $t0, $v0
	ori $a0, $t0 ,0 
	ori $a1, $s0 ,0 
	ori $a2, $s1 ,0 
	jal  Max3
 





################################################################################################
	# save $v0 to Max3
	sw $v0 ,max
	lw $a0, max		# load max into $a0

	# now print the result
	li 	$v0, 1		# set up the print int syscall
	syscall
	
	#exit
	li 	$v0, 10		# set up exit syscall
	syscall
##################################################################################################
#Max procedure
Max3:  	        add  $v0,$a0,$zero 		# move a0 into v0
		sub  $t0,$a1,$v0 		# $t0  <-($a1) – ($a0) 
		bltz $t0,L1	                # ($a1) –($a0) < 0 # ($t0) < 0 then go to L1
		add  $v0, $a1,$zero		#$v0<- ($a1)-($a0)+($a0) # ($v0) <-($a1 ) largest
L1 :		sub  $t0,$a2,$v0  		#$t0<- ($a2) – ($a0)
		bltz $t0,L2     		#($a2) < ($a0) then go to L2 # ($a2)-($a0) <0
		add  $v0, $a2,$zero		
L2:		jr	$ra			#return Max3

###################################################################################################
