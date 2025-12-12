"
I'm an infinite task to update (move) the Boids simulation in the Bloc element.
"
Class {
	#name : #BoidsMoveTask,
	#superclass : #BlRepeatedTask,
	#instVars : [
		'boidsElement',
		'previousSeconds'
	],
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #'instance creation' }
BoidsMoveTask class >> on: aBoidsElement [

	^ self basicNew
		initializeOn: aBoidsElement;
		yourself

]

{ #category : #initialization }
BoidsMoveTask >> initializeOn: aBoidsElement [

	self initialize.

	boidsElement := aBoidsElement.	
	self delay: 0 seconds
]

{ #category : #'api - running' }
BoidsMoveTask >> onRun [

	| seconds |
	seconds := time nowInUTCMicroseconds / 1.0e6.
	previousSeconds ifNil: [
		previousSeconds := seconds ].

	boidsElement move: (seconds - previousSeconds).

	previousSeconds := seconds
]
