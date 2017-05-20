initialization
initializeForSymbols: aCollectionOfCharacters
	"Initialize game model with the  cards that a represented by character symbols taken from a given
	collection of symbols.
	Note, amount of characters must correspond to amount of possible card combinations
	which is in fact = (total card count / how many card to match).
	So, if grid size is 4, then total card count is 4^2 = 16. If player should match 2 cards,
	then collection size must be 16 / 2 = 8"
	self
		assert: [ aCollectionOfCharacters size = (self cardsCount / self matchesCount) ]
		description: [ 'Amount of characters must be equal to possible all combinations' ].

	availableCards := (aCollectionOfCharacters asArray
			collect: [ :aSymbol | 
				(1 to: self matchesCount) collect: [ :i | 
					MgCardModel new symbol: aSymbol ] ] ) flattened shuffled asOrderedCollection