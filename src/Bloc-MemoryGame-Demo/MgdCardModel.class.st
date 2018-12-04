"
I am a card model that can be flipped in order to show its back or face.
When card is flipped on the face a player should see a symbol that is used to compare two cards.

!! Examples:

[[[
	| cardModel |
	cardModel := MgdCardModel new symbol: $a.
	cardModel flip.
	cardModel disappear
]]]
"
Class {
	#name : #MgdCardModel,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'flipped',
		'announcer'
	],
	#category : 'Bloc-MemoryGame-Demo-Model'
}

{ #category : #accessing }
MgdCardModel >> announcer [
	"Return my announcer that is used to notify my observers"
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #actions }
MgdCardModel >> disappear [
	"Ask card to disapper"
	self notifyDisappear
]

{ #category : #actions }
MgdCardModel >> flip [
	"Flip the card on the other side (toggle flipped state)"
	flipped := flipped not.
	self notifyFlipped
]

{ #category : #'gt-inspector' }
MgdCardModel >> gtInspectorCardIn: aComposite [
	<gtInspectorPresentationOrder: 1>
	
	aComposite fastTable 
		title: 'Card' translated;
		display: [ {
			#Symbol: -> self symbol printString.
			#'Visible side:' -> (self isFlipped ifTrue: [ 'Face' ] ifFalse: [ 'Back' ])
		} ];
		column: 'Name' evaluated: [ :each | each key ];
		column: 'Value' evaluated: [ :each | each value ]
]

{ #category : #'gt-inspector' }
MgdCardModel >> gtInspectorCardSubscribtionsIn: aComposite [
	<gtInspectorPresentationOrder: 2>
	
	^ self announcer gtInspectorSubscriptionsIn: aComposite
]

{ #category : #initialization }
MgdCardModel >> initialize [
	super initialize.
	flipped := false
]

{ #category : #testing }
MgdCardModel >> isFlipped [
	"Return true if card is flipped and its face (symbol) is visible, false otherwise"
	<return: #Number>

	^ flipped
]

{ #category : #notifying }
MgdCardModel >> notifyDisappear [
	"Notify all observers that I disappeared from the game"
	self announcer announce: MgdCardDisappearAnnouncement new
]

{ #category : #notifying }
MgdCardModel >> notifyFlipped [
	"Notify all observers that my flipped state was changed (from flipped to not or the other way around)"
	self announcer announce: MgdCardFlippedAnnouncement new
]

{ #category : #printing }
MgdCardModel >> printOn: aStream [
	aStream
		nextPutAll: 'Card';
		nextPut: Character space;
		nextPut: $(;
		nextPut: self symbol;
		nextPut: $)
]

{ #category : #accessing }
MgdCardModel >> symbol [
	"Return a symbol that should be displayed when card is flipped and face is visible"
	<return: #Character>

	^ symbol
]

{ #category : #accessing }
MgdCardModel >> symbol: aCharacter [
	"Initialize the card with a given symbol as a character"
	self
		assert: [ aCharacter isNotNil ]
		description: [ 'Character must not be nil' ].

	symbol := aCharacter
]
