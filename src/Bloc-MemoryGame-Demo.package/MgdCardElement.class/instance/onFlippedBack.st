announcement - handling
onFlippedBack
	BlScaleAnimation new
		target: self;
		easing: BlEasing bounceOut;
		scaleTo: 0.001@0.001;
		duration: 350;
		start