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
		'game'
	],
	#category : #'Bloc-Memory-Elements'
}

{ #category : #example }
MGGameElement class >> exampleInASpace [
	<example>
	
	| space game gameElement |
	game := MGGame withNumbers.
	gameElement := self new.
	gameElement memoryGame: game.
	 
	space := BlSpace new.
	space extent: 420@420.
	space addChild: gameElement. 
	space show. 

]

{ #category : #initialization }
MGGameElement >> initialize [

	super initialize.

	self background: (BlBackground paint: Color gray darker).
	self layout: (BlGridLayout horizontal cellSpacing: 20).

	self constraintsDo: [ :aLayoutConstraints | 
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ]
]

{ #category : #accessing }
MGGameElement >> memoryGame [
	^ game
]

{ #category : #accessing }
MGGameElement >> memoryGame: aGame [

	| aCardEventListener |
	game := aGame.
	aCardEventListener := self newCardEventListener memoryGame: aGame.
	self layout columnCount: game gridSize.
	game availableCards do: [ :aCard | 
		| cardElement |
		cardElement := self newCardElement card: aCard.
		cardElement addEventHandler: aCardEventListener.
		self addChild: cardElement ]
]

{ #category : #accessing }
MGGameElement >> newCardElement [
	^ MGCardElement new
]

{ #category : #'instance creation' }
MGGameElement >> newCardEventListener [

	^ MGCardEventListener new
]
