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

	| aSpace |
	aSpace := BlPaneCreatingReorderingHandler new fittingColumnsExample.
	0.5 seconds wait.
	aSpace close.
	0.5 seconds wait
]
