Class {
	#name : #MgCardEventListener,
	#superclass : #BlElementEventListener,
	#instVars : [
		'memoryGame'
	],
	#category : 'Bloc-MemoryGame-Elements'
}

{ #category : #'mouse handlers' }
MgCardEventListener >> clickEvent: anEvent [
	self memoryGame chooseCard: anEvent currentTarget card
]

{ #category : #accessing }
MgCardEventListener >> memoryGame [
	^ memoryGame
]

{ #category : #accessing }
MgCardEventListener >> memoryGame: aMemoryGame [
	memoryGame := aMemoryGame
]
