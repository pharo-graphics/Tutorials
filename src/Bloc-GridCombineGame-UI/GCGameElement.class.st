"
I am a GUI for `GCGame`.

My central collaborator is a game model, which is associated at instance creation. Whatever the state of the game, I will show it's state and subscribe to it's announcements to update myself when required.

Vocabulary: 
- *tiles* are the numbered elements that the player slides
- *slots* are invisible rectangles disposed in a grid that covers the game element, and serve as a reference for positioning and sizing the tiles.

When I'm added to a parent element (e.g. a space), I subscribe to the key and mouse wheel events to respond accordingly by sliding the tiles.

See an example on my class-side.
"
Class {
	#name : #GCGameElement,
	#superclass : #GCElement,
	#instVars : [
		'game',
		'skin',
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

	| game gameElement space skin |
	game := GCGame new.
	skin := GCClassicSkin new.
	gameElement := self on: game skin: skin.

	space := BlSpace new.
	space root addChild: gameElement.
	space
		extent: game gridExtent * (skin cellSize + (2 * skin cellMarginSize));
		show;
		inspect
]

{ #category : #examples }
GCGameElement class >> example32 [

	| customVariant game gameElement space skin |
	customVariant :=
		GCMockVariant new
			isSuccessBlock: [:n | n = 32 ];
			slideDoneBlock: [ :ann |
				5 timesRepeat: [
					ann game insertNewTileAt: 
						ann game availablePositions atRandom ] ];
			yourself.

	game :=
		(GCGame
			gridExtent: 5@5
			variant: customVariant)
				insertNewTileAt: 1@1;
				yourself.
	skin := GCClassicSkin new.
	gameElement := self on: game skin: skin.

	space := BlSpace new.
	space root addChild: gameElement.
	space
		extent: game gridExtent * (skin cellSize + (2 * skin cellMarginSize));
		show
]

{ #category : #'instance creation' }
GCGameElement class >> on: aGame skin: aSkin [

	^ self basicNew
		initializeWithGame: aGame skin: aSkin;
		yourself
]

{ #category : #private }
GCGameElement >> addTileElementFor: aTile [

	| tileElement |
	tileElement := GCLabelElement new
		text: aTile content asRopedText;
		yourself.
	tilesContainer addChild: tileElement.

	tileElement transformDo: [ :t |
		t translateBy: (self tilePositionFor: aTile) ].

	elementByTile
		at: aTile
		put: tileElement.

	skin applyTileSkinOn: tileElement.

	^ tileElement
]

{ #category : #accessing }
GCGameElement >> game [

	^ game
]

{ #category : #initialization }
GCGameElement >> initialize [

	super initialize.

	elementByTile := Dictionary new.

	"The tile container is an overlay on top of the slots."
	slotsContainer := GCElement new.
	tilesContainer := GCElement new.
	self
		addChild: slotsContainer;
		addChild: tilesContainer.

	"Key bindings need to be registered on the parent"
	isSlideEnabled := false.
	self
		when: BlElementAddedToParentEvent
		do: [ :anEvent |
			isSlideEnabled := true.
			self
				registerKeyBindings;
				registerToMouseWheel ]
]

{ #category : #initialization }
GCGameElement >> initializeWithGame: aGame [

	game := aGame.

	slotsContainer layout: BlGridLayout vertical.
	slotsContainer layout rowCount: game gridExtent y.
	slotElementMatrix := Array2D
		rows: game gridExtent y
		columns: game gridExtent x
		tabulate: [ :row :column |
			self newSlotElementForRow: row column: column ].
	slotElementMatrix do: [:each |
		slotsContainer addChild: each ].
	"If slots resize, then tiles must be repositioned."
	slotElementMatrix anyOne
		when: BlElementExtentChangedEvent
		do: [ :event | self refreshOnSlotsPixelResize ].

	game tiles do: [ :each |
		self addTileElementFor: each ].
	self refreshScoreInTitle.
	
	self subscribeToGameAnnouncements
]

{ #category : #initialization }
GCGameElement >> initializeWithGame: aGame skin: aSkin [

	self
		initialize;
		initializeWithSkin: aSkin;
		initializeWithGame: aGame
]

{ #category : #initialization }
GCGameElement >> initializeWithSkin: aSkin [

	skin := aSkin.
	skin applyGameSkinOn: self
]

{ #category : #initialization }
GCGameElement >> newSlotElementForRow: row column: column [

	| newSlotElement |
	newSlotElement := GCElement new.
	newSlotElement id: ('{1}@{2}' format: {column.row}).

	skin applySlotSkinOn: newSlotElement.
	
	^ newSlotElement
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
	
	| label |
	self unregisterEventHandlers.

	label := GCLabelElement new.
	self addChild: label.

	ann isSuccess
		ifTrue: [ skin applyGameSuccessMessageSkinOn: label ]
		ifFalse: [ skin applyGameFailedMessageSkinOn: label ]
]

{ #category : #'model updates' }
GCGameElement >> refreshOnInsertedTile: aGCInsertedTileAnnouncement [ 
	
	| newTileElement |
	newTileElement := self addTileElementFor: aGCInsertedTileAnnouncement tile.
	
	skin applyTileInsertedSkinOn: newTileElement
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

{ #category : #private }
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

{ #category : #accessing }
GCGameElement >> skin [

	^ skin
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

{ #category : #accessing }
GCGameElement >> slotsContainer [

	^ slotsContainer
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

{ #category : #accessing }
GCGameElement >> tilesContainer [

	^ tilesContainer
]

{ #category : #initialization }
GCGameElement >> unregisterEventHandlers [

	self parent
		removeEventHandler: keyBindingsEventHandler;
		removeEventHandler: mouseWheelEventHandler
]
