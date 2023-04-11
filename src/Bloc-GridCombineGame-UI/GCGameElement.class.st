"
I am a GUI for `GCGame`.

After creation, a game must be associated via the corresponding accessor. At that moment, I will show the game state and subscribe to it's announcements to update myself when required.

When I'm added to a parent element, I subscribe to the key and mouse wheel events to respond accordingly by sliding the tiles.

See an example on my class-side.
"
Class {
	#name : #GCGameElement,
	#superclass : #GCElement,
	#instVars : [
		'game',
		'tilesContainer',
		'slotsContainer',
		'elementByTile',
		'keyBindingsEventHandler',
		'mouseWheelEventHandler',
		'isSlideEnabled',
		'slotElementMatrix'
	],
	#category : #'Bloc-GridCombineGame-UI'
}

{ #category : #examples }
GCGameElement class >> example2048 [

	self exampleFor: GCGame new
]

{ #category : #examples }
GCGameElement class >> exampleFor: game [

	| gameElement space skin |
	gameElement := GCGameElement new
		game: game;
		yourself.
	space := BlSpace new.

	skin := game variant skinClass on: gameElement.
	space root whenLayoutedDo: [ :evt | skin applyToNewElements ].

	space
		addChild: gameElement;
		extent: game gridExtent * (skin cellSize + (2 * skin cellMarginSize));
		show
]

{ #category : #examples }
GCGameElement class >> exampleMocked32 [

	| customVariant |
	customVariant :=
		GCMockVariant new
			isSuccessBlock: [:n | n = 32 ];
			slideDoneBlock: [ :ann |
				5 timesRepeat: [
					ann game insertNewTileAt: 
						ann game availablePositions atRandom ] ];
			yourself.

	self exampleFor:
		((GCGame
			gridExtent: 5@5
			variant: customVariant)
			insertNewTileAt: 1@1;
			yourself)
]

{ #category : #private }
GCGameElement >> addTileElementFor: aTile [

	| tileElement |
	tileElement := GCTileElement new
		text: aTile content asRopedText;
		yourself.
	tilesContainer addChild: tileElement.
	
	tileElement transformDo: [ :t |
		t translateBy: (self tilePositionFor: aTile) ].
	
	elementByTile
		at: aTile
		put: tileElement.
		
	^ tileElement
]

{ #category : #accessing }
GCGameElement >> game [

	^ game
]

{ #category : #accessing }
GCGameElement >> game: aGame [

	game ifNotNil: [ self notYetImplemented ].
	game := aGame.

	elementByTile := Dictionary new.

	slotsContainer layout: BlGridLayout vertical.
	slotsContainer layout rowCount: game gridExtent y.
	slotElementMatrix := Array2D
		rows: game gridExtent y
		columns: game gridExtent x
		tabulate: [ :row :column | GCElement new ].
	slotElementMatrix withIndicesDo: [:each :row :column |
		slotsContainer
			addChild: each
			as: ('{1}@{2}' format: {column.row}) ].
	"If slots resize, then tiles must be repositioned."
	slotElementMatrix anyOne
		when: BlElementExtentChangedEvent
		do: [ :event | self refreshOnSlotsPixelResize ].

	game tiles do: [ :each |
		self addTileElementFor: each ].
	self refreshScoreInTitle.
	
	self subscribeToGameAnnouncements.
]

{ #category : #initialization }
GCGameElement >> initialize [

	super initialize.

	"The tile container is an overlay on top of the slots."
	self
		addChild: (slotsContainer := GCElement new) as: #slotContainer;
		addChild: (tilesContainer := GCElement new) as: #tileContainer.

	"Key bindings need to be registered on the parent"
	isSlideEnabled := false.
	self
		when: BlElementAddedToParentEvent
		do: [ :anEvent |
			isSlideEnabled := true.
			self
				registerKeyBindings;
				registerToMouseWheel ].

]

{ #category : #'model updates' }
GCGameElement >> refreshOnDeletedTile: aGCDeletedTileAnnouncement [ 
	
	| tileElement |
	tileElement := elementByTile at: aGCDeletedTileAnnouncement tile.
	
	tileElement addAnimation:
		(BlOpacityAnimation new
			duration: 0.2 seconds;
			opacity: 0.0;
			onFinishedDo: [ tileElement removeFromParent ];
			yourself)
			
 
]

{ #category : #private }
GCGameElement >> refreshOnFinished: ann [
	
	| containerElement label id |
	self unregisterEventHandlers.

	id := ann isSuccess
		ifTrue: [ #success ]
		ifFalse: [ #failed ].
		
	containerElement := GCElement new id: id; yourself.

	label :=
		BlTextElement new
			text: id asString capitalized asRopedText;
			yourself.

	self addChild: containerElement as: id.
	containerElement
		addChild: label as: #label;
		opacity: 0.0;
		addAnimation:
			(BlOpacityAnimation new
				duration: 0.2 seconds;
				opacity: 1.0;
				yourself).

]

{ #category : #'model updates' }
GCGameElement >> refreshOnInsertedTile: aGCInsertedTileAnnouncement [ 
	
	| newElement |
	newElement := self addTileElementFor: aGCInsertedTileAnnouncement tile.
	
	newElement
		opacity: 0.0;
		addAnimation:
			(BlOpacityAnimation new
				duration: 0.2 seconds;
				opacity: 1.0;
				yourself)
]

{ #category : #'model updates' }
GCGameElement >> refreshOnMovedTile: aGCMovedTileAnnouncement [ 
	
	| aTile |
	aTile := aGCMovedTileAnnouncement tile.
	(elementByTile at: aTile) transformDo: [ :t |
		t translateBy: (self tilePositionFor: aTile) ]
]

{ #category : #private }
GCGameElement >> refreshOnSlideDone [

	self refreshScoreInTitle
]

{ #category : #'model updates' }
GCGameElement >> refreshOnSlotsPixelResize [
	
	elementByTile keysAndValuesDo: [ :tile :tileElement |
		tileElement transformDo: [ :t | 
			t translateBy: (self tilePositionFor: tile) ]].
]

{ #category : #'model updates' }
GCGameElement >> refreshOnUpgradedTile: aGCUpgradedTileAnnouncement [

	| aTile |
	aTile := aGCUpgradedTileAnnouncement tile.
	(elementByTile at: aTile) text: aTile content asRopedText
]

{ #category : #initialization }
GCGameElement >> refreshScoreInTitle [
	
	self space ifNotNil: [ :s | s title: ('Score: ', game score asString) ]
]

{ #category : #initialization }
GCGameElement >> registerKeyBindings [

	| selectorByKey |
	selectorByKey := {
		KeyboardKey up    -> #slideUp.
		KeyboardKey down  -> #slideDown.
		KeyboardKey left  -> #slideLeft.
		KeyboardKey right -> #slideRight.
	} asDictionary.

	keyBindingsEventHandler := BlEventHandler on: BlKeyUpEvent do: [ :evt |
		selectorByKey
			at: evt key
			ifPresent: [ :slideSelector |
				self
					slideIfEnabled: slideSelector
					andDisableDuring: 0.25 seconds ] ].

	self parent addEventHandler: keyBindingsEventHandler.
]

{ #category : #initialization }
GCGameElement >> registerToMouseWheel [

	mouseWheelEventHandler :=
		BlEventHandler
			on: BlMouseWheelEvent
			do: [ :evt |
				#(
					isScrollLeft 	slideLeft
					isScrollRight 	slideRight
					isScrollUp 		slideUp
					isScrollDown 	slideDown
				) pairsDo: [ :scrollSelector :slideSelector |
					(evt perform: scrollSelector) ifTrue: [
						"Quite a lot of wait, but else it is annoying on Mac"
						self
							slideIfEnabled: slideSelector
							andDisableDuring: 1 second ] ]
				].

	self parent addEventHandler: mouseWheelEventHandler.
]

{ #category : #private }
GCGameElement >> slideIfEnabled: slideSelector andDisableDuring: aDuration [

	isSlideEnabled ifFalse: [ ^self ].

	"Disable slides during a period"
	isSlideEnabled := false.
	[	self space time wait: aDuration.
		isSlideEnabled := true ] fork.
	
	game perform: slideSelector
]

{ #category : #initialization }
GCGameElement >> subscribeToGameAnnouncements [

	game announcer
		when: GCInsertedTileAnnouncement
			send: #refreshOnInsertedTile:
			to: self;
		when: GCMovedTileAnnouncement
			send: #refreshOnMovedTile:
			to: self;
		when: GCUpgradedTileAnnouncement
			send: #refreshOnUpgradedTile:
			to: self;
		when: GCDeletedTileAnnouncement
			send: #refreshOnDeletedTile:
			to: self;
		when: GCSlideDoneAnnouncement
			send: #refreshOnSlideDone
			to: self;
		when: GCFinishedAnnouncement
			send: #refreshOnFinished:
			to: self
]

{ #category : #private }
GCGameElement >> tilePositionFor: aTile [
	"Answer the local pixel position that corresponds to the tile position, which is a board position. Use the corresponding slot as a reference."

	^ (slotElementMatrix
		at: aTile position x
		at: aTile position y) position
]

{ #category : #initialization }
GCGameElement >> unregisterEventHandlers [

	self parent
		removeEventHandler: keyBindingsEventHandler;
		removeEventHandler: mouseWheelEventHandler
]
