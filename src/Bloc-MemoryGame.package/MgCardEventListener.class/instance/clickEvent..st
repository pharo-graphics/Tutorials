mouse handlers
clickEvent: anEvent
	"| animation |
	animation := BlRotateAnimation new duration: 1000.
	
	animation addEventHandlerOn: BlAnimationTickEvent do: [ self halt ].

	animation2 := BlRotateAnimation new duration: 1000.
	
	animation2 addEventHandlerOn: BlAnimationTickEvent do: [ self halt ].
	animation2 onTickDo: [ ].
	
	anEvent currentTarget addEventHandlerOn: BlAnimationTickEvent do: [ self halt ].
	
	anEvent currentTarget addAnimation: (BlRotateAnimation new duration: 1000)"