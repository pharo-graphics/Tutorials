"
A DTPaneCreatingReorderingHandlerTest is a test class for testing the behavior of DTPaneCreatingReorderingHandler
"
Class {
	#name : #BlPaneCreatingReorderingHandlerTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Reordering-Tests'
}

{ #category : #tests }
BlPaneCreatingReorderingHandlerTest >> testShowInSpace [

	| aSpace shown semaphore |
	shown := false.
	semaphore := Semaphore new.

	aSpace := BlPaneCreatingReorderingHandler new fittingColumnsExample.
	aSpace
		when: BlSpaceShownEvent
		doOnce: [ :event |
			shown := true.
			aSpace close.
			semaphore signal ].

	semaphore wait.
	
	self assert: shown
]
