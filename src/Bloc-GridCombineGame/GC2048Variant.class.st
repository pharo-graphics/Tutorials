"
I represent the original 2048 game variant.
"
Class {
	#name : #GC2048Variant,
	#superclass : #GCVariant,
	#instVars : [
		'random'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #accessing }
GC2048Variant >> game: aGame [
	"The game has just initialized and we do stuff."

	super game: aGame.
	
	self insertTileAtRandomPosition.

	game announcer
		when: GCSlideDoneAnnouncement
		send: #insertTileAtRandomPosition
		to: self
]

{ #category : #initialization }
GC2048Variant >> initialize [

	super initialize.
	
	random := Random new
]

{ #category : #actions }
GC2048Variant >> insertTileAtRandomPosition [
	"Insert a new tile, assuming game is not full, i.e. there is at least an available slot."

	game insertNewTileAt: (game availablePositions atRandom: random)
]

{ #category : #testing }
GC2048Variant >> isSuccessTileValue: anInteger [ 
	
	^ anInteger = 2048
]

{ #category : #accessing }
GC2048Variant >> nextAfterCombining: anInteger [ 
	
	^ anInteger * 2
]

{ #category : #accessing }
GC2048Variant >> nextInitialTileValue [
	
	^ 2
]

{ #category : #accessing }
GC2048Variant >> random [

	^ random
]

{ #category : #accessing }
GC2048Variant >> random: anObject [

	random := anObject
]
