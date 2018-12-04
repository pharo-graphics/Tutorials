Class {
	#name : #MgRawCardElement,
	#superclass : #MgCardElement,
	#category : 'Bloc-MemoryGame-Elements'
}

{ #category : #drawing }
MgRawCardElement >> drawBacksideOn: aCanvas [
	
	aCanvas stroke
		paint: Color paleBlue;
		path: (aCanvas shape line: 0@0 to: self extent);
		draw.

	aCanvas stroke
		paint: Color paleBlue;
		path: (aCanvas shape line: self width @ 0 to: 0@self height);
		draw
]

{ #category : #drawing }
MgRawCardElement >> drawCommonOn: aCanvas [
	aCanvas fill
		paint: self backgroundPaint;
		path: self boundsInLocal;
		draw
]

{ #category : #drawing }
MgRawCardElement >> drawFlippedSideOn: aCanvas [
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
]

{ #category : #drawing }
MgRawCardElement >> drawOnSpartaCanvas: aCanvas [
	| roundedRectangle |
	
	roundedRectangle := aCanvas shape 
		roundedRectangle: self boundsInLocal 
		radii: (BlCornerRadii radius: self cornerRadius).

	aCanvas clip
		by: roundedRectangle
		during: [
			self drawCommonOn: aCanvas.
			self card isFlipped
				ifTrue: [ self drawFlippedSideOn: aCanvas ]
				ifFalse: [ self drawBacksideOn: aCanvas ] ]
]
