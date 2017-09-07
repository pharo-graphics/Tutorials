I am a card model that can be flipped or not.
When card is flipped player should see a symbol that is used to compare two cards.

!! Examples:

[[[
	| cardModel |
	cardModel := MgdCardModel new symbol: $a.
	cardModel flip.
	cardModel disappear
]]]