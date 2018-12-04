"
I contain runnable games initalized with different card types
"
Class {
	#name : #MgExamples,
	#superclass : #Object,
	#category : 'Bloc-MemoryGame-Examples'
}

{ #category : #examples }
MgExamples class >> open [
	"I create and start a game with Number cards"
	<script: 'self open'>
	| game gameElement |
	
	game := MgGameModel new.
	game initializeForSymbols: '12345678'.

	gameElement := MgGameElement new.
	gameElement memoryGame: game.
	
	self openInWindow: gameElement
]

{ #category : #examples }
MgExamples class >> openEmoji [
	"I create and start a game with Emoji cards.
	(only works on OSX with Moz2D rendering backend)"
	<script: 'self openEmoji'>
	| game gameElement |

	game := MgGameModel new.
	game initializeForSymbols: '💰🏡🎅🍪🍕🚀😸🙈'.

	gameElement := MgGameElement new.
	gameElement memoryGame: game.
	
	self openInWindow: gameElement
]

{ #category : #examples }
MgExamples class >> openHieroglyphs [
	"I create and start a game with Hieroglyph cards.
	(only works on OSX with Moz2D rendering backend)"
	<script: 'self openHieroglyphs'>
	| game gameElement |

	game := MgGameModel new.
	game initializeForSymbols: '为从公家里地个时'.

	gameElement := MgGameElement new.
	gameElement memoryGame: game.
	
	self openInWindow: gameElement
]

{ #category : #opening }
MgExamples class >> openInWindow: anElement [
	"Open a given game element in a window"
	| aSpace |
	aSpace := BlSpace new
		extent: 420@420;
		title: 'Memory Game'.

	aSpace root
		addChild: anElement;
		yourself.
	
	aSpace show
]
