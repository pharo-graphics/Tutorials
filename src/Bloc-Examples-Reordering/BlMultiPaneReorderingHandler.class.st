"
In planning boards, we want to drag and drop tasks from one pane to another. This event handler supports that. The container is the space where the dragging and dropping is to happen, the panes are the elements that contain tasks
"
Class {
	#name : #BlMultiPaneReorderingHandler,
	#superclass : #BlReorderingHandler,
	#instVars : [
		'container',
		'panes'
	],
	#category : #'Bloc-Examples-Reordering'
}

{ #category : #examples }
BlMultiPaneReorderingHandler >> cardsExample [
	<sampleInstance>

	| enlargeButton reduceButton bar pane scene space |
	pane := self newThreeColumnsPane.
	pane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	enlargeButton := BlTextElement new
		            margin: (BlInsets all: 10);
		            text: 'Click to Enlarge' asRopedText;
		            when: BlClickEvent do: [ :evt |
			            | subject |
			            subject := (pane childAt: 1) childAt: 1.
			            subject size: subject size + (20 @ 20) ];
		            yourself.
	reduceButton := BlTextElement new
		           margin: (BlInsets all: 10);
		           text: 'Click to Reduce' asRopedText;
		           when: BlClickEvent do: [ :evt |
			           | subject |
			           subject := (pane childAt: 1) childAt: 1.
			           subject size: (subject size - (20 @ 20) max: 10 @ 10) ];
		           yourself.
	bar := BlElement new
		       size: 800 @ 40;
		       background: Color lightGray muchLighter;
		       layout: BlLinearLayout horizontal;
		       constraintsDo: [ :c |
			       c horizontal matchParent.
			       c vertical exact: 40 ];
		       addChild: reduceButton;
		       addChild: enlargeButton;
		       yourself.
	scene := BlElement new
		         constraintsDo: [ :c |
			         c horizontal matchParent.
			         c vertical matchParent ];
		         layout: BlLinearLayout vertical;
		         addChild: bar;
		         addChild: pane;
		         requestLayout;
		         yourself.
	space := BlSpace new
		extent: 800 @ 600;
		title: 'Cards';
		yourself.
	space root addChild: scene.
	space show.
	^ space
]

{ #category : #accessing }
BlMultiPaneReorderingHandler >> container: theContainer [

	container := theContainer
]

{ #category : #'event handling' }
BlMultiPaneReorderingHandler >> dragEvent: anEvent [

	| dragPosition dragDelta aNewPosition |
	dragPosition := anEvent currentTarget globalPointToParent:
		                anEvent position.
	self movePlaceholderIfOverOtherChild: anEvent.
	dragDelta := dragPosition
	             -
	             (dragStartPosition ifNil: [
		              dragStartPosition := dragPosition ]).
	dragDelta := self computePullDelta: dragDelta.
	aNewPosition := (originalPosition ifNil: [
		                 originalPosition := anEvent currentTarget position ])
	                + dragDelta.
	allowedOutOfBounds ifFalse: [
		| aMaxPosition |
		aMaxPosition := anEvent currentTarget hasParent
			                ifTrue: [
			                anEvent currentTarget parent extent
			                - anEvent currentTarget extent ]
			                ifFalse: [ 0 @ 0 ].
		aNewPosition := aNewPosition min: aMaxPosition max: 0 @ 0 ].
	anEvent currentTarget position: aNewPosition.
	anEvent consumed: true.
	anEvent currentTarget dispatchEvent: (BlPullEvent new
			 initialPosition: originalPosition;
			 currentPosition: aNewPosition)
]

{ #category : #'event handling' }
BlMultiPaneReorderingHandler >> dragStartEvent: anEvent [

	| draggable |
	anEvent consumed: true.
	draggable := anEvent currentTarget.
	parent := panes detect: [ :aPane | aPane containsGlobalPoint: anEvent position ].
	overlay := BlOverlayElement on: container.
	container parent addChild: overlay.

	"drag start position in parent"
	dragStartPosition := draggable globalPointToParent: anEvent position.

	"element position in parent"
	originalPosition := draggable position.
	placeholder := self newPlaceholderFor: draggable.
	parent replaceChild: draggable with: placeholder.
	overlay addChild: draggable.

	anEvent currentTarget dispatchEvent: BlPullStartEvent new
]

{ #category : #private }
BlMultiPaneReorderingHandler >> movePlaceholderIfOverOtherChild: anEvent [

	| mouseOverOther index |
	self movePlaceholderToCorrectParent: anEvent.
	mouseOverOther := placeholder.
	parent children do: [ :each |
		(each containsGlobalPoint: anEvent position) ifTrue: [
			mouseOverOther := each ] ].
	mouseOverOther = placeholder ifTrue: [ ^ self ].

	index := parent childIndexOf: mouseOverOther.
	parent removeChild: placeholder.
	parent addChild: placeholder at: index
]

{ #category : #'event handling' }
BlMultiPaneReorderingHandler >> movePlaceholderToCorrectParent: anEvent [

	| currentPane |
	currentPane := panes
		detect: [ :aPane |
			aPane containsGlobalPoint: anEvent position ]
		ifNone: [ parent ].
	currentPane = parent ifTrue: [ ^ self ].

	parent removeChild: placeholder.
	parent := currentPane.
	parent addChild: placeholder
]

{ #category : #private }
BlMultiPaneReorderingHandler >> newThreeColumnsPane [

	| pane columnBlock toDo doing done columns handler |
	pane := BlElement new
		        size: 800 @ 600;
		        background: Color lightGray muchLighter;
		        padding: (BlInsets all: 2);
		        layout: BlLinearLayout horizontal;
		        yourself.

	columnBlock := [
	               BlElement new
		               border: (BlBorder paint: Color lightGray lighter);
		               background:
			               Color yellow muchLighter muchLighter lighter;
		               layout: BlFlowLayout new;
		               margin: (BlInsets all: 2);
		               padding: (BlInsets all: 2);
		               constraintsDo: [ :c |
			               c horizontal matchParent.
			               c vertical matchParent ] ].

	toDo := columnBlock value.
	doing := columnBlock value.
	done := columnBlock value.
	columns := {
		           toDo.
		           doing.
		           done }.

	handler := self class new
		           container: pane;
		           panes: columns;
		           yourself.

	pane addChildren: columns.
	10 timesRepeat: [
		| element |
		element := BlElement new
			           size: 80 @ 60;
			           border: (BlBorder paint: Color black);
			           background: Color random;
			           margin: (BlInsets all: 2);
			           addEventHandler: handler;
			           yourself.
		toDo addChild: element ].
	^ pane
]

{ #category : #accessing }
BlMultiPaneReorderingHandler >> panes: thePanes [
	panes := thePanes
]

{ #category : #examples }
BlMultiPaneReorderingHandler >> threeColumnsExample [
	<sampleInstance>

	| space |
	space := BlSpace new
		extent: 800 @ 600;
		title: 'Three columns';
		show;
		yourself.
	space root addChild: self newThreeColumnsPane.
	^ space
]
