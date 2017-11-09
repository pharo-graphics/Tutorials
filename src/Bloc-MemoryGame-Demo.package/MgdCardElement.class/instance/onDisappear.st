announcement - handling
onDisappear
	| vanish enlarge minimize disappear |

	"when two cards match we want them to enlarge a bit in order to get player's attention"
	enlarge := BlTransformAnimation scale: 1.15 @ 1.15.
	enlarge
		absolute;
		easing: BlEasing bounceOut;
		duration: 0.5 seconds;
		target: self.

	"vanish animation manipulates opacity to make element transparent"
	vanish := BlOpacityAnimation new
		opacity: 0;
		duration: 0.35 seconds;
		target: self.

	"minimization animation changes card's scale to a tiny value"
	minimize := BlTransformAnimation scale: 0.01 @ 0.01.		
	minimize
		absolute;
		easing: BlEasing linear;
		duration: 0.35 seconds;
		target: self.

	"disappearing animation makes card transparent and minimizes until it becomes invisible"
	disappear := BlParallelAnimation with: { vanish . minimize }.
	
	"final animation consists of two sequential animations: enlarge and disappear"
	(BlSequentialAnimation with: { enlarge. disappear })
		"in order to preserve grid layout we don't actually remove cards from the window,
		we make them transparent (vanish animation) and forbid them from handling mouse events"
		onFinishedDo: [ self wantsMouse: false ];
		start