"
I'm an event listener for mouse clicks on cards of a memory game.

"
Class {
	#name : #MGCardEventListener,
	#superclass : #BlEventListener,
	#instVars : [
		'memoryGame'
	],
	#category : #'Bloc-Memory-Elements'
}

{ #category : #'mouse handlers' }
MGCardEventListener >> clickEvent: anEvent [

	memoryGame chooseCard: anEvent currentTarget card
]

{ #category : #accessing }
MGCardEventListener >> memoryGame: aGame [
	memoryGame := aGame
]
