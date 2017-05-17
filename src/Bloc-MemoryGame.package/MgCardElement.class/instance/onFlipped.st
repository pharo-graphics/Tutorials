announcement - handling
onFlipped
	self card flipped
		ifTrue: [ self onFlippedFace ]
		ifFalse: [ self onFlippedBack ]