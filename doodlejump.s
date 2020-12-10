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
# - Milestone 5
# 1. Program terminates with Game Over screen when player jumps to illegal area
# 2. Player's score is displayed on the screen
# 3. Fancier graphics: background, platform, and doodler's appearances have been updated
# 4. Lethal Obstacles: Coconuts thrown randomly

.data
displayAddress: .word 0x10008000 	# the display address we write pixels to
background: .word 0xbaedff 		# the background colour
topBG: .word 0xfa6d0f			# the colour of the top third of the background 
doodlerColour: .word 0xff1919		# the doodler's colour (1220979 in decimal)
platformColour: .word 0xffffff 		# the platform's colour (12747008 in decimal)
platforms: .space 12			# array of 3 integers
doodlerLoc: .space 4			# the top most coordinate of the doodler
gameOverColour: .word 0x56007a		# the colour of the text for the "Game Over" screen
score: .word 0				# the player's score?
scoreColour: .word 0xf0ba18		# the colour of the score display
leavesColour: .word 0x008729		# the colour of the tree leaves
trunkColour: .word 0xba6418		# the colour of the tree trunk
coconutColour: .word 0x783800		# the colour of the coconuts
deadlyCoconutColour: .word 0x8c2315	# the colour of the deadly coconuts
deadlyCoconuts: .space 12		# array of 3 integers


.text
j main

# function for drawing the background on display
displayBackground:	lw $t0, displayAddress
			add $t1, $zero, $zero		# i = 0
			addi $t2, $zero, 1024		# draw the background colour
			lw $t3, topBG			# top colour
			add $t6, $zero, 32
			
TOP_LOOP:		bge $t1, $t2, DRAW_TREE
			sll $t4, $t1, 2			# offset = i*4
			add $t5, $t0, $t4		# location in displayAddress we are drawing to
			div $t1, $t6
			mfhi $t7
			bne $t7, 0, NO_BG_INCREMENT
			addi $t3, $t3, 8
NO_BG_INCREMENT:	sw $t3, 0($t5)
			addi $t1, $t1, 1		# i += 1
			j TOP_LOOP

