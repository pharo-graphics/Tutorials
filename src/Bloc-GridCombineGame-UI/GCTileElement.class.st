"
I'm a graphical representation of a `GCTile`.
"
Class {
	#name : #GCTileElement,
	#superclass : #GCElement,
	#instVars : [
		'label'
	],
	#category : #'Bloc-GridCombineGame-UI'
}

{ #category : #initialization }
GCTileElement >> initialize [

	super initialize.

	self
		addChild: (label := BlTextElement new)
		as: #label
]

{ #category : #accessing }
GCTileElement >> text: aBlRopedText [
	
	label text: aBlRopedText
]
