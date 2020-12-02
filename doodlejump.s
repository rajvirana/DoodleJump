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
# - Milestone 2/3
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
displayBackground:
	add $t0, $zero, $zero # $t0 holds i=0
	addi $t1, $zero, 1024 # $t1 holds 1024, the maximum number of pixels to display
	BG_LOOP:
		bge $t0, $t1, BG_LOOP_EXIT	# exit when i >= 1024
		sll $t2, $t0, 2 	# $t2 = offset = i*4
		add $t3, $s0, $t2	# $t3 = displayAddress[i] the pixel we will be writing to
		sw $s1, 0($t3) 		# write the value at register $t5 into $t3 = displayAddress[i]
		addi $t0, $t0, 1 	# increment i += 1
		j BG_LOOP
	
	BG_LOOP_EXIT:
		jr $ra

# function for generating a random number (used to decide where a platform should be drawn)
generateRandom:
	li $v0, 42
	li $a0, 0
	li $a1, 1008
	syscall # random number will be in $a0
	jr $ra 	# jump back to where we left off in main
	
# function for inserting the random number generated into the correct position of $s4
# PARAMETERS: $a0 - random number, $a1 - offset needed to get platforms[i]
insertNumber:
	add $t2, $a0, $zero 	# load the value in $a0 into $t2
	add $t3, $a1, $zero	# load the offset value into $t3
	add $t3, $t3, $s4 	# get platforms[i] by getting the address offset bits away from $s4
	sw $t2, 0($t3)		# load the number into platforms[i]
	jr $ra

# function for displaying the 3 platforms on the screen utilizing the platforms array in $s4 (size = 3)
displayPlatforms:
	add $t0, $zero, $zero 	# i = 0
	addi $t1, $zero, 3	# limit_i = 3
	PLATFORMS_LOOP:
		bge $t0, $t1, DISPLAY_PLATFORMS_EXIT 	# exit when $t0 >= $t1 (i >= 3)
		sll $t2, $t0, 2 			# offset = i*4
		add $t3, $s4, $t2 			# $t3 = addr(platforms[i])
		lw $t4, 0($t3)				# load the value at platforms[i] into $t4, we have the position to display a platform now
		sll $t4, $t4, 2
		add $t4, $s0, $t4			# the position to write to in relation to the displayAddress
		
		add $t5, $zero, $zero			# j = 0
		addi $t6, $zero, 6			# limit_j = 6
		DISPLAY_PLATFORMS_SUB_LOOP:
			bge $t5, $t6, EXIT_DISPLAY_SUB_LOOP 	# exit when j >= 3
			sll $t7, $t5, 2				# sub_offset = j*4
			add $t8, $t4, $t7			# the new positions we want to draw $s3 to in $s0
			sw $s3, 0($t8)				# display the platform colour to $s0 at the appropriate position
			addi $t5, $t5, 1			# j += 1
			j DISPLAY_PLATFORMS_SUB_LOOP
		
		EXIT_DISPLAY_SUB_LOOP:
		addi $t0, $t0, 1			# increment i += 1
		j PLATFORMS_LOOP
		
	DISPLAY_PLATFORMS_EXIT:
	jr $ra

# function to display doodler on screen
displayDoodler:
	li $s5, 3776
	add $t0, $s5, $s0
	sw $s2, 0($t0)
	sw $s2, 124($t0)
	sw $s2, 128($t0)
	sw $s2, 132($t0)
	sw $s2, 252($t0)
	sw $s2, 260($t0)
	jr $ra
	
		
main:
	# initialize saved registers
	
	lw $s0, displayAddress 	# $s0 holds the base address for display
	lw $s1, background 	# $s1 holds the array of background colour codes of size 1024
	lw $s2, doodlerColour 	# $s2 holds the doodler's colour
	lw $s3, platformColour # $s3 holds the platform's colour
	la $s4, platforms 	# $s4 holds the leftmost coordinates of 3 platforms
	la $s5, doodlerLoc 	# $s5 holds the topmost coordinate of the doodler
	
	# display the background on the screen
	jal displayBackground
	
	add $t0, $zero, $zero # $t0 holds i=0
	addi $t1, $zero, 3 # $t1 holds 3, the maximum number of platforms to display
	GENERATE_LOOP:
		bge $t0, $t1, GENERATE_LOOP_EXIT 	# exit if $t0 >= $t1 (i >= 3)
		jal generateRandom 			# generate a random number in the range of [0, 1008}
		sll $a1, $t0, 2				# offset = i*4
		jal insertNumber			# insert this number into (offset)$s4 = (i*4)$s4
		addi $t0, $t0, 1			# increment i += 1
		j GENERATE_LOOP 			# if reached, continue to loop
		
	GENERATE_LOOP_EXIT:
	jal displayPlatforms
	jal displayDoodler
	
		
				
	EXIT:
		li $v0, 10
		syscall
	

	 
