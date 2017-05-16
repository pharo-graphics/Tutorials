mouse handlers
clickEvent: anEvent
	| animation cardElement |
	
	cardElement := anEvent currentTarget.
	
	animation := cardElement card flipped
		ifTrue: [
			self memoryGame chooseCard: cardElement card.
			BlScaleAnimation new
				target: anEvent currentTarget;
				easing: BlEasing bounceOut;
				scaleTo: 0.001@0.001;
				duration: 500 ]
		ifFalse: [
			BlScaleAnimation new
				target: anEvent currentTarget;
				easing: BlEasing bounceOut;
				scaleTo: 0.2@0.2;
				duration: 350;
				onFinishedDo: [ self memoryGame chooseCard: cardElement card ] ].

	animation start