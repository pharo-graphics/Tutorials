"
I represent the event of a tile that has been combined with another tile and then upgrades it's value (the other tile is deleted).
"
Class {
	#name : #GCUpgradedTileAnnouncement,
	#superclass : #GCTileAnnouncement,
	#instVars : [
		'oldValue',
		'newValue'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #accessing }
GCUpgradedTileAnnouncement >> newValue [

	^ newValue
]

{ #category : #accessing }
GCUpgradedTileAnnouncement >> newValue: anObject [

	newValue := anObject
]

{ #category : #accessing }
GCUpgradedTileAnnouncement >> oldValue [

	^ oldValue
]

{ #category : #accessing }
GCUpgradedTileAnnouncement >> oldValue: anObject [

	oldValue := anObject
]
