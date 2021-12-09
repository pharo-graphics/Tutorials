"
A DTPaneCreatingReorderingHandlerTest is a test class for testing the behavior of DTPaneCreatingReorderingHandler
"
Class {
	#name : #DTPaneCreatingReorderingHandlerTest,
	#superclass : #TestCase,
	#category : #'Brick-Examples-Reordering-Tests'
}

{ #category : #tests }
DTPaneCreatingReorderingHandlerTest >> testShowInSpace [

	| pane space |
	pane := DTPaneCreatingReorderingHandler new 
	        fittingColumns
	        constraintsDo: [ :c | 
	            c horizontal matchParent.
	            c vertical matchParent ];
	        yourself.
	space := BlSpace new extent: 800@600.

	space root addChild: pane.
	space show.

	self flag: #todo. "Must wait"
	space close.

]
