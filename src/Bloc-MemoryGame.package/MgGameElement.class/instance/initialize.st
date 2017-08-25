initialization
initialize
	super initialize.
	
	self background: (BlBackground paint: Color gray darker).
	
	self layout: (BlGridLayout horizontal cellSpacing: 20).
	self constraintsDo: [ :layoutConstraints |
		layoutConstraints horizontal fitContent.
		layoutConstraints vertical fitContent ]