accessing
card: aMgCard
	| text |
	super card: aMgCard.
	
	text := BrRopedText string: aMgCard symbol asString.
	text attributes: {
		BrFontSizeAttribute size: self symbolFontSize.
		BrTextForegroundAttribute paint: Color white }.
	
	face text: text