DRAW_TREE:		# start with drawing the leaves
			lw $t1, leavesColour
			sw $t1, 0($t0)
			sw $t1, 128($t0)
			sw $t1, 256($t0)
			sw $t1, 384($t0)
			sw $t1, 512($t0)
			sw $t1, 640($t0)
			sw $t1, 768($t0)
			sw $t1, 896($t0)
			sw $t1, 1024($t0)
			sw $t1, 1152($t0)
			sw $t1, 1280($t0)
			sw $t1, 1408($t0)
			sw $t1, 1536($t0)
			sw $t1, 1664($t0)
			sw $t1, 132($t0)	# section break
			sw $t1, 260($t0)
			sw $t1, 388($t0)
			sw $t1, 516($t0)
			sw $t1, 644($t0)
			sw $t1, 772($t0)
			sw $t1, 900($t0)
			sw $t1, 1028($t0)
			sw $t1, 1156($t0)
			sw $t1, 1284($t0)
			sw $t1, 1412($t0)
			sw $t1, 1540($t0)
			sw $t1, 1668($t0)
			sw $t1, 392($t0)	# section break
			sw $t1, 520($t0)
			sw $t1, 648($t0)
			sw $t1, 776($t0)
			sw $t1, 904($t0)
			sw $t1, 1032($t0)
			sw $t1, 1160($t0)
			sw $t1, 1288($t0)
			sw $t1, 1416($t0)
			sw $t1, 652($t0)	# section break
			sw $t1, 780($t0)
			sw $t1, 908($t0)
			sw $t1, 1036($t0)
			sw $t1, 1164($t0)
			sw $t1, 1292($t0)
			sw $t1, 1420($t0)
			sw $t1, 528($t0)	# section break
			sw $t1, 656($t0)
			sw $t1, 784($t0)
			sw $t1, 912($t0)
			sw $t1, 1040($t0)
			sw $t1, 1168($t0)
			sw $t1, 1296($t0)
			sw $t1, 1424($t0)
			sw $t1, 1552($t0)
			sw $t1, 1680($t0)
			sw $t1, 276($t0)	# section break
			sw $t1, 404($t0)
			sw $t1, 532($t0)
			sw $t1, 660($t0)
			sw $t1, 788($t0)
			sw $t1, 1172($t0)	# section break
			sw $t1, 1300($t0)
			sw $t1, 1428($t0)
			sw $t1, 280($t0)	# section break
			sw $t1, 408($t0)
			sw $t1, 536($t0)
			sw $t1, 664($t0)
			sw $t1, 1176($t0)	# section break
			sw $t1, 1304($t0)
			sw $t1, 1432($t0)
			sw $t1, 156($t0)	# section break
			sw $t1, 284($t0)
			sw $t1, 412($t0)
			sw $t1, 160($t0)
			sw $t1, 288($t0)
			sw $t1, 1308($t0)	# section break
			sw $t1, 1436($t0)
			sw $t1, 1564($t0)
			sw $t1, 1312($t0)
			sw $t1, 1440($t0)
			sw $t1, 1568($t0)
			sw $t1, 1572($t0)
			
			# drawing coconuts
			lw $t1, coconutColour
			sw $t1, 1792($t0)	# first coconut
			sw $t1, 1796($t0)
			sw $t1, 1920($t0)
			sw $t1, 1924($t0)
			sw $t1, 1544($t0)	# second coconut
			sw $t1, 1548($t0)
			sw $t1, 1672($t0)
			sw $t1, 1676($t0)
			sw $t1, 1808($t0)	# third coconut
			sw $t1, 1812($t0)
			sw $t1, 1936($t0)
			sw $t1, 1940($t0)
			
			# drawing tree trunk
			lw $t1, trunkColour
			sw $t1, 2048($t0)	# first line
			sw $t1, 2176($t0)
			sw $t1, 2304($t0)
			sw $t1, 2432($t0)
			sw $t1, 2560($t0)
			sw $t1, 2688($t0)
			sw $t1, 2816($t0)
			sw $t1, 2944($t0)
			sw $t1, 3072($t0)
			sw $t1, 3200($t0)
			sw $t1, 3328($t0)
			sw $t1, 3456($t0)
			sw $t1, 3584($t0)
			sw $t1, 3712($t0)
			sw $t1, 3840($t0)
			sw $t1, 3968($t0)	
			sw $t1, 2052($t0)	# second line
			sw $t1, 2180($t0)
			sw $t1, 2308($t0)
			sw $t1, 2436($t0)
			sw $t1, 2564($t0)
			sw $t1, 2692($t0)
			sw $t1, 2820($t0)
			sw $t1, 2948($t0)
			sw $t1, 3076($t0)
			sw $t1, 3204($t0)
			sw $t1, 3332($t0)
			sw $t1, 3460($t0)
			sw $t1, 3588($t0)
			sw $t1, 3716($t0)
			sw $t1, 3844($t0)
			sw $t1, 3972($t0)
			
			sw $t1, 1800($t0)	# third line
			sw $t1, 1928($t0)
			sw $t1, 2056($t0)	
			sw $t1, 2184($t0)
			sw $t1, 2312($t0)
			sw $t1, 2440($t0)
			sw $t1, 2568($t0)
			sw $t1, 2696($t0)
			sw $t1, 2824($t0)
			sw $t1, 2952($t0)
			sw $t1, 3080($t0)
			sw $t1, 3208($t0)
			sw $t1, 3336($t0)
			sw $t1, 3464($t0)
			sw $t1, 3592($t0)
			sw $t1, 3720($t0)
			sw $t1, 3848($t0)
			sw $t1, 3976($t0)
			
			sw $t1, 1804($t0)	# fourth line
			sw $t1, 1932($t0)
			sw $t1, 2060($t0)	
			sw $t1, 2188($t0)
			sw $t1, 2316($t0)
			sw $t1, 2444($t0)
			sw $t1, 2572($t0)
			sw $t1, 2700($t0)
			sw $t1, 2828($t0)
			sw $t1, 2956($t0)
			sw $t1, 3084($t0)
			sw $t1, 3212($t0)
			sw $t1, 3340($t0)
			sw $t1, 3468($t0)
			sw $t1, 3596($t0)
			sw $t1, 3724($t0)
			sw $t1, 3852($t0)
			sw $t1, 3980($t0)
			
			sw $t1, 2064($t0)	# fifth lin
			sw $t1, 2192($t0)
			sw $t1, 2320($t0)
			sw $t1, 2448($t0)
			sw $t1, 2576($t0)
			sw $t1, 2704($t0)
			sw $t1, 2832($t0)
			sw $t1, 2960($t0)
			sw $t1, 3088($t0)
			sw $t1, 3216($t0)
			sw $t1, 3344($t0)
			sw $t1, 3472($t0)
			sw $t1, 3600($t0)
			sw $t1, 3728($t0)
			sw $t1, 3856($t0)
			sw $t1, 3984($t0)		
			
