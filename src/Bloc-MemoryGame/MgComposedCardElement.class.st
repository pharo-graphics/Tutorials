Class {
	#name : #MgComposedCardElement,
	#superclass : #MgCardElement,
	#instVars : [
		'face',
		'back'
	],
	#category : #'Bloc-MemoryGame-Elements'
}

{ #category : #accessing }
MgComposedCardElement >> card: aMgCard [
	| text |
	super card: aMgCard.
	
	text := aMgCard symbol asString asRopedText.
	text 
		fontSize: self symbolFontSize;
		foreground: Color white.
	
	face text: text
]

{ #category : #initialization }
MgComposedCardElement >> initialize [
	super initialize.
	
	self geometry: (BlRectangle cornerRadius: self cornerRadius).
	self background: self backgroundPaint.
	self layout: BlFrameLayout new.
	
	face := BlTextElement new.
	face constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	face visibility: BlVisibility hidden.

	back := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: (BlLineElement new
			border: (BlBorder paint: Color paleBlue width: 1);
			fromAnchor: (BlAbsolutePositionAnchor position: 0 @ 0);
			toAnchor: (BlAbsolutePositionAnchor position: 80 @ 80);
			yourself);
		addChild: (BlLineElement new
			border: (BlBorder paint: Color paleBlue width: 1);
			fromAnchor: (BlAbsolutePositionAnchor position: 80 @ 0);
			toAnchor: (BlAbsolutePositionAnchor position: 0 @ 80);
			yourself).
		
	self addChild: face.
	self addChild: back
]

{ #category : #'announcement - handling' }
MgComposedCardElement >> onFlippedBack [
	super onFlippedBack.
	
	face visibility: BlVisibility hidden.
	back visibility: BlVisibility visible.
]

{ #category : #'announcement - handling' }
MgComposedCardElement >> onFlippedFace [
	super onFlippedFace.
	
	face visibility: BlVisibility visible.
	back visibility: BlVisibility hidden.
]
