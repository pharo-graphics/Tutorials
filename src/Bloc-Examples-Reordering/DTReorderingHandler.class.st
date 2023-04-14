"
I support dragging and dropping to reorder
"
Class {
	#name : #DTReorderingHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'originalPosition',
		'dragStartPosition',
		'allowedOutOfBounds',
		'direction',
		'overlay',
		'parent',
		'placeholder'
	],
	#classVars : [
		'Any',
		'Horizontal',
		'Vertical'
	],
	#category : #'Bloc-Examples-Reordering'
}

{ #category : #'class initialization' }
DTReorderingHandler class >> initialize [	
	Any := #any.
	Vertical := #vertical.
	Horizontal := #horizontal
]

{ #category : #accessing }
DTReorderingHandler >> allowOutOfBounds [
	"Allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := true
]

{ #category : #accessing }
DTReorderingHandler >> beFree [

	direction := Any
]

{ #category : #accessing }
DTReorderingHandler >> beHorizontal [

	direction := Horizontal
]

{ #category : #accessing }
DTReorderingHandler >> beVertical [

	direction := Vertical
]

{ #category : #'event handling' }
DTReorderingHandler >> computePullDelta: aDragDelta [
	
	direction = Any
		ifTrue: [ ^ aDragDelta ].
		
	direction = Vertical
		ifTrue: [ ^ 0 @ aDragDelta y ].
		
	direction = Horizontal
		ifTrue: [ ^ aDragDelta x @ 0 ].
		
	^ direction
]

{ #category : #accessing }
DTReorderingHandler >> disallowOutOfBounds [
	"Do not allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := false
]

{ #category : #'event handling' }
DTReorderingHandler >> dragEndEvent: anEvent [

	| draggable |
	"anEvent consumed: true."
	draggable := anEvent currentTarget.
	overlay removeChild: draggable.
	parent replaceChild: placeholder with: draggable.
	overlay detach.

	anEvent currentTarget dispatchEvent: BlPullEndEvent new
]

{ #category : #'event handling' }
DTReorderingHandler >> dragEvent: anEvent [

	| dragPosition dragDelta aNewPosition |
	dragPosition := anEvent currentTarget globalPointToParent:
		                anEvent position.
	self movePlaceholderIfOverOtherChild: anEvent.
	dragDelta := dragPosition
	             -
	             (dragStartPosition ifNil: [
		              dragStartPosition := dragPosition ]).
	dragDelta := self computePullDelta: dragDelta.

	aNewPosition := dragDelta + (originalPosition ifNil: [
		                 originalPosition := anEvent currentTarget position ]).
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
			 oldPosition: dragPosition;
			 newPosition: aNewPosition;
			 delta: dragDelta)
]

{ #category : #'event handling' }
DTReorderingHandler >> dragStartEvent: anEvent [

	| draggable |
	anEvent consumed: true.
	draggable := anEvent currentTarget.
	parent := draggable parent.
	overlay := BlOverlayElement on: parent.
	parent parent addChild: overlay.

	"drag start position in parent"
	dragStartPosition := draggable globalPointToParent: anEvent position.

	"element position in parent"
	originalPosition := draggable position.
	placeholder := self newPlaceholderFor: draggable.
	parent replaceChild: draggable with: placeholder.
	overlay addChild: draggable.

	anEvent currentTarget dispatchEvent: BlPullStartEvent new
]

{ #category : #'event handling' }
DTReorderingHandler >> eventsToHandle [

	^ {
		  BlDragStartEvent.
		  BlDragEvent.
		  BlDragEndEvent }
]

{ #category : #initialization }
DTReorderingHandler >> initialize [

	super initialize.

	allowedOutOfBounds := true.
	direction := Any
]

{ #category : #examples }
DTReorderingHandler >> inplaceSortingExample [
	<sampleInstance>

	| pane |
	pane := BlElement new
		layout: BlFlowLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.

	10 timesRepeat: [
		pane addChild:
			(BlElement new
				size: 150 @ 100;
				border: (BlBorder paint: Color black);
				background: Color random;
				margin: (BlInsets all: 5);
				addEventHandler: self class new;
				yourself) ].

	^ BlSpace new
		addChild: pane;
		extent: 700 @ 600;
		title: 'Inplace sorting';
		show;
		yourself
]

{ #category : #private }
DTReorderingHandler >> movePlaceholderIfOverOtherChild: anEvent [

	| mouseOverOther index |
	mouseOverOther := placeholder.
	parent children do: [ :each |
		(each containsGlobalPoint: anEvent position) ifTrue: [
			mouseOverOther := each ] ].
	mouseOverOther = placeholder ifTrue: [ ^ self ].
	index := parent childIndexOf: mouseOverOther.
	parent removeChild: placeholder.
	parent addChild: placeholder at: index
]

{ #category : #private }
DTReorderingHandler >> newPlaceholderFor: draggable [

	^ BlElement new
		  size: draggable size;
		  border: (draggable border copyWithStyle: BlStrokeStyle dashed);
		  margin: draggable margin;
		  background: (draggable background paint color alpha: 0.2);
		  yourself
]
