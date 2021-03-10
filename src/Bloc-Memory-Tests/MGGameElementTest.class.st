"
A MGGameElementTest is a test class for testing the behavior of MGGameElement
"
Class {
	#name : #MGGameElementTest,
	#superclass : #TestCase,
	#category : #'Bloc-Memory-Tests-Elements'
}

{ #category : #tests }
MGGameElementTest >> testShowInSpace [

	"Create the game model and the Bloc element."
	| aGameElement space |
	aGameElement := MGGameElement new
		memoryGame: MGGame withNumbers;
		yourself.

	"The space represents the window"
	space := BlSpace new.
	space addChild: aGameElement. 

	"Calculate the extent of the game board for the first time, to set it to the window."
	space pulse.
	space extent: aGameElement extent.

	"Show the window"
	space show.

	self flag: #todo. "Must enqueue as a task?"
	space close.

]