EXIT_DISPLAY_BG:	jr $ra
			

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
			lw $t2, platformColour
			add $t0, $zero, $zero 	# i = 0
			addi $t1, $zero, 3	# limit_i = 3
			
PLATFORMS_LOOP:		# loop through the platforms and display a cloud
			bge $t0, $t1, DISPLAY_PLATFORMS_EXIT	# while i < 3
			sll $t3, $t0, 2				# offset = i*4
			add $t4, $s0, $t3			# addr(platforms[i])
			lw $t5, 0($t4)				# the value at platforms[i]
			sll $t5, $t5, 2
			add $t6, $t9, $t5			# the position we are drawing at
			sw $t2, 0($t6)				# first row of the cloud
			sw $t2, 4($t6)
			sw $t2, 8($t6)
			sw $t2, 12($t6)
			sw $t2, 16($t6)
			sw $t2, 20($t6)
			sw $t2, 24($t6)
			sw $t2, -124($t6)			# second row of the cloud
			sw $t2, -120($t6)
			sw $t2, -116($t6)
			sw $t2, -112($t6)
			sw $t2, -108($t6)
			sw $t2, -248($t6)			# third row of the cloud
			sw $t2, -244($t6)
			sw $t2, -240($t6)
			
			addi $t0, $t0, 1
			j PLATFORMS_LOOP
			
			
EXIT_DISPLAY_SUB_LOOP:	addi $t0, $t0, 1			# increment i += 1
			j PLATFORMS_LOOP
		
DISPLAY_PLATFORMS_EXIT:	jr $ra

