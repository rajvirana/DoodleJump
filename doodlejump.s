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
# - Milestone 3
#

.data
displayAddress: .word 0x10008000 	# the display address we write pixels to
background: .word 0xbaedff 		# the background colour 
doodlerColour: .word 0x12a173 		# the doodler's colour (1220979 in decimal)
platformColour: .word 0xc28100 		# the platform's colour (12747008 in decimal)
platforms: .space 12			# array of 3 integers
doodlerLoc: .space 4			# the top most coordinate of the doodler
gameOverColour: .word 0x56007a		# the colour of the text for the "Game Over" screen
myMessage: .asciiz  "Game Over\n"

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
generateRandom:		li $v0, 42
			li $a0, 0
			li $a1, 752
			syscall # random number will be in $a0
			addi $a0, $a0, 256
			jr $ra 	# jump back to where we left off in main
	
# function for inserting the random number generated into the correct position of $s4
# PARAMETERS: $a0 - random number, $a1 - offset needed to get platforms[i]
insertNumber:		add $t2, $a0, $zero 	# load the value in $a0 into $t2
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
displayDoodler:		lw $t0, displayAddress	# load the displayAddress into $t0
			lw $t1, doodlerColour 	# load the doodlerColour into $t1
			add $t2, $a0, $zero 	# the topmost coordinate the doodler is drawn at (3648 is the initial position)
			sw $t2, 0($s1)		# save the doodler's current location
			add $t3, $t2, $t0	# the topmost coordinate of the doodler in relation to the displayAddress
			sw $t1, 0($t3)		# head
			sw $t1, 124($t3)	# body left
			sw $t1, 128($t3)	# body middle
			sw $t1, 132($t3)	# body right
			sw $t1, 252($t3)	# left foot
			sw $t1, 260($t3)	# right foot
			jr $ra

# function to make the program sleep for a certain number of milliseconds
sleep:			li $v0, 32
			li $a0, 200
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

# function that moves the doodler one unit left
doodlerLeft:		lw $t0, 0($s1)		# load the current position of the doodler into $t0
			addi $t0, $t0, -12	# subtract 4 pixels from the previous position
			sw $t0, 0($s1)		# set this as the new position of the doodler
			jr $ra

# function that moves the doodler one unit right
doodlerRight:		lw $t0, 0($s1)		# load the current position of the doodler into $t0
			addi $t0, $t0, 12	# subtract 4 pixels from the previous position
			sw $t0, 0($s1)		# set this as the new position of the doodler
			jr $ra

# function that moves the doodler up
doodlerUp:		lw $t0, 0($s1)		# load the current position of the doodler into $t0
			addi $t0, $t0, -128	# subtract 128 pixels from the previous position to make the doodler move UP
			sw $t0, 0($s1)		# set this as the new position of the doodler
			jr $ra

# function that moves the doodler down
doodlerDown:		lw $t0, 0($s1)		# load the current position of the doodler into $t0
			addi $t0, $t0, 128	# add 128 pixels from the previous position to make the doodler move DOWN
			sw $t0, 0($s1)		# set this as the new position of the doodler
			jr $ra

# function that checks for collision
checkPlatformCollision:		lw $t0, 0($s1)				# load the doodler's location into $t0 (unit-wise)
				lw $t1, displayAddress			# the displayAddress
				lw $t7, platformColour 			# the colour of the platform
				addi $t2, $t0, 252			# left foot (unit-wise)
				addi $t3, $t0, 260			# right foot (unit-wise)
				
				addi $t4, $t2, 128			# the position directly underneath the left foot (unit-wise)
				add $t5, $t4, $t1			# the position directly underneath the left foot in relation to the displayAddress
				lw $t6, 0($t5)				# load the word at this index of the displayAddress
				bne $t6, $t7, CHECK_RIGHT_FOOT		# if the position underneath the left foot is the colour brown
				addi $v0, $zero, 1
				j EXIT_CHECK_COLLISION			# if it is, then collision has been detected, return true
