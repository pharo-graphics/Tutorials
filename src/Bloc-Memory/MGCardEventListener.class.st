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