# function to display doodler on screen
displayDoodler:		lw $t0, displayAddress	# load the displayAddress into $t0
			lw $t1, doodlerColour 	# load the doodlerColour into $t1
			lw $t8, trunkColour # will be used for the eyes and mouth 
			add $t2, $a0, $zero 	# the topmost coordinate the doodler is drawn at (3648 is the initial position)
			sw $t2, 0($s1)		# save the doodler's current location
			add $t3, $t2, $t0	# the topmost coordinate of the doodler in relation to the displayAddress
			
			sw $t8, 0($t3)		# first line
			sw $t1, 4($t3)
			sw $t8, 8($t3)
			sw $t1, 128($t3)	# second line
			sw $t8, 132($t3)
			sw $t1, 136($t3)
			sw $t1, 124($t3)	# right arm
			sw $t1, -8($t3)	
			sw $t1, 140($t3)	# left arm
			sw $t1, 16($t3)
			sw $t1, 256($t3)	# third line
			sw $t1, 260($t3)
			sw $t1, 264($t3)
			sw $t1, 384($t3)	# left foot
			sw $t1, 392($t3)	# right foot
			
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
				addi $t2, $t0, 384			# left foot (unit-wise)
				addi $t3, $t0, 392			# right foot (unit-wise)
				
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
				addi $t0, $t0, 1152			# add 4 rows to the doodler
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
				
				sw $t1, 20($t3)				# starting the top row of "A"
				sw $t1, 24($t3)
				sw $t1, 28($t3)				# top row of "A" done
				sw $t1, 148($t3)			# starting the left vertical line of "A"
				sw $t1, 276($t3)
				sw $t1, 404($t3)
				sw $t1, 532($t3)			# left vertical line of "A" complete
				sw $t1, 280($t3)			# middle portion of "A"
				sw $t1, 156($t3)			# starting the right vertical line of "A"
				sw $t1, 284($t3)
				sw $t1, 412($t3)
				sw $t1, 540($t3)			# A done
				
				sw $t1, 36($t3)				# left top part of M
				sw $t1, 40($t3)
				sw $t1, 172($t3)			# the v part of M
				sw $t1, 300($t3)			# v part of M done
				sw $t1, 48($t3)				# right top part of M
				sw $t1, 52($t3)				# top of M done
				sw $t1, 164($t3)			# left vertical line of M
				sw $t1, 292($t3)
				sw $t1, 420($t3)
				sw $t1, 548($t3)			# left vertical line of M done		
				sw $t1, 180($t3)			# starting right vertical line of M
				sw $t1, 308($t3)
				sw $t1, 436($t3)
				sw $t1, 564($t3)			# M done
				
				sw $t1, 60($t3)				# starting top of E
				sw $t1, 64($t3)
				sw $t1, 68($t3)				# top of E done
				sw $t1, 188($t3)			# start of vertical line of E
				sw $t1, 316($t3)
				sw $t1, 444($t3)
				sw $t1, 572($t3)			# vertical line of E done
				sw $t1, 576($t3)			# start of bottom line of E
				sw $t1, 580($t3)			# bottom line of E done
				sw $t1, 320($t3)			# E done
				
				sw $t1, 768($t3)			# top line of O
				sw $t1, 772($t3)
				sw $t1, 776($t3)
				sw $t1, 780($t3)			# end of O top line
				sw $t1, 908($t3)			# start of right vertical line of O
				sw $t1, 1036($t3)
				sw $t1, 1164($t3)
				sw $t1, 1292($t3)
				sw $t1, 1420($t3)			# end of right vertical line and start of bottom line of O
				sw $t1, 1416($t3)
				sw $t1, 1412($t3)
				sw $t1, 1408($t3)			# end of bottom line of O and start of left vertical line of O
				sw $t1, 1280($t3)
				sw $t1, 1152($t3)
				sw $t1, 1024($t3)
				sw $t1, 896($t3)			# O done
				
				sw $t1, 788($t3)			# left part of V
				sw $t1, 916($t3)
				sw $t1, 1044($t3)
				sw $t1, 1172($t3)
				sw $t1, 1300($t3)
				sw $t1, 1432($t3)			# point of V
				sw $t1, 1308($t3)			# start of the right part of V from bottom up
				sw $t1, 1180($t3)
				sw $t1, 1052($t3)
				sw $t1, 924($t3)			
				sw $t1, 796($t3)			# V done
				
				sw $t1, 804($t3)			# top line of E
				sw $t1, 808($t3)
				sw $t1, 812($t3)			# end of top line of E
				sw $t1, 932($t3)			# start of vertical line of E
				sw $t1, 1060($t3)
				sw $t1, 1188($t3)
				sw $t1, 1316($t3)			# end of vertical line of E
				sw $t1, 1320($t3)			# start of bottom line of E
				sw $t1, 1324($t3)			# end of bottom line of E
				sw $t1, 1064($t3)			# middle part of E
				
				sw $t1, 820($t3)			# start of the top line of R
				sw $t1, 824($t3)
				sw $t1, 828($t3)
				sw $t1, 832($t3)			# end of top line of R
				sw $t1, 948($t3)			# start of vertical line of R
				sw $t1, 1076($t3)
				sw $t1, 1204($t3)
				sw $t1, 1332($t3)			# end of vertical line of R
				sw $t1, 960($t3)			# right vertical line of R
				sw $t1, 1088($t3)			# end of vertical line of R
				sw $t1, 1084($t3)			# start of the horizonal line of R
				sw $t1, 1080($t3)			# end of the horizontal line of R
				sw $t1, 1212($t3)			# start of diagonal of R
				sw $t1, 1344($t3)			# R done
					
				jr $ra

# function to update the player's score
updateScore:			la $t0, score
				lw $t2, 0($t0)
				#addi $t1, $zero, 9
				#bge $t2, $t1, EXIT_UPDATE_SCORE
				addi $t2, $t2, 1 
				sw $t2, 0($t0)
EXIT_UPDATE_SCORE:		jr $ra

# function that draws a 0 
# $a0 - the location (unit-wise) the number should be drawn (left-corner)
displayZero:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing from
				
				sw $t2, 0($t3)			# top part of 0
				sw $t2, 4($t3)
				sw $t2, 8($t3)			# end of the top line of 0
				sw $t2, 136($t3)		# start of right vertical line of 0
				sw $t2, 264($t3)		
				sw $t2, 392($t3)
				sw $t2, 520($t3)
				sw $t2, 516($t3)		# start of bottom line of 0
				sw $t2, 512($t3)		# end of the bottom line of 0
				sw $t2, 128($t3)		# start of left vertical line of 0
				sw $t2, 256($t3)
				sw $t2, 384($t3)
				
				jr $ra

