announcements
onFlipped
	| animation |
		
	animation := self card flipped
		ifTrue: [
			BlScaleAnimation new
				target: self;
				easing: BlQuinticInterpolator default;
				scaleTo: (0.15@0.15) negated;
				duration: 300 ]
		ifFalse: [
			BlScaleAnimation new
				target: self;
				easing: BlEasing bounceOut;
				scaleTo: 0.001@0.001;
				duration: 350 ].

	animation start