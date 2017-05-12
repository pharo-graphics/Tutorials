mouse handlers
clickEvent: anEvent

	self memoryGame chooseCard: anEvent currentTarget card

	"| animation |
	animation := BlScaleAnimation new
		target: anEvent currentTarget;
		easing: BlEasing bounceOut;
		scaleTo: 1.1@1.1;
		duration: 500.


	animation start."

	"| animation |
	animation := BlRotateAnimation new duration: 1000.
	
	animation addEventHandlerOn: BlAnimationTickEvent do: [ self halt ].

	animation2 := BlRotateAnimation new duration: 1000.
	
	animation2 addEventHandlerOn: BlAnimationTickEvent do: [ self halt ].
	animation2 onTickDo: [ ].
	
	anEvent currentTarget addEventHandlerOn: BlAnimationTickEvent do: [ self halt ].
	
	anEvent currentTarget addAnimation: (BlRotateAnimation new duration: 1000)"