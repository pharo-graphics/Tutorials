"
I am an event that occurs on a game's tile.
"
Class {
	#name : #GCTileAnnouncement,
	#superclass : #GCGameAnnouncement,
	#instVars : [
		'tile'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #accessing }
GCTileAnnouncement >> tile [

	^ tile
]

{ #category : #accessing }
GCTileAnnouncement >> tile: anObject [

	tile := anObject
]
