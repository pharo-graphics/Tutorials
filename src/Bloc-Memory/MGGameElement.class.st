"
I'm a game UI for a game model.

To open a game, look at the example in class-side.

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
MGGameElement class >> example [
	<sampleInstance>

	| aGameElement space |
	aGameElement := MGGameElement new.
	aGameElement memoryGame: MGGame withNumbers.

	space := BlSpace new.
	space root addChild: aGameElement.
	space root whenLayoutedDoOnce: [ space extent: aGameElement size ].
	^ space show
]

{ #category : #initialization }
MGGameElement >> initialize [

	super initialize.

	self background: (BlBackground paint: Color gray darker).

	self layout:
		(BlGridLayout horizontal
			cellSpacing: 20;
			yourself).

	self constraintsDo: [ :layoutConstraints | 
		layoutConstraints horizontal fitContent.
		layoutConstraints vertical fitContent ]
]

{ #category : #accessing }
MGGameElement >> memoryGame [

	^ game
]

{ #category : #accessing }
MGGameElement >> memoryGame: aGame [

	| aCardEventListener |
	game := aGame.
	aCardEventListener :=
		MGCardEventListener new
			memoryGame: aGame;
			yourself.

	self layout columnCount: game gridSize.

	game availableCards do: [ :aCard | 
		| cardElement |
		cardElement :=
			MGCardElement new
				card: aCard;
				addEventHandler: aCardEventListener;
				yourself.
		self addChild: cardElement ]
]
