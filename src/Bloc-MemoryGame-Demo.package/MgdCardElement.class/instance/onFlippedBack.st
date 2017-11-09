announcement - handling
onFlippedBack
	| animation |

	animation := BlTransformAnimation scale: 1@1.
	animation
		absolute;
		easing: BlEasing bounceOut;
		duration: 0.35 seconds.
	
	animation startOn: self