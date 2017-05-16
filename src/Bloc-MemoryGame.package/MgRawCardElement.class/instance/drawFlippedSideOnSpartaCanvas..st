drawing
drawFlippedSideOnSpartaCanvas: aCanvas
	| font textPainter metrics |
	
	font := aCanvas font
		size: 50;
		build.

	textPainter := aCanvas text
		font: font;
		paint: Color white;
		string: self card symbol asString.
	
	metrics := textPainter measure.
	
	textPainter
		baseline: (self extent - metrics textMetrics bounds extent) / 2.0 - metrics textMetrics bounds origin;
		draw