accessing
memoryGame: aMemoryGame

	self layout columnCount: aMemoryGame gridSize.
	
	aMemoryGame availableCards do: [ :aCard |
		self addChild: (self newCardElement
			card: aCard;
			addEventHandler: (self newCardEventListener memoryGame: aMemoryGame)) ].