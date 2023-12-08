Class {
	#name : 'BlPaneCreatingReorderingHandler',
	#superclass : 'BlMultiPaneReorderingHandler',
	#instVars : [
		'draggableOffset'
	],
	#category : 'Bloc-Examples-Reordering',
	#package : 'Bloc-Examples-Reordering'
}

{ #category : 'adding' }
BlPaneCreatingReorderingHandler >> addPaneWith: draggable at: anEvent [

	| column |
	column := self columnBlock value.
	panes add: column.
	column addChild: draggable.
	container addChild: column.
	column position:
		(column globalPointToParent: anEvent position) - draggableOffset
		+ (-4 @ -12).
	column when: BlPullStartEvent do: [ self makeLast: column ]
]

{ #category : 'private' }
BlPaneCreatingReorderingHandler >> columnBlock [

	^ [ BlElement new
			border: (BlBorder paint: Color lightGray lighter);
			background: Color yellow muchLighter muchLighter lighter;
			layout: BlFlowLayout new;
			margin: (BlInsets all: 2);
			padding: (BlInsets top: 10 left: 2 bottom: 2 right: 2);
			constraintsDo: [ :c | 
				c horizontal exact: 86*3.
				c vertical fitContent ];
			addEventHandler: BlPullHandler new;
			yourself ]
]

{ #category : 'event handling' }
BlPaneCreatingReorderingHandler >> dragEndEvent: anEvent [
	"anEvent consumed: true."
	| draggable |
	draggable := anEvent currentTarget.
	overlay removeChild: draggable.
	(parent containsGlobalPoint: anEvent position) ifTrue: [
		parent replaceChild: placeholder with: draggable] 
	ifFalse: [ 
		parent removeChild: placeholder.
		self addPaneWith: draggable at: anEvent].
	overlay detach.
	panes do: [:each | |nrOfChildren|
		nrOfChildren := each childrenCount.
		nrOfChildren = 0 ifTrue: [ container removeChild: each]
		ifFalse: [ each constraintsDo: [ :c | 
			c horizontal exact: 86*(nrOfChildren sqrt roundUpTo: 1)]].
].
	(panes removeAllSuchThat: [:each | each childrenCount = 0]).
	anEvent currentTarget dispatchEvent: BlPullEndEvent new
]

{ #category : 'event handling' }
BlPaneCreatingReorderingHandler >> dragStartEvent: anEvent [
	|draggable |
	anEvent consumed: true.
	draggable := anEvent currentTarget.
	parent := panes detect: [ :aPane | (aPane containsGlobalPoint: anEvent position) 
		and: [ draggable hasParent: aPane]].
	overlay := BlOverlayElement on: container.
	container parent addChild: overlay.

	"drag start position in parent"
	dragStartPosition := draggable globalPointToParent: anEvent position.
	draggableOffset := dragStartPosition - draggable position.
	"element position in parent"
	originalPosition := draggable position.
	placeholder := self newPlaceholderFor: draggable.
	parent replaceChild: draggable with: placeholder.
	overlay addChild: draggable.

	anEvent currentTarget dispatchEvent: BlPullStartEvent new
]

{ #category : 'examples' }
BlPaneCreatingReorderingHandler >> fittingColumnsExample [
	<sampleInstance>

	| pane columnBlock toDo columns handler space |
	pane := BlElement new
		        constraintsDo: [:c |
		           c horizontal matchParent.
		           c vertical matchParent ];
		        background: Color lightGray muchLighter;
		        padding: (BlInsets all: 2);
		        layout: BlBasicLayout new;
		        yourself.
	columnBlock := self columnBlock.
	toDo := columnBlock value.
	columns := { toDo } asOrderedCollection.
	handler := self class new
		           container: pane;
		           panes: columns;
		           yourself.
	columns do: [ :column |
		column when: BlPullStartEvent do: [ handler makeLast: column ] ].
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

	space := BlSpace new
		extent: 800 @ 600;
		title: 'Fitting columns';
		yourself.
	space root addChild: pane.
	space show.
	^ space
]

{ #category : 'private' }
BlPaneCreatingReorderingHandler >> makeLast: aPane [

	panes swap: (panes indexOf: aPane) with: panes size.
	container removeChildren.
	container addChildren: panes
]

{ #category : 'private' }
BlPaneCreatingReorderingHandler >> movePlaceholderToCorrectParent: anEvent [

	| currentPane |
	currentPane := panes reversed
		detect: [ :aPane |
			aPane containsGlobalPoint: anEvent position ]
		ifNone: [ parent ].
	currentPane = parent ifTrue: [ ^ self ].

	parent removeChild: placeholder.
	parent constraintsDo: [ :c |
		c horizontal exact: 86 * (parent childrenCount sqrt roundUpTo: 1) ].
	parent := currentPane.
	parent addChild: placeholder.
	parent constraintsDo: [ :c |
		c horizontal exact: 86 * (parent childrenCount sqrt roundUpTo: 1) ]
]
