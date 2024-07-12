Class {
	#name : #GCGameElementTest,
	#superclass : #TestCase,
	#category : #'Bloc-GridCombineGame-Tests-UI'
}

{ #category : #tests }
GCGameElementTest >> testShowInSpace [

	| aSpace shown semaphore |
	shown := false.
	semaphore := Semaphore new.

	aSpace := GCGameElement example2048.
	aSpace
		when: BlSpaceShownEvent
		doOnce: [ :event |
			shown := true.
			aSpace close.
			semaphore signal ].

	semaphore wait.
	
	self assert: shown
]
