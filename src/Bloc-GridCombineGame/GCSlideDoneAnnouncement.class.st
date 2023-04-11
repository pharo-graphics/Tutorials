"
I am an event that happens when a slide was done in a game, and the game doesn't finish yet.
"
Class {
	#name : #GCSlideDoneAnnouncement,
	#superclass : #GCGameAnnouncement,
	#instVars : [
		'isVertical',
		'isToEnd'
	],
	#category : #'Bloc-GridCombineGame'
}

{ #category : #accessing }
GCSlideDoneAnnouncement >> isToEnd [

	^ isToEnd
]

{ #category : #accessing }
GCSlideDoneAnnouncement >> isToEnd: anObject [

	isToEnd := anObject
]

{ #category : #accessing }
GCSlideDoneAnnouncement >> isVertical [

	^ isVertical
]

{ #category : #accessing }
GCSlideDoneAnnouncement >> isVertical: anObject [

	isVertical := anObject
]
