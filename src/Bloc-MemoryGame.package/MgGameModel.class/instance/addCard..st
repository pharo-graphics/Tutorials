adding
addCard: aCard
	"Add card to the list of available cards"
	self
		assert: [ availableCards size < self cardsCount ]
		description: [ 'Amount of cards must not exceed grid size limit' ].

	availableCards add: aCard