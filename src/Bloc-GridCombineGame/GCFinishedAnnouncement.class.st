"
I represent the event that communicates that a game when finished, either the player won or lost the game.
"
Class {
	#name : #GCFinishedAnnouncement,
	#superclass : #GCGameAnnouncement,
	#instVars : [
		'isSuccess'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #'instance creation' }
GCFinishedAnnouncement class >> newFullOn: aGame [

	^ self new
		  isSuccess: false;
		  game: aGame;
		  yourself
]

{ #category : #'instance creation' }
GCFinishedAnnouncement class >> newSuccessOn: aGame [

	^ self new
		  isSuccess: true;
		  game: aGame;
		  yourself
]

{ #category : #testing }
GCFinishedAnnouncement >> isSuccess [

	^ isSuccess
]

{ #category : #testing }
GCFinishedAnnouncement >> isSuccess: aBoolean [ 
	
	isSuccess := aBoolean
]
