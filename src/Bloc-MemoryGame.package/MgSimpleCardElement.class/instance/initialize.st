initialization
initialize
	super initialize.
	
	self size: 80@80.
	self background: Color gray.
	self geometry: (BlRectangle new
		cornerRadius: 12)