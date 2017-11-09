opening
openInWindow: anElement
	"Open a given game element in a window"
	| aSpace |
	aSpace := BlSpace new
		extent: 420@420;
		title: 'Memory Game'.

	aSpace root
		addChild: anElement;
		yourself.
	
	aSpace show