drawing
drawFlippedSideOnSpartaCanvas: aCanvas
	| font textPainter metrics baseline origin |
	
	font := aCanvas font
		size: self symbolFontSize;
		build.

	textPainter := aCanvas text
		font: font;
		paint: Color white;
		string: self card symbol asString.
	
	metrics := textPainter measure.
	
	origin := (self extent - metrics textMetrics bounds extent) / 2.0.
	baseline := origin - metrics textMetrics bounds origin.
	
	textPainter
		baseline: baseline;
		draw