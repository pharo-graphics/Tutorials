drawing
drawPathOnSpartaCanvas: aCanvas
	| radius radiusOffset |
	
	radius := 12.
	radiusOffset := radius/Float pi.
	
	aCanvas fill
		paint: Color lightGray;
		path: (aCanvas shape 
			roundedRectangle: self boundsInLocal 
			radii: (BlCornerRadii radius: radius));
		draw.
	
	aCanvas stroke
		paint: Color paleBlue;
		path: (aCanvas shape 
			line: radiusOffset@radiusOffset 
			to: (self width-radiusOffset)@(self height-radiusOffset));
		draw.
	aCanvas stroke
		paint: Color paleBlue;
		path: (aCanvas shape 
			line: (self width-radiusOffset)@radiusOffset
			to: radiusOffset@(self height-radiusOffset));
		draw.
	
	"aCanvas fill
		paint: Color lightGray;
		path: ((BlRectangle new
			cornerRadius: 12)
				buildPathOnSpartaCanvas: aCanvas within: self boundsInLocal);
		draw.
	
	aCanvas stroke
		paint: Color paleBlue;
		path: ((BlLine new
			 from: radiusOffset@radiusOffset;
			 to: (self width-radiusOffset)@(self height-radiusOffset))
				buildPathOnSpartaCanvas: aCanvas within: self boundsInLocal);
		draw.
	aCanvas stroke
		paint: Color paleBlue;
		path: ((BlLine new
			 from: (self width-radiusOffset)@radiusOffset;
			 to: radiusOffset@(self height-radiusOffset))
				buildPathOnSpartaCanvas: aCanvas within: self boundsInLocal);
		draw."
		
	
		
	