initialization
initialize
	super initialize.
	
	self geometry: (BlRectangle cornerRadius: self cornerRadius).
	self background: self backgroundColor.
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
			fromAnchor: (BlGeometryStaticAnchor position: 0 @ 0);
			toAnchor: (BlGeometryStaticAnchor position: 80 @ 80);
			yourself);
		addChild: (BlLineElement new
			border: (BlBorder paint: Color paleBlue width: 1);
			fromAnchor: (BlGeometryStaticAnchor position: 80 @ 0);
			toAnchor: (BlGeometryStaticAnchor position: 0 @ 80);
			yourself).
		
	self addChild: face.
	self addChild: back