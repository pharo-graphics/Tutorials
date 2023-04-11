"
I define rules to make a `GCGameElement` look close to the classic 2048 game.
"
Class {
	#name : #GC2048Skin,
	#superclass : #GCMessageRuleSheet,
	#category : #'Bloc-GridCombineGame-UI'
}

{ #category : #private }
GC2048Skin >> cellMarginSize [
		
	^ 3
]

{ #category : #private }
GC2048Skin >> cellSize [
		
	^ 75 asPoint
]

{ #category : #rules }
GC2048Skin >> finishedAsFailedRule [

	^ (self newBaseQuery // #failed) -> {
		#background:. Color red translucent.
		#layout:. self linearCenteredLayout.
		#constraintsDo:. self matchParentConstraintsBlock.
		}

]

{ #category : #rules }
GC2048Skin >> finishedAsSuccessLabelRule [

	^ (self newBaseQuery // #success // BlTextElement) -> {
		#defaultFontSize:. 50.
		}

]

{ #category : #rules }
GC2048Skin >> finishedAsSuccessRule [

	^ (self newBaseQuery // #success) -> {
		#background:. Color green translucent.
		#layout:. self linearCenteredLayout.
		#constraintsDo:. self matchParentConstraintsBlock.
		}

]

{ #category : #rules }
GC2048Skin >> gameRule [

	^ self newBaseQuery -> {
			#background:. Color paleOrange darker.
			#constraintsDo:. self matchParentConstraintsBlock.
		}

]

{ #category : #private }
GC2048Skin >> linearCenteredLayout [

	^ BlLinearLayout new
		  alignCenter;
		  yourself
]

{ #category : #private }
GC2048Skin >> matchParentConstraintsBlock [
	"Wrap it since setup will send value"

	^ [[ :aLayoutConstraints | 
			aLayoutConstraints horizontal matchParent.
			aLayoutConstraints vertical matchParent ]]
]

{ #category : #private }
GC2048Skin >> newRoundedGeometry [
	
	^ BlRoundedRectangleGeometry cornerRadius: self cellMarginSize
]

{ #category : #rules }
GC2048Skin >> slotContainerRule [

	^ (self newBaseQuery / #slotContainer) -> { 
			#constraintsDo:. self matchParentConstraintsBlock.
		}

]

{ #category : #rules }
GC2048Skin >> slotRule [

	^ (self newBaseQuery / #slotContainer // BlElement) -> { 
			#size:. self cellSize.
			#margin:. BlInsets all: self cellMarginSize.
			#background:. Color paleOrange.
			#geometry:. [ self newRoundedGeometry ]. "Elements cannot share geometry"
		}

]

{ #category : #rules }
GC2048Skin >> tileContainerRule [

	^ (self newBaseQuery / #tileContainer) -> { 
			#constraintsDo:. self matchParentConstraintsBlock.
		}

]

{ #category : #rules }
GC2048Skin >> tileLabelRule [

	^ (self newBaseQuery // GCTileElement // BlTextElement) -> {
			#defaultFontSize:. 28.
			}

]

{ #category : #rules }
GC2048Skin >> tileRule [

	^ (self newBaseQuery // GCTileElement) -> {
			#layout:. self linearCenteredLayout.
			#size:. self cellSize.
			#background:. Color paleYellow.
			#geometry:. [ self newRoundedGeometry ]. "Elements cannot share geometry"

			"Animate each movement"
			#transitionAt:duration:. { #transformation. 0.2 seconds }.
			#transitionAt:easing:.   { #transformation. BlQuinticInterpolator default }.

			}

]
