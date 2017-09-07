accessing
symbol: aCharacter
	"Initialize the card with a given symbol as a character"
	self
		assert: [ aCharacter isNotNil ]
		description: [ 'Character must not be nil' ].

	symbol := aCharacter