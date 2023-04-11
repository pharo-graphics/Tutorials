"
I model a generalization of a well-known game called 2048.

This game consists on:

- The board is a rectangular grid whose slots can have a tile.
- On each turn, the player moves all tiles in the board in one of the following directions: up, down, left, right. We call this ""a slide"". 
- Each tile has a value, and a slide produces the combination of two adjacent tiles if they have the same value. In the combination, one of the tiles is delete and the other is upgraded. This upgrade means a change in the tile value.
- When 
"
Class {
	#name : #GCGame,
	#superclass : #Object,
	#instVars : [
		'variant',
		'gridExtent',
		'tiles',
		'columns',
		'rows',
		'score',
		'announcer'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #'instance creation' }
GCGame class >> gridExtent: aPoint variant: aVariant [
	
	^ self basicNew
		initializeWithGridExtent: aPoint variant: aVariant;
		yourself
]

{ #category : #'instance creation' }
GCGame class >> new [

	^ self gridExtent: 4 @ 4 variant: GC2048Variant new
]

{ #category : #accessing }
GCGame >> announcer [

	^ announcer
]

{ #category : #accessing }
GCGame >> availablePositions [
		
	^ Array streamContents: [ :stream |
		columns withIndexDo: [ :each :columnIndex |
			each withIndexDo: [ :slot :rowIndex |
				slot ifNil: [
					stream nextPut: columnIndex @ rowIndex ] ] ] ]
]

{ #category : #private }
GCGame >> deleteTile: aTile [ 

	(columns at: aTile position x) at: aTile position y put: nil.
	(rows at: aTile position y)    at: aTile position x put: nil.

	tiles remove: aTile.
	
	announcer announce:
		(GCDeletedTileAnnouncement new
			game: self;
			tile: aTile;
			yourself)
]

{ #category : #accessing }
GCGame >> gridExtent [

	^ gridExtent
]

{ #category : #initialization }
GCGame >> initializeWithGridExtent: aPoint [

	self initialize.

	announcer := Announcer new.
	tiles := OrderedCollection new.
	score := 0.

	gridExtent := aPoint.
	columns := (1 to: gridExtent x) collect: [ :each |
		GCGridLine new: gridExtent y ].
	rows := (1 to: gridExtent y) collect: [ :each |
		GCGridLine new: gridExtent x ].

	self variant: GC2048Variant new
]

{ #category : #initialization }
GCGame >> initializeWithGridExtent: aPoint variant: aVariant [

	self initialize.

	announcer := Announcer new.
	tiles := OrderedCollection new.
	score := 0.

	gridExtent := aPoint.
	columns := (1 to: gridExtent x) collect: [ :each |
		GCGridLine new: gridExtent y ].
	rows := (1 to: gridExtent y) collect: [ :each |
		GCGridLine new: gridExtent x ].

	variant := aVariant.
	variant game: self
]

{ #category : #actions }
GCGame >> insertNewTileAt: aPosition [
	"Insert a new tile at certain position. Signal an error if the slot is not available."

	| newTile |
	newTile := GCTile new
		game: self;
		content: variant nextInitialTileValue;
		position: aPosition;
		yourself.
	
	tiles add: newTile.
	(columns at: newTile position x)
		at: newTile position y
		put: newTile.
	(rows at: newTile position y)
		at: newTile position x
		put: newTile.
	
	announcer announce:
		(GCInsertedTileAnnouncement new
			game: self;
			tile: newTile;
			yourself).
			
	self isFull ifTrue: [ 
		announcer announce:
			(GCFinishedAnnouncement newFullOn: self) ]
]

{ #category : #testing }
GCGame >> isFinished [
	
	^ self isFull or: [ self isSuccess ]
]

{ #category : #testing }
GCGame >> isFull [
	
	^ tiles size = (gridExtent x * gridExtent y)
]

{ #category : #testing }
GCGame >> isSuccess [

	^ tiles anySatisfy: [ :each |
		 variant isSuccessTileValue: each content ]
]

{ #category : #private }
GCGame >> moveTile: aTile to: newPosition [

	| oldPosition |
	oldPosition := aTile position.
	
	"Delete"
	(columns at: oldPosition x) at: oldPosition y put: nil.
	(rows at: oldPosition y)    at: oldPosition x put: nil.
	
	"Insert"
	(columns at: newPosition x) at: newPosition y put: aTile.
	(rows at: newPosition y)    at: newPosition x put: aTile.
	
	aTile position: newPosition.
	
	announcer announce:
		(GCMovedTileAnnouncement new
			game: self;
			tile: aTile;
			oldPosition: oldPosition;
			newPosition: newPosition;
			yourself)

]

{ #category : #accessing }
GCGame >> score [

	^ score
]

{ #category : #actions }
GCGame >> slideDown [

	self slideIsVertical: true isToEnd: true
]

{ #category : #actions }
GCGame >> slideIsVertical: isVertical isToEnd: isToEnd [

	| lines |
	lines := isVertical ifTrue: [ columns ] ifFalse: [ rows ].
	lines withIndexDo: [ :eachLine :lineIndex |
		eachLine
			slideTiles: isToEnd
			movesDo: [ :tile :otherIndex |
				self
					moveTile: tile
					to: (isVertical
						ifTrue: [ lineIndex @ otherIndex ]
						ifFalse: [ otherIndex @ lineIndex ]) ]
			combinesDo: [ :tile1 :tile2 :otherIndex |
				self deleteTile: tile1.
				self upgradeTile: tile2.
				self
					moveTile: tile2
					to: (isVertical
						ifTrue: [ lineIndex @ otherIndex ]
						ifFalse: [ otherIndex @ lineIndex ]) ] ].

	announcer announce: (self isSuccess
		ifTrue: [ GCFinishedAnnouncement newSuccessOn: self ]
		ifFalse: [ GCSlideDoneAnnouncement new
			game: self;
			isVertical: isVertical;
			isToEnd: isToEnd;
			yourself ])
]

{ #category : #actions }
GCGame >> slideLeft [

	self slideIsVertical: false isToEnd: false
]

{ #category : #actions }
GCGame >> slideRight [

	self slideIsVertical: false isToEnd: true
]

{ #category : #actions }
GCGame >> slideUp [

	self slideIsVertical: true isToEnd: false
]

{ #category : #accessing }
GCGame >> tiles [

	^ tiles
]

{ #category : #private }
GCGame >> upgradeTile: aTile [ 

	| oldValue newValue |
	oldValue := aTile content.
	newValue := variant nextAfterCombining: oldValue.
	aTile content: newValue.
	score := score + newValue.
	
	announcer announce:
		(GCUpgradedTileAnnouncement new
			game: self;
			tile: aTile;
			oldValue: oldValue;
			newValue: newValue;
			yourself)
]

{ #category : #accessing }
GCGame >> variant [

	^ variant
]
