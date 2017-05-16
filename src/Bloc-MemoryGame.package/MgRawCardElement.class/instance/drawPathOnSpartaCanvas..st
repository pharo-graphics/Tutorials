drawing
drawPathOnSpartaCanvas: aCanvas
	| radius |
	
	radius := 12.
	
	aCanvas fill
		paint: Color lightGray;
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
			
	self card flipped
		ifTrue: [ self drawFlippedSideOnSpartaCanvas: aCanvas ]
		ifFalse: [ self drawBacksideOnSpartaCanvas: aCanvas ]