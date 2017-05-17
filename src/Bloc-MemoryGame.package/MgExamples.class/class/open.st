instance creation
open
	<example>
	| space game gameElement |
	space := BlSpace new.
	space extent: 420@420.

	game := MgGameModel new.
	"game initializeForSymbols: '为从公家里地个时'."
	game initializeForSymbols: '💰🏡🎅🍪🍕🚀😸🙈'.

	gameElement := MgGameElement new.
	gameElement memoryGame: game.

	space root addChild: gameElement.
	space show