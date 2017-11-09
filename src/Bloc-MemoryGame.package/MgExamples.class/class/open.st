examples
open
	"I create and start a game with Number cards"
	<script: 'self open'>
	| game gameElement |
	
	game := MgGameModel new.
	game initializeForSymbols: '12345678'.

	gameElement := MgGameElement new.
	gameElement memoryGame: game.
	
	self openInWindow: gameElement