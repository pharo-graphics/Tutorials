I am a card model that can be flipped in order to show its back or face.
When card is flipped on the face a player should see a symbol that is used to compare two cards.

!! Examples:

[[[
	| cardModel |
	cardModel := MgdCardModel new symbol: $a.
	cardModel flip.
	cardModel disappear
]]]