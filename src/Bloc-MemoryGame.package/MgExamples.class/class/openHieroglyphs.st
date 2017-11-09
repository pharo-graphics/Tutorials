examples
openHieroglyphs
	"I create and start a game with Hieroglyph cards.
	(only works on OSX with Moz2D rendering backend)"
	<script: 'self openHieroglyphs'>
	| game gameElement |

	game := MgGameModel new.
	game initializeForSymbols: '为从公家里地个时'.

	gameElement := MgGameElement new.
	gameElement memoryGame: game.
	
	self openInWindow: gameElement