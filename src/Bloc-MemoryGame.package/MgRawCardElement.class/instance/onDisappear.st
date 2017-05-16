announcements
onDisappear
	| disappearAnimation enlargeAnimation scalingAnimation parallelAnimation sequentialAnimation |

	enlargeAnimation := BlScaleAnimation new
		target: self;
		easing: BlEasing bounceOut;
		scaleTo: 0.2@0.2;
		duration: 500.

	disappearAnimation := BlOpacityAnimation new
		target: self;
		opacity: 0;
		duration: 400.
	
	scalingAnimation := BlScaleAnimation new
		target: self;
		easing: BlEasing linear;
		scaleTo: (0.9@0.9) negated;
		duration: 400.
	
	parallelAnimation := BlParallelAnimation new
		addAll: { disappearAnimation . scalingAnimation }.
	
	sequentialAnimation := BlSequentialAnimation new
		onFinishedDo: [ self mouseTransparent: true ];
		addAll: { enlargeAnimation. parallelAnimation }.
		
	sequentialAnimation start