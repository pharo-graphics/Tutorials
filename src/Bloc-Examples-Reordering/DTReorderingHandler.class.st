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

{ #category : #initialization }
DTReorderingHandler >> initialize [

	super initialize.

	allowedOutOfBounds := true.
	direction := Any
]
