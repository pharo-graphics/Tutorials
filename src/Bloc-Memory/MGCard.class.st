"
I am a card model that can be flipped to show its back or face.
When card is flipped on the face a player should see a symbol that is used to compare two cards.

!! Examples:

[[[
	| cardModel |
	cardModel := MGCard new symbol: $a.
	cardModel flip.
	cardModel disappear
]]]
"
Class {
	#name : #MGCard,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'flipped',
		'announcer'
	],
	#category : #'Bloc-Memory-Model'
}

{ #category : #accessing }
MGCard >> announcer [
	"Return my announcer that is used to notify my observers"
	
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #actions }
MGCard >> disappear [
	"Ask card to disapper"
	
	self notifyDisappear
]

{ #category : #actions }
MGCard >> flip [
	"Flip the card on the other side (toggle flipped state)"
	
	flipped := flipped not.
	self notifyFlipped
]

{ #category : #initialization }
MGCard >> initialize [
	super initialize.
	flipped := false
]

{ #category : #testing }
MGCard >> isFlipped [
	"Return true if card is flipped and its face (symbol) is visible, false otherwise"

	^ flipped
]

{ #category : #notifying }
MGCard >> notifyDisappear [
	"Notify all observers that I disappeared from the game"
	
	self announcer announce: MGCardDisappearAnnouncement new
]

{ #category : #notifying }
MGCard >> notifyFlipped [
	"Notify all observers that my flipped state was changed (from flipped to not or the other way around)"
	
	self announcer announce: MGCardFlippedAnnouncement new
]

{ #category : #printing }
MGCard >> printOn: aStream [
	aStream
		nextPutAll: 'Card';
		nextPut: Character space;
		nextPut: $(;
		nextPut: self symbol;
		nextPut: $)
]

{ #category : #accessing }
MGCard >> symbol [
	"Return a symbol that should be displayed when card is flipped and face is visible"

	^ symbol
]

{ #category : #accessing }
MGCard >> symbol: aCharacter [
	"Initialize the card with a given symbol as a character"

	symbol := aCharacter
]
