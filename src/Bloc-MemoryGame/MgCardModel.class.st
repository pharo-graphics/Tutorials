"
I am a card model that can be flipped or not.
When card is flipped player should see a symbol that is used to compare two cards.

!! Examples:

[[[
	| cardModel |
	cardModel := MgCardModel new symbol: $a.
	cardModel flip.
	cardModel disappear
]]]
"
Class {
	#name : #MgCardModel,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'flipped',
		'announcer'
	],
	#category : 'Bloc-MemoryGame-Model'
}

{ #category : #accessing }
MgCardModel >> announcer [
	"Return my announcer that is used to notify my observers"
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #actions }
MgCardModel >> disappear [
	"Ask card to disapper"
	self notifyDisappear
]

{ #category : #actions }
MgCardModel >> flip [
	"Flip the card on the other side (toggle flipped state)"
	flipped := flipped not.
	self notifyFlipped
]

{ #category : #initialization }
MgCardModel >> initialize [
	super initialize.
	flipped := false
]

{ #category : #testing }
MgCardModel >> isFlipped [
	"Return true if card is flipped and its face (symbol) is visible, false otherwise"
	<return: #Number>

	^ flipped
]

{ #category : #notifying }
MgCardModel >> notifyDisappear [
	"Notify all observers that I disappeared from the game"
	self announcer announce: MgCardDisappearAnnouncement new
]

{ #category : #notifying }
MgCardModel >> notifyFlipped [
	"Notify all observers that my flipped state was changed (from flipped to not or the other way around)"
	self announcer announce: MgCardFlippedAnnouncement new
]

{ #category : #printing }
MgCardModel >> printOn: aStream [
	aStream
		nextPutAll: 'Card';
		nextPut: Character space;
		nextPut: $(;
		nextPut: self symbol;
		nextPut: $)
]

{ #category : #accessing }
MgCardModel >> symbol [
	"Return a symbol that should be displayed when card is flipped and face is visible"
	<return: #Character>

	^ symbol
]

{ #category : #accessing }
MgCardModel >> symbol: aCharacter [
	"Initialize the card with a given symbol as a character"
	self
		assert: [ aCharacter isNotNil ]
		description: [ 'Character must not be nil' ].

	symbol := aCharacter
]