CHECK_RIGHT_FOOT:		addi $t4, $t3, 128			# the position directly underneat the right foot (unit-wise)
				add $t5, $t4, $t1			# the position directly underneath the right foot in realtion to the displayAddress
				lw $t6, 0($t5)				# load the word at this index of the displayAddress
				bne $t6, $t7, COLLISION_UNDETECTED	# check if the position underneath the right foot is the colour brown
				addi $v0, $zero, 1
				j EXIT_CHECK_COLLISION			# collision has been detected, return true
COLLISION_UNDETECTED:		add $v0, $zero, $zero			# if it hasn't then there is no collision, return false
EXIT_CHECK_COLLISION:		jr $ra

# function to move the EXISTING platforms down
movePlatforms:			add $t0, $zero, $zero			# i = 0
				addi $t1, $zero, 3			# limit = 3
MOVE_PLATFORMS_LOOP:		bge $t0, $t1, EXIT_MOVE_PLATFORMS	# while i < 3
				sll $t2, $t0, 2				# offset = i*4
				add $t2, $t2, $s0			# the address of platforms[i]
				lw $t3, 0($t2)				# load the position of platforms[i] into $t3
				addi $t3, $t3, 256			# move this platform down by 25 rows
				sw $t3, 0($t2)				# write this back into platforms[i]
				addi $t0, $t0, 1			# i += 1
				j MOVE_PLATFORMS_LOOP		
EXIT_MOVE_PLATFORMS:		jr $ra

# function to generate a new random number in the top half of the screen
generateNewRandom:	li $v0, 42
			li $a0, 0
			li $a1, 128
			syscall # random number will be in $a0
			addi $a0, $a0, 64
			jr $ra 	# jump back to where we left off in generateNewPlatforms

# function to generate new platforms onto the screen
generateNewPlatforms:		addi $sp, $sp, -4			# move stack pointer a word
				sw $ra, 0($sp)				# push link to main onto the stack
				addi $t5, $zero, 1024			# the max value in displayAddress
				add $t1, $zero, $zero			# i = 0
				addi $t2, $zero, 3			# limit = 3
NEW_PLATFORMS_LOOP:		bge $t1, $t2, EXIT_NEW_PLATFORMS_LOOP	# while i < 3
				sll $t3, $t1, 2				# offset = i*4
				add $t3, $t3, $s0			# the address of platforms[i]
				lw $t4, 0($t3)				# the value at platforms[i]
				blt $t4, $t5, NEW_PLATFORMS_INCREMENT	# if platforms[i] >= 1024
				li $v0, 42
				li $a0, 0
				li $a1, 256
				syscall # random number will be in $a0
				addi $a0, $a0, 256
				#jal generateNewPlatforms		# generate a new number in the top part of the array
				add $t6, $zero, $a0			# load the random number into $t6			
				sw $t6, 0($t3)				# insert it into platforms[i]					
NEW_PLATFORMS_INCREMENT:	addi $t1, $t1, 1			# i += 1
				j NEW_PLATFORMS_LOOP
EXIT_NEW_PLATFORMS_LOOP:	lw $ra, 0($sp)				# pop a word off the stack
				addi $sp, $sp, 4			# move stack pointer a word
				jr $ra

# function to update the doodler's position after jumping to high up
updateDoodlerLoc:		lw $t0, 0($s1)				# load the doodler's current position
				addi $t0, $t0, 1024			# add 4 rows to the doodler
				sw $t0, 0($s1)				# write this into $s1
				jr $ra
				
