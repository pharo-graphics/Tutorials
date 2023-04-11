"
I represent a variant of a `GCGame`.

Subclasses may want to subscribe to game announcements to react.
"
Class {
	#name : #GCVariant,
	#superclass : #Object,
	#instVars : [
		'game'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #testing }
GCVariant class >> isAbstract [

	^ self == GCVariant
]

{ #category : #accessing }
GCVariant >> game: aGCGame [

	game := aGCGame
]

{ #category : #testing }
GCVariant >> isSuccessTileValue: anObject [
	"Answer where this tile contents mean a game finished with success."

	^ self subclassResponsibility
]

{ #category : #accessing }
GCVariant >> nextAfterCombining: anObject [
	"Answer the next tile value after a combination of the received argument."

	^ self subclassResponsibility
]

{ #category : #accessing }
GCVariant >> nextInitialTileValue [
	"Answer a content value for a new tile."

	^ self subclassResponsibility
]
