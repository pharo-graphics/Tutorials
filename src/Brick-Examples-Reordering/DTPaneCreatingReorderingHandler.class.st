Class {
	#name : #DTPaneCreatingReorderingHandler,
	#superclass : #DTMultiPaneReorderingHandler,
	#instVars : [
		'draggableOffset'
	],
	#category : #'Brick-Examples-Reordering'
}

{ #category : #adding }
DTPaneCreatingReorderingHandler >> addPaneWith: draggable at: anEvent [ 
	|column|
	column := self columnBlock value.
	panes add: column.
	column addChild: draggable.
	container addChild: column.
	column relocate: (column globalPointToParent: anEvent position) - draggableOffset + (-4@ -12). 
	column when: BlPullStartEvent do: [ self makeLast: column]. 

]

{ #category : #'as yet unclassified' }
DTPaneCreatingReorderingHandler >> columnBlock [
	^ [ BlElement new
		border: (BlBorder paint: Color lightGray lighter);
		background: Color yellow muchLighter muchLighter lighter;
		layout: BlFlowLayout new;
		margin: (BlInsets all: 2);
		padding: (BlInsets top: 10 left: 2 bottom: 2 right: 2);
		constraintsDo: [ :c | 
			c horizontal exact: 86*3.
			c vertical fitContent ];
		addEventHandler: BlPullHandler new ]
]

{ #category : #'as yet unclassified' }
DTPaneCreatingReorderingHandler >> dragEndEvent: anEvent [
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

{ #category : #'as yet unclassified' }
DTPaneCreatingReorderingHandler >> dragStartEvent: anEvent [
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
	placeholder := self placeholderFor: draggable.
	parent replaceChild: draggable with: placeholder.
	overlay addChild: draggable.

	anEvent currentTarget dispatchEvent: BlPullStartEvent new
]

{ #category : #'as yet unclassified' }
DTPaneCreatingReorderingHandler >> fittingColumns [
	<gtExample>
	| pane columnBlock toDo columns handler |
	pane := BlElement new
		size: 800 @ 600;
		background: Color lightGray muchLighter;
		padding: (BlInsets all: 2);
		layout: BlBasicLayout new;
		yourself.
	columnBlock := self columnBlock.
	toDo := columnBlock value.
	columns := {toDo} asOrderedCollection.
	handler := self class new
		container: pane;
		panes: columns;
		yourself.
	columns do: [:column |
		column when: BlPullStartEvent do: [ handler makeLast: column]]. 
	pane addChildren: columns.
	10
		timesRepeat: [ | element |
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

{ #category : #'as yet unclassified' }
DTPaneCreatingReorderingHandler >> makeLast: aPane [
	panes swap: (panes indexOf: aPane) with: panes size.
	container removeChildren.
	container addChildren: panes
]

{ #category : #'as yet unclassified' }
DTPaneCreatingReorderingHandler >> movePlaceholderToCorrectParent: anEvent [
	| currentPane |
	currentPane := panes reversed
		detect: [ :aPane |(aPane containsGlobalPoint: anEvent position)]
	ifNone: [ parent ].
	currentPane = parent
		ifFalse: [ 
			parent removeChild: placeholder.
			parent constraintsDo: [ :c | 
				c horizontal exact: 86*(parent childrenCount sqrt roundUpTo: 1)].
			parent := currentPane.
			parent addChild: placeholder.
			parent constraintsDo: [ :c | 
				c horizontal exact: 86*(parent childrenCount sqrt roundUpTo: 1)].
 ]
]
