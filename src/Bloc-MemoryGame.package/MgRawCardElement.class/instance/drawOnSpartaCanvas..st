drawing
drawOnSpartaCanvas: aCanvas
	| roundedRectangle |
	
	roundedRectangle := aCanvas shape 
		roundedRectangle: self boundsInLocal 
		radii: (BlCornerRadii radius: self cornerRadius).

	aCanvas clip
		by: roundedRectangle
		during: [
			self drawCommonOn: aCanvas.
			self card isFlipped
				ifTrue: [ self drawFlippedSideOn: aCanvas ]
				ifFalse: [ self drawBacksideOn: aCanvas ] ]