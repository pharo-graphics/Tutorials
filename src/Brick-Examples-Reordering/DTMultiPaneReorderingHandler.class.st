"
In planning boards, we want to drag and drop tasks from one pane to another. This event handler supports that. The container is the space where the dragging and dropping is to happen, the panes are the elements that contain tasks
"
Class {
	#name : #DTMultiPaneReorderingHandler,
	#superclass : #DTReorderingHandler,
	#instVars : [
		'container',
		'panes'
	],
	#category : #'Brick-Examples-Reordering'
}

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> cards [
	<gtExample>
	| plusSize minSize bar pane scene aSpace |
	pane := self threeColumns
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	plusSize := self plusButton 
		action: [ | subject |
			subject := (pane childAt: 1) childAt: 1.
			subject size: subject size + (20 @ 20) ];
		yourself.
	minSize := self minButton
		action: [ | subject |
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
		addChild: minSize;
		addChild: plusSize;
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
	aSpace := BlSpace new
		addChild: scene;
		extent: 800 @ 600;
		title: 'Cards'.
	^ aSpace show
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> container: theContainer [
	container := theContainer
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> dragEndEvent: anEvent [
	"anEvent consumed: true."
	| draggable |
	draggable := anEvent currentTarget.
	overlay removeChild: draggable.
	parent replaceChild: placeholder with: draggable.
	overlay detach.

	anEvent currentTarget dispatchEvent: BlPullEndEvent new
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> dragEvent: anEvent [
	| dragPosition dragDelta aNewPosition |
	dragPosition := anEvent currentTarget
		globalPointToParent: anEvent position.
	self movePlaceholderIfOverOtherChild: anEvent.
	dragDelta := dragPosition
		- (dragStartPosition ifNil: [ dragStartPosition := dragPosition ]).
	dragDelta := self computePullDelta: dragDelta.
	aNewPosition := (originalPosition
		ifNil: [ originalPosition := anEvent currentTarget position ])
		+ dragDelta.
	allowedOutOfBounds
		ifFalse: [ | aMaxPosition |
			aMaxPosition := anEvent currentTarget hasParent
				ifTrue: [ anEvent currentTarget parent extent - anEvent currentTarget extent ]
				ifFalse: [ 0 @ 0 ].
			aNewPosition := aNewPosition min: aMaxPosition max: 0 @ 0 ].
	anEvent currentTarget relocate: aNewPosition.
	anEvent consumed: true.
	anEvent currentTarget
		dispatchEvent:
			(BlPullEvent new
				initialPosition: originalPosition;
				oldPosition: dragPosition;
				newPosition: aNewPosition;
				delta: dragDelta)
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> dragStartEvent: anEvent [
	|draggable |
	anEvent consumed: true.
	draggable := anEvent currentTarget.
	parent := panes detect: [ :aPane | aPane containsGlobalPoint: anEvent position ].
	overlay := BlOverlayElement on: container.
	container parent addChild: overlay.

	"drag start position in parent"
	dragStartPosition := draggable globalPointToParent: anEvent position.

	"element position in parent"
	originalPosition := draggable position.
	placeholder := self placeholderFor: draggable.
	parent replaceChild: draggable with: placeholder.
	overlay addChild: draggable.

	anEvent currentTarget dispatchEvent: BlPullStartEvent new
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> minButton [
	^BrButton new
		margin:
			(BlInsets
				top: 10
				left: 10
				bottom: 10
				right: 0);
		aptitude: BrLeftButtonAptitude;
		icon: BrGlamorousVectorIcons remove;
		yourself.
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> movePlaceholderIfOverOtherChild: anEvent [
	| mouseOverOther |
	self movePlaceholderToCorrectParent: anEvent.
	mouseOverOther := placeholder.
	parent children
		do: [ :each | 
			(each containsGlobalPoint: anEvent position)
				ifTrue: [ mouseOverOther := each ] ].
	mouseOverOther = placeholder
		ifFalse: [ | index |
			index := parent childIndexOf: mouseOverOther.
			parent removeChild: placeholder.
			parent addChild: placeholder at: index ]
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> movePlaceholderToCorrectParent: anEvent [
	| currentPane |
	currentPane := panes
		detect: [ :aPane | aPane containsGlobalPoint: anEvent position ]
		ifNone: [ parent ].
	currentPane = parent
		ifFalse: [ parent removeChild: placeholder.
			parent := currentPane.
			parent addChild: placeholder ]
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> panes: thePanes [
	panes := thePanes
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> plusButton [
	^BrButton new
		margin:
			(BlInsets
				top: 10
				left: 0
				bottom: 10
				right: 10);
		aptitude: BrRightButtonAptitude;
		icon: BrGlamorousVectorIcons add;
		yourself.
]

{ #category : #'as yet unclassified' }
DTMultiPaneReorderingHandler >> threeColumns [
	<gtExample>
	|pane columnBlock toDo doing done columns handler|
	pane := BlElement new
	size: 800 @ 600;
	background: (Color lightGray muchLighter);
	padding: (BlInsets all: 2);
	layout: BlLinearLayout horizontal;
	yourself.
	
columnBlock  := [BlElement new
	border: (BlBorder paint: Color lightGray lighter);
	background: Color yellow muchLighter muchLighter lighter;
	layout: BlFlowLayout new;
	margin: (BlInsets all: 2);
	padding: (BlInsets all: 2);
	constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent]].
		
toDo := columnBlock value.
doing := columnBlock value.
done := columnBlock value.
columns := { toDo . doing . done}.

handler := DTMultiPaneReorderingHandler new
	container: pane;
	panes: columns;
	yourself.

pane addChildren: columns. 	
10 timesRepeat: [ |element|
	element := BlElement new
		size: 80 @ 60;
		border: (BlBorder paint: Color black);
		background: Color random;
		margin: (BlInsets all: 2);
		addEventHandler: handler;
		yourself.
	toDo addChild: element].
^pane
]
