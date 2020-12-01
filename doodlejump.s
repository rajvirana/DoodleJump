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
# (See the assignment handout for descriptions of the milestones)
# - Milestone 0
#

.data
displayAddress: .word 0x10008000 # the display address we write pixels to
background: .word 0xbaedff # the background colour 
doodlerColour: .word 0x12a173 	# the doodler's colour (1220979 in decimal)
platformColour: .word 0xc28100 	# the platform's colour (12747008 in decimal)

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
		#lw $t4, 0($s1) 		# loading the value at address $t4 = background[i] into $t5
		sw $s1, 0($t3) 		# write the value at register $t5 into $t3 = displayAddress[i]
		addi $t0, $t0, 1 	# increment i += 1
		j BG_LOOP
	
	BG_LOOP_EXIT:
		jr $ra
		
main:
	# initialize saved registers
	
	lw $s0, displayAddress 	# $s0 holds the base address for display
	lw $s1, background 	# $s1 holds the array of background colour codes of size 1024
	lw $s2, doodlerColour 	# $s2 holds the doodler's colour
	lw $s3, platformColour # $s3 holds the platform's colour
	
	# display the background on the screen
	jal displayBackground
	
	EXIT:
	li $v0, 10
	syscall
	

	 
