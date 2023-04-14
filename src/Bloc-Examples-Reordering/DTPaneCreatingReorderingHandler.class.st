Class {
	#name : #DTPaneCreatingReorderingHandler,
	#superclass : #DTMultiPaneReorderingHandler,
	#instVars : [
		'draggableOffset'
	],
	#category : #'Bloc-Examples-Reordering'
}

{ #category : #adding }
DTPaneCreatingReorderingHandler >> addPaneWith: draggable at: anEvent [

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

{ #category : #examples }
DTPaneCreatingReorderingHandler >> fittingColumnsExample [
	<sampleInstance>

	| pane columnBlock toDo columns handler |
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

	^ BlSpace new
		addChild: pane;
		extent: 800 @ 600;
		title: 'Fitting columns';
		show;
		yourself
]
