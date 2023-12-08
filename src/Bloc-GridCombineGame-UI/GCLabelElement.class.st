"
I'm an element that wraps a `BlTextElement` that is convenient to do a graphical representation of a `GCTile` as well as an overlay message that is shown when the game finishes.
"
Class {
	#name : #GCLabelElement,
	#superclass : #GCElement,
	#instVars : [
		'label'
	],
	#category : #'Bloc-GridCombineGame-UI'
}

{ #category : #initialization }
GCLabelElement >> initialize [

	super initialize.

	label := BlTextElement new.

	self addChild: label as: #label
]

{ #category : #accessing }
GCLabelElement >> label [

	^ label
]

{ #category : #accessing }
GCLabelElement >> text: aBlRopedText [
	
	label text: aBlRopedText
]
