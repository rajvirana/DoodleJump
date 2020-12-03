#####################################################################
#
# CSC258H5S Fall 2020 Assembly Final Project
# University of Toronto, St. George
#
# Student: Rajvi Rana, 1005103745
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# - Milestone 1
#

.data
displayAddress: .word 0x10008000 	# the display address we write pixels to
background: .word 0xbaedff 		# the background colour 
doodlerColour: .word 0x12a173 		# the doodler's colour (1220979 in decimal)
platformColour: .word 0xc28100 		# the platform's colour (12747008 in decimal)
platforms: .space 12			# array of 3 integers
doodlerLoc: .space 4			# the top most coordinate of the doodler

.text
j main

# function for drawing the background on display
displayBackground:	lw $t4, displayAddress 		# load the displayAddress into $t4
			lw $t5, background		# load the background colour into $t5
			add $t0, $zero, $zero 		# $t0 holds i=0
			addi $t1, $zero, 1024 		# $t1 holds 1024, the maximum number of pixels to display
			
BG_LOOP:		bge $t0, $t1, BG_LOOP_EXIT	# exit when i >= 1024
			sll $t2, $t0, 2 		# $t2 = offset = i*4
			add $t3, $t4, $t2		# $t3 = displayAddress[i] the pixel we will be writing to
			sw $t5, 0($t3) 			# write the value at register $t5 into $t3 = displayAddress[i]
			addi $t0, $t0, 1 		# increment i += 1
			j BG_LOOP
	
BG_LOOP_EXIT:		jr $ra

# function for generating a random number (used to decide where a platform should be drawn)
generateRandom:	li $v0, 42
		li $a0, 0
		li $a1, 1008
		syscall # random number will be in $a0
		jr $ra 	# jump back to where we left off in main
	
# function for inserting the random number generated into the correct position of $s4
# PARAMETERS: $a0 - random number, $a1 - offset needed to get platforms[i]
insertNumber:	add $t2, $a0, $zero 	# load the value in $a0 into $t2
		add $t3, $a1, $zero	# load the offset value into $t3
		add $t3, $t3, $s0 	# get platforms[i] by getting the address offset bits away from $s0
		sw $t2, 0($t3)		# load the number into platforms[i]
		jr $ra

# function for displaying the 3 platforms on the screen utilizing the platforms array in $s4 (size = 3)
displayPlatforms:	lw $t9, displayAddress
			lw $s7, platformColour
			add $t0, $zero, $zero 	# i = 0
			addi $t1, $zero, 3	# limit_i = 3
			
PLATFORMS_LOOP:		bge $t0, $t1, DISPLAY_PLATFORMS_EXIT 	# exit when $t0 >= $t1 (i >= 3)
			sll $t2, $t0, 2 			# offset = i*4
			add $t3, $s0, $t2 			# $t3 = addr(platforms[i])
			lw $t4, 0($t3)				# load the value at platforms[i] into $t4, we have the position to display a platform now
			sll $t4, $t4, 2
			add $t4, $t9, $t4			# the position to write to in relation to the displayAddress
		
			add $t5, $zero, $zero			# j = 0
			addi $t6, $zero, 6			# limit_j = 6
			
DISPLAY_PLATFORMS_SUB_LOOP:	bge $t5, $t6, EXIT_DISPLAY_SUB_LOOP 	# exit when j >= 3
				sll $t7, $t5, 2				# sub_offset = j*4
				add $t8, $t4, $t7			# the new positions we want to draw $s3 to in $s0
				sw $s7, 0($t8)				# display the platform colour to $s0 at the appropriate position
				addi $t5, $t5, 1			# j += 1
				j DISPLAY_PLATFORMS_SUB_LOOP
		
EXIT_DISPLAY_SUB_LOOP:	addi $t0, $t0, 1			# increment i += 1
			j PLATFORMS_LOOP
		
DISPLAY_PLATFORMS_EXIT:	jr $ra