# function that draws a 1
# $a0 - the location the number should be drawn (left-corner)
displayOne:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing from
				
				sw $t2, 8($t3)
				sw $t2, 136($t3)
				sw $t2, 264($t3)
				sw $t2, 392($t3)
				sw $t2, 520($t3)
				
				jr $ra

# function that draws a 2
# $a0 - the location the number should be drawn (left-corner)
displayTwo:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing fro
				
				sw $t2, 0($t3)			# top of 2
				sw $t2, 4($t3)
				sw $t2, 8($t3)
				sw $t2, 136($t3)		# first vertical
				sw $t2, 264($t3)
				sw $t2, 260($t3)		# 2nd horizontal
				sw $t2, 256($t3)
				sw $t2, 384($t3)		# 2nd vertical
				sw $t2, 512($t3)
				sw $t2, 516($t3)		# 3rd horizontal
				sw $t2, 520($t3)
				
				jr $ra

# function that draws a 3
# $a0 - the location the number should be drawn (left-corner)
displayThree:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing from
				
				sw $t2, 0($t3)			# 1st horizontal
				sw $t2, 4($t3)
				sw $t2, 8($t3)
				sw $t2, 136($t3)		# long vertical
				sw $t2, 264($t3)
				sw $t2, 392($t3)
				sw $t2, 520($t3)
				sw $t2, 260($t3)		# 2nd horizontal
				sw $t2, 256($t3)
				sw $t2, 516($t3)		# 2nd horizontal
				sw $t2, 512($t3)
				
				jr $ra

# function that draws a 4
# $a0 - the location the number should be drawn (left-corner)
displayFour:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing from
				
				sw $t2, 0($t3)			# small vertical
				sw $t2, 128($t3)
				sw $t2, 256($t3)
				sw $t2, 260($t3)		# middle
				sw $t2, 8($t3)			# long vertical
				sw $t2, 136($t3)
				sw $t2, 264($t3)
				sw $t2, 392($t3)
				sw $t2, 520($t3)
				
				jr $ra
				
# function that draws a 5
# $a0 - the location the number should be drawn (left-corner)
displayFive:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing from
				
				sw $t2, 0($t3)			# first horizontal
				sw $t2, 4($t3)
				sw $t2, 8($t3)
				sw $t2, 128($t3)		# first vertical
				sw $t2, 256($t3)
				sw $t2, 260($t3)		# second horizontal
				sw $t2, 264($t3)
				sw $t2, 392($t3)		# 2nd vertical
				sw $t2, 520($t3)
				sw $t2, 516($t3)		# third horizontal
				sw $t2, 512($t3)
				
				jr $ra

# function that draws a 6
# $a0 - the location the number should be drawn (left-corner)
displaySix:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing from
				
				sw $t2, 0($t3)			# first horizontal
				sw $t2, 4($t3)
				sw $t2, 8($t3)
				sw $t2, 128($t3)		# first vertical
				sw $t2, 256($t3)
				sw $t2, 260($t3)		# second horizontal
				sw $t2, 264($t3)
				sw $t2, 392($t3)		# 2nd vertical
				sw $t2, 520($t3)
				sw $t2, 516($t3)		# third horizontal
				sw $t2, 512($t3)
				sw $t2, 384($t3)		# filling in the last square
				
				jr $ra

# function that draws a 7
# $a0 - the location the number should be drawn (left-corner)
displaySeven:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing from
				
				sw $t2, 0($t3)			# horizontal
				sw $t2, 4($t3)
				sw $t2, 8($t3)			# vertical
				sw $t2, 136($t3)
				sw $t2, 264($t3)
				sw $t2, 392($t3)
				sw $t2, 520($t3)
				
				jr $ra