# function that draws the "Game Over" screen
gameOver:			lw $t0, displayAddress
				lw $t1, gameOverColour
				li $t2, 672				# the coordinate of the left upper corner of the text "Game Over"
				add $t3, $t0, $t2			# the same coordinate but in relation to the displayAddress
				sw $t1, 0($t3)
				sw $t1, 4($t3)
				sw $t1, 8($t3)
				sw $t1, 12($t3)				# first row of "G" is done
				sw $t1, 128($t3)			# starting vertical line of "G"
				sw $t1, 256($t3)
				sw $t1, 384($t3)
				sw $t1, 512($t3)			# vertical line of "G" done
				sw $t1, 516($t3)			# starting bottom line of "G"
				sw $t1, 520($t3)
				sw $t1, 524($t3)			# bottom line of "G" done
				sw $t1, 396($t3)			# building the litte tag for "G"
				sw $t1, 268($t3)
				sw $t1, 264($t3)			# G done
				jr $ra

main:	# initialize saved registers
	la $s0, platforms 	# $s4 holds the leftmost coordinates of 3 platforms
	la $s1, doodlerLoc 	# $s5 holds the topmost coordinate of the doodler
	li $s2, 1		# $s2 is 1 if the game should continue running, 0 if it should reset to initial position and freeze
	
	add $t0, $zero, $zero # $t0 holds i=0
	addi $t1, $zero, 3 # $t1 holds 3, the maximum number of platforms to display
GENERATE_LOOP1:	bge $t0, $t1, DISPLAY1	# exit if $t0 >= $t1 (i >= 3)
		addi $a2, $zero, 752
		jal generateRandom 	# generate a random number in the range of [0, 1008}
		sll $a1, $t0, 2		# offset = i*4
		jal insertNumber	# insert this number into (offset)$s4 = (i*4)$s4
		addi $t0, $t0, 1	# increment i += 1
		j GENERATE_LOOP1 	# if reached, continue to loop
	
DISPLAY1:	jal displayBackground
		jal displayPlatforms
		li $a0, 3648
		jal displayDoodler
			
IF:		jal checkKeyboardInput	# check for keyboard input
		bne $v0, 1, IF	# if 's' was pressed, start the game
		li $s3, 0			# $s3 is the counter to determine if the doodler should jump or down
		j GAME_LOOP
	
GAME_LOOP:	beqz $s2, EXIT
		
		bge $s3, 12, MOVE_DOWN		# if $s3 >= 10, then it's time for the doodler to descend
MOVE_UP:	jal doodlerUp			# else, move the doodler up
		addi $s3, $s3, 1		# increment the counter by 1
		j UPDATE_PLATFORMS		# proceed to check for keyboard input
MOVE_DOWN:	jal doodlerDown

UPDATE_PLATFORMS:	lw $t0, 0($s1)
			bge $t0, 1536, GAME_INPUT
			jal movePlatforms
			jal generateNewPlatforms
			jal updateDoodlerLoc
		
GAME_INPUT:	jal checkKeyboardInput		# check if a key has been pressed
		
		beq $v0, 1, GENERATE_LOOP1	# if 's' has been pressed, then go back to GENERATE_LOOP1
		beq $v0, 2, MOVE_LEFT		# if 'j' has been pressed, then move left
		beq $v0, 3, MOVE_RIGHT		# if 'k' has been pressed, then move right
		j CHECK_COLLISION_GAME

MOVE_LEFT:	jal doodlerLeft			# change the coordinate so that the doodler moves left
		j CHECK_COLLISION_GAME
MOVE_RIGHT:	jal doodlerRight		# change the coordinate so that the doodler moves right

CHECK_COLLISION_GAME:	jal checkPlatformCollision
			bne $v0, 1, CHECK_ILLEGAL_AREA
			add $s3, $zero, $zero

CHECK_ILLEGAL_AREA:	lw $t0, 0($s1)
			li $t1, 4096
			ble $t0, $t1, GENERATE_LOOP_EXIT
			jal gameOver
			li $v0, 4
			la $a0, myMessage
			syscall
			j EXIT
		
GENERATE_LOOP_EXIT:	# draw screen
			jal displayBackground
			jal displayPlatforms
			lw $a0, 0($s1)
			jal displayDoodler			
	
			jal sleep
			j GAME_LOOP
				
EXIT:	li $v0, 10
	syscall
	

	 
