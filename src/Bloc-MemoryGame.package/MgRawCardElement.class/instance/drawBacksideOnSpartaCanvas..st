drawing
drawBacksideOnSpartaCanvas: aCanvas
	| radius radiusOffset |
	
	radius := self cornerRadius.
	radiusOffset := radius/Float pi.
	
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
		draw
		
	"aCanvas stroke
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