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

	| aSpace shown semaphore |
	shown := false.
	semaphore := Semaphore new.

	aSpace := MGGameElement example.
	aSpace
		when: BlSpaceShownEvent
		doOnce: [ :event |
			shown := true.
			aSpace close.
			semaphore signal ].

	semaphore wait.
	
	self assert: shown
]
