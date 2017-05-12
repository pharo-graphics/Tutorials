initialization
initialize
	super initialize.
	
	self effect: (BlDropShadowEffect color: Color black width: 4 offset: 2).
	self size: self background image extent.
	self addEventHandler: MgCardEventListener new