Class {
	#name : #MgGameElement,
	#superclass : #BlElement,
	#classInstVars : [
		'cardType'
	],
	#category : 'Bloc-MemoryGame-Elements'
}

{ #category : #accessing }
MgGameElement class >> cardType [
	^ cardType ifNil: [ cardType := MgRawCardElement ]
]

{ #category : #accessing }
MgGameElement class >> cardType: aCardElementClass [
	cardType := aCardElementClass
]

{ #category : #initialization }
MgGameElement >> initialize [
	super initialize.
	
	self background: (BlBackground paint: Color gray darker).
	
	self layout: (BlGridLayout horizontal cellSpacing: 20).
	self constraintsDo: [ :layoutConstraints |
		layoutConstraints horizontal fitContent.
		layoutConstraints vertical fitContent ]
]

{ #category : #accessing }
MgGameElement >> memoryGame: aMemoryGame [

	self layout columnCount: aMemoryGame gridSize.
	
	aMemoryGame availableCards do: [ :aCard |
		self addChild: (self newCardElement
			card: aCard;
			addEventHandler: (self newCardEventListener memoryGame: aMemoryGame)) ].
]

{ #category : #building }
MgGameElement >> newCardElement [
	^ self class cardType new
]

{ #category : #building }
MgGameElement >> newCardEventListener [
	^ MgCardEventListener new
]
