examples
openEmoji
	"I create and start a game with Emoji cards.
	(only works on OSX with Moz2D rendering backend)"
	<script: 'self openEmoji'>
	| game gameElement |

	game := MgGameModel new.
	game initializeForSymbols: '💰🏡🎅🍪🍕🚀😸🙈'.

	gameElement := MgGameElement new.
	gameElement memoryGame: game.
	
	self openInWindow: gameElement