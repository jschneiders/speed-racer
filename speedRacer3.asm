.data

stageWidth:		.half 16			# Store stage size
stageHeight:		.half 32			# Usual settings $gp, 32x32, 16xScaling, 512x512

carX:			.half 5
carY:			.half 25

carColour:		.word 0x0022CC22		# Store colour to draw objects
bgColour:		.word 0xFF003300		# Store colour to draw background

.text

Main:			# Load player info
			lh $a0, carX 			# Get player's position
			lh $a1, carY			
			jal CoordsToAddress		# Calculate position in stage memory
			nop
			or $s0, $zero, $v0		# Store stage memory position in s0
			
			
			# Load colour info
			lw $s6, carColour		# Store drawing colour in s6
			lw $s7, bgColour		# Store background colour in s7
			
			# Prepare the arena
			or $a0, $zero, $s7		# Clear stage to background colour
			jal FillMemory
			nop
			jal AddBoundaries		# Add walls
			nop
			
			# Draw player's initial head
			or $a0, $zero, $s6		# Load draw colour	
			or $a1, $zero, $s0		# Load position
			jal PaintMemory			# Call the paint function
			nop
			
			or $a0, $zero, $s0		# Load position
			ori $a1, $zero, 1		# Set distance to move
			
# esse comentário em pt_br é pra tu entender o que taconteceno			
# o keyboard simulator armazena 2 informações:
# no 0xFFFF0000 ele armazena 0 ou 1, 0 se alguma tecla não foi pressionada e 1 caso foi pressionada
# no 0xFFFF0004 ele armazena o valor da tecla que foi pressionada
			
			li $t0, 0xffff0000		# Store address for the keyboard and MMIO simulator data	
MainRead:						# Read keyboard
			jal Sleep			# System sleep so don't crash everything
			nop
			lw $v0, 0($t0)			# Load if any key was pressed
			andi $v0, $v0, 0x01		
			beq $v0, $zero, MainRead	# If 0 so no key was pressed
			lw $v1, 4($t0)			# Load the value of the key pressed
			
			beq $v1, 100, MoveRight		# D pressed go right
			beq $v1, 97, MoveLeft		# A pressed go left
			
			li $v0, 10			# If any other key is pressed, finish the program
			syscall
			
			
MoveRight:
		or $a0, $zero, $s7		# Load bgcolour	
		or $a1, $zero, $s0		# Load position
		jal PaintMemory			# Call the paint function
		nop
		or $a0, $zero, $s6		# Load draw colour	
		addi $a1, $a1, 4
		jal PaintMemory			# Call the paint function
		nop
		or $s0, $zero, $a1
		j MainRead
		nop
		#jr $ra
		#nop

MoveLeft:
		or $a0, $zero, $s7		# Load bgcolour	
		or $a1, $zero, $s0		# Load position
		jal PaintMemory			# Call the paint function
		nop
		or $a0, $zero, $s6		# Load draw colour	
		subi $a1, $a1, 4
		jal PaintMemory			# Call the paint function
		nop
		or $s0, $zero, $a1
		j MainRead
		nop
		#jr $ra
		#nop
		
					
			
			
###########################################################################################
# Sleep function for game loop
# Takes none
# Returns none
Sleep:
			ori $v0, $zero, 32		# Syscall sleep
			ori $a0, $zero, 60		# For this many miliseconds
			syscall
			jr $ra				# Return
			nop
###########################################################################################
# Function to convert coordinates into stage memory addresses
# Takes a0 = x, a1 = y
# Returns  v0 = address
CoordsToAddress:
		or $v0, $zero, $a0		# Move x coordinate to v0
		lh $a0, stageWidth		# Load the screen width into a0
		multu $a0, $a1			# Multiply y coordinate by the screen width
		nop
		mflo $a0			# Retrieve result from lo register
		addu $v0, $v0, $a0		# Add the result to the x coordinate and store in v0
		sll $v0, $v0, 2			# Multiply v0 by 4 (bytes) using a logical shift
		addu $v0, $v0, $gp		# Add gp to v0 to give stage memory address
		jr $ra				# Return
		nop
		
###########################################################################################
# Function to draw the given colour to the given stage memory address (gp)
# Takes a0 = colour, a1 = address
# Returns none
PaintMemory:
		sw $a0, ($a1)			# Set colour
		jr $ra				# Return
		nop
		
###########################################################################################
# Function to fill the stage memory with a given colour
# Takes a0 = colour
# Returns none
FillMemory:
		lh $a1, stageWidth		# Calculate ending position
		lh $a2, stageHeight
		multu $a1, $a2			# Multiply screen width by screen height
		nop
		mflo $a2			# Retreive total tiles
		sll $a2, $a2, 2			# Multiply by 4
		add $a2, $a2, $gp		# Add global pointer
		
		or $a1, $zero, $gp		# Set loop var to global pointer
FillMemory_l:	
		sw $a0, ($a1)
		add $a1, $a1, 4
		blt $a1, $a2, FillMemory_l
		nop
		
		jr $ra				# Return
		nop
		
###########################################################################################
# Function to add boundary walls
# Takes none
# Returns none
AddBoundaries:
		lh $a1, stageWidth		# Calculate ending position
		sll $a1, $a1, 2			# Multiply by 4
		add $a2, $a1, $gp		# Add global pointer
		
		or $a1, $zero, $gp		# Set loop var to global pointer
AddBoundaries_t:	
		sw $s6, ($a1)
		add $a1, $a1, 4
		blt $a1, $a2, AddBoundaries_t
		nop
		

		lh $a1, stageWidth		# Calculate next ending condition
		lh $a2, stageHeight
		multu $a1, $a2			# Multiply screen width by screen height
		nop
		mflo $a2			# Retreive total tiles
		sub $a2, $a2, $a1		# Minus one width
		sll $a2, $a2, 2			# Multiply by 4
		add $a2, $a2, $gp		# Add global pointer
		
		subi $a1, $a1, 1		# Take 1 from width
		sll $a3, $a1, 2			# Multiply by 4 to get mem to add
		
		or $a1, $zero, $gp		# Set loop var to global pointer
AddBoundaries_s:	
		sw $s6, ($a1)
		add $a1, $a1, $a3
		sw $s6, ($a1)
		add $a1, $a1, 4
		blt $a1, $a2, AddBoundaries_s
		nop
		
		or $a3, $zero, $a1		# backup a1 (current position)
		
		lh $a1, stageWidth		# Calculate final ending position
		lh $a2, stageHeight
		multu $a1, $a2			# Multiply screen width by screen height
		nop
		mflo $a2			# Retreive total tiles
		sll $a2, $a2, 2			# Multiply by 4
		add $a2, $a2, $gp		# Add global pointer
		
		or $a1, $zero, $a3		# restore previous position
AddBoundaries_b:
		sw $s6, ($a1)
		add $a1, $a1, 4
		blt $a1, $a2, AddBoundaries_b
		nop

		jr $ra				# Return
		nop
