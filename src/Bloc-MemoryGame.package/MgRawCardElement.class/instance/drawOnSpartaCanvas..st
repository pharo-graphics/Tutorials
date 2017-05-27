drawing
drawOnSpartaCanvas: aCanvas
	| radius |

	radius := self cornerRadius.
	
	aCanvas fill
		paint: self backgroundColor;
		path: (aCanvas shape 
			roundedRectangle: self boundsInLocal 
			radii: (BlCornerRadii radius: radius));
		draw.
	
	"aCanvas fill
		paint: Color lightGray;
		path: ((BlRectangle new
			cornerRadius: 12)
				buildPathOnSpartaCanvas: aCanvas within: self boundsInLocal);
		draw."	
			
	self card isFlipped
		ifTrue: [ self drawFlippedSideOnSpartaCanvas: aCanvas ]
		ifFalse: [ self drawBacksideOnSpartaCanvas: aCanvas ]