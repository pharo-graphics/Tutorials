"
A DTPaneCreatingReorderingHandlerTest is a test class for testing the behavior of DTPaneCreatingReorderingHandler
"
Class {
	#name : #DTPaneCreatingReorderingHandlerTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Reordering-Tests'
}

{ #category : #tests }
DTPaneCreatingReorderingHandlerTest >> testShowInSpace [

	| aSpace |
	aSpace := DTPaneCreatingReorderingHandler new fittingColumnsExample.
	0.5 seconds wait.
	aSpace close.
	0.5 seconds wait
]
