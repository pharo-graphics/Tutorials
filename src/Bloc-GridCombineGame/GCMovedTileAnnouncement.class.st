"
I represent the event of a tile that has changed position in a game's board.
"
Class {
	#name : #GCMovedTileAnnouncement,
	#superclass : #GCTileAnnouncement,
	#instVars : [
		'oldPosition',
		'newPosition'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #accessing }
GCMovedTileAnnouncement >> newPosition [

	^ newPosition
]

{ #category : #accessing }
GCMovedTileAnnouncement >> newPosition: anObject [

	newPosition := anObject
]

{ #category : #accessing }
GCMovedTileAnnouncement >> oldPosition [

	^ oldPosition
]

{ #category : #accessing }
GCMovedTileAnnouncement >> oldPosition: anObject [

	oldPosition := anObject
]
