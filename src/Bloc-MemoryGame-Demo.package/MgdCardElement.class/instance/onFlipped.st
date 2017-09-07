announcement - handling
onFlipped
	"Is sent after the card is flipped in the model"
	
	self card isFlipped
		ifTrue: [ self onFlippedFace ]
		ifFalse: [ self onFlippedBack ]