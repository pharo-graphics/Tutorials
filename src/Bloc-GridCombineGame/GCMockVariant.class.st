"
I'm a mocked game variant. Useful for debugging or testing.
"
Class {
	#name : #GCMockVariant,
	#superclass : #GCVariant,
	#instVars : [
		'nextValueBlock',
		'initialValueBlock',
		'isSuccessBlock',
		'slideDoneBlock'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #accessing }
GCMockVariant >> game: aGame [
	"The game has just initialized and we do stuff."

	super game: aGame.
	
	game announcer
		when: GCSlideDoneAnnouncement
		send: #slideDone:
		to: self
]

{ #category : #accessing }
GCMockVariant >> initialValueBlock [

	^ initialValueBlock
]

{ #category : #accessing }
GCMockVariant >> initialValueBlock: aBlock [

	initialValueBlock := aBlock
]

{ #category : #initialization }
GCMockVariant >> initialize [

	super initialize.
	
	initialValueBlock := [ 2 ].
	nextValueBlock := [ :n | n * 2 ].
	isSuccessBlock := [ :n | n = 2048 ].
	slideDoneBlock := [ :ann | ].
]

{ #category : #accessing }
GCMockVariant >> isSuccessBlock [

	^ isSuccessBlock
]

{ #category : #accessing }
GCMockVariant >> isSuccessBlock: aBlock [

	isSuccessBlock := aBlock
]

{ #category : #testing }
GCMockVariant >> isSuccessTileValue: anObject [
	"Answer where this tile contents mean a game finished with success."

	^ isSuccessBlock value: anObject
]

{ #category : #accessing }
GCMockVariant >> nextAfterCombining: anObject [
	"Answer the next tile value after a combination of the received argument."

	^ nextValueBlock value: anObject
]

{ #category : #accessing }
GCMockVariant >> nextInitialTileValue [
	"Answer a content value for a new tile."

	^ initialValueBlock value
]

{ #category : #accessing }
GCMockVariant >> nextValueBlock [

	^ nextValueBlock
]

{ #category : #accessing }
GCMockVariant >> nextValueBlock: aBlock [

	nextValueBlock := aBlock
]

{ #category : #accessing }
GCMockVariant >> slideDone: aGCSlideDoneAnnouncement [

	slideDoneBlock cull: aGCSlideDoneAnnouncement
]

{ #category : #accessing }
GCMockVariant >> slideDoneBlock [

	^ slideDoneBlock
]

{ #category : #accessing }
GCMockVariant >> slideDoneBlock: anObject [

	slideDoneBlock := anObject
]