# function that draws a 8
# $a0 - the location the number should be drawn (left-corner)
displayEight:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing from
				
				sw $t2, 0($t3)			# first horizontal
				sw $t2, 4($t3)
				sw $t2, 8($t3)
				sw $t2, 128($t3)		# first vertical
				sw $t2, 256($t3)
				sw $t2, 260($t3)		# second horizontal
				sw $t2, 264($t3)
				sw $t2, 392($t3)		# 2nd vertical
				sw $t2, 520($t3)
				sw $t2, 516($t3)		# third horizontal
				sw $t2, 512($t3)
				sw $t2, 384($t3)		# filling in the last square
				sw $t2, 136($t3)		# filling in the last square
				
				jr $ra

# function that draws a 8
# $a0 - the location the number should be drawn (left-corner)
displayNine:			add $t0, $a0, $zero
				lw $t1, displayAddress
				lw $t2, scoreColour
				add $t3, $t0, $t1		# the location to start drawing from
				
				sw $t2, 0($t3)			# first horizontal
				sw $t2, 4($t3)
				sw $t2, 8($t3)			# long vertical
				sw $t2, 136($t3)		
				sw $t2, 264($t3)
				sw $t2, 392($t3)
				sw $t2, 520($t3)
				sw $t2, 128($t3)		# short vertical
				sw $t2, 256($t3)
				sw $t2, 260($t3)
				
				jr $ra

# function that draws a coconut
# $a0 - the offset the coconut is drawin by (top-left corner of the coconut)
displayCoconuts:		lw $t0, displayAddress
				lw $t5, deadlyCoconutColour
				add $t1, $zero, $zero
				addi $t2, $zero, 3
DISPLAY_COCONUTS_LOOP:		bge $t1, $t2, EXIT_DISPLAY_COCONUTS
				sll $t3, $t1, 2				# offset = i*4
				add $t6, $s5, $t3			# addr(deadlyCoconuts[i])
				lw $t7, 0($t6)				# deadlyCoconuts[i]
				add $t7, $t7, $t0			# location to write in realtion to displayAddress
				sw $t5, 0($t7)
				sw $t5, 4($t7)
				sw $t5, 128($t7)
				sw $t5, 132($t7)
				addi $t1, $t1, 1			# i += 1
				j DISPLAY_COCONUTS_LOOP

EXIT_DISPLAY_COCONUTS:		jr $ra

# function to update the values of each coconut
updateCoconuts:			add $t0, $zero, $zero
				addi $t1, $zero, 3
UPDATE_COCONUTS_LOOP:		bge $t0, $t1, EXIT_UPDATE_COCONUTS
				sll $t2, $t0, 2				# offset = i*4
				add $t3, $t2, $s5			# addr(deadlyCoconuts[i])
				lw $t4, 0($t3)				# deadlyCoconuts[i]
				addi $t4, $t4, 256
				sw $t4, 0($t3)
				addi $t0, $t0, 1			# i += 1
				j UPDATE_COCONUTS_LOOP

EXIT_UPDATE_COCONUTS:		jr $ra

# function that resets the coconuts position when they have moved off screen
resetCoconuts:			lw $t8, 0($s5)
				blt $t8, 4020, DISPLAY_SCORE
				addi $t1, $zero, 52 	# initial position for deadlyCoconuts[i]
				sw $t1, 0($s5)		# deadlyCoconuts[i] = 13
				addi $t1, $zero, 80    
				sw $t1, 4($s5)
				addi $t1, $zero, 104
				sw $t1, 8($s5)
				li $s4, 0
				
# function that randomly decides if a coconut should start falling or not
# $a0 will be 0 if no coconut, or 1, if yes coconut at the end of this function
generateRandomCoconut:		li $v0, 42
				li $a0, 0
				li $a1, 3
				syscall
				
				jr $ra
# function to detect collision detection with a coconut
coconutCollision:		lw $t0, 0($s1)				# load the doodler's location into $t0 (unit-wise)
				lw $t1, displayAddress			# the displayAddress
				lw $t7, deadlyCoconutColour 		# the colour of the coconuts
				addi $t2, $t0, 8			# right part of doolder's head (unit-wise)
				addi $t3, $t0, -8			# left arm (unit-wise)
				addi $t4, $t0, 16			# right arm (unit-wise)
				
				add $t0, $t0, -128			
				add $t0, $t0, $t1			# the position right above left part of the head
				add $t2, $t2, -120
				add $t2, $t2, $t1			# the position right above right part of the head
				add $t3, $t3, -12
				add $t3, $t3, $t1			# the position to the left of the left arm
				add $t4, $t4, 20
				add $t4, $t4, $t1			# the position to the right of the right arm
				
				add $v0, $zero, $zero			# collision = true
				
				lw $t5, 0($t0)
				bne $t5, $t7, CHECK_RIGHT_ARM
				addi $v0, $zero, 1			# collision = true
				j EXIT_COCONUT_COLLISION
