accessing
card: aMgCard
	| text |
	super card: aMgCard.
	
	text := BrRopedText string: aMgCard symbol asString.
	text attributes: {
		BrFontSizeAttribute size: 50.
		BrTextForegroundAttribute paint: Color white }.
	
	face text: text