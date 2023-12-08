"
I define rules to make a `GCGameElement` look close to the classic 2048 game.
"
Class {
	#name : #GCClassicSkin,
	#superclass : #GCGameSkin,
	#category : #'Bloc-GridCombineGame-UI'
}

{ #category : #applying }
GCClassicSkin >> applyGameFailedMessageSkinOn: aLabelElement [ 

	self applyGameFinishedMessageSkinOn: aLabelElement.

	aLabelElement
		background: Color red translucent;
		text: 'Failed' asRopedText
]

{ #category : #applying }
GCClassicSkin >> applyGameFinishedMessageSkinOn: aLabelElement [ 

	aLabelElement label defaultFontSize: 50.

	aLabelElement
		layout: self newLinearCenteredLayout;
		constraintsDo: self matchParentConstraintsBlock.
	
	aLabelElement
		opacity: 0.0;
		addAnimation:
			(BlOpacityAnimation new
				duration: 0.2 seconds;
				opacity: 1.0;
				yourself)
]

{ #category : #applying }
GCClassicSkin >> applyGameSkinOn: aGameElement [ 

	aGameElement
		background: Color paleOrange darker;
		constraintsDo: self matchParentConstraintsBlock.

	aGameElement tilesContainer
		constraintsDo: self matchParentConstraintsBlock.

	aGameElement slotsContainer
		constraintsDo: self matchParentConstraintsBlock

]

{ #category : #applying }
GCClassicSkin >> applyGameSuccessMessageSkinOn: aLabelElement [ 

	self applyGameFinishedMessageSkinOn: aLabelElement.

	aLabelElement
		background: Color green translucent;
		text: 'Success' asRopedText
]

{ #category : #applying }
GCClassicSkin >> applySlotSkinOn: aSlotElement [

	aSlotElement
		size: self cellSize;
		margin: (BlInsets all: self cellMarginSize);
		background: Color paleOrange;
		geometry: self newRoundedGeometry
]

{ #category : #applying }
GCClassicSkin >> applyTileInsertedSkinOn: aTileElement [
	"Assumes the common tile skin is already applied, this behavior is for the tiles that were insterted by a player's slide."

	aTileElement
		opacity: 0.0;
		addAnimation:
			(BlOpacityAnimation new
				duration: 0.2 seconds;
				opacity: 1.0;
				yourself)
]

{ #category : #applying }
GCClassicSkin >> applyTileSkinOn: aTileElement [

	aTileElement
		layout: self newLinearCenteredLayout;
		size: self cellSize;
		background: Color paleYellow;
		geometry: self newRoundedGeometry.

	"Animate translations"
	(aTileElement transitionAt: #transformation)
		duration: 0.2 seconds;
		easing: BlQuinticInterpolator default.

	aTileElement label defaultFontSize: 28.
]

{ #category : #private }
GCClassicSkin >> cellMarginSize [
		
	^ 3
]

{ #category : #private }
GCClassicSkin >> cellSize [
		
	^ 75 asPoint
]

{ #category : #private }
GCClassicSkin >> matchParentConstraintsBlock [
	"Wrap it since setup will send value"

	^ [ :aLayoutConstraints | 
			aLayoutConstraints horizontal matchParent.
			aLayoutConstraints vertical matchParent ]
]

{ #category : #private }
GCClassicSkin >> newLinearCenteredLayout [

	^ BlLinearLayout new
		  alignCenter;
		  yourself
]

{ #category : #private }
GCClassicSkin >> newRoundedGeometry [
	
	^ BlRoundedRectangleGeometry cornerRadius: self cellMarginSize
]