CHECK_RIGHT_HEAD:		lw $t5, 0($t2)
				bne $t5, $t7, CHECK_LEFT_ARM
				addi $v0, $zero, 1			# collision = true
				j EXIT_COCONUT_COLLISION
CHECK_LEFT_ARM:			lw $t5, 0($t3)
				bne $t5, $t7, CHECK_RIGHT_ARM
				addi $v0, $zero, 1			# collision = true
				j EXIT_COCONUT_COLLISION
CHECK_RIGHT_ARM:		lw $t5, 0($t4)
				bne $t5, $t7, EXIT_COCONUT_COLLISION
				addi $v0, $zero, 1			# collision = true
				j EXIT_COCONUT_COLLISION
EXIT_COCONUT_COLLISION:		jr $ra		
				
				
main:	# initialize saved registers
	la $s0, platforms 	# $s0 holds the leftmost coordinates of 3 platforms
	la $s1, doodlerLoc 	# $s1 holds the topmost coordinate of the doodler
	li $s2, 1		# $s2 is 1 if the game should continue running, 0 if it should reset to initial position and freeze
	li $s4, 0		# currently, do not display any coconuts
	la $s5, deadlyCoconuts	# $s5 holds array of coconuts

	addi $t1, $zero, 52 	# initial position for deadlyCoconuts[i]
	sw $t1, 0($s5)		# deadlyCoconuts[i] = 13
	addi $t1, $zero, 80    
	sw $t1, 4($s5)
	addi $t1, $zero, 104
	sw $t1, 8($s5)
	
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
			jal updateScore
			li $v0, 1
			lw $a0, score
			syscall

CHECK_ILLEGAL_AREA:	lw $t0, 0($s1)
			li $t1, 4096
			ble $t0, $t1, CHECK_COCONUT_COLLISION
			jal gameOver
			j EXIT

CHECK_COCONUT_COLLISION:	jal coconutCollision
				add $t0, $v0, $zero
				bne $t0, 1, GENERATE_LOOP_EXIT
				jal gameOver
				j EXIT
		
GENERATE_LOOP_EXIT:	# draw screen
			jal displayBackground
			jal displayPlatforms
			lw $a0, 0($s1)
			jal displayDoodler
			
COCONUT_GENERATOR:	bne $s4, 0, DISPLAY_COCONUTS 		# if $s4 == 0, generate a number to see if we should throw coconuts
			jal generateRandomCoconut
			add $t3, $a0, $zero
			bne $t3, 1, DISPLAY_SCORE		# if $a0 == 1, throw the coconuts!!
			li $s4, 1				# store 1 into $s3 to display coconuts

DISPLAY_COCONUTS:	jal displayCoconuts
			
UPDATE_COCONUTS:	jal updateCoconuts
			


RESET_COCONUTS:		jal resetCoconuts
				
DISPLAY_SCORE:		lw $t0, score
			addi $t1, $zero, 9
			bgt $t0, $t1, DISPLAY_TWO_DIGIT_SCORE
			
SCORE_ZERO:		bne $t0, 0, SCORE_ONE
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displayZero
			j SLEEP
SCORE_ONE:		bne $t0, 1, SCORE_TWO
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displayOne
			j SLEEP
SCORE_TWO:		bne $t0, 2, SCORE_THREE
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displayTwo
			j SLEEP
SCORE_THREE:		bne $t0, 3, SCORE_FOUR
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displayThree
			j SLEEP
SCORE_FOUR:		bne $t0, 4, SCORE_FIVE
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displayFour
			j SLEEP
SCORE_FIVE:		bne $t0, 5, SCORE_SIX
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displayFive
			j SLEEP
SCORE_SIX:		bne $t0, 6, SCORE_SEVEN
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displaySix
			j SLEEP
