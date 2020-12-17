# DoodleJump
As a final project in my computer organization course (CSC258) I developed a mini version of the game, Doodle Jump, in assembly.

## Required Software
To play the game you will need to install [MARS](https://courses.missouristate.edu/KenVollmar/MARS/download.htm).
Once that's downloaded, go ahead and open up the Bitmap Display and Keyboard Display and MMIO Simulator and select "Connect to MIPS" for both of them.

### Bitmap Display Configurations
- Unit width in pixels: 8
- Unit height in pixels: 8
- Display width in pixels: 256
- Display height in pixels: 256
- Base Address for Display: 0x10008000 ($gp)

## Instructions
To play the game, follow the instructions below:
1. Ensure your Bitmap Display and Keyboard Display and MMIO Simulator are both connected to MIPS.
2. Assemble the code and press play.
3. Press 's' to start and restart the game.
4. Press 'j' to jump left, and 'k' to jump right.
5. AVOID THE COCONUTS.

## Features
1. Program terminates with Game Over screen when player jumps to illegal area
2. Player's score is displayed on the screen
3. Fancier graphics: background, platform, and doodler's appearances have been updated
4. Lethal Obstacles: Coconuts thrown randomly
5. Sound effect whenever doodler jumps on platform
