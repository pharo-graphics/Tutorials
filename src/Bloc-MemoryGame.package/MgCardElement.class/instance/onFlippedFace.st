announcement - handling
onFlippedFace
	| animation |

	animation := BlTransformAnimation scale: 0.85 @ 0.85.	
	animation
		absolute;
		easing: BlQuinticInterpolator default;
		duration: 0.3 seconds.
	
	animation startOn: self