SCORE_SEVEN:		bne $t0, 7, SCORE_EIGHT
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displaySeven
			j SLEEP
SCORE_EIGHT:		bne $t0, 8, SCORE_NINE
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displayEight
			j SLEEP
SCORE_NINE:		bne $t0, 9, SLEEP
			addi $a0, $zero, 136
			jal displayZero
			addi $a0, $zero, 152
			jal displayNine
			j SLEEP	
			
DISPLAY_TWO_DIGIT_SCORE:	addi $t2, $zero, 10
				div $t0, $t2
				mfhi $t3		# the first digit
				mflo $t4		# the second digit
				
			
DISPLAY_FIRST_DIGIT:	# let's first display the first digit

SCORE_ZERO2:		bne $t3, 0, SCORE_ONE2
			addi $a0, $zero, 152
			jal displayZero
			j DISPLAY_SECOND_DIGIT
SCORE_ONE2:		bne $t3, 1, SCORE_TWO2
			addi $a0, $zero, 152
			jal displayOne
			j DISPLAY_SECOND_DIGIT
SCORE_TWO2:		bne $t3, 2, SCORE_THREE2
			addi $a0, $zero, 152
			jal displayTwo
			j DISPLAY_SECOND_DIGIT
SCORE_THREE2:		bne $t3, 3, SCORE_FOUR2
			addi $a0, $zero, 152
			jal displayThree
			j DISPLAY_SECOND_DIGIT
SCORE_FOUR2:		bne $t3, 4, SCORE_FIVE2
			addi $a0, $zero, 152
			jal displayFour
			j DISPLAY_SECOND_DIGIT
SCORE_FIVE2:		bne $t3, 5, SCORE_SIX2
			addi $a0, $zero, 152
			jal displayFive
			j DISPLAY_SECOND_DIGIT
SCORE_SIX2:		bne $t3, 6, SCORE_SEVEN2
			addi $a0, $zero, 152
			jal displaySix
			j DISPLAY_SECOND_DIGIT
SCORE_SEVEN2:		bne $t3, 7, SCORE_EIGHT2
			addi $a0, $zero, 152
			jal displaySeven
			j DISPLAY_SECOND_DIGIT
SCORE_EIGHT2:		bne $t3, 8, SCORE_NINE2
			addi $a0, $zero, 152
			jal displayEight
			j DISPLAY_SECOND_DIGIT
SCORE_NINE2:		bne $t3, 9, DISPLAY_SECOND_DIGIT
			addi $a0, $zero, 152
			jal displayNine
			j DISPLAY_SECOND_DIGIT

DISPLAY_SECOND_DIGIT:	

SCORE_ZERO3:		bne $t4, 0, SCORE_ONE3
			addi $a0, $zero, 136
			jal displayZero
			j SLEEP	
SCORE_ONE3:		bne $t4, 1, SCORE_TWO3
			addi $a0, $zero, 136
			jal displayOne
			j SLEEP	
SCORE_TWO3:		bne $t4, 2, SCORE_THREE3
			addi $a0, $zero, 136
			jal displayTwo
			j SLEEP	
SCORE_THREE3:		bne $t4, 3, SCORE_FOUR3
			addi $a0, $zero, 136
			jal displayThree
			j SLEEP	
SCORE_FOUR3:		bne $t4, 4, SCORE_FIVE3
			addi $a0, $zero, 136
			jal displayFour
			j SLEEP	
SCORE_FIVE3:		bne $t4, 5, SCORE_SIX3
			addi $a0, $zero, 136
			jal displayFive
			j SLEEP	
SCORE_SIX3:		bne $t4, 6, SCORE_SEVEN3
			addi $a0, $zero, 136
			jal displaySix
			j SLEEP	
SCORE_SEVEN3:		bne $t4, 7, SCORE_EIGHT3
			addi $a0, $zero, 136
			jal displaySeven
			j SLEEP	
SCORE_EIGHT3:		bne $t4, 8, SCORE_NINE3
			addi $a0, $zero, 136
			jal displayEight
			j SLEEP	
SCORE_NINE3:		bne $t4, 9, SLEEP
			addi $a0, $zero, 136
			jal displayNine
			j SLEEP	
	
SLEEP:			jal sleep
			j GAME_LOOP
				
EXIT:	li $v0, 10
	syscall
	

	 
