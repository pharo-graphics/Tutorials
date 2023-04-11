"
I'm a tile in a `GCGame`.
"
Class {
	#name : #GCTile,
	#superclass : #Object,
	#instVars : [
		'game',
		'content',
		'position'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #accessing }
GCTile >> content [

	^ content
]

{ #category : #accessing }
GCTile >> content: anObject [

	content := anObject
]

{ #category : #accessing }
GCTile >> game [

	^ game
]

{ #category : #accessing }
GCTile >> game: anObject [

	game := anObject
]

{ #category : #accessing }
GCTile >> position [

	^ position
]

{ #category : #accessing }
GCTile >> position: anObject [

	position := anObject
]

{ #category : #printing }
GCTile >> printOn: aStream [
	"Generate a string representation of the receiver based on its instance variables."

	super printOn: aStream.
	aStream
		nextPutAll: ' position: ';
		print: position.
	aStream
		nextPutAll: ' content: ';
		print: content
]
