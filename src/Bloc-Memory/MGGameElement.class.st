"
I'm a game visual board.

## To open a game 

```
| aGameElement space |
aGameElement := MGGameElement new memoryGame: MGGame withNumbers; yourself.
space := BlSpace new.
space addChild: aGameElement. 
space pulse.
space extent: aGameElement extent.
space show. 
```


## To open a game in a separate native window
```
| aGameElement space |
aGameElement := MGGameElement new memoryGame: MGGame withNumbers; yourself.
space := BlSpace new.
space host: BlOSWindowSDL2Host new.  
space addChild: aGameElement. 
space pulse.
space extent: aGameElement extent.
space show. 
```
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
	
	^ self new memoryGame: MGGame withNumbers; yourself

]

{ #category : #example }
MGGameElement class >> exampleInASpace [
	<sampleInstance>
	
	self openOnModel: MGGame withNumbers inSpace: (BlSpace new extent: 420@420; yourself)

]

{ #category : #example }
MGGameElement class >> exampleInASpaceInAnOSWindow [
	<sampleInstance>
	
	self nativelyOpenOnModel: MGGame withNumbers inSpace: BlSpace new.
]

{ #category : #opening }
MGGameElement class >> nativelyOpenOnModel: aModel inSpace: aSpace [

	aSpace host: BlOSWindowSDL2Host new.
	^ self openOnModel: aModel inSpace: aSpace.
]

{ #category : #'instance creation' }
MGGameElement class >> onModel: aModel [

	^ self new memoryGame: aModel; yourself
]

{ #category : #'instance creation' }
MGGameElement class >> onModel: aModel inSpace: aSpace [

	| game |
	game := self onModel: aModel.
	aSpace addChild: game. 
	^ game
]

{ #category : #opening }
MGGameElement class >> openOnModel: aModel inSpace: aSpace [

	| game |
	game := self onModel: aModel inSpace: aSpace.
	aSpace pulse.
	aSpace show.
	^ game
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
