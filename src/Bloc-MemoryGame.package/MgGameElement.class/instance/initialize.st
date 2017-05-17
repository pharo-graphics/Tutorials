initialization
initialize
	super initialize.
	
	self layout: (BlGridLayout horizontal
		cellSpacing: 20;
		columnCount: 3).
	
	"self size: 320@320"
	self constraintsDo: [ :layoutConstraints |
		layoutConstraints horizontal fitContent.
		layoutConstraints vertical fitContent. ]