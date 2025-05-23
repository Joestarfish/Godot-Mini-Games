# Mini Games

This project will be used to learn how to use the Godot engine.

The Godot project currently consist of a simple number guessing mini-game just to get used to the engine. It will probably contain other mini-games to learn more and more about the engine but these are not meant to be played.

This repo is more of a learning tool than a release-ready game

## TODO:
- [ ] Number Guessing game
	- [x] Make a simple interface:
		- [x] Text containing a number
		- [x] Input to enter the number
	- [x] Script to generate a random number
		- [x] Generate a random number between a `min` and `max` variable
		- [x] Write this number on screen
	- [x] Input validation
		- [x] Compare the input to the generated number
		- [x] If the number is right, increment a `score` variable
	- [ ] Make the game fun
		- [ ] Add some sort of effect (animation and sound) when the answer is right
		- [ ] Add other effects when the answer is wrong
		- [ ] Make the random number invisible to the player until they validate their answer
		- [ ] Allow multiple tries
			- [ ] Store the current remaining tries in a variable
			- [ ] Show the remaining tries on screen
			- [ ] When the answer is wrong, decrement this variable and update it on screen
			- [ ] Make the player lose when they are out of attempts
- [ ] Make a main menu
	- [ ] Allow selecting the game from the main menu
	- [ ] Add a `Go back` button in the game to go back to the menu
- [ ] Saving
    - [ ] Save the progress on disk
    - [ ] Load the progress when loading the game
    - [ ] Allow the user to clear their save
- [ ] Add other games or features
