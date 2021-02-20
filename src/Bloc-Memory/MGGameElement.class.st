"
| board space |
board := MGGameElement example.
space := BlSpace new.
space extent: 420@420.
space addChild: board.
space show. 
{  board . space } inspect 
"
Class {
	#name : #MGGameElement,
	#superclass : #BlElement,
	#instVars : [
		'memoryGame'
	],
	#category : #'Bloc-Memory-Elements'
}

{ #category : #example }
MGGameElement class >> example [ 
	"self example"
	<example>
	
	| game board |
	game := MGGame withNumbers.
   board := MGGameElement new.
   board memoryGame: game.
	^ board
]

{ #category : #initialization }
MGGameElement >> initialize [
	super initialize.
	self layout: BlGridLayout horizontal.
]

{ #category : #accessing }
MGGameElement >> memoryGame [
	^ memoryGame
]

{ #category : #accessing }
MGGameElement >> memoryGame: anObject [
	memoryGame := anObject.
	memoryGame availableCards
		do: [ :aCard | self addChild: (self newCardElement card: aCard) ]
]

{ #category : #accessing }
MGGameElement >> newCardElement [
	^ MGCardElement new
]