# function to display doodler on screen
displayDoodler:	lw $t0, displayAddress	# load the displayAddress into $t0
		lw $t1, doodlerColour 	# load the doodlerColour into $t1
		add $t2, $a0, $zero 	# the topmost coordinate the doodler is drawn at (3776 is the initial position)
		sw $t2, 0($s1)		# save the doodler's current location
		add $t3, $t2, $t0	# the topmost coordinate of the doodler in relation to the displayAdress
		sw $t1, 0($t3)
		sw $t1, 124($t3)
		sw $t1, 128($t3)
		sw $t1, 132($t3)
		sw $t1, 252($t3)
		sw $t1, 260($t3)
		jr $ra

# function to make the program sleep for a certain number of milliseconds
sleep:	li $v0, 32
	li $a0, 1000
	syscall
	jr $ra

# function that checks for keyboard input
checkKeyboardInput:	lw $t8, 0xffff0000	# load the value at this address into $t8
			bne $t8, 1, NO_KEY	# if $t8 != 1, then no key was pressed, exit the function
			lw $t2, 0xffff0004	# load the ascii value of the key that was pressed
			
			beq $t2, 0x73, RESPOND_S
			beq $t2, 0x6a, RESPOND_J
			beq $t2, 0x6b, RESPOND_K
			j NO_KEY
			
			
RESPOND_S:		li $v0, 1
			j EXIT_CHECK_BOARD
RESPOND_J:		li $v0, 2
			j EXIT_CHECK_BOARD
RESPOND_K:		li $v0, 3
			j EXIT_CHECK_BOARD
			
NO_KEY:			add $v0, $zero, $zero	# ensure that $v0 = 0 if no key was pressed
EXIT_CHECK_BOARD:	jr $ra			# exit the function
			
		
main:	# initialize saved registers
	la $s0, platforms 	# $s4 holds the leftmost coordinates of 3 platforms
	la $s1, doodlerLoc 	# $s5 holds the topmost coordinate of the doodler
	li $s2, 1		# $s2 is 1 if the game should continue running, 0 if it should reset to initial position and freeze
	
	add $t0, $zero, $zero # $t0 holds i=0
	addi $t1, $zero, 3 # $t1 holds 3, the maximum number of platforms to display
GENERATE_LOOP1:	bge $t0, $t1, DISPLAY1 	# exit if $t0 >= $t1 (i >= 3)
		jal generateRandom 	# generate a random number in the range of [0, 1008}
		sll $a1, $t0, 2		# offset = i*4
		jal insertNumber	# insert this number into (offset)$s4 = (i*4)$s4
		addi $t0, $t0, 1	# increment i += 1
		j GENERATE_LOOP1 	# if reached, continue to loop
	
DISPLAY1:	jal displayBackground
		li $a0, 3776
		jal displayPlatforms
		jal displayDoodler
			
IF:		jal checkKeyboardInput	# check for keyboard input
		bne $v0, 1, IF	# if 's' was pressed, start the game
		j GAME_LOOP
	
GAME_LOOP:	beqz $s2, EXIT
		jal checkKeyboardInput	# check if a key has been pressed
		
		beq $v0, 1, IF		# if 's' has been pressed, then go back to IF		
		
###### NOTE THAT THIS SECTION WILL BE REPLACED WITH A CALCULATE/UPDATE PLATFORMS FUNCTION ######
		add $t0, $zero, $zero # $t0 holds i=0
		addi $t1, $zero, 3 # $t1 holds 3, the maximum number of platforms to display
GENERATE_LOOP2:	bge $t0, $t1, GENERATE_LOOP_EXIT 	# exit if $t0 >= $t1 (i >= 3)
		jal generateRandom 			# generate a random number in the range of [0, 1008}
		sll $a1, $t0, 2				# offset = i*4
		jal insertNumber			# insert this number into (offset)$s4 = (i*4)$s4
		addi $t0, $t0, 1			# increment i += 1
		j GENERATE_LOOP2 			# if reached, continue to loop
################################################################################################
	
# check for keyboard input and if it is 's', stop the game (i.e. return to IF)
		
GENERATE_LOOP_EXIT:	jal displayBackground
			jal displayPlatforms
			li $a0, 3776
			jal displayDoodler
	
			jal sleep
			j GAME_LOOP
				
EXIT:	li $v0, 10
	syscall
	

	 
