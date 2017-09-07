announcement - handling
onFlipped
	self card isFlipped
		ifTrue: [ self onFlippedFace ]
		ifFalse: [ self onFlippedBack ]