"
A MGGameElementTest is a test class for testing the behavior of MGGameElement
"
Class {
	#name : #MGGameElementTest,
	#superclass : #TestCase,
	#category : #'Bloc-Memory-Tests-Elements'
}

{ #category : #tests }
MGGameElementTest >> testShowInSpace [

	| space |
	space := MGGameElement example.
	space
		when: BlSpaceShownEvent
		doOnce: [ :event | space close ]
]
