"
I represent an event that occurs in a `GCGame`.
"
Class {
	#name : #GCGameAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'game'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #accessing }
GCGameAnnouncement >> game [

	^ game
]

{ #category : #accessing }
GCGameAnnouncement >> game: anObject [

	game := anObject
]
