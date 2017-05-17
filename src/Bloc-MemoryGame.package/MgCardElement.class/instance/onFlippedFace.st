announcement - handling
onFlippedFace
	BlScaleAnimation new
		target: self;
		easing: BlQuinticInterpolator default;
		scaleTo: (0.15@0.15) negated;
		duration: 300;
